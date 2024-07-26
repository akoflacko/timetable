import 'package:flutter/material.dart';

import '../controller/controller.dart';
import '../event/builder.dart';
import '../event/event.dart';
import '../event/provider.dart';
import '../model/model.dart';
import '../resources/theme.dart';
import '../typedef/typedef.dart';

class TimetableScope<E extends Event> extends StatefulWidget {
  TimetableScope({
    super.key,
    this.dateController,
    this.timeController,
    EventProvider<E>? eventProvider,
    this.eventBuilder,
    this.allDayEventBuilder,
    this.allDayOverflowBuilder,
    this.timeOverlayProvider,
    this.callbacks,
    this.theme,
    required this.child,
  }) : eventProvider = eventProvider?.debugChecked;

  final DateController? dateController;
  final TimeController? timeController;

  final EventProvider<E>? eventProvider;
  final EventBuilder<E>? eventBuilder;

  final AllDayEventBuilder<E>? allDayEventBuilder;
  final AllDayOverflowBuilder<E>? allDayOverflowBuilder;

  final TimeOverlayProvider? timeOverlayProvider;

  final TimetableCallbacks? callbacks;
  final TimetableThemeData? theme;

  final Widget child;

  @override
  State<TimetableScope<E>> createState() => _TimetableScopeState<E>();
}

class _TimetableScopeState<E extends Event> extends State<TimetableScope<E>> {
  late final _dateController = DateController();
  late final _timeController = TimeController();

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => DefaultDateController(
        controller: widget.dateController ?? DefaultDateController.of(context) ?? _dateController,
        child: DefaultTimeController(
          controller: widget.timeController ?? DefaultTimeController.of(context) ?? _timeController,
          child: DefaultEventProvider<E>(
            eventProvider: widget.eventProvider ?? DefaultEventProvider.of<E>(context) ?? (_) => [],
            child: DefaultEventBuilder(
              builder: widget.eventBuilder ?? DefaultEventBuilder.of<E>(context)!,
              allDayBuilder: widget.allDayEventBuilder,
              allDayOverflowBuilder: widget.allDayOverflowBuilder,
              child: DefaultTimeOverlayProvider(
                overlayProvider: widget.timeOverlayProvider ?? DefaultTimeOverlayProvider.of(context) ?? emptyTimeOverlayProvider,
                child: DefaultTimetableCallbacks(
                  callbacks: widget.callbacks ?? DefaultTimetableCallbacks.of(context) ?? const TimetableCallbacks(),
                  child: TimetableTheme(
                    data: widget.theme ?? TimetableTheme.of(context) ?? TimetableThemeData(context),
                    child: widget.child,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}

class _InheritedTimetable<E extends Event> extends InheritedModel<_InheritedTimetableAspect> {
  const _InheritedTimetable({
    required super.child,
    required this.dateController,
    required this.timeController,
    required this.eventProvider,
    required this.eventBuilder,
    required this.allDayEventBuilder,
    required this.allDayOverflowBuilder,
    required this.timeOverlayProvider,
    required this.callbacks,
    required this.theme,
  });

  final DateController dateController;

  final TimeController timeController;

  final EventProvider<E> eventProvider;

  final EventBuilder<E> eventBuilder;

  final AllDayEventBuilder allDayEventBuilder;

  final AllDayOverflowBuilder allDayOverflowBuilder;

  final TimeOverlayProvider timeOverlayProvider;

  final TimetableCallbacks callbacks;

  final TimetableThemeData theme;

  @override
  bool updateShouldNotify(_InheritedTimetable oldWidget) => true;

  @override
  bool updateShouldNotifyDependent(
    _InheritedTimetable oldWidget,
    Set<_InheritedTimetableAspect> dependencies,
  ) {
    var shouldNotify = false;

    if (dependencies.contains(_InheritedTimetableAspect.dateController)) {
      shouldNotify = shouldNotify || dateController != oldWidget.dateController;
    }

    if (dependencies.contains(_InheritedTimetableAspect.timeController)) {
      shouldNotify = shouldNotify || timeController != oldWidget.timeController;
    }

    if (dependencies.contains(_InheritedTimetableAspect.eventProvider)) {
      shouldNotify = shouldNotify || eventProvider != oldWidget.eventProvider;
    }

    if (dependencies.contains(_InheritedTimetableAspect.eventBuilder)) {
      shouldNotify = shouldNotify || eventBuilder != oldWidget.eventBuilder;
    }

    if (dependencies.contains(_InheritedTimetableAspect.allDayEventBuilder)) {
      shouldNotify = shouldNotify || allDayEventBuilder != oldWidget.allDayEventBuilder;
    }

    if (dependencies.contains(_InheritedTimetableAspect.allDayOverflowBuilder)) {
      shouldNotify = shouldNotify || allDayOverflowBuilder != oldWidget.allDayOverflowBuilder;
    }

    if (dependencies.contains(_InheritedTimetableAspect.timeOverlayProvider)) {
      shouldNotify = shouldNotify || timeOverlayProvider != oldWidget.timeOverlayProvider;
    }

    if (dependencies.contains(_InheritedTimetableAspect.callbacks)) {
      shouldNotify = shouldNotify || callbacks != oldWidget.callbacks;
    }

    if (dependencies.contains(_InheritedTimetableAspect.theme)) {
      shouldNotify = shouldNotify || theme != oldWidget.theme;
    }

    return shouldNotify;
  }
}

enum _InheritedTimetableAspect {
  dateController,
  timeController,
  eventProvider,
  eventBuilder,
  allDayEventBuilder,
  allDayOverflowBuilder,
  timeOverlayProvider,
  callbacks,
  theme,
}
