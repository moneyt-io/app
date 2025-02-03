import 'package:drift/drift.dart';
import 'chart_accounts_table.dart';

@DataClassName('CreditCard')
class CreditCards extends Table {
  // Identificación
  IntColumn get id => integer().autoIncrement()();
  
  // Referencias
  IntColumn get chartAccountId => integer().references(ChartAccounts, #id)();
  
  // Datos principales
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get description => text().nullable()();
  RealColumn get quota => real()();
  IntColumn get closingDay => integer()();
  
  // Estado y auditoría
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
