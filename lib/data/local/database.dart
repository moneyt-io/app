import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:moneyt_pfm/data/local/daos/transaction_dao.dart';
import 'package:moneyt_pfm/data/local/tables/transaction_table.dart';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'tables/category_table.dart';
import 'tables/account_table.dart';
import 'daos/category_dao.dart';
import 'daos/account_dao.dart';

part 'database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app_database.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(
  tables: [Categories, Accounts, Transactions],
  daos: [CategoryDao, AccountDao, TransactionDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 3;

  CategoryDao get categoryDao => CategoryDao(this);
  AccountDao get accountDao => AccountDao(this);
  TransactionDao get transactionDao => TransactionDao(this);

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 3) {
        // Aquí solo migraciones de esquema
        await m.createAll();
      }
    },
  );
}