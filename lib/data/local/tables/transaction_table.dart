// lib/data/local/tables/transaction_table.dart
import 'package:drift/drift.dart';
import 'package:moneyt_pfm/data/local/tables/document_type_table.dart';
import 'contact_table.dart';
import 'journal_table.dart';
import 'currency_table.dart';

// Constantes para tipos de transacción
const String TRANSACTION_TYPE_INCOME = 'I';    // Ingreso
const String TRANSACTION_TYPE_EXPENSE = 'E';   // Gasto
const String TRANSACTION_TYPE_TRANSFER = 'T';  // Transferencia

// Constantes para flujo de dinero
const String FLOW_TYPE_INFLOW = 'I';     // Entrada de dinero
const String FLOW_TYPE_OUTFLOW = 'O';    // Salida de dinero

@DataClassName('Transaction')
class Transactions extends Table {
  // Relational fields
  IntColumn get id => integer().autoIncrement()();
  TextColumn get documentTypeId => text().withLength(min: 1, max: 1).references(DocumentTypes, #id)();
  TextColumn get currencyId => text().withLength(min: 3, max: 3).references(Currencies, #id)();
  IntColumn get journalId => integer().references(Journal, #id)();
  IntColumn get contactId => integer().nullable().references(Contacts, #id)();
  
  // Main data fields
  IntColumn get secuencial => integer()();
  DateTimeColumn get date => dateTime()();
  RealColumn get amount => real()();
  RealColumn get rateExchange => real()();
  TextColumn get description => text().nullable()();

  // Audit fields
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}