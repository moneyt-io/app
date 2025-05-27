import 'package:drift/drift.dart';

@DataClassName('LoanDetails')
class LoanDetail extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get loanId => integer()();
  TextColumn get currencyId => text().withLength(min: 1, max: 3)();
  TextColumn get paymentTypeId => text().withLength(min: 1, max: 1)();
  IntColumn get paymentId => integer()();
  IntColumn get journalId => integer()();
  IntColumn get transactionId => integer()();
  RealColumn get amount => real()();
  RealColumn get rateExchange => real().withDefault(const Constant(1.0))();
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  String get tableName => 'loan_details';
}
