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
import 'package:shared_preferences/shared_preferences.dart';

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

    // Agregar getters para los DAOs
  CategoryDao get categoryDao => CategoryDao(this);
  AccountDao get accountDao => AccountDao(this);
  TransactionDao get transactionDao => TransactionDao(this);

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
      await _initializeDefaultData(); // Agregamos la inicialización aquí
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 3) {
        // Si es una versión anterior a 3, también inicializamos datos
        await _initializeDefaultData();
      }
    },
  );

  // Método para inicializar datos por defecto
  Future<void> _initializeDefaultData() async {
    final prefs = await SharedPreferences.getInstance();
    final bool isFirstRun = prefs.getBool('is_first_run') ?? true;

    if (isFirstRun) {
      try {
        // Categorías por defecto
        final defaultCategories = [
          CategoriesCompanion.insert(
            name: 'Alimentación',
            type: 'E',
            description: const Value('Gastos en comida y bebida'),
            status: const Value(true),
          ),
          CategoriesCompanion.insert(
            name: 'Transporte',
            type: 'E',
            description: const Value('Gastos en transporte y movilidad'),
            status: const Value(true),
          ),
          CategoriesCompanion.insert(
            name: 'Servicios',
            type: 'E',
            description: const Value('Pagos de servicios básicos'),
            status: const Value(true),
          ),
          CategoriesCompanion.insert(
            name: 'Salario',
            type: 'I',
            description: const Value('Ingresos por trabajo'),
            status: const Value(true),
          ),
          CategoriesCompanion.insert(
            name: 'Otros Ingresos',
            type: 'I',
            description: const Value('Otros tipos de ingresos'),
            status: const Value(true),
          ),
        ];

        // Cuentas por defecto
        final defaultAccounts = [
          AccountsCompanion.insert(
            name: 'Efectivo',
          ),
          AccountsCompanion.insert(
            name: 'Cuenta Bancaria',
          ),
        ];

        // Verificar si ya existen categorías
        final existingCategories = await categoryDao.getAllCategories();
        if (existingCategories.isEmpty) {
          // Insertar categorías solo si no existen
          for (final category in defaultCategories) {
            await categoryDao.insertCategory(category);
          }
        }

        // Verificar si ya existen cuentas
        final existingAccounts = await accountDao.getAllAccounts();
        if (existingAccounts.isEmpty) {
          // Insertar cuentas solo si no existen
          for (final account in defaultAccounts) {
            await accountDao.insertAccount(account);
          }
        }

        // Marcar que ya no es primera ejecución
        await prefs.setBool('is_first_run', false);
      } catch (e) {
        print('Error al inicializar datos por defecto: $e');
        // No marcamos como ejecutado si hay error
      }
    }
  }
}