import 'package:drift/drift.dart';
import 'loan_entries_table.dart';
import 'currencies_table.dart';
import 'payment_types_table.dart';
import 'journal_entries_table.dart';
import 'transaction_entries_table.dart';

@DataClassName('LoanDetails')
class LoanDetail extends Table {
  // Relational fields
  IntColumn get id => integer().autoIncrement()();
  IntColumn get loanId => integer().references(LoanEntry, #id)();
  TextColumn get currencyId => text().withLength(min: 3, max: 3).references(Currency, #id)();
  TextColumn get paymentTypeId => text().withLength(min: 1, max: 1).references(PaymentType, #id)();
  IntColumn get paymentId => integer()();
  IntColumn get journalId => integer().references(JournalEntry, #id)();
  IntColumn get transactionId => integer().references(TransactionEntry, #id)();
  
  // Main data fields
  RealColumn get amount => real()();
  RealColumn get rateExchange => real()();

  // Audit fields
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
