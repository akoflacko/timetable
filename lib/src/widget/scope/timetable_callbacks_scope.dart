import 'package:flutter/widgets.dart';

import '../../extension/src/build_context.dart';
import '../../model/model.dart';

/// Provides the default callbacks for Timetable widgets below it.
///
/// [TimetableCallbacksScope] widgets above this on are overridden.
class TimetableCallbacksScope extends InheritedWidget {
  const TimetableCallbacksScope({
    required this.callbacks,
    required super.child,
  });

  final TimetableCallbacks callbacks;

  @override
  bool updateShouldNotify(TimetableCallbacksScope oldWidget) => callbacks != oldWidget.callbacks;

  static TimetableCallbacks? of(
    BuildContext context, {
    bool listen = true,
  }) =>
      context
          .inhMaybeOf<TimetableCallbacksScope>(
            listen: listen,
          )
          ?.callbacks;
}
