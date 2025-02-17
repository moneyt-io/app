import 'package:drift/drift.dart';
import 'loan_table.dart';
import 'currency_table.dart';
import 'payment_type_table.dart';
import 'journal_table.dart';
import 'transaction_table.dart';

@DataClassName('LoanDetail')
class LoanDetails extends Table {
  // Relational fields
  IntColumn get id => integer().autoIncrement()();
  IntColumn get loanId => integer().references(Loans, #id)();
  TextColumn get currencyId => text().withLength(min: 3, max: 3).references(Currencies, #id)();
  TextColumn get paymentTypeId => text().withLength(min: 1, max: 1).references(PaymentTypes, #id)();
  IntColumn get paymentId => integer()();
  IntColumn get journalId => integer().references(Journal, #id)();
  IntColumn get transactionId => integer().references(Transactions, #id)();
  
  // Main data fields
  RealColumn get amount => real()();
  RealColumn get rateExchange => real()();

  // Audit fields
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
