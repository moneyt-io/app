import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:moneyt_pfm/data/datasources/local/tables/loan_details_table.dart';
import 'package:moneyt_pfm/data/datasources/local/tables/loan_entries_table.dart';
import 'package:moneyt_pfm/data/datasources/local/tables/shared_expense_details_table.dart';
import 'package:moneyt_pfm/data/datasources/local/tables/shared_expense_entries_table.dart';
import 'package:moneyt_pfm/data/datasources/local/tables/wallets_table.dart';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
// *** Añadir importaciones faltantes ***
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

// Importar todas las tablas
import 'tables/categories_table.dart';
import 'tables/transaction_entries_table.dart';
import 'tables/transaction_details_table.dart';
import 'tables/contacts_table.dart';
import 'tables/accounting_types_tables.dart';
import 'tables/document_types_table.dart';
import 'tables/flow_types_table.dart';
import 'tables/payment_types_table.dart';
import 'tables/currencies_table.dart';
import 'tables/chart_accounts_table.dart';
import 'tables/credit_cards_table.dart';
import 'tables/journal_entries_table.dart';
import 'tables/journal_details_table.dart';

import 'seeds/reference_seeds.dart';

part 'database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(()async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app_database.sqlite'));

    // Configurar SQLite nativo
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }
    final cachebase = (await getTemporaryDirectory()).path;
    sqlite3.tempDirectory = cachebase;

    return NativeDatabase.createInBackground(file);
  });
}

@DriftDatabase(
  tables: [
    // Tablas referenciales
    AccountingType,
    DocumentType,
    FlowType,
    PaymentType,
    Currency,
    
    // Tablas principales
    ChartAccount,
    Category,
    Contact,
    Wallet,
    CreditCard,
    
    
    // Tablas transaccionales
    JournalEntry,
    JournalDetail,
    TransactionEntry,
    TransactionDetail,
    LoanEntry,
    LoanDetail,
    SharedExpenseEntry,
    SharedExpenseDetail,
  ]
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Método necesario para backups locales
  Future<String> getDatabasePath() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app_database.sqlite'));
    return file.path;
  }

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      // 1. Crear todas las tablas
      await m.createAll();
      // 2. Llamar al seeder centralizado
      await ReferenceSeeds.seedAll(this);
    },
  );
}