// lib/main.dart
import 'package:flutter/material.dart';
import 'package:moneyt_pfm/domain/repositories/backup_repository.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/di/injection_container.dart';
import 'core/l10n/language_manager.dart';
import 'presentation/providers/theme_provider.dart';
import 'presentation/providers/auth_provider.dart';
import 'presentation/providers/drawer_provider.dart';
import 'routes/app_routes.dart';
import 'firebase_options.dart';

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
  
  // Si el usuario está autenticado o ha completado el onboarding, no mostrar la pantalla de bienvenida
  final authProvider = getIt<AppAuthProvider>();
  final bool skipWelcome = hasCompletedOnboarding || authProvider.isAuthenticated;

  runApp(
    MultiProvider(
      providers: [
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
    
    return MaterialApp(
      title: 'MoneyT',
      theme: themeProvider.lightTheme,
      darkTheme: themeProvider.darkTheme,
      themeMode: themeProvider.themeMode,
      locale: Locale(languageManager.currentLanguage.code),
      onGenerateRoute: AppRoutes.onGenerateRoute,
      initialRoute: skipWelcome ? AppRoutes.home : AppRoutes.welcome,
    );
  }
}
