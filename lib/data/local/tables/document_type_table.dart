import 'package:drift/drift.dart';

@DataClassName('DocumentType')
class DocumentTypes extends Table {
  TextColumn get id => text().withLength(min: 1, max: 1)();
  TextColumn get name => text().withLength(min: 1, max: 50)();
}
