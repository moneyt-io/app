import 'package:drift/drift.dart';

@DataClassName('TransactionDetails')
class TransactionDetail extends Table {
  // Relational fields
  IntColumn get id => integer().autoIncrement()();
  IntColumn get transactionId => integer()();
  TextColumn get currencyId => text().withLength(min: 1, max: 3)();
  TextColumn get flowId => text().withLength(min: 1, max: 1)(); // F=From, T=To
  TextColumn get paymentTypeId => text().withLength(min: 1, max: 1)(); // W=Wallet, C=CreditCard
  IntColumn get paymentId => integer().nullable()();
  IntColumn get categoryId => integer().nullable()();

  // Main data fields
  RealColumn get amount => real()();
  RealColumn get rateExchange => real().withDefault(const Constant(1.0))();
}
