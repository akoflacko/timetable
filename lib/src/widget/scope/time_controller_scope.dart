import 'package:flutter/widgets.dart';

import '../../controller/controller.dart';
import '../../extension/src/build_context.dart';

import 'timetable_scope.dart';

/// Provides the [TimeController] for Timetable widgets below it.
///
/// See also:
///
/// * [TimetableScope], which bundles multiple configuration widgets for
///   Timetable.
class TimeControllerScope extends InheritedWidget {
  const TimeControllerScope({
    required this.controller,
    required super.child,
  });

  final TimeController controller;

  @override
  bool updateShouldNotify(TimeControllerScope oldWidget) => controller != oldWidget.controller;

  static TimeController? of(
    BuildContext context, {
    bool listen = true,
  }) =>
      context
          .inhMaybeOf<TimeControllerScope>(
            listen: listen,
          )
          ?.controller;
}
