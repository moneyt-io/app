import 'package:drift/drift.dart';
import 'document_type_table.dart';
import 'chart_accounts_table.dart';

@DataClassName('CashBank')
class CashBanks extends Table {
  // Identificación
  IntColumn get id => integer().autoIncrement()();
  
  // Referencias
  IntColumn get documentTypeId => integer().references(DocumentTypes, #id)();
  IntColumn get chartAccountId => integer().references(ChartAccounts, #id)();
  
  // Datos principales
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get description => text().nullable()();
  
  // Estado y auditoría
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
