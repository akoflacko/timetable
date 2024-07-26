import 'package:flutter/widgets.dart';

import '../event/all_day.dart';
import '../event/event.dart';
import '../model/model.dart';
import '../widget/widget.dart';

typedef AllDayEventBuilder<E extends Event> = Widget Function(
  BuildContext context,
  E event,
  AllDayEventLayoutInfo info,
);

typedef AllDayOverflowBuilder<E extends Event> = Widget Function(
  BuildContext context,
  DateTime date,
  List<E> overflowedEvents,
);

typedef DateWidgetBuilder = Widget Function(
  BuildContext context,
  DateTime date,
);

typedef EventBuilder<E extends Event> = Widget Function(
  BuildContext context,
  E event,
);

typedef MonthWidgetBuilder = Widget Function(
  BuildContext context,
  DateTime month,
);

typedef WeekWidgetBuilder = Widget Function(
  BuildContext context,
  Week week,
);

typedef MultiDateTimetableHeaderBuilder = Widget Function(
  BuildContext context,
  double? leadingWidth,
);

typedef MultiDateTimetableContentBuilder = Widget Function(
  BuildContext context,
  ValueChanged<double> onLeadingWidthChanged,
);

typedef WeekTapCallback = void Function(Week week);

typedef DateTapCallback = void Function(DateTime date);

typedef DateTimeTapCallback = void Function(DateTime dateTime);

/// Provides [TimeOverlay]s to Timetable widgets.
///
/// [TimeOverlayProvider]s may only return overlays for the given [date].
///
/// See also:
///
/// * [emptyTimeOverlayProvider], which returns an empty list for all dates.
/// * [mergeTimeOverlayProviders], which merges multiple [TimeOverlayProvider]s.
typedef TimeOverlayProvider = List<TimeOverlay> Function(
  BuildContext context,
  DateTime date,
);

typedef MonthBasedStyleProvider<T> = T Function(DateTime month);

typedef WeekBasedStyleProvider<T> = T Function(Week week);

typedef DateBasedStyleProvider<T> = T Function(DateTime date);

typedef TimeBasedStyleProvider<T> = T Function(Duration time);

typedef Mapper<T, R> = R Function(T);

typedef PartDayDragStartCallback = VoidCallback;

typedef PartDayDragUpdateCallbackRaw = void Function(
  GlobalKey<MultiDateContentGeometry>? geometryKey,
  DateTime dateTime,
);

typedef PartDayDragUpdateCallback = void Function(DateTime dateTime);

typedef PartDayDragUpdateCallbackWithGeometryKey = void Function(
  GlobalKey<MultiDateContentGeometry> geometryKey,
  DateTime dateTime,
);

typedef PartDayDragEndCallbackRaw = void Function(
  GlobalKey<MultiDateContentGeometry>? geometryKey,
  DateTime? dateTime,
);

typedef PartDayDragEndCallback = void Function(DateTime? dateTime);

typedef PartDayDragEndCallbackWithGeometryKey = void Function(
  GlobalKey<MultiDateContentGeometry> geometryKey,
  DateTime? dateTime,
);

typedef PartDayDragCanceledCallbackRaw = void Function(
  GlobalKey<MultiDateContentGeometry>? geometryKey,
  // ignore: avoid_positional_boolean_parameters
  bool wasMoved,
);

// ignore: avoid_positional_boolean_parameters
typedef PartDayDragCanceledCallback = void Function(bool wasMoved);

typedef PartDayDragCanceledCallbackWithGeometryKey = void Function(
  GlobalKey<MultiDateContentGeometry> geometryKey,
  // ignore: avoid_positional_boolean_parameters
  bool wasMoved,
);
