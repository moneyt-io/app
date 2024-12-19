import 'package:drift/drift.dart';
import 'package:drift/native.dart';
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
  tables: [Categories, Accounts], // Registra las tablas aquí
  daos: [CategoryDao, AccountDao],  // Esta es la línea importante

)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}
