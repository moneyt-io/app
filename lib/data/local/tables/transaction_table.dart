// lib/data/local/tables/transaction_table.dart
import 'package:drift/drift.dart';
import 'account_table.dart';
import 'category_table.dart';
import 'contact_table.dart';

// Constantes para tipos de transacción
const String TRANSACTION_TYPE_INCOME = 'I';    // Ingreso
const String TRANSACTION_TYPE_EXPENSE = 'E';   // Gasto
const String TRANSACTION_TYPE_TRANSFER = 'T';  // Transferencia

// Constantes para flujo de dinero
const String FLOW_TYPE_INFLOW = 'I';     // Entrada de dinero
const String FLOW_TYPE_OUTFLOW = 'O';    // Salida de dinero

@DataClassName('Transaction')
class Transactions extends Table {
  // Identificación
  IntColumn get id => integer().autoIncrement()();
  
  // Campos principales
  TextColumn get type => text().withLength(min: 1, max: 1)();  // I,E,C,D,T
  TextColumn get flow => text().withLength(min: 1, max: 1)();  // I,O
  RealColumn get amount => real()();
  
  // Referencias
  IntColumn get accountId => integer().references(Accounts, #id)();
  IntColumn get categoryId => integer().nullable().references(Categories, #id)();
  IntColumn get contactId => integer().nullable().references(Contacts, #id)();
  
  // Detalles de la transacción
  TextColumn get reference => text().nullable().withLength(min: 1, max: 50)();
  TextColumn get description => text().nullable().withLength(min: 1, max: 255)();
  
  // Fechas y estado
  DateTimeColumn get transactionDate => dateTime()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  BoolColumn get status => boolean().withDefault(const Constant(true))();
}