// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/date_symbol_data_local.dart'; // Agregar esta importación
import 'package:get_it/get_it.dart';
import 'presentation/providers/theme_provider.dart';
import 'presentation/providers/backup_provider.dart'; // Asegúrate que la importación esté presente
import 'presentation/providers/loan_provider.dart';
import 'app.dart';
import 'core/di/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializar formateo de fechas (agregar esta línea)
  await initializeDateFormatting('es_ES', null);

  // Inicializar dependencias
  await initializeDependencies();

  // Obtener preferencias
  final prefs = await SharedPreferences.getInstance();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(prefs),
        ),
        ChangeNotifierProvider(
          create: (_) => GetIt.instance<BackupProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => LoanProvider(),
        ),
        // ChangeNotifierProvider(
        //   create: (_) => getIt<LanguageManager>(),
        // ),
      ],
      child: const MoneyTApp(),
    ),
  );
}