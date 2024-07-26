extension InternalDurationTimetable on Duration {
  double operator /(Duration other) => inMicroseconds / other.inMicroseconds;
}
