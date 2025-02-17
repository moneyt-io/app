import 'package:drift/drift.dart';

@DataClassName('AccountingType')
class AccountingTypes extends Table {
  TextColumn get id => text().withLength(min: 2, max: 2)();
  TextColumn get name => text().withLength(min: 1, max: 50)();
}
