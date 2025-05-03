import 'package:drift/drift.dart';
import 'currencies_table.dart';
import 'chart_accounts_table.dart';

@DataClassName('Wallets')
class Wallet extends Table {
  // Relational fields
  IntColumn get id => integer().autoIncrement()();
  IntColumn get parentId => integer().nullable().references(Wallet, #id)(); // Added parentId
  TextColumn get currencyId => text().withLength(min: 3, max: 3).references(Currency, #id)();
  IntColumn get chartAccountId => integer().references(ChartAccount, #id)();
  
  // Main data fields
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get description => text().nullable()();
  BoolColumn get active => boolean().withDefault(const Constant(true))();

  // Audit fields
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
