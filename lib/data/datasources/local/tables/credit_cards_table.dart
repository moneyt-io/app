import 'package:drift/drift.dart';
import 'currencies_table.dart';
import 'chart_accounts_table.dart';

@DataClassName('CreditCards')
class CreditCard extends Table {
  IntColumn get id => integer().autoIncrement()();
  
  TextColumn get currencyId => text().references(Currency, #id)();
  IntColumn get chartAccountId => integer().references(ChartAccount, #id)();
  
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  RealColumn get quota => real()();
  IntColumn get closingDay => integer()();
  IntColumn get paymentDueDay => integer()();
  RealColumn get interestRate => real().withDefault(const Constant(0.0))();
  
  // Campos de auditoría
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
