import 'package:drift/drift.dart';
import 'journal_entries_table.dart';
import 'currencies_table.dart';
import 'chart_accounts_table.dart';

@DataClassName('JournalDetails')
class JournalDetail extends Table {
  // Relational fields
  IntColumn get id => integer().autoIncrement()();
  IntColumn get journalId => integer().references(JournalEntry, #id)();
  TextColumn get currencyId => text().withLength(min: 3, max: 3).references(Currency, #id)();
  IntColumn get chartAccountId => integer().references(ChartAccount, #id)();
  
  // Main data fields
  RealColumn get credit => real()();
  RealColumn get debit => real()();
  RealColumn get rateExchange => real()();
}
