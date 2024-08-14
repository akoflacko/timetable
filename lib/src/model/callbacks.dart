import 'package:flutter/widgets.dart';

import '../typedef/typedef.dart';
import '../widget/widget.dart';

@immutable
class TimetableCallbacks {
  const TimetableCallbacks({
    this.onWeekTap,
    this.onDateTap,
    this.onDateBackgroundTap,
    this.onDateTimeBackgroundTap,
    this.onMultiDateHeaderOverflowTap,
  });

  /// Called when the user taps on a week.
  ///
  /// Used internally by [WeekIndicator].
  final WeekTapCallback? onWeekTap;

  /// Called when the user taps on a date.
  ///
  /// You can react to this, e.g., by changing your view to just show this
  /// single date.
  ///
  /// Used internally by [DateHeader].
  final DateTapCallback? onDateTap;

  /// Called when the user taps on the background of a date.
  ///
  /// You can react to this, e.g., by creating an event for that specific date.
  ///
  /// Used internally by [MultiDateEventHeader].
  final DateTapCallback? onDateBackgroundTap;

  /// Called when the user taps on the background of a date at a specific time.
  ///
  /// You can react to this, e.g., by creating an event for that specific date
  /// and time.
  ///
  /// Used internally by [DateContent].
  final DateTimeTapCallback? onDateTimeBackgroundTap;

  /// Called when the user taps on the overflow of a [MultiDateEventHeader].
  ///
  /// These overflows are shown when there are more multi-date events in
  /// parallel than may be shown as separate rows in the header.
  ///
  /// See also:
  ///
  /// * [MultiDateEventHeader], which shows the overflow widgets.
  /// * [MultiDateEventHeaderStyle.maxEventRows] and
  ///   [MultiDateTimetableStyle.maxHeaderFraction], which control how many rows
  ///   are allowed before creating an overflow.
  /// * [EventBuilderScope.allDayOverflowBuilder], which creates the overflow
  ///   widgets.
  /// * [MultiDateEventHeaderOverflow], the default widget for representing the
  ///   overflow.
  final DateTapCallback? onMultiDateHeaderOverflowTap;

  TimetableCallbacks copyWith({
    WeekTapCallback? onWeekTap,
    bool clearOnWeekTap = false,
    DateTapCallback? onDateTap,
    bool clearOnDateTap = false,
    DateTapCallback? onDateBackgroundTap,
    bool clearOnDateBackgroundTap = false,
    DateTimeTapCallback? onDateTimeBackgroundTap,
    bool clearOnDateTimeBackgroundTap = false,
    DateTapCallback? onMultiDateHeaderOverflowTap,
    bool clearOnMultiDateHeaderOverflowTap = false,
  }) {
    assert(!(clearOnWeekTap && onWeekTap != null));
    assert(!(clearOnDateTap && onDateTap != null));
    assert(!(clearOnDateBackgroundTap && onDateBackgroundTap != null));
    assert(!(clearOnDateTimeBackgroundTap && onDateTimeBackgroundTap != null));
    assert(
      !(clearOnMultiDateHeaderOverflowTap && onMultiDateHeaderOverflowTap != null),
    );

    return TimetableCallbacks(
      onWeekTap: clearOnWeekTap ? null : onWeekTap ?? this.onWeekTap,
      onDateTap: clearOnDateTap ? null : onDateTap ?? this.onDateTap,
      onDateBackgroundTap: clearOnDateBackgroundTap ? null : onDateBackgroundTap ?? this.onDateBackgroundTap,
      onDateTimeBackgroundTap: clearOnDateTimeBackgroundTap ? null : onDateTimeBackgroundTap ?? this.onDateTimeBackgroundTap,
      onMultiDateHeaderOverflowTap: clearOnMultiDateHeaderOverflowTap ? null : onMultiDateHeaderOverflowTap ?? this.onMultiDateHeaderOverflowTap,
    );
  }

  @override
  int get hashCode {
    return Object.hash(
      onWeekTap,
      onDateTap,
      onDateBackgroundTap,
      onDateTimeBackgroundTap,
      onMultiDateHeaderOverflowTap,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is TimetableCallbacks &&
        onWeekTap == other.onWeekTap &&
        onDateTap == other.onDateTap &&
        onDateBackgroundTap == other.onDateBackgroundTap &&
        onDateTimeBackgroundTap == other.onDateTimeBackgroundTap &&
        onMultiDateHeaderOverflowTap == other.onMultiDateHeaderOverflowTap;
  }
}
