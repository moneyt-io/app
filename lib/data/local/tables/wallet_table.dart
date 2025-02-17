import 'package:drift/drift.dart';
import 'currency_table.dart';
import 'chart_accounts_table.dart';

@DataClassName('Wallet')
class Wallets extends Table {
  // Relational fields
  IntColumn get id => integer().autoIncrement()();
  TextColumn get currencyId => text().withLength(min: 3, max: 3).references(Currencies, #id)();
  TextColumn get chartAccountId => text().withLength(min: 1, max: 1).references(ChartAccounts, #id)();
  
  // Main data fields
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get description => text().nullable()();
  BoolColumn get active => boolean().withDefault(const Constant(true))();

  // Audit fields
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
