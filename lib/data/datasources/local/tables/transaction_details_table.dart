import 'package:drift/drift.dart';
import 'transaction_entries_table.dart';
import 'currencies_table.dart';
import 'flow_types_table.dart';
import 'payment_types_table.dart';
import 'categories_table.dart';

@DataClassName('TransactionDetails')
class TransactionDetail extends Table {
  // Relational fields
  IntColumn get id => integer().autoIncrement()();
  IntColumn get transactionId => integer().references(TransactionEntry, #id)();
  TextColumn get currencyId => text().withLength(min: 3, max: 3).references(Currency, #id)();
  TextColumn get flowId => text().withLength(min: 1, max: 1).references(FlowType, #id)();
  TextColumn get paymentTypeId => text().withLength(min: 1, max: 1).references(PaymentType, #id)();
  IntColumn get paymentId => integer()();
  IntColumn get categoryId => integer().references(Category, #id)();

  // Main data fields
  RealColumn get amount => real()();
  RealColumn get rateExchange => real()();
}
