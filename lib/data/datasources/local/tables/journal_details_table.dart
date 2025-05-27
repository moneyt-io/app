import 'package:drift/drift.dart';

@DataClassName('JournalDetails')
class JournalDetail extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get journalId => integer()();
  TextColumn get currencyId => text().withLength(min: 1, max: 3)();
  IntColumn get chartAccountId => integer()();
  RealColumn get credit => real().withDefault(const Constant(0.0))();
  RealColumn get debit => real().withDefault(const Constant(0.0))();
  RealColumn get rateExchange => real().withDefault(const Constant(1.0))();
}
