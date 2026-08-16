import 'package:flutter_test/flutter_test.dart';
import 'package:moneyt_pfm/core/utils/recurring_date_helper.dart';
import 'package:moneyt_pfm/domain/enums/recurrence_frequency.dart';

void main() {
  group('RecurringDateHelper Tests', () {
    test('Normalizes dates by stripping time component', () {
      final dt = DateTime(2026, 7, 1, 14, 30, 45, 123);
      final normalized = RecurringDateHelper.toDateOnly(dt);
      expect(normalized, equals(DateTime(2026, 7, 1)));
    });

    test('Monthly calculation maintains day of month accurately', () {
      final start = DateTime(2026, 7, 1);
      final next = RecurringDateHelper.calculateNextDueDate(
        start,
        RecurrenceFrequency.monthly,
      );
      expect(next, equals(DateTime(2026, 8, 1)));

      final next2 = RecurringDateHelper.calculateNextDueDate(
        next,
        RecurrenceFrequency.monthly,
      );
      expect(next2, equals(DateTime(2026, 9, 1)));
    });

    test('Handles month-end overflow gracefully (Jan 31 -> Feb 28 in non-leap year)', () {
      final jan31 = DateTime(2025, 1, 31);
      final feb = RecurringDateHelper.calculateNextDueDate(
        jan31,
        RecurrenceFrequency.monthly,
      );
      expect(feb, equals(DateTime(2025, 2, 28)));
    });

    test('Handles leap year month-end (Jan 31 2024 -> Feb 29 2024)', () {
      final jan31 = DateTime(2024, 1, 31);
      final feb = RecurringDateHelper.calculateNextDueDate(
        jan31,
        RecurrenceFrequency.monthly,
      );
      expect(feb, equals(DateTime(2024, 2, 29)));
    });

    test('computeDueDates calculates all missed intervals between July 1 and August 15', () {
      final lastRef = DateTime(2026, 7, 1);
      final now = DateTime(2026, 8, 15, 10, 0);

      final dueDates = RecurringDateHelper.computeDueDates(
        lastRef,
        RecurrenceFrequency.monthly,
        now,
      );

      // Should contain exactly August 1st (not July 1st because lastRef is exclusive, and not Sept 1st because it is after now)
      expect(dueDates.length, equals(1));
      expect(dueDates.first, equals(DateTime(2026, 8, 1)));
    });

    test('computeDueDates returns multiple dates if user was offline for several months', () {
      final lastRef = DateTime(2026, 1, 1);
      final now = DateTime(2026, 4, 15);

      final dueDates = RecurringDateHelper.computeDueDates(
        lastRef,
        RecurrenceFrequency.monthly,
        now,
      );

      expect(dueDates.length, equals(3));
      expect(dueDates[0], equals(DateTime(2026, 2, 1)));
      expect(dueDates[1], equals(DateTime(2026, 3, 1)));
      expect(dueDates[2], equals(DateTime(2026, 4, 1)));
    });

    test('computeDueDates returns empty if next due date is in the future', () {
      final lastRef = DateTime(2026, 8, 1);
      final now = DateTime(2026, 8, 10);

      final dueDates = RecurringDateHelper.computeDueDates(
        lastRef,
        RecurrenceFrequency.monthly,
        now,
      );

      expect(dueDates.isEmpty, isTrue);
    });

    test('Daily frequency advances day by day', () {
      final start = DateTime(2026, 8, 1);
      final next = RecurringDateHelper.calculateNextDueDate(
        start,
        RecurrenceFrequency.daily,
      );
      expect(next, equals(DateTime(2026, 8, 2)));
    });

    test('Weekly frequency advances 7 days', () {
      final start = DateTime(2026, 8, 1);
      final next = RecurringDateHelper.calculateNextDueDate(
        start,
        RecurrenceFrequency.weekly,
      );
      expect(next, equals(DateTime(2026, 8, 8)));
    });

    test('Yearly frequency advances exactly 1 year', () {
      final start = DateTime(2026, 7, 1);
      final next = RecurringDateHelper.calculateNextDueDate(
        start,
        RecurrenceFrequency.yearly,
      );
      expect(next, equals(DateTime(2027, 7, 1)));
    });
  });
}
