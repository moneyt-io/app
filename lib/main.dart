import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:get_it/get_it.dart';
import 'presentation/core/providers/theme_provider.dart';
import 'presentation/core/providers/language_provider.dart';
import 'presentation/core/l10n/generated/strings.g.dart';
import 'presentation/features/backup/backup_provider.dart';
import 'presentation/features/loans/loan_provider.dart';
import 'presentation/features/contacts/contact_provider.dart'; // AGREGADO
import 'app.dart';
import 'core/di/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializar formateo de fechas
  await initializeDateFormatting('es_ES', null);

  // Inicializar slang con idioma por defecto (español)
  LocaleSettings.setLocale(AppLocale.es);

  // Inicializar dependencias
  await initializeDependencies();

  // Obtener preferencias
  final prefs = await SharedPreferences.getInstance();
  
  runApp(
    // SIN TranslationProvider - configuramos slang manualmente
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(prefs),
        ),
        ChangeNotifierProvider(
          create: (_) => LanguageProvider(prefs),
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
      ],
      child: const MoneyTApp(),
    ),
  );
}