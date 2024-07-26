extension DoubleTimetable on double {
  double coerceAtLeast(double min) => this < min ? min : this;

  double coerceAtMost(double max) => this > max ? max : this;

  double coerceIn(double min, double max) => coerceAtLeast(min).coerceAtMost(max);
}
