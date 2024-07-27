import 'package:flutter/widgets.dart' hide Interval;

import '../../event/event.dart';
import '../../extension/src/build_context.dart';
import '../../typedef/typedef.dart';
import '../multi_date_event_header_overflow.dart';

class EventBuilderScope<E extends Event> extends InheritedWidget {
  EventBuilderScope({
    required this.builder,
    AllDayEventBuilder<E>? allDayBuilder,
    AllDayOverflowBuilder<E>? allDayOverflowBuilder,
    required super.child,
  })  : allDayBuilder = allDayBuilder ?? ((context, event, _) => builder(context, event)),
        allDayOverflowBuilder = allDayOverflowBuilder ??
            ((context, date, overflowedEvents) => MultiDateEventHeaderOverflow(
                  date,
                  overflowCount: overflowedEvents.length,
                ));

  final EventBuilder<E> builder;
  final AllDayEventBuilder<E> allDayBuilder;
  final AllDayOverflowBuilder<E> allDayOverflowBuilder;

  @override
  bool updateShouldNotify(
    EventBuilderScope<E> oldWidget,
  ) =>
      builder != oldWidget.builder || allDayBuilder != oldWidget.allDayBuilder;

  static EventBuilder<E>? eventBuilderOf<E extends Event>(
    BuildContext context, {
    bool listen = true,
  }) =>
      context
          .inhMaybeOf<EventBuilderScope<E>>(
            listen: listen,
          )
          ?.builder;

  static AllDayEventBuilder<E>? allDayOf<E extends Event>(
    BuildContext context, {
    bool listen = true,
  }) =>
      context
          .inhMaybeOf<EventBuilderScope<E>>(
            listen: listen,
          )
          ?.allDayBuilder;

  static AllDayOverflowBuilder<E>? allDayOverflowOf<E extends Event>(
    BuildContext context, {
    bool listen = true,
  }) =>
      context
          .inhMaybeOf<EventBuilderScope<E>>(
            listen: listen,
          )
          ?.allDayOverflowBuilder;
}
