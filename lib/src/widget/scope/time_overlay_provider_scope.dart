import 'package:flutter/widgets.dart';

import '../../extension/src/build_context.dart';
import '../../typedef/typedef.dart';

class TimeOverlayProviderScope extends InheritedWidget {
  const TimeOverlayProviderScope({
    required this.overlayProvider,
    required super.child,
  });

  final TimeOverlayProvider overlayProvider;

  @override
  bool updateShouldNotify(TimeOverlayProviderScope oldWidget) => overlayProvider != oldWidget.overlayProvider;

  static TimeOverlayProvider? of(
    BuildContext context, {
    bool listen = true,
  }) =>
      context
          .inhMaybeOf<TimeOverlayProviderScope>(
            listen: listen,
          )
          ?.overlayProvider;
}
