import 'package:drift/drift.dart';
import 'accounting_type_table.dart';

@DataClassName('ChartAccount')
class ChartAccounts extends Table {
  // Relational fields
  TextColumn get id => text().withLength(min: 1, max: 1)();
  TextColumn get parentId => text().nullable().withLength(min: 1, max: 1).references(ChartAccounts, #id)();
  TextColumn get accountingTypeId => text().withLength(min: 1, max: 1).references(AccountingTypes, #id)();
  
  // Main data fields
  TextColumn get code => text().withLength(min: 1, max: 50)();
  IntColumn get level => integer()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  BoolColumn get active => boolean().withDefault(const Constant(true))();

  // Audit fields
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
