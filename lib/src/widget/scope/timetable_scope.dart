import 'package:flutter/material.dart';

import '../../controller/controller.dart';
import '../../event/event.dart';
import '../../event/provider.dart';
import '../../model/model.dart';
import '../../resources/theme.dart';
import '../../typedef/typedef.dart';

import 'scope.dart';

class TimetableScope<E extends Event> extends StatefulWidget {
  TimetableScope({
    super.key,
    this.dateController,
    this.timeController,
    EventProvider<E>? eventProvider,
    this.eventBuilder,
    this.allDayEventBuilder,
    this.allDayOverflowBuilder,
    this.timeOverlayProvider,
    this.callbacks,
    this.theme,
    required this.child,
  }) : eventProvider = eventProvider?.debugChecked;

  final DateController? dateController;
  final TimeController? timeController;

  final EventProvider<E>? eventProvider;
  final EventBuilder<E>? eventBuilder;

  final AllDayEventBuilder<E>? allDayEventBuilder;
  final AllDayOverflowBuilder<E>? allDayOverflowBuilder;

  final TimeOverlayProvider? timeOverlayProvider;

  final TimetableCallbacks? callbacks;
  final TimetableThemeData? theme;

  final Widget child; 

  @override
  State<TimetableScope<E>> createState() => _TimetableScopeState<E>();
}

class _TimetableScopeState<E extends Event> extends State<TimetableScope<E>> {
  late final _dateController = DateController();
  late final _timeController = TimeController();

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dateController = widget.dateController ?? DateControllerScope.of(context) ?? _dateController;
    final timeController = widget.timeController ?? TimeControllerScope.of(context) ?? _timeController;
    final eventProvider = widget.eventProvider ?? EventProviderScope.of<E>(context) ?? (_) => [];
    final eventBuilder = widget.eventBuilder ?? EventBuilderScope.eventBuilderOf<E>(context)!;
    final allDayEventBuilder = widget.allDayEventBuilder;
    final allDayOverflowBuilder = widget.allDayOverflowBuilder;
    final timeOverlayProvider = widget.timeOverlayProvider ?? TimeOverlayProviderScope.of(context) ?? emptyTimeOverlayProvider;
    final callbacks = widget.callbacks ?? TimetableCallbacksScope.of(context) ?? const TimetableCallbacks();
    final theme = widget.theme ?? TimetableThemeScope.themeOf(context) ?? TimetableThemeData(context);

    return DateControllerScope(
      controller: dateController,
      child: TimeControllerScope(
        controller: timeController,
        child: EventProviderScope<E>(
          eventProvider: eventProvider,
          child: EventBuilderScope(
            builder: eventBuilder,
            allDayBuilder: allDayEventBuilder,
            allDayOverflowBuilder: allDayOverflowBuilder,
            child: TimeOverlayProviderScope(
              overlayProvider: timeOverlayProvider,
              child: TimetableCallbacksScope(
                callbacks: callbacks,
                child: TimetableThemeScope(
                  data: theme,
                  child: widget.child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
