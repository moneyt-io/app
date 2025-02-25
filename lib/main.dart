// lib/main.dart
import 'package:flutter/material.dart';
import 'package:moneyt_pfm/data/local/database.dart';
import 'package:moneyt_pfm/domain/repositories/backup_repository.dart';
import 'package:moneyt_pfm/presentation/providers/sync_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/di/injection_container.dart';
import 'core/l10n/language_manager.dart';
import 'presentation/providers/theme_provider.dart';
import 'presentation/providers/auth_provider.dart';
import 'presentation/providers/drawer_provider.dart';
import 'presentation/routes/app_routes.dart';
import 'firebase_options.dart';
import 'data/services/sync_service.dart';
import 'data/services/backup_service.dart'; // Importar BackupService
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializar Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Inicializar GetIt y dependencias
  await initializeDependencies();

  // Verificar si es la primera vez que se abre la app
  final prefs = await SharedPreferences.getInstance();
  final bool hasCompletedOnboarding = prefs.getBool('has_completed_onboarding') ?? false;
  
  // Registrar la última vez que el usuario abrió la app
  final analytics = FirebaseAnalytics.instance;
  await analytics.logEvent(
    name: 'app_open',
    parameters: <String, Object>{
      'last_opened': DateTime.now().toIso8601String(),
    },
  );

  // Si el usuario está autenticado o ha completado el onboarding, no mostrar la pantalla de bienvenida
  final authProvider = getIt<AppAuthProvider>();
  final bool skipWelcome = hasCompletedOnboarding || authProvider.isAuthenticated;

  runApp(
    MultiProvider(
      providers: [
        Provider<SyncService>(
          create: (_) => SyncService(
            auth: FirebaseAuth.instance,
            firestore: FirebaseFirestore.instance,
            localDb: AppDatabase(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(prefs),
        ),
        ChangeNotifierProvider(
          create: (_) => getIt<LanguageManager>(),
        ),
        ChangeNotifierProvider(
          create: (_) => authProvider,
        ),
        ChangeNotifierProvider(
          create: (_) => getIt<DrawerProvider>(),
        ),
        Provider<BackupRepository>(
          create: (_) => getIt<BackupRepository>(),
        ),
        ChangeNotifierProvider(
          create: (_) => SyncProvider(syncService: getIt<SyncService>()),
        ),
        Provider<BackupService>( // Agregar BackupService al MultiProvider
          create: (_) => getIt<BackupService>(),
        ),
        Provider<FirebaseAnalytics>(
          create: (_) => FirebaseAnalytics.instance,
        ),
      ],
      child: MyApp(skipWelcome: skipWelcome),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool skipWelcome;

  const MyApp({
    Key? key,
    required this.skipWelcome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final languageManager = context.watch<LanguageManager>();
    final analytics = context.read<FirebaseAnalytics>();

    return MaterialApp(
      title: 'MoneyT',
      theme: themeProvider.lightTheme,
      darkTheme: themeProvider.darkTheme,
      themeMode: themeProvider.themeMode,
      initialRoute: skipWelcome ? AppRoutes.home : AppRoutes.welcome,
      locale: Locale(languageManager.currentLanguage.code),
      onGenerateRoute: AppRoutes.onGenerateRoute,
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
    );
  }
}