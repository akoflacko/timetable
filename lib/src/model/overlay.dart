import 'package:flutter/widgets.dart';

import '../event/event.dart';
import '../extension/extension.dart';
import '../typedef/typedef.dart';
import '../utils.dart';

@immutable
class TimeOverlay {
  TimeOverlay({
    required this.start,
    required this.end,
    required this.widget,
    this.position = TimeOverlayPosition.behindEvents,
  })  : assert(start.debugCheckIsValidTimetableTimeOfDay()),
        assert(end.debugCheckIsValidTimetableTimeOfDay()),
        assert(start < end);

  final Duration start;
  final Duration end;

  /// The widget that will be shown as an overlay.
  final Widget widget;

  /// Whether to paint this overlay behind or in front of events.
  final TimeOverlayPosition position;
}

enum TimeOverlayPosition { behindEvents, inFrontOfEvents }

// ignore: prefer_function_declarations_over_variables
final TimeOverlayProvider emptyTimeOverlayProvider = (context, date) {
  assert(date.debugCheckIsValidTimetableDate());
  return [];
};

TimeOverlayProvider mergeTimeOverlayProviders(
  List<TimeOverlayProvider> overlayProviders,
) {
  return (context, date) => overlayProviders.expand((it) => it(context, date)).toList();
}

extension EventToTimeOverlay on Event {
  TimeOverlay? toTimeOverlay({
    required DateTime date,
    required Widget widget,
    TimeOverlayPosition position = TimeOverlayPosition.inFrontOfEvents,
  }) {
    assert(date.debugCheckIsValidTimetableDate());

    if (!interval.intersects(date.fullDayInterval)) return null;

    return TimeOverlay(
      start: start.difference(date).coerceAtLeast(Duration.zero),
      end: endInclusive.difference(date).coerceAtMost(1.days),
      widget: widget,
      position: position,
    );
  }
}
