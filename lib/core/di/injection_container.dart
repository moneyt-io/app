// lib/core/di/injection_container.dart
import 'package:get_it/get_it.dart';
import '../../data/local/database.dart';
import '../../data/local/daos/category_dao.dart';
import '../../data/local/daos/account_dao.dart';
import '../../data/local/daos/transaction_dao.dart';
import '../../data/local/daos/contact_dao.dart';
import '../../data/repositories/category_repository_impl.dart';
import '../../data/repositories/account_repository_impl.dart';
import '../../data/repositories/transaction_repository_impl.dart';
import '../../data/repositories/contact_repository_impl.dart';
import '../../data/repositories/backup_repository_impl.dart';
import '../../domain/repositories/category_repository.dart';
import '../../domain/repositories/account_repository.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../../domain/repositories/contact_repository.dart';
import '../../domain/repositories/backup_repository.dart';
import '../../domain/usecases/category_usecases.dart';
import '../../domain/usecases/account_usecases.dart';
import '../../domain/usecases/transaction_usecases.dart';
import '../../domain/usecases/contact_usecases.dart';
import '../../data/local/backup/backup_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  // Database
  final database = AppDatabase();
  getIt.registerSingleton<AppDatabase>(database);

  // Initialize SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);

  // DAOs
  getIt.registerSingleton(database.categoryDao);
  getIt.registerSingleton(database.accountDao);
  getIt.registerSingleton(database.transactionDao);
  getIt.registerSingleton(database.contactDao);

  // Repositories
  getIt.registerSingleton<CategoryRepository>(
    CategoryRepositoryImpl(getIt<CategoryDao>()),
  );
  getIt.registerSingleton<AccountRepository>(
    AccountRepositoryImpl(getIt<AccountDao>()),
  );
  getIt.registerSingleton<TransactionRepository>(
    TransactionRepositoryImpl(getIt<TransactionDao>()),
  );
  getIt.registerSingleton<ContactRepository>(
    ContactRepositoryImpl(getIt<ContactDao>()),
  );

  // Services
  getIt.registerLazySingleton<BackupService>(
    () => BackupService(
      database: getIt<AppDatabase>(),
      prefs: getIt<SharedPreferences>(),
    ),
  );

  // Backup
  getIt.registerSingleton<BackupRepository>(
    BackupRepositoryImpl(getIt<BackupService>()),
  );

  // Use Cases
  // Categories
  getIt.registerLazySingleton(() => GetCategories(getIt<CategoryRepository>()));
  getIt.registerLazySingleton(() => CreateCategory(getIt<CategoryRepository>()));
  getIt.registerLazySingleton(() => UpdateCategory(getIt<CategoryRepository>()));
  getIt.registerLazySingleton(() => DeleteCategory(getIt<CategoryRepository>()));

  // Accounts
  getIt.registerLazySingleton(() => GetAccounts(getIt<AccountRepository>()));
  getIt.registerLazySingleton(() => CreateAccount(getIt<AccountRepository>()));
  getIt.registerLazySingleton(() => UpdateAccount(getIt<AccountRepository>()));
  getIt.registerLazySingleton(() => DeleteAccount(getIt<AccountRepository>()));

  // Contacts
  getIt.registerLazySingleton(() => GetContacts(getIt<ContactRepository>()));
  getIt.registerLazySingleton(() => CreateContact(getIt<ContactRepository>()));
  getIt.registerLazySingleton(() => UpdateContact(getIt<ContactRepository>()));
  getIt.registerLazySingleton(() => DeleteContact(getIt<ContactRepository>()));

  // Transactions
  getIt.registerFactory(() => TransactionUseCases(getIt<TransactionRepository>()));
}