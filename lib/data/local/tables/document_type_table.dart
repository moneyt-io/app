import 'package:drift/drift.dart';

@DataClassName('DocumentType')
class DocumentTypes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}
