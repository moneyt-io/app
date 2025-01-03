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
import '../../domain/repositories/category_repository.dart';
import '../../domain/repositories/account_repository.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../../domain/repositories/contact_repository.dart';
import '../../domain/usecases/category_usecases.dart';
import '../../domain/usecases/account_usecases.dart';
import '../../domain/usecases/transaction_usecases.dart';
import '../../domain/usecases/contact_usecases.dart';

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
  getIt.registerLazySingleton<TransactionDao>(
    () => TransactionDao(getIt<AppDatabase>()),
  );
  getIt.registerLazySingleton<ContactDao>(
    () => ContactDao(getIt<AppDatabase>()),
  );

  // Repositories
  getIt.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(getIt<CategoryDao>()),
  );
  getIt.registerLazySingleton<AccountRepository>(
    () => AccountRepositoryImpl(getIt<AccountDao>()),
  );
  getIt.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(getIt<TransactionDao>()),
  );
  getIt.registerLazySingleton<ContactRepository>(
    () => ContactRepositoryImpl(getIt<ContactDao>()),
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

  // Transactions
  getIt.registerLazySingleton(
    () => TransactionUseCases(getIt<TransactionRepository>()),
  );

  // Contacts
  getIt.registerLazySingleton(() => GetContacts(getIt<ContactRepository>()));
  getIt.registerLazySingleton(() => GetContactById(getIt<ContactRepository>()));
  getIt.registerLazySingleton(() => CreateContact(getIt<ContactRepository>()));
  getIt.registerLazySingleton(() => UpdateContact(getIt<ContactRepository>()));
  getIt.registerLazySingleton(() => DeleteContact(getIt<ContactRepository>()));
}