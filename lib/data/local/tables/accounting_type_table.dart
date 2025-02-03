import 'package:drift/drift.dart';

@DataClassName('AccountingType')
class AccountingTypes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}
