// lib/data/local/database.dart
import 'package:drift/drift.dart';
import 'document_type_table.dart';
import 'chart_accounts_table.dart';

@DataClassName('Category')
class Categories extends Table {
  // Relational fields
  IntColumn get id => integer().autoIncrement()();
  IntColumn get parentId => integer().nullable().references(Categories, #id)();
  TextColumn get documentTypeId => text().withLength(min: 1, max: 1).references(DocumentTypes, #id)();
  TextColumn get chartAccountId => text().withLength(min: 1, max: 1).references(ChartAccounts, #id)();

  // Main Data Fields
  TextColumn get name => text().withLength(min: 1, max: 50)();
  BoolColumn get active => boolean().withDefault(const Constant(true))();

  // Audit fields
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
