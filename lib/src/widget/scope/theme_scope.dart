import 'package:flutter/widgets.dart';

import '../../extension/src/build_context.dart';
import '../../resources/resources.dart';

/// Provides styles for nested Timetable widgets.
///
/// See also:
///
/// * [TimetableThemeData], which bundles the actual styles.
class TimetableThemeScope extends InheritedWidget {
  const TimetableThemeScope({
    required this.data,
    required super.child,
  });

  final TimetableThemeData data;

  @override
  bool updateShouldNotify(TimetableThemeScope oldWidget) => data != oldWidget.data;

  static TimetableThemeData? themeOf(
    BuildContext context, {
    bool listen = true,
  }) =>
      context.inhMaybeOf<TimetableThemeScope>(listen: listen)?.data;

  static TimetableThemeData maybeOrDefaultOf(
    BuildContext context, {
    bool listen = true,
  }) =>
      themeOf(context, listen: listen) ?? TimetableThemeData(context);
}
