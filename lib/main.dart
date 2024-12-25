// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';
import 'data/local/database.dart';
import 'data/repositories/category_repository_impl.dart';
import 'data/repositories/account_repository_impl.dart';
import 'data/repositories/transaction_repository_impl.dart';
import 'domain/repositories/category_repository.dart';
import 'domain/repositories/account_repository.dart';
import 'domain/repositories/transaction_repository.dart';
import 'domain/usecases/category_usecases.dart';
import 'domain/usecases/account_usecases.dart';
import 'domain/usecases/transaction_usecases.dart';
import 'presentation/providers/theme_provider.dart';
import 'routes/app_routes.dart';

final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializar SharedPreferences para el tema
  final prefs = await SharedPreferences.getInstance();

  // Configurar la base de datos
  final appDatabase = AppDatabase();
  
  // Registrar DAOs
  getIt.registerSingleton(appDatabase.categoryDao);
  getIt.registerSingleton(appDatabase.accountDao);
  getIt.registerSingleton(appDatabase);

  // Registrar repositorios
  getIt.registerSingleton<CategoryRepository>(
    CategoryRepositoryImpl(getIt()),
  );
  
  getIt.registerSingleton<AccountRepository>(
    AccountRepositoryImpl(getIt()),
  );
  
  getIt.registerSingleton<TransactionRepository>(
    TransactionRepositoryImpl(getIt()),
  );

  // Registrar casos de uso de categorías
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

  // Registrar casos de uso de cuentas
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

  // Registrar casos de uso de transacciones
  getIt.registerFactory<TransactionUseCases>(
    () => TransactionUseCases(getIt<TransactionRepository>()),
  );

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(prefs),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Mi Presupuesto',
          debugShowCheckedModeBanner: false,
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
          initialRoute: AppRoutes.home,
          onGenerateRoute: AppRoutes.onGenerateRoute,
        );
      },
    );
  }
}