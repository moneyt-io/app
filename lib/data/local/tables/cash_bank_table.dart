import 'package:drift/drift.dart';
import 'document_type_table.dart';
import 'chart_accounts_table.dart';

@DataClassName('CashBank')
class CashBanks extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get documentTypeId => integer().nullable().references(DocumentTypes, #id)();
  IntColumn get chartAccountId => integer().nullable().references(ChartAccounts, #id)();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get description => text().nullable()();
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
