// lib/main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:moneyt_pfm/data/services/backup_service.dart';
import 'package:moneyt_pfm/presentation/providers/auth_provider.dart';
import 'package:moneyt_pfm/data/repositories/backup_repository_impl.dart';
import 'package:moneyt_pfm/domain/repositories/backup_repository.dart';
import 'package:moneyt_pfm/domain/usecases/account_usecases.dart';
import 'package:moneyt_pfm/domain/usecases/category_usecases.dart';
import 'package:moneyt_pfm/domain/usecases/contact_usecases.dart';
import 'package:moneyt_pfm/domain/usecases/transaction_usecases.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/di/injection_container.dart';
import 'core/l10n/language_manager.dart';
import 'presentation/providers/theme_provider.dart';
import 'presentation/providers/drawer_provider.dart';
import 'routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializar Firebase
  await Firebase.initializeApp();

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
        ChangeNotifierProvider(create: (_) => getIt<AppAuthProvider>()),
        ChangeNotifierProvider(create: (_) => ThemeProvider(prefs)),
        Provider<BackupRepository>(
          create: (_) => BackupRepositoryImpl(getIt<BackupService>()),
        ),
        ChangeNotifierProvider(
          create: (context) => DrawerProvider(
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
        ),
        ChangeNotifierProvider.value(value: languageManager),
      ],
      child: Consumer<LanguageManager>(
        builder: (context, languageManager, child) {
          return Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return MaterialApp(
                title: 'MoneyT',
                theme: themeProvider.lightTheme,
                darkTheme: themeProvider.darkTheme,
                themeMode: themeProvider.themeMode,
                onGenerateRoute: AppRoutes.onGenerateRoute,
                initialRoute: isFirstRun 
                  ? AppRoutes.welcome 
                  : context.watch<AppAuthProvider>().isAuthenticated 
                    ? AppRoutes.home 
                    : AppRoutes.welcome,
              );
            },
          );
        },
      ),
    ),
  );
}
