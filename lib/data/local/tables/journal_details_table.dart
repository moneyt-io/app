import 'package:drift/drift.dart';
import 'journal_table.dart';
import 'currency_table.dart';
import 'chart_accounts_table.dart';

@DataClassName('JournalDetail')
class JournalDetails extends Table {
  // Relational fields
  IntColumn get id => integer().autoIncrement()();
  IntColumn get journalId => integer().references(Journal, #id)();
  TextColumn get currencyId => text().withLength(min: 3, max: 3).references(Currencies, #id)();
  TextColumn get chartAccountId => text().withLength(min: 1, max: 1).references(ChartAccounts, #id)();
  
  // Main data fields
  RealColumn get credit => real()();
  RealColumn get debit => real()();
  RealColumn get rateExchange => real()();
}
