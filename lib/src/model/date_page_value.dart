import 'package:flutter/foundation.dart';

import '../controller/controller.dart';
import '../extension/extension.dart';
import '../utils.dart';

import 'model.dart';

/// The value held by [DateController].
@immutable
class DatePageValue with Diagnosticable {
  const DatePageValue(this.visibleRange, this.page);

  final VisibleDateRange visibleRange;
  int get visibleDayCount => visibleRange.visibleDayCount;

  final double page;
  DateTime get date => DateTimeTimetable.dateFromPage(page.round());

  int get firstVisiblePage => page.floor();

  /// The first date that is at least partially visible.
  DateTime get firstVisibleDate {
    final result = DateTimeTimetable.dateFromPage(firstVisiblePage);
    assert(result.debugCheckIsValidTimetableDate());
    return result;
  }

  int get lastVisiblePage => page.ceil() + visibleDayCount - 1;

  /// The last date that is at least partially visible.
  DateTime get lastVisibleDate {
    final result = DateTimeTimetable.dateFromPage(lastVisiblePage);
    assert(result.debugCheckIsValidTimetableDate());
    return result;
  }

  /// The interval of dates that are at least partially visible.
  Interval get visibleDates {
    final result = Interval(firstVisibleDate, lastVisibleDate.atEndOfDay);
    assert(result.debugCheckIsValidTimetableDateInterval());
    return result;
  }

  Iterable<DateTime> get visibleDatesIterable sync* {
    var currentDate = firstVisibleDate;
    while (currentDate <= lastVisibleDate) {
      yield currentDate;
      currentDate = currentDate.add(1.days);
    }
  }

  DatePageValue copyWith({VisibleDateRange? visibleRange, double? page}) => DatePageValue(visibleRange ?? this.visibleRange, page ?? this.page);

  @override
  int get hashCode => Object.hash(visibleRange, page);
  @override
  bool operator ==(Object other) {
    return other is DatePageValue && visibleRange == other.visibleRange && page == other.page;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('visibleRange', visibleRange));
    properties.add(DoubleProperty('page', page));
    properties.add(DateDiagnosticsProperty('date', date));
  }
}

class DatePageValueWithScrollActivity extends DatePageValue {
  const DatePageValueWithScrollActivity(
    super.visibleRange,
    super.page,
    this.activity,
  );

  final DateScrollActivity activity;

  DatePageValueWithScrollActivity copyWithActivity({
    VisibleDateRange? visibleRange,
    double? page,
    required DateScrollActivity activity,
  }) =>
      DatePageValueWithScrollActivity(
        visibleRange ?? this.visibleRange,
        page ?? this.page,
        activity,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    properties.add(DiagnosticsProperty('activity', activity));
  }
}
