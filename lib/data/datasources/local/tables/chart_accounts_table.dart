import 'package:drift/drift.dart';
import 'accounting_types_tables.dart';

@DataClassName('ChartAccounts')
class ChartAccount extends Table {
  // Relational fields
  IntColumn get id => integer().autoIncrement()();
  IntColumn get parentId => integer().nullable().references(ChartAccount, #id)();
  TextColumn get accountingTypeId => text().withLength(min: 1, max: 1).references(AccountingType, #id)();
  
  // Main data fields
  TextColumn get code => text().withLength(min: 1, max: 50)();
  IntColumn get level => integer()();
  TextColumn get name => text().withLength(min: 1, max: 50)();

  // Audit fields
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
