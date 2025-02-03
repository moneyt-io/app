import 'package:drift/drift.dart';

@DataClassName('FlowType')
class FlowTypes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}
