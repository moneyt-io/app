// lib/data/local/database.dart
import 'package:drift/drift.dart';
import 'document_type_table.dart';
import 'chart_accounts_table.dart';

@DataClassName('Category')
class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get parentId => integer().nullable()();
  IntColumn get documentTypeId => integer().references(DocumentTypes, #id)();
  IntColumn get chartAccountId => integer().references(ChartAccounts, #id)();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get type => text().withLength(min: 1, max: 1)();
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();  DateTimeColumn get updatedAt => dateTime().nullable()();  DateTimeColumn get deletedAt => dateTime().nullable()();  @override  List<String> get customConstraints => [    'FOREIGN KEY(parent_id) REFERENCES categories(id) ON DELETE CASCADE'
  ];
}
