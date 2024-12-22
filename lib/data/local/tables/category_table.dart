// lib/data/local/database.dart
import 'package:drift/drift.dart';

class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get parentId => integer().nullable()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get description => text().nullable()();
  TextColumn get type => text().withLength(min: 1, max: 1)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get status => boolean().withDefault(const Constant(true))();  // Nuevo campo

  @override
  List<String> get customConstraints => [
    'FOREIGN KEY(parent_id) REFERENCES categories(id) ON DELETE CASCADE'
  ];
}