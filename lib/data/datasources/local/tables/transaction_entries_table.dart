import 'package:drift/drift.dart';

@DataClassName('TransactionEntries')
class TransactionEntry extends Table {
  // Relational fields
  IntColumn get id => integer().autoIncrement()();
  TextColumn get documentTypeId => text().withLength(min: 1, max: 1)();
  TextColumn get currencyId => text().withLength(min: 1, max: 3)();
  IntColumn get journalId => integer()();
  IntColumn get contactId => integer().nullable()();
  
  // Main data fields
  IntColumn get secuencial => integer()();
  DateTimeColumn get date => dateTime()();
  RealColumn get amount => real()();
  RealColumn get rateExchange => real().withDefault(const Constant(1.0))();
  TextColumn get description => text().nullable()();

  // Audit fields
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}