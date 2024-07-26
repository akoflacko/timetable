import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../controller/controller.dart';

import 'date_page_value.dart';

/// The equivalent of [ScrollActivity] for [DateController].
@immutable
abstract class DateScrollActivity with Diagnosticable {
  const DateScrollActivity();
}

/// A scroll activity that does nothing.
class IdleDateScrollActivity extends DateScrollActivity {
  const IdleDateScrollActivity();
}

/// The activity a [DateController] performs when the user drags their finger
/// across the screen and is settling afterwards.
class DragDateScrollActivity extends DateScrollActivity {
  const DragDateScrollActivity();
}

/// A scroll activity for when the [DateController] is animated to a new page.
class DrivenDateScrollActivity extends DateScrollActivity {
  const DrivenDateScrollActivity(this.target);

  final DatePageValue target;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('target', target));
  }
}
