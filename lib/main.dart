import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'presentation/core/providers/theme_provider.dart';
import 'presentation/core/providers/language_provider.dart';
import 'presentation/core/l10n/generated/strings.g.dart';
import 'presentation/features/backup/backup_provider.dart';
import 'presentation/features/loans/loan_provider.dart';
import 'presentation/features/contacts/contact_provider.dart';
import 'presentation/features/transactions/transaction_provider.dart';
import 'presentation/features/wallets/wallet_provider.dart';
import 'presentation/features/auth/auth_provider.dart' as app_auth;
import 'core/services/data_seed_service.dart';
import 'core/constants/app_storage_keys.dart';
import 'app.dart';
import 'core/di/injection_container.dart';
import 'core/services/paywall_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    // Log error to a crashlytics service or analytics in a real app
    debugPrint('Firebase initialization failed: $e');
  }

  await initializeDateFormatting('es_ES', null);

  // Inicialización inteligente del idioma
  // 1. Detecta el idioma del dispositivo
  // 2. Si no está soportado, usa el fallback (Inglés/Base)
  LocaleSettings.useDeviceLocale();

  await initializeDependencies();

  try {
    await GetIt.instance<PaywallService>().init();
  } catch (e) {
    debugPrint('PaywallService initialization failed: $e');
  }

  await _initializeCriticalData();

  final prefs = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(prefs),
        ),
        ChangeNotifierProvider(
          create: (_) => LanguageProvider(prefs),
        ),
        ChangeNotifierProvider(
          create: (_) => GetIt.instance<app_auth.AuthProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => GetIt.instance<BackupProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => LoanProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ContactProvider(GetIt.instance()),
        ),
        ChangeNotifierProxyProvider<LoanProvider, TransactionProvider>(
          create: (context) => TransactionProvider(),
          update: (context, loanProvider, transactionProvider) {
            transactionProvider?.refreshTransactions();
            return transactionProvider!;
          },
        ),
        ChangeNotifierProxyProvider<TransactionProvider, WalletProvider>(
          create: (context) => WalletProvider(
            GetIt.instance(), // WalletUseCases
            GetIt.instance(), // BalanceCalculationService
          ),
          update: (context, transactionProvider, walletProvider) {
            walletProvider?.recalculateBalances();
            return walletProvider!;
          },
        ),
      ],
      child: const MoneyTApp(),
    ),
  );
}

/// Ensures essential data is available before the app starts.
Future<void> _initializeCriticalData() async {
  try {
    final seedsCompleted = await DataSeedService.areSeedsCompleted();

    if (!seedsCompleted) {
      await DataSeedService.runSeedsIfNeeded();
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      AppStorageKeys.lastAppOpen,
      DateTime.now().toIso8601String(),
    );
  } catch (e) {
    debugPrint('Error during critical data initialization: $e');
  }
}
