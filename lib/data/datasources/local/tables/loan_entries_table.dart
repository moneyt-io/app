import 'package:drift/drift.dart';

@DataClassName('LoanEntries')
class LoanEntry extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get documentTypeId => text().withLength(min: 1, max: 1)();
  TextColumn get currencyId => text().withLength(min: 1, max: 3)();
  IntColumn get contactId => integer()();
  IntColumn get secuencial => integer()();
  DateTimeColumn get date => dateTime()();
  RealColumn get amount => real()();
  RealColumn get rateExchange => real().withDefault(const Constant(1.0))();
  TextColumn get description => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('ACTIVE'))();
  RealColumn get totalPaid => real().withDefault(const Constant(0.0))(); // AGREGADO
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  String get tableName => 'loan_entries';
}
