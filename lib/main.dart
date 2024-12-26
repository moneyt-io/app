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
import 'core/l10n/language_manager.dart';
import 'routes/app_routes.dart';
import 'data/services/initialization_service.dart';

final getIt = GetIt.instance;

// Clase para manejar la inicialización de la app
class AppInitializer {
  static late AppDatabase _database;
  static late InitializationService _initService;

  static Future<void> initializeDatabase() async {
    // Configurar la base de datos
    _database = AppDatabase();
    
    // Registrar DAOs
    getIt.registerSingleton(_database.categoryDao);
    getIt.registerSingleton(_database.accountDao);
    getIt.registerSingleton(_database);

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

    // Crear y registrar el servicio de inicialización
    _initService = InitializationService(
      _database,
      getIt<SharedPreferences>(),
      getIt<LanguageManager>(),
    );
    getIt.registerSingleton(_initService);

    // Inicializar datos por defecto si es necesario
    await _initService.initializeDefaultDataIfNeeded();
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializar SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  final bool isFirstRun = prefs.getBool('is_first_run') ?? true;

  // Inicializar LanguageManager
  final languageManager = LanguageManager();
  await languageManager.initialize();

  // Registrar singletons que no dependen de la base de datos
  getIt.registerSingleton<LanguageManager>(languageManager);
  getIt.registerSingleton<SharedPreferences>(prefs);

  // Si no es primera ejecución, inicializar la base de datos
  if (!isFirstRun) {
    await AppInitializer.initializeDatabase();
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider(prefs)),
        ChangeNotifierProvider.value(value: languageManager),
      ],
      child: MyApp(isFirstRun: isFirstRun),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isFirstRun;

  const MyApp({super.key, required this.isFirstRun});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final languageManager = context.watch<LanguageManager>();

    return MaterialApp(
      title: languageManager.translations.appName,
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
      onGenerateRoute: AppRoutes.onGenerateRoute,
      initialRoute: isFirstRun ? AppRoutes.welcome : AppRoutes.home,
    );
  }
}