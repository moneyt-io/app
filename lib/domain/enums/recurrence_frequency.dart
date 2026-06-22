/// Enum representing the frequency of a recurring transaction.
/// 
/// Values correspond to the string stored in the database column
/// `recurrenceFrequency` on `transaction_entries`.
enum RecurrenceFrequency {
  daily,
  weekly,
  monthly,
  bimonthly,
  quarterly,
  yearly;

  /// The raw string key persisted in the database.
  String get key => name; // 'daily', 'weekly', etc.

  /// Display label in Spanish (fallback when i18n is not available).
  String get labelEs {
    switch (this) {
      case RecurrenceFrequency.daily:
        return 'Diario';
      case RecurrenceFrequency.weekly:
        return 'Semanal';
      case RecurrenceFrequency.monthly:
        return 'Mensual';
      case RecurrenceFrequency.bimonthly:
        return 'Bimestral';
      case RecurrenceFrequency.quarterly:
        return 'Trimestral';
      case RecurrenceFrequency.yearly:
        return 'Anual';
    }
  }

  /// Emoji associated with this frequency.
  String get emoji {
    switch (this) {
      case RecurrenceFrequency.daily:
        return '📅';
      case RecurrenceFrequency.weekly:
        return '📆';
      case RecurrenceFrequency.monthly:
        return '🔄';
      case RecurrenceFrequency.bimonthly:
        return '🗓️';
      case RecurrenceFrequency.quarterly:
        return '📊';
      case RecurrenceFrequency.yearly:
        return '🎯';
    }
  }

  /// Parses a string key from the database. Returns null if the key
  /// does not match any known frequency (i.e., the transaction is not recurring).
  static RecurrenceFrequency? fromKey(String? key) {
    if (key == null) return null;
    for (final value in RecurrenceFrequency.values) {
      if (value.key == key) return value;
    }
    return null;
  }
}
