import 'package:drift/drift.dart';
import 'accounting_type_table.dart';

@DataClassName('ChartAccount')
class ChartAccounts extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get accountingTypeId => integer().references(AccountingTypes, #id)();
  IntColumn get parentId => integer().nullable().references(ChartAccounts, #id)();
  TextColumn get code => text()();
  TextColumn get name => text()();
  IntColumn get level => integer()();
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
