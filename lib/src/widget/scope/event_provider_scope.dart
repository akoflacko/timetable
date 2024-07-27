import 'package:flutter/widgets.dart';

import '../../event/event.dart';
import '../../event/provider.dart';
import '../../extension/src/build_context.dart';

class EventProviderScope<E extends Event> extends InheritedWidget {
  EventProviderScope({
    required EventProvider<E> eventProvider,
    required super.child,
  }) : eventProvider = eventProvider.debugChecked;

  final EventProvider<E> eventProvider;

  @override
  bool updateShouldNotify(EventProviderScope oldWidget) => eventProvider != oldWidget.eventProvider;

  static EventProvider<E>? of<E extends Event>(
    BuildContext context, {
    bool listen = true,
  }) =>
      context
          .inhMaybeOf<EventProviderScope<E>>(
            listen: listen,
          )
          ?.eventProvider;
}
