import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart' hide Interval;

import '../extension/extension.dart';
import '../model/model.dart';
import '../utils.dart';
import '../widget/scope.dart';

/// Controls the visible dates in Timetable widgets.
///
/// You can read (and listen to) the currently visible dates via [date].
///
/// To programmatically change the visible dates, use any of the following
/// functions:
///
/// * [animateToToday], [animateTo], or [animateToPage] if you want an animation
/// * [jumpToToday], [jumpTo], or [jumpToPage] if you don't want an animation
///
/// You can also get and update the [VisibleDateRange] via [visibleRange].
class DateController extends ValueNotifier<DatePageValueWithScrollActivity> {
  DateController({
    DateTime? initialDate,
    VisibleDateRange? visibleRange,
  })  : assert(initialDate.debugCheckIsValidTimetableDate()),
        // We set the correct value in the body below.
        super(_initialValue(visibleRange)) {
    // The correct value is set via the listener when we assign to our value.
    _date = ValueNotifier(DateTimeTimetable.dateFromPage(0));
    addListener(() => _date.value = value.date);

    // The correct value is set via the listener when we assign to our value.
    _visibleDates = ValueNotifier(Interval(DateTime(0), DateTime(0)));
    addListener(() => _visibleDates.value = value.visibleDates);

    final rawStartPage = initialDate?.page ?? DateTimeTimetable.today().page;
    value = value.copyWithActivity(
      page: value.visibleRange.getTargetPageForFocus(rawStartPage),
      activity: const IdleDateScrollActivity(),
    );
  }

  static DatePageValueWithScrollActivity _initialValue(
    VisibleDateRange? visibleRange,
  ) =>
      DatePageValueWithScrollActivity(
        visibleRange ?? VisibleDateRange.week(),
        0,
        const IdleDateScrollActivity(),
      );

  late final ValueNotifier<DateTime> _date;
  ValueListenable<DateTime> get date => _date;

  VisibleDateRange get visibleRange => value.visibleRange;
  set visibleRange(VisibleDateRange visibleRange) {
    cancelAnimation();
    value = value.copyWithActivity(
      page: visibleRange.getTargetPageForFocus(value.page),
      visibleRange: visibleRange,
      activity: const IdleDateScrollActivity(),
    );
  }

  late final ValueNotifier<Interval> _visibleDates;
  ValueListenable<Interval> get visibleDates => _visibleDates;

  // Animation
  AnimationController? _animationController;

  Future<void> animateToToday({
    Curve curve = Curves.easeInOut,
    Duration duration = const Duration(milliseconds: 200),
    required TickerProvider vsync,
  }) {
    return animateTo(
      DateTimeTimetable.today(),
      curve: curve,
      duration: duration,
      vsync: vsync,
    );
  }

  Future<void> animateTo(
    DateTime date, {
    Curve curve = Curves.easeInOut,
    Duration duration = const Duration(milliseconds: 200),
    required TickerProvider vsync,
  }) {
    return animateToPage(
      date.page,
      curve: curve,
      duration: duration,
      vsync: vsync,
    );
  }

  Future<void> animateToPage(
    double page, {
    Curve curve = Curves.easeInOut,
    Duration duration = const Duration(milliseconds: 200),
    required TickerProvider vsync,
  }) async {
    cancelAnimation();
    final controller = AnimationController(debugLabel: 'DateController', vsync: vsync);
    _animationController = controller;

    final previousPage = value.page;
    final targetPage = value.visibleRange.getTargetPageForFocus(page);
    final targetDatePageValue = DatePageValue(visibleRange, targetPage);
    controller.addListener(() {
      value = value.copyWithActivity(
        page: lerpDouble(previousPage, targetPage, controller.value)!,
        activity: controller.isAnimating ? DrivenDateScrollActivity(targetDatePageValue) : const IdleDateScrollActivity(),
      );
    });

    controller.addStatusListener((status) {
      if (status != AnimationStatus.completed) return;
      controller.dispose();
      _animationController = null;
    });

    await controller.animateTo(1, duration: duration, curve: curve);
  }

  void jumpToToday() => jumpTo(DateTimeTimetable.today());
  void jumpTo(DateTime date) {
    assert(date.debugCheckIsValidTimetableDate());
    jumpToPage(date.page);
  }

  void jumpToPage(double page) {
    cancelAnimation();
    value = value.copyWithActivity(
      page: value.visibleRange.getTargetPageForFocus(page),
      activity: const IdleDateScrollActivity(),
    );
  }

  void cancelAnimation() {
    if (_animationController == null) return;

    value = value.copyWithActivity(activity: const IdleDateScrollActivity());
    _animationController!.dispose();
    _animationController = null;
  }

  bool _isDisposed = false;
  bool get isDisposed => _isDisposed;
  @override
  void dispose() {
    _date.dispose();
    super.dispose();
    _isDisposed = true;
  }
}

/// Provides the [DateController] for Timetable widgets below it.
///
/// See also:
///
/// * [TimetableScope], which bundles multiple configuration widgets for
///   Timetable.
class DefaultDateController extends InheritedWidget {
  const DefaultDateController({required this.controller, required super.child});

  final DateController controller;

  @override
  bool updateShouldNotify(DefaultDateController oldWidget) => controller != oldWidget.controller;

  static DateController? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DefaultDateController>()?.controller;
  }
}
