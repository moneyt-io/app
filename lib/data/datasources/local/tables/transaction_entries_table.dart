import 'package:drift/drift.dart';
import 'package:moneyt_pfm/data/datasources/local/tables/document_types_table.dart';
import 'contacts_table.dart';
import 'journal_entries_table.dart';
import 'currencies_table.dart';

@DataClassName('TransactionEntries')
class TransactionEntry extends Table {
  // Relational fields
  IntColumn get id => integer().autoIncrement()();
  TextColumn get documentTypeId => text().withLength(min: 1, max: 1).references(DocumentType, #id)();
  TextColumn get currencyId => text().withLength(min: 3, max: 3).references(Currency, #id)();
  IntColumn get journalId => integer().references(JournalEntry, #id)();
  IntColumn get contactId => integer().nullable().references(Contact, #id)();
  
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