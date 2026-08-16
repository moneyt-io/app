import 'package:drift/drift.dart';

@DataClassName('RecurringTransactionData')
class RecurringTransactions extends Table {
  // Primary key
  IntColumn get id => integer().autoIncrement()();

  // Relational & categorization fields
  TextColumn get documentTypeId => text().withLength(min: 1, max: 1)(); // 'E' (Expense) or 'I' (Income)
  TextColumn get currencyId => text().withLength(min: 1, max: 3)();
  IntColumn get paymentId => integer()(); // Wallet ID or Credit Card ID
  TextColumn get paymentTypeId => text().withLength(min: 1, max: 1).withDefault(const Constant('W'))(); // 'W' (Wallet) or 'C' (Credit Card)
  IntColumn get categoryId => integer()();
  IntColumn get contactId => integer().nullable()();

  // Financial fields
  RealColumn get amount => real()();
  RealColumn get rateExchange => real().withDefault(const Constant(1.0))();
  TextColumn get description => text().nullable()();

  // Recurrence rule configuration
  // Possible values: 'daily', 'weekly', 'monthly', 'bimonthly', 'quarterly', 'yearly'
  TextColumn get frequency => text()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime().nullable()();
  DateTimeColumn get lastExecutedAt => dateTime().nullable()();
  DateTimeColumn get nextExecutionDate => dateTime()();

  // Status & audit fields
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  BoolColumn get autoCreate => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
