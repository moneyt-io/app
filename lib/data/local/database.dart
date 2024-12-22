import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:moenyt_drift/data/local/daos/transaction_dao.dart';
import 'package:moenyt_drift/data/local/tables/transaction_table.dart';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'tables/category_table.dart';
import 'tables/account_table.dart';
import 'daos/category_dao.dart';
import 'daos/account_dao.dart';


part 'database.g.dart'; // Necesario para la generación de código

// Importa las tablas


LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app_database.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(
  tables: [Categories, Accounts, Transactions],
  daos: [CategoryDao, AccountDao, TransactionDao],// Esta es la línea importante

)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      // Agregar lógica de migración si es necesario
    },
  );

  TransactionDao get transactionDao => TransactionDao(this);
}