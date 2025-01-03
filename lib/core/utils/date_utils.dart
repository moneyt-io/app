// lib/core/utils/date_utils.dart

class DateRange {
  final DateTime start;
  final DateTime end;

  DateRange({required this.start, required this.end});
}

DateRange calculateDateRange(String range) {
  final now = DateTime.now();
  DateTime start;
  DateTime end;

  switch (range) {
    case 'today':
      start = DateTime(now.year, now.month, now.day);
      end = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);
      break;
    case 'yesterday':
      final yesterday = now.subtract(const Duration(days: 1));
      start = DateTime(yesterday.year, yesterday.month, yesterday.day);
      end = DateTime(yesterday.year, yesterday.month, yesterday.day, 23, 59, 59, 999);
      break;
    case 'lastWeek':
      end = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);
      start = end.subtract(const Duration(days: 7));
      break;
    case 'lastMonth':
      end = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);
      // Restamos un mes y ajustamos por si el día actual no existe en el mes anterior
      if (now.month == 1) {
        start = DateTime(now.year - 1, 12, now.day);
      } else {
        final daysInPreviousMonth = DateTime(now.year, now.month, 0).day;
        final day = now.day > daysInPreviousMonth ? daysInPreviousMonth : now.day;
        start = DateTime(now.year, now.month - 1, day);
      }
      break;
    case 'lastThreeMonths':
      end = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);
      // Restamos tres meses y ajustamos por si el día actual no existe
      if (now.month <= 3) {
        final newMonth = now.month + 9; // Volvemos al año anterior
        final daysInMonth = DateTime(now.year - 1, newMonth, 0).day;
        final day = now.day > daysInMonth ? daysInMonth : now.day;
        start = DateTime(now.year - 1, newMonth, day);
      } else {
        final daysInMonth = DateTime(now.year, now.month - 3, 0).day;
        final day = now.day > daysInMonth ? daysInMonth : now.day;
        start = DateTime(now.year, now.month - 3, day);
      }
      break;
    case 'thisYear':
      start = DateTime(now.year, 1, 1);
      end = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);
      break;
    case 'custom':
    default:
      start = now.subtract(const Duration(days: 30));
      end = now;
  }

  return DateRange(start: start, end: end);
}
