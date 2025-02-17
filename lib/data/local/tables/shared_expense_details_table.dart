import 'package:drift/drift.dart';
import 'shared_expense_table.dart';
import 'currency_table.dart';
import 'loan_table.dart';
import 'transaction_table.dart';

@DataClassName('SharedExpenseDetail')
class SharedExpenseDetails extends Table {
  // Relational fields
  IntColumn get id => integer().autoIncrement()();
  IntColumn get sharedExpensesId => integer().references(SharedExpenses, #id)();
  TextColumn get currencyId => text().withLength(min: 3, max: 3).references(Currencies, #id)();
  IntColumn get loanId => integer().references(Loans, #id)();
  IntColumn get transactionId => integer().references(Transactions, #id)();
  
  // Main data fields
  RealColumn get percentage => real()();
  RealColumn get amount => real()();
  RealColumn get rateExchange => real()();
  TextColumn get status => text().withLength(min: 1, max: 1)();

  // Audit fields
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
