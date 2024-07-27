import 'package:flutter/material.dart';

import '../../controller/controller.dart';
import '../../event/event.dart';
import '../../event/provider.dart';
import '../../model/visible_date_range.dart';
import '../../typedef/typedef.dart';
import '../scope/timetable_scope.dart';
import '../scope/theme_scope.dart';

import 'multi_date.dart';

/// A Timetable widget that displays multiple consecutive days without their
/// dates and without a week indicator.
///
/// To configure it, provide a [DateController] (with a
/// [VisibleDateRange.fixed]), [TimeController], [EventProvider], and
/// [EventBuilder] via a [TimetableScope] widget above in the widget tree. (You
/// can also provide these via `DefaultFoo` widgets directly, like
/// [DefaultDateController].)
///
/// See also:
///
/// * [MultiDateTimetable], which is used under the hood and can also display
///   concrete dates and be swipeable.
class RecurringMultiDateTimetable<E extends Event> extends StatelessWidget {
  RecurringMultiDateTimetable({
    super.key,
    WidgetBuilder? timetableBuilder,
  }) : timetableBuilder = timetableBuilder ?? _defaultTimetableBuilder<E>();

  final WidgetBuilder timetableBuilder;
  static WidgetBuilder _defaultTimetableBuilder<E extends Event>() {
    return (context) => MultiDateTimetable<E>(
          headerBuilder: (header, leadingWidth) => MultiDateTimetableHeader<E>(
            leading: SizedBox(width: leadingWidth),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = TimetableThemeScope.maybeOrDefaultOf(context);

    return TimetableThemeScope(
      data: theme.copyWith(
        dateHeaderStyleProvider: (date) => theme.dateHeaderStyleProvider(date).copyWith(showDateIndicator: false),
      ),
      child: Builder(builder: timetableBuilder),
    );
  }
}
