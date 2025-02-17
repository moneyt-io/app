// lib/data/local/database.dart
import 'package:drift/drift.dart';
import 'document_types_table.dart';
import 'chart_accounts_table.dart';

@DataClassName('Categories')
class Category extends Table {
  // Relational fields
  IntColumn get id => integer().autoIncrement()();
  IntColumn get parentId => integer().nullable().references(Category, #id)();
  TextColumn get documentTypeId => text().withLength(min: 1, max: 1).references(DocumentType, #id)();
  TextColumn get chartAccountId => text().withLength(min: 1, max: 1).references(ChartAccount, #id)();

  // Main Data Fields
  TextColumn get name => text().withLength(min: 1, max: 50)();
  
  // Audit fields
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
