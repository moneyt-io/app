// lib/core/di/injection_container.dart
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/local/database.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/backup_repository_impl.dart';
import '../../data/repositories/category_repository_impl.dart';
import '../../data/repositories/account_repository_impl.dart';
import '../../data/repositories/transaction_repository_impl.dart';
import '../../data/repositories/contact_repository_impl.dart';
import '../../data/local/daos/category_dao.dart';
import '../../data/local/daos/account_dao.dart';
import '../../data/local/daos/transaction_dao.dart';
import '../../data/local/daos/contact_dao.dart';
import '../../data/services/sync_service.dart';
import '../../data/services/sync_manager.dart';
import '../../data/services/backup_service.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/backup_repository.dart';
import '../../domain/repositories/category_repository.dart';
import '../../domain/repositories/account_repository.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../../domain/repositories/contact_repository.dart';
import '../../domain/usecases/category_usecases.dart';
import '../../domain/usecases/account_usecases.dart';
import '../../domain/usecases/contact_usecases.dart';
import '../../domain/usecases/transaction_usecases.dart';
import '../../presentation/providers/auth_provider.dart';
import '../../presentation/providers/drawer_provider.dart';
import '../l10n/language_manager.dart'; // Import LanguageManager

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  // Firebase
  getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  getIt.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
  getIt.registerSingleton<GoogleSignIn>(GoogleSignIn());

  // Database
  final database = AppDatabase();
  getIt.registerSingleton<AppDatabase>(database);

  // Initialize SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);

  // Language Manager
  final languageManager = LanguageManager();
  await languageManager.initialize();
  getIt.registerSingleton<LanguageManager>(languageManager);

  // DAOs
  getIt.registerSingleton<CategoryDao>(database.categoryDao);
  getIt.registerSingleton<AccountDao>(database.accountDao);
  getIt.registerSingleton<TransactionDao>(database.transactionDao);
  getIt.registerSingleton<ContactDao>(database.contactDao);

  // Services
  getIt.registerLazySingleton<SyncService>(
    () => SyncService(
      auth: getIt<FirebaseAuth>(),
      firestore: getIt<FirebaseFirestore>(),
      localDb: getIt<AppDatabase>(),
    ),
  );

  getIt.registerLazySingleton<SyncManager>(
    () => SyncManager(getIt<SyncService>()),
  );

  getIt.registerLazySingleton<BackupService>(
    () => BackupService(
      database: getIt<AppDatabase>(),
      prefs: getIt<SharedPreferences>(),
    ),
  );

  // Repositories
  getIt.registerSingleton<TransactionRepository>(
    TransactionRepositoryImpl(getIt<TransactionDao>()),
  );

  getIt.registerSingleton<CategoryRepository>(
    CategoryRepositoryImpl(getIt<CategoryDao>()),
  );
  
  getIt.registerSingleton<AccountRepository>(
    AccountRepositoryImpl(
      getIt<AccountDao>(),
      getIt<SyncManager>(),
    ),
  );
  
  getIt.registerSingleton<ContactRepository>(
    ContactRepositoryImpl(getIt<ContactDao>()),
  );

  getIt.registerSingleton<BackupRepository>(
    BackupRepositoryImpl(getIt<BackupService>()),
  );

  getIt.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(
      auth: getIt<FirebaseAuth>(),
      firestore: getIt<FirebaseFirestore>(),
      googleSignIn: getIt<GoogleSignIn>(),
      syncService: getIt<SyncService>(),
    ),
  );

  // Use Cases
  // Transactions
  getIt.registerSingleton<TransactionUseCases>(
    TransactionUseCases(getIt<TransactionRepository>()),
  );

  // Categories
  getIt.registerFactory<GetCategories>(
    () => GetCategories(getIt<CategoryRepository>()),
  );
  getIt.registerFactory<CreateCategory>(
    () => CreateCategory(getIt<CategoryRepository>()),
  );
  getIt.registerFactory<UpdateCategory>(
    () => UpdateCategory(getIt<CategoryRepository>()),
  );
  getIt.registerFactory<DeleteCategory>(
    () => DeleteCategory(getIt<CategoryRepository>()),
  );

  // Accounts
  getIt.registerFactory<GetAccounts>(
    () => GetAccounts(getIt<AccountRepository>()),
  );
  getIt.registerFactory<CreateAccount>(
    () => CreateAccount(getIt<AccountRepository>()),
  );
  getIt.registerFactory<UpdateAccount>(
    () => UpdateAccount(getIt<AccountRepository>()),
  );
  getIt.registerFactory<DeleteAccount>(
    () => DeleteAccount(getIt<AccountRepository>()),
  );

  // Contacts
  getIt.registerFactory<GetContacts>(
    () => GetContacts(getIt<ContactRepository>()),
  );
  getIt.registerFactory<CreateContact>(
    () => CreateContact(getIt<ContactRepository>()),
  );
  getIt.registerFactory<UpdateContact>(
    () => UpdateContact(getIt<ContactRepository>()),
  );
  getIt.registerFactory<DeleteContact>(
    () => DeleteContact(getIt<ContactRepository>()),
  );

  // Providers
  getIt.registerLazySingleton<AppAuthProvider>(
    () => AppAuthProvider(
      getIt<AuthRepository>(),
      getIt<SharedPreferences>(),
    ),
  );

  getIt.registerLazySingleton<DrawerProvider>(
    () => DrawerProvider(
      // Categories
      getCategories: getIt<GetCategories>(),
      createCategory: getIt<CreateCategory>(),
      updateCategory: getIt<UpdateCategory>(),
      deleteCategory: getIt<DeleteCategory>(),
      // Accounts
      getAccounts: getIt<GetAccounts>(),
      createAccount: getIt<CreateAccount>(),
      updateAccount: getIt<UpdateAccount>(),
      deleteAccount: getIt<DeleteAccount>(),
      // Contacts
      getContacts: getIt<GetContacts>(),
      createContact: getIt<CreateContact>(),
      updateContact: getIt<UpdateContact>(),
      deleteContact: getIt<DeleteContact>(),
      // Transactions
      transactionUseCases: getIt<TransactionUseCases>(),
    ),
  );
}
