import 'package:flutter/widgets.dart';

import '../event/event.dart';
import '../extension/extension.dart';
import '../model/overlay.dart';
import '../typedef/typedef.dart';
import '../utils.dart';

import 'date_events.dart';
import 'scope/scope.dart';
import 'time_overlays.dart';

/// A widget that displays [Event]s and [TimeOverlay]s.
///
/// If [onBackgroundTap] is not supplied, [TimetableCallbacksScope]'s
/// `onDateTimeBackgroundTap` is used if it's provided above in the widget tree.
///
/// See also:
///
/// * [DateEvents] and [TimeOverlays], which are used to actually layout
///   [Event]s and [TimeOverlay]s. [DateEvents] can be styled.
/// * [TimetableCallbacksScope], which provides callbacks to descendant
///   Timetable widgets.
class DateContent<E extends Event> extends StatelessWidget {
  DateContent({
    super.key,
    required this.date,
    required List<E> events,
    this.overlays = const [],
    this.onBackgroundTap,
  })  : assert(date.debugCheckIsValidTimetableDate()),
        assert(
          events.every((e) => e.interval.intersects(date.fullDayInterval)),
          'All events must intersect the given date',
        ),
        events = events.sortedByStartLength();

  final DateTime date;

  final List<E> events;
  final List<TimeOverlay> overlays;

  final DateTimeTapCallback? onBackgroundTap;

  @override
  Widget build(BuildContext context) {
    final onBackgroundTap = this.onBackgroundTap ?? TimetableCallbacksScope.of(context)?.onDateTimeBackgroundTap;

    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;

        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTapUp: onBackgroundTap != null ? (details) => onBackgroundTap(date + (details.localPosition.dy / height).days) : null,
          child: Stack(
            children: [
              _buildOverlaysForPosition(
                TimeOverlayPosition.behindEvents,
              ),
              DateEvents<E>(
                date: date,
                events: events,
              ),
              _buildOverlaysForPosition(
                TimeOverlayPosition.inFrontOfEvents,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOverlaysForPosition(
    TimeOverlayPosition position,
  ) =>
      Positioned.fill(
        child: TimeOverlays(
          overlays: overlays
              .where((it) => it.position == position) //
              .toList(),
        ),
      );
}
