import 'package:flutter/widgets.dart';

import '../../controller/controller.dart';
import '../../extension/src/build_context.dart';

import 'timetable_scope.dart';

/// Provides the [DateController] for Timetable widgets below it.
///
/// See also:
///
/// * [TimetableScope], which bundles multiple configuration widgets for
///   Timetable.
class DateControllerScope extends InheritedWidget {
  const DateControllerScope({required this.controller, required super.child});

  final DateController controller;

  @override
  bool updateShouldNotify(DateControllerScope oldWidget) => controller != oldWidget.controller;

  static DateController? of(
    BuildContext context, {
    bool listen = true,
  }) =>
      context
          .inhMaybeOf<DateControllerScope>(
            listen: listen,
          )
          ?.controller;
}
