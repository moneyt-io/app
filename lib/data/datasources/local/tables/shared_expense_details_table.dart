import 'package:drift/drift.dart';
import 'shared_expense_entries_table.dart';
import 'currencies_table.dart';
import 'loan_entries_table.dart';
import 'transaction_entries_table.dart';

@DataClassName('SharedExpenseDetails')
class SharedExpenseDetail extends Table {
  // Relational fields
  IntColumn get id => integer().autoIncrement()();
  IntColumn get sharedExpenseId => integer().references(SharedExpenseEntry, #id)();
  TextColumn get currencyId => text().withLength(min: 3, max: 3).references(Currency, #id)();
  IntColumn get loanId => integer().references(LoanEntry, #id)();
  IntColumn get transactionId => integer().references(TransactionEntry, #id)();
  
  // Main data fields
  RealColumn get percentage => real()();
  RealColumn get amount => real()();
  RealColumn get rateExchange => real()();
  TextColumn get status => text().withLength(min: 1, max: 1)();
}
