import '../../../timetable.dart';
import '../../utils.dart';

extension DateTimeTimetable on DateTime {
  static DateTime date(int year, [int month = 1, int day = 1]) {
    final date = DateTime.utc(year, month, day);
    assert(date.debugCheckIsValidTimetableDate());
    return date;
  }

  static DateTime month(int year, int month) {
    final date = DateTime.utc(year, month, 1);
    assert(date.debugCheckIsValidTimetableMonth());
    return date;
  }

  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    bool? isUtc,
  }) {
    return InternalDateTimeTimetable.create(
      year: year ?? this.year,
      month: month ?? this.month,
      day: day ?? this.day,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      second: second ?? this.second,
      millisecond: millisecond ?? this.millisecond,
      isUtc: isUtc ?? this.isUtc,
    );
  }

  Duration get timeOfDay => difference(atStartOfDay);

  DateTime get atStartOfDay => copyWith(hour: 0, minute: 0, second: 0, millisecond: 0);
  bool get isAtStartOfDay => this == atStartOfDay;
  DateTime get atEndOfDay => copyWith(hour: 23, minute: 59, second: 59, millisecond: 999);
  bool get isAtEndOfDay => this == atEndOfDay;

  static DateTime now() {
    final date = DateTime.now().copyWith(isUtc: true);
    assert(date.debugCheckIsValidTimetableDateTime());
    return date;
  }

  static DateTime today() {
    final date = DateTimeTimetable.now().atStartOfDay;
    assert(date.debugCheckIsValidTimetableDate());
    return date;
  }

  static DateTime currentMonth() {
    final month = DateTimeTimetable.today().firstDayOfMonth;
    assert(month.debugCheckIsValidTimetableMonth());
    return month;
  }

  bool get isToday => atStartOfDay == DateTimeTimetable.today();

  Interval get fullDayInterval {
    assert(debugCheckIsValidTimetableDate());
    return Interval(this, atEndOfDay);
  }

  DateTime nextOrSame(int dayOfWeek) {
    assert(debugCheckIsValidTimetableDate());
    assert(weekday.debugCheckIsValidTimetableDayOfWeek());

    return this + ((dayOfWeek - weekday) % DateTime.daysPerWeek).days;
  }

  DateTime previousOrSame(int weekday) {
    assert(debugCheckIsValidTimetableDate());
    assert(weekday.debugCheckIsValidTimetableDayOfWeek());

    return this - ((this.weekday - weekday) % DateTime.daysPerWeek).days;
  }

  int get daysInMonth {
    final february = isLeapYear ? 29 : 28;
    final index = this.month - 1;
    return [31, february, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31][index];
  }

  DateTime get firstDayOfMonth => atStartOfDay.copyWith(day: 1);
  DateTime get lastDayOfMonth => copyWith(day: daysInMonth);

  DateTime roundTimeToMultipleOf(Duration duration) {
    assert(duration.debugCheckIsValidTimetableTimeOfDay());
    return atStartOfDay + duration * (timeOfDay / duration).floor();
  }

  double get page {
    assert(debugCheckIsValidTimetableDateTime());
    return millisecondsSinceEpoch / Duration.millisecondsPerDay;
  }

  int get datePage {
    assert(debugCheckIsValidTimetableDate());
    return page.floor();
  }

  static DateTime dateFromPage(int page) {
    final date = DateTime.fromMillisecondsSinceEpoch(
      (page * Duration.millisecondsPerDay).toInt(),
      isUtc: true,
    );
    assert(date.debugCheckIsValidTimetableDate());
    return date;
  }

  static DateTime dateTimeFromPage(double page) {
    return DateTime.fromMillisecondsSinceEpoch(
      (page * Duration.millisecondsPerDay).toInt(),
      isUtc: true,
    );
  }
}

extension DateTimeWeekTimetable on DateTime {
  Week get week => Week.forDate(this);

  int get dayOfYear {
    const common = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334];
    const leapOffsets = [0, 31, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335];
    final offsets = isLeapYear ? leapOffsets : common;
    return offsets[month - 1] + day;
  }

  bool get isLeapYear => year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);
}

extension InternalDateTimeTimetable on DateTime {
  static DateTime create({
    required int year,
    int month = 1,
    int day = 1,
    int hour = 0,
    int minute = 0,
    int second = 0,
    int millisecond = 0,
    bool isUtc = true,
  }) {
    final constructor = isUtc ? DateTime.utc : DateTime.new;
    return constructor(year, month, day, hour, minute, second, millisecond);
  }

  DateTime operator +(Duration duration) => add(duration);

  DateTime operator -(Duration duration) => subtract(duration);

  bool operator <(DateTime other) => isBefore(other);
  bool operator <=(DateTime other) => isBefore(other) || isAtSameMomentAs(other);
  bool operator >(DateTime other) => isAfter(other);
  bool operator >=(DateTime other) => isAfter(other) || isAtSameMomentAs(other);

  static final List<int> innerDateHours = List.generate(Duration.hoursPerDay - 1, (i) => i + 1);
}
