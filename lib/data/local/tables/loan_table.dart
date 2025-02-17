import 'package:drift/drift.dart';
import 'document_type_table.dart';
import 'currency_table.dart';
import 'contact_table.dart';

@DataClassName('Loan')
class Loans extends Table {
  // Relational fields
  IntColumn get id => integer().autoIncrement()();
  TextColumn get documentTypeId => text().withLength(min: 1, max: 1).references(DocumentTypes, #id)();
  TextColumn get currencyId => text().withLength(min: 3, max: 3).references(Currencies, #id)();
  IntColumn get contactId => integer().references(Contacts, #id)();
  
  // Main data fields
  IntColumn get secuencial => integer()();
  DateTimeColumn get date => dateTime()();
  RealColumn get amount => real()();
  RealColumn get rateExchange => real()();
  TextColumn get description => text().nullable()();
  TextColumn get status => text().withLength(min: 1, max: 1)();

  // Audit fields
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
