import 'package:drift/drift.dart';
import 'transaction_table.dart';
import 'currency_table.dart';
import 'flow_type_table.dart';
import 'payment_type_table.dart';
import 'category_table.dart';

@DataClassName('TransactionDetail')
class TransactionDetails extends Table {
  // Relational fields
  IntColumn get id => integer().autoIncrement()();
  IntColumn get transactionId => integer().references(Transactions, #id)();
  TextColumn get currencyId => text().withLength(min: 3, max: 3).references(Currencies, #id)();
  TextColumn get flowId => text().withLength(min: 1, max: 1).references(FlowTypes, #id)();
  TextColumn get paymentTypeId => text().withLength(min: 1, max: 1).references(PaymentTypes, #id)();
  IntColumn get paymentId => integer()();
  IntColumn get categoryId => integer().references(Categories, #id)();
  
  // Main data fields
  RealColumn get amount => real()();
  RealColumn get rateExchange => real()();
}
