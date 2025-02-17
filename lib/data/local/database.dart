import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

// Importar todas las tablas
import 'tables/category_table.dart';
import 'tables/transaction_table.dart';
import 'tables/transaction_details_table.dart';
import 'tables/contact_table.dart';
import 'tables/accounting_type_table.dart';
import 'tables/document_type_table.dart';
import 'tables/flow_type_table.dart';
import 'tables/payment_type_table.dart';
import 'tables/currency_table.dart';
import 'tables/chart_accounts_table.dart';
import 'tables/credit_card_table.dart';
import 'tables/journal_table.dart';
import 'tables/journal_details_table.dart';

// Importar todos los DAOs
import 'daos/category_dao.dart';
import 'daos/contact_dao.dart';
import 'daos/chart_accounts_dao.dart';
import 'daos/cash_bank_dao.dart';
import 'daos/credit_card_dao.dart';
import 'daos/journal_dao.dart';

import 'seeds/reference_seeds.dart';

part 'database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app_database.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(
  tables: [
    // Primero las tablas referenciales
    AccountingTypes,
    DocumentTypes,
    FlowTypes,
    PaymentTypes,
    Currencies,
    
    // Luego las tablas principales
    ChartAccounts,
    Categories,
    Contacts,
    CreditCards,
    
    Journal,
    JournalDetails,
    Transactions,
    TransactionDetails,
  ],
  daos: [
    ChartAccountsDao,
    CategoryDao,
    CashBankDao,
    ContactDao,
    CreditCardDao,
    JournalDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // DAOs getters
  CategoryDao get categoryDao => CategoryDao(this);
  ContactDao get contactDao => ContactDao(this);
  ChartAccountsDao get chartAccountsDao => ChartAccountsDao(this);
  CashBankDao get cashBankDao => CashBankDao(this);
  CreditCardDao get creditCardDao => CreditCardDao(this);
  JournalDao get journalDao => JournalDao(this);

  // Método necesario para backups locales
  Future<String> getDatabasePath() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app_database.sqlite'));
    return file.path;
  }

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
      await ReferenceSeeds.seedAll(this);
    },
  );
}