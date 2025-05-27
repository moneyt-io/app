import 'package:drift/drift.dart';

@DataClassName('JournalEntries')
class JournalEntry extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get documentTypeId => text().withLength(min: 1, max: 1)();
  IntColumn get secuencial => integer()();
  DateTimeColumn get date => dateTime()();
  TextColumn get description => text().nullable()();
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)(); // NO NULLABLE
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)(); // NO NULLABLE
  DateTimeColumn get deletedAt => dateTime().nullable()(); // SÍ NULLABLE
}
