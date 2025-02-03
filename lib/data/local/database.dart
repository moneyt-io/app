import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

// Importar todas las tablas
import 'tables/category_table.dart';
import 'tables/account_table.dart';
import 'tables/transaction_table.dart';
import 'tables/contact_table.dart';
import 'tables/accounting_type_table.dart';
import 'tables/document_type_table.dart';
import 'tables/flow_type_table.dart';
import 'tables/chart_accounts_table.dart';
import 'tables/cash_bank_table.dart';
import 'tables/credit_card_table.dart';

// Importar todos los DAOs
import 'daos/category_dao.dart';
import 'daos/account_dao.dart';
import 'daos/transaction_dao.dart';
import 'daos/contact_dao.dart';
import 'daos/chart_accounts_dao.dart';
import 'daos/cash_bank_dao.dart';
import 'daos/credit_card_dao.dart';

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
    // Nivel 1 - Tablas base sin dependencias
    AccountingTypes,
    DocumentTypes,
    FlowTypes,
    
    // Nivel 2 - Dependen solo de Nivel 1
    ChartAccounts,
    CashBanks,     // <- Agregamos CashBanks aquí
    CreditCards,     // <- Agregamos CreditCards aquí
    
    // Nivel 3 - Dependen de niveles anteriores
    Categories,
    Accounts,
    Contacts,
    
    // Nivel 4 - Depende de todas las anteriores
    Transactions,
  ],
  daos: [
    CategoryDao,
    AccountDao,
    TransactionDao,
    ContactDao,
    ChartAccountsDao,
    CashBankDao,    // <- Agregamos el nuevo DAO
    CreditCardDao,    // <- Agregamos el nuevo DAO
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 5;

  CategoryDao get categoryDao => CategoryDao(this);
  AccountDao get accountDao => AccountDao(this);
  TransactionDao get transactionDao => TransactionDao(this);
  ContactDao get contactDao => ContactDao(this);
  ChartAccountsDao get chartAccountsDao => ChartAccountsDao(this);
  CashBankDao get cashBankDao => CashBankDao(this);  // Agregamos el getter para el nuevo DAO
  CreditCardDao get creditCardDao => CreditCardDao(this);  // Agregamos el getter para el nuevo DAO

  Future<String> getDatabasePath() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app_database.sqlite'));
    return file.path;
  }

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();

      // Semilla para tablas referenciales
      await _seedReferenceTables();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 3) {
        await m.createAll();
      }
      if (from < 4) {
        // Crear la tabla de contactos en la versión 4
        await m.createTable(contacts);
      }
      if (from < 5) {
        // Crear tablas referenciales en la nueva versión
        await m.createTable(accountingTypes);
        await m.createTable(documentTypes);
        await m.createTable(flowTypes);
        await _seedReferenceTables();
      }
    },
  );

  Future<void> _seedReferenceTables() async {
    // Insertar usando constructores básicos
    await batch((batch) {
      batch.insertAll(
        accountingTypes,
        [
          AccountingType(id: 1, name: 'Assets'),
          AccountingType(id: 2, name: 'Liabilities'),
          AccountingType(id: 3, name: 'Equity'),
          AccountingType(id: 4, name: 'Income'),
          AccountingType(id: 5, name: 'Expenses'),
        ],
        mode: InsertMode.insertOrIgnore,
      );
    });

    await batch((batch) {
      batch.insertAll(
        documentTypes,
        [
          DocumentType(id: 1, name: 'Income'),
          DocumentType(id: 2, name: 'Expense'),
          DocumentType(id: 3, name: 'Transfer'),
          DocumentType(id: 4, name: 'Lend'),
          DocumentType(id: 5, name: 'Borrow'),
        ],
        mode: InsertMode.insertOrIgnore,
      );
    });

    await batch((batch) {
      batch.insertAll(
        flowTypes,
        [
          FlowType(id: 1, name: 'From'),
          FlowType(id: 2, name: 'To'),
        ],
        mode: InsertMode.insertOrIgnore,
      );
    });
  }
}