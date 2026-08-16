import '../../domain/enums/recurrence_frequency.dart';

/// Utility class for calculating recurring dates safely across calendars,
/// preventing month-overflow bugs (e.g. 31 Jan -> 28 Feb -> 31 Mar)
/// and normalizing dates to strip out time-of-day discrepancies.
class RecurringDateHelper {
  RecurringDateHelper._();

  /// Advances a given date by the specified [frequency] preserving the target day-of-month.
  /// If the target month has fewer days than the original day (e.g., Feb 30),
  /// it clamps to the last valid day of that month (e.g., Feb 28/29).
  static DateTime advanceDate(DateTime from, RecurrenceFrequency frequency) {
    switch (frequency) {
      case RecurrenceFrequency.daily:
        return DateTime(from.year, from.month, from.day + 1);

      case RecurrenceFrequency.weekly:
        return DateTime(from.year, from.month, from.day + 7);

      case RecurrenceFrequency.monthly:
        return _addMonths(from, 1);

      case RecurrenceFrequency.bimonthly:
        return _addMonths(from, 2);

      case RecurrenceFrequency.quarterly:
        return _addMonths(from, 3);

      case RecurrenceFrequency.yearly:
        return _addYears(from, 1);
    }
  }

  /// Calculates the next scheduled execution date strictly after [referenceDate].
  static DateTime calculateNextDueDate(DateTime referenceDate, RecurrenceFrequency frequency) {
    return advanceDate(referenceDate, frequency);
  }

  /// Returns all due dates between [lastRef] (exclusive) and [now] (inclusive).
  /// Max iterations safety cap is 365.
  static List<DateTime> computeDueDates(
    DateTime lastRef,
    RecurrenceFrequency freq,
    DateTime now,
  ) {
    final dates = <DateTime>[];
    final normalizedNow = DateTime(now.year, now.month, now.day, 23, 59, 59);
    DateTime cursor = DateTime(lastRef.year, lastRef.month, lastRef.day);
    int iterations = 0;

    while (iterations < 365) {
      final next = advanceDate(cursor, freq);
      if (next.isAfter(normalizedNow)) break;
      dates.add(next);
      cursor = next;
      iterations++;
    }

    return dates;
  }

  /// Normalizes a DateTime to date-only (00:00:00).
  static DateTime toDateOnly(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// Checks if two dates share the exact same calendar year, month, and day.
  static bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  static DateTime _addMonths(DateTime from, int monthsToAdd) {
    final targetYear = from.year + ((from.month - 1 + monthsToAdd) ~/ 12);
    final targetMonth = ((from.month - 1 + monthsToAdd) % 12) + 1;
    final maxDaysInTargetMonth = _daysInMonth(targetYear, targetMonth);
    final targetDay = from.day > maxDaysInTargetMonth ? maxDaysInTargetMonth : from.day;
    return DateTime(targetYear, targetMonth, targetDay);
  }

  static DateTime _addYears(DateTime from, int yearsToAdd) {
    final targetYear = from.year + yearsToAdd;
    final targetMonth = from.month;
    final maxDays = _daysInMonth(targetYear, targetMonth);
    final targetDay = from.day > maxDays ? maxDays : from.day;
    return DateTime(targetYear, targetMonth, targetDay);
  }

  static int _daysInMonth(int year, int month) {
    // Day 0 of the next month gives the last day of the current month
    return DateTime(year, month + 1, 0).day;
  }
}
