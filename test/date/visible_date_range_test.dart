import 'package:flutter_test/flutter_test.dart';
import 'package:timetable/timetable.dart';
import 'dart:math';

void main() {
  group('VisibleDateRange.days', () {
    test('getTargetPageForFocus', () {
      for (var i = 0; i < 100; i++) {
        final rangeSize = Random().nextInt(1000) + 1;
        final page = Random().nextInt(10000);
        expect(
          VisibleDateRange.days(rangeSize).getTargetPageForFocus(page.toDouble()),
          page,
        );
      }
    });

    test('getTargetPageForCurrent', () {
      for (var i = 0; i < 100; i++) {
        final rangeSize = Random().nextInt(1000) + 1;
        final page = Random().nextDouble() * 10000;
        expect(
          VisibleDateRange.days(rangeSize).getTargetPageForCurrent(page),
          page.round(),
        );
      }
    });

    test('scrolling with limits without swipe range', () {
      for (var i = 0; i < 100; i++) {
        final visibleDayCount = Random().nextInt(1000) + 1;
        final maxDateOffset = Random().nextInt(1000) + 1;
        final minDate = DateTimeTimetable.today();
        final maxDate = minDate.add(Duration(days: maxDateOffset));

        final range = DaysVisibleDateRange(
          visibleDayCount,
          minDate: minDate,
          maxDate: maxDate,
        );

        expect(range.visibleDayCount, visibleDayCount);
        expect(range.minPage, minDate.page);
        expect(
          range.maxPage,
          (maxDate.page - visibleDayCount + 1).coerceAtLeast(minDate.page),
        );
      }
    });
  });

  group('VisibleDateRange.week', () {
    test('getTargetPageForFocus', () {
      for (var i = 0; i < 100; i++) {
        final startOfWeek = _randomDayOfWeek();
        final page = Random().nextInt(10000);
        final daysFromWeekStart = (DateTimeTimetable.dateFromPage(page).weekday - startOfWeek) % DateTime.daysPerWeek;
        expect(
          VisibleDateRange.week(startOfWeek: startOfWeek).getTargetPageForFocus(page.toDouble()),
          page - daysFromWeekStart,
        );
      }
    });

    test('getTargetPageForCurrent', () {
      for (var i = 0; i < 100; i++) {
        final startOfWeek = _randomDayOfWeek();
        final page = Random().nextDouble() * 10000;
        final floorPage = page.floor();
        final daysFromWeekStart = (DateTimeTimetable.dateFromPage(floorPage).weekday + (page % 1) - startOfWeek) % DateTime.daysPerWeek;

        var targetPage = page - daysFromWeekStart;
        if (daysFromWeekStart > DateTime.daysPerWeek / 2) {
          targetPage += DateTime.daysPerWeek;
        }

        expect(
          VisibleDateRange.week(startOfWeek: startOfWeek).getTargetPageForCurrent(page),
          targetPage,
        );
      }
    });
  });
}

int _randomDayOfWeek() => Random().nextInt(7) + DateTime.monday;
