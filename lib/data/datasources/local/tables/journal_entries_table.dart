import 'package:drift/drift.dart';
import 'package:moneyt_pfm/data/datasources/local/tables/document_types_table.dart';

@DataClassName('JournalEntries')
class JournalEntry extends Table {
  // Relational fields
  IntColumn get id => integer().autoIncrement()();
  TextColumn get documentTypeId => text().withLength(min: 1, max: 1).references(DocumentType, #id)();
  
  // Main data fields
  IntColumn get secuencial => integer()();
  DateTimeColumn get date => dateTime()();
  TextColumn get description => text().nullable()();

  // Audit fields
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
