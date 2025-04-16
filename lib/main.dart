// lib/main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/date_symbol_data_local.dart'; // Agregar esta importación
import 'firebase_options.dart';
import 'presentation/providers/theme_provider.dart';
import 'app.dart';
import 'core/di/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializar formateo de fechas (agregar esta línea)
  await initializeDateFormatting('es_ES', null);
  
  // Inicializar Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );  

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
        // ChangeNotifierProvider(
        //   create: (_) => getIt<LanguageManager>(),
        // ),
      ],
      child: const MoneyTApp(),
    ),
  );
}