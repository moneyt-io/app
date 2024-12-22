// lib/core/di/injection_container.dart
import 'package:get_it/get_it.dart';
import '../../data/local/database.dart';
import '../../data/local/daos/category_dao.dart';
import '../../data/local/daos/account_dao.dart';
import '../../data/local/daos/transaction_dao.dart';  // Nuevo import
import '../../data/repositories/category_repository_impl.dart';
import '../../data/repositories/account_repository_impl.dart';
import '../../data/repositories/transaction_repository_impl.dart';  // Nuevo import
import '../../domain/repositories/category_repository.dart';
import '../../domain/repositories/account_repository.dart';
import '../../domain/repositories/transaction_repository.dart';  // Nuevo import
import '../../domain/usecases/category_usecases.dart';
import '../../domain/usecases/account_usecases.dart';
import '../../domain/usecases/transaction_usecases.dart';  // Nuevo import

final getIt = GetIt.instance;

Future<void> init(AppDatabase database) async {
  // Database
  getIt.registerSingleton<AppDatabase>(database);

  // DAOs
  getIt.registerLazySingleton<CategoryDao>(
    () => CategoryDao(getIt<AppDatabase>()),
  );
  getIt.registerLazySingleton<AccountDao>(
    () => AccountDao(getIt<AppDatabase>()),
  );
  getIt.registerLazySingleton<TransactionDao>(  // Nuevo
    () => TransactionDao(getIt<AppDatabase>()),
  );

  // Repositories
  getIt.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(getIt<CategoryDao>()),
  );
  getIt.registerLazySingleton<AccountRepository>(
    () => AccountRepositoryImpl(getIt<AccountDao>()),
  );
  getIt.registerLazySingleton<TransactionRepository>(  // Nuevo
    () => TransactionRepositoryImpl(getIt<AppDatabase>()),
  );

  // Use Cases
  // Categorías
  getIt.registerLazySingleton(() => GetCategories(getIt<CategoryRepository>()));
  getIt.registerLazySingleton(() => CreateCategory(getIt<CategoryRepository>()));
  getIt.registerLazySingleton(() => UpdateCategory(getIt<CategoryRepository>()));
  getIt.registerLazySingleton(() => DeleteCategory(getIt<CategoryRepository>()));

  // Cuentas
  getIt.registerLazySingleton(() => GetAccounts(getIt<AccountRepository>()));
  getIt.registerLazySingleton(() => CreateAccount(getIt<AccountRepository>()));
  getIt.registerLazySingleton(() => UpdateAccount(getIt<AccountRepository>()));
  getIt.registerLazySingleton(() => DeleteAccount(getIt<AccountRepository>()));

  // Transacciones
  getIt.registerLazySingleton(() => TransactionUseCases(getIt<TransactionRepository>()));
}