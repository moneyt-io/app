import 'package:drift/drift.dart';

@DataClassName('Currency')
class Currencies extends Table {
  TextColumn get id => text().withLength(min: 3, max: 3)();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get symbol => text().withLength(min: 1, max: 5)();
  RealColumn get rateExchange => real()();
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
