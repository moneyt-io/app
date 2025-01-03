// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/local/database.dart';
import 'data/local/daos/category_dao.dart';
import 'data/local/daos/account_dao.dart';
import 'data/local/daos/transaction_dao.dart';
import 'data/local/daos/contact_dao.dart';
import 'data/repositories/category_repository_impl.dart';
import 'data/repositories/account_repository_impl.dart';
import 'data/repositories/transaction_repository_impl.dart';
import 'data/repositories/contact_repository_impl.dart';
import 'domain/repositories/category_repository.dart';
import 'domain/repositories/account_repository.dart';
import 'domain/repositories/transaction_repository.dart';
import 'domain/repositories/contact_repository.dart';
import 'domain/usecases/category_usecases.dart';
import 'domain/usecases/account_usecases.dart';
import 'domain/usecases/transaction_usecases.dart';
import 'domain/usecases/contact_usecases.dart';
import 'presentation/providers/theme_provider.dart';
import 'presentation/providers/drawer_provider.dart';
import 'core/l10n/language_manager.dart';
import 'routes/app_routes.dart';

Future<void> initializeDependencies() async {
  // Database
  final database = AppDatabase();
  GetIt.I.registerSingleton<AppDatabase>(database);

  // DAOs
  GetIt.I.registerSingleton(database.categoryDao);
  GetIt.I.registerSingleton(database.accountDao);
  GetIt.I.registerSingleton(database.transactionDao);
  GetIt.I.registerSingleton(database.contactDao);

  // Repositories
  GetIt.I.registerSingleton<CategoryRepository>(
    CategoryRepositoryImpl(GetIt.I<CategoryDao>()),
  );
  GetIt.I.registerSingleton<AccountRepository>(
    AccountRepositoryImpl(GetIt.I<AccountDao>()),
  );
  GetIt.I.registerSingleton<TransactionRepository>(
    TransactionRepositoryImpl(GetIt.I<TransactionDao>()),
  );
  GetIt.I.registerSingleton<ContactRepository>(
    ContactRepositoryImpl(GetIt.I<ContactDao>()),
  );
  
  // Use Cases
  // Categories
  GetIt.I.registerFactory(() => GetCategories(GetIt.I()));
  GetIt.I.registerFactory(() => CreateCategory(GetIt.I()));
  GetIt.I.registerFactory(() => UpdateCategory(GetIt.I()));
  GetIt.I.registerFactory(() => DeleteCategory(GetIt.I()));

  // Accounts
  GetIt.I.registerFactory(() => GetAccounts(GetIt.I()));
  GetIt.I.registerFactory(() => CreateAccount(GetIt.I()));
  GetIt.I.registerFactory(() => UpdateAccount(GetIt.I()));
  GetIt.I.registerFactory(() => DeleteAccount(GetIt.I()));

  // Contacts
  GetIt.I.registerFactory(() => GetContacts(GetIt.I()));
  GetIt.I.registerFactory(() => CreateContact(GetIt.I()));
  GetIt.I.registerFactory(() => UpdateContact(GetIt.I()));
  GetIt.I.registerFactory(() => DeleteContact(GetIt.I()));

  // Transactions
  GetIt.I.registerFactory(() => TransactionUseCases(GetIt.I()));
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializar dependencias
  await initializeDependencies();
  
  // Inicializar SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  final bool isFirstRun = prefs.getBool('is_first_run') ?? true;
  
  // Inicializar el administrador de idiomas
  final languageManager = LanguageManager();
  await languageManager.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider(prefs)),
        ChangeNotifierProvider(
          create: (context) => DrawerProvider(
            // Categories
            getCategories: GetIt.I<GetCategories>(),
            createCategory: GetIt.I<CreateCategory>(),
            updateCategory: GetIt.I<UpdateCategory>(),
            deleteCategory: GetIt.I<DeleteCategory>(),
            // Accounts
            getAccounts: GetIt.I<GetAccounts>(),
            createAccount: GetIt.I<CreateAccount>(),
            updateAccount: GetIt.I<UpdateAccount>(),
            deleteAccount: GetIt.I<DeleteAccount>(),
            // Contacts
            getContacts: GetIt.I<GetContacts>(),
            createContact: GetIt.I<CreateContact>(),
            updateContact: GetIt.I<UpdateContact>(),
            deleteContact: GetIt.I<DeleteContact>(),
            // Transactions
            transactionUseCases: GetIt.I<TransactionUseCases>(),
          ),
        ),
        ChangeNotifierProvider.value(value: languageManager),
      ],
      child: Consumer<LanguageManager>(
        builder: (context, languageManager, child) {
          return Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return MaterialApp(
                title: 'MoneyT',
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: Colors.blue,
                    brightness: Brightness.light,
                  ),
                  useMaterial3: true,
                  appBarTheme: const AppBarTheme(
                    centerTitle: true,
                    elevation: 0,
                  ),
                  inputDecorationTheme: const InputDecorationTheme(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  ),
                  cardTheme: CardTheme(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                darkTheme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: Colors.blue,
                    brightness: Brightness.dark,
                  ),
                  useMaterial3: true,
                  appBarTheme: const AppBarTheme(
                    centerTitle: true,
                    elevation: 0,
                  ),
                  inputDecorationTheme: const InputDecorationTheme(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  ),
                  cardTheme: CardTheme(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                themeMode: themeProvider.themeMode,
                initialRoute: isFirstRun ? AppRoutes.welcome : AppRoutes.home,
                onGenerateRoute: AppRoutes.onGenerateRoute,
              );
            },
          );
        },
      ),
    ),
  );
}
