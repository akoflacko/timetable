import 'package:flutter/widgets.dart';

extension BuildContextX on BuildContext {
  T? inhMaybeOf<T extends InheritedWidget>({
    bool listen = true,
  }) =>
      listen ? dependOnInheritedWidgetOfExactType<T>() : getInheritedWidgetOfExactType<T>();

  T inhOf<T extends InheritedWidget>({
    bool listen = true,
  }) =>
      inhMaybeOf<T>(listen: listen) ??
      (throw ArgumentError(
        'Out of scope, not found inherited widget '
            'a $T of the exact type',
        'out_of_scope',
      ));

  T? inhFrom<T extends InheritedModel<Object>>(
    Object aspect,
  ) =>
      InheritedModel.inheritFrom<T>(
        this,
        aspect: aspect,
      );
}
