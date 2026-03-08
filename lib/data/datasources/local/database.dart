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
import 'daos/journal_dao.dart';
import 'daos/transaction_dao.dart';
import 'tables/categories_table.dart';
import 'tables/transaction_entries_table.dart'; // AGREGADO
import 'tables/transaction_details_table.dart'; // AGREGADO
import 'tables/contacts_table.dart';
import 'tables/accounting_types_tables.dart';
import 'tables/document_types_table.dart';
import 'tables/flow_types_table.dart';
import 'tables/payment_types_table.dart';
import 'tables/currencies_table.dart';
import 'tables/chart_accounts_table.dart';
import 'tables/credit_cards_table.dart';
import 'tables/journal_entries_table.dart'; // AGREGADO
import 'tables/journal_details_table.dart'; // AGREGADO
import 'tables/loan_entries_table.dart';
import 'tables/loan_details_table.dart';
import 'daos/loan_dao.dart';

import 'seeds/reference_seeds.dart';

part 'database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(()async {
    // 1. Obtener la ruta segura recomendada (Library/Application Support en iOS, app_flutter en Android)
    final supportDir = await getApplicationSupportDirectory();
    final newFile = File(p.join(supportDir.path, 'app_database.sqlite'));

    // 2. Migration: Check if database exists in old path (Documents/)
    // This safely ensures users migrating from early versions don't lose their data
    final docDir = await getApplicationDocumentsDirectory();
    final oldFile = File(p.join(docDir.path, 'app_database.sqlite'));

    if (await oldFile.exists() && !(await newFile.exists())) {
      print('📦 Migrating database from Documents/ to Application Support/ ...');
      await oldFile.copy(newFile.path);
      
      // Attempt to clean up old files including journal/wal files SQLite creates
      final oldDbDir = oldFile.parent;
      final oldFiles = [
        oldFile,
        File(p.join(oldDbDir.path, 'app_database.sqlite-wal')),
        File(p.join(oldDbDir.path, 'app_database.sqlite-shm'))
      ];
      
      for (final f in oldFiles) {
        if (await f.exists()) {
          try {
            await f.delete();
          } catch (e) {
            print('Warning: Could not delete old DB file: $e');
          }
        }
      }
    }

    // Configurar SQLite nativo
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }
    final cacheDir = await getTemporaryDirectory();
    sqlite3.tempDirectory = cacheDir.path;

    return NativeDatabase.createInBackground(newFile);
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
    LoanEntry, // ← AGREGADO
    LoanDetail, // ← AGREGADO
    SharedExpenseEntry,
    SharedExpenseDetail,
  ],
  daos: [
    LoanDao, // ← AGREGADO
    TransactionDao, // AGREGADO
    JournalDao, // AGREGADO
  ]
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2; // INCREMENTADO para nueva migración

  // Método necesario para backups locales
  Future<String> getDatabasePath() async {
    final dbFolder = await getApplicationSupportDirectory();
    final file = File(p.join(dbFolder.path, 'app_database.sqlite'));
    return file.path;
  }

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      // 1. Crear todas las tablas
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 2) {
        // Migración para agregar nuevas tablas
        await m.createTable(transactionEntry);
        await m.createTable(transactionDetail);
        await m.createTable(journalEntry);
        await m.createTable(journalDetail);
        
        // Agregar columna totalPaid a loan_entries si no existe
        await m.addColumn(loanEntry, loanEntry.totalPaid);
      }
    },
  );
}