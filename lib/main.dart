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
import 'presentation/features/contacts/contact_provider.dart';
// ✅ AGREGADO: Imports para nuevo sistema de inicialización
import 'core/services/data_seed_service.dart';
import 'core/constants/app_storage_keys.dart';
import 'app.dart';
import 'core/di/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  print('🚀 MoneyT App: Starting initialization...');
  
  // Inicializar formateo de fechas
  await initializeDateFormatting('es_ES', null);

  // Inicializar slang con idioma por defecto (español)
  LocaleSettings.setLocale(AppLocale.es);

  // Inicializar dependencias
  await initializeDependencies();

  // ✅ AGREGADO: Inicialización temprana de datos críticos
  await _initializeCriticalData();

  // Obtener preferencias
  final prefs = await SharedPreferences.getInstance();
  
  print('✅ MoneyT App: Initialization completed, starting app...');
  
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

/// ✅ AGREGADO: Inicialización de datos críticos
/// 
/// Se ejecuta antes del arranque de la app para asegurar que los datos
/// esenciales estén disponibles.
Future<void> _initializeCriticalData() async {
  try {
    print('🌱 Initializing critical data...');
    
    // Verificar y ejecutar seeds si es necesario
    final seedsCompleted = await DataSeedService.areSeedsCompleted();
    
    if (!seedsCompleted) {
      print('🌱 Seeds not completed, running seeds...');
      final success = await DataSeedService.runSeedsIfNeeded();
      
      if (success) {
        print('✅ Seeds completed successfully');
      } else {
        print('❌ Warning: Seeds failed to complete');
        // No bloquear la app, continuar y manejar en UI
      }
    } else {
      print('✅ Seeds already completed');
    }
    
    // Registrar última apertura de la app
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      AppStorageKeys.lastAppOpen, 
      DateTime.now().toIso8601String(),
    );
    
    // Logging de estado para debugging
    await _logAppState();
    
  } catch (e) {
    print('❌ Error during critical data initialization: $e');
    // No bloquear la app, continuar y manejar errores en UI
  }
}

/// ✅ AGREGADO: Logging del estado actual de la app
/// 
/// Útil para debugging y diagnóstico de problemas.
Future<void> _logAppState() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    
    // Obtener información de seeds
    final seedInfo = await DataSeedService.getSeedInfo();
    
    // Log del estado actual
    print('📊 App State Summary:');
    print('   - Seeds completed: ${seedInfo['completed']}');
    print('   - Seeds version: ${seedInfo['version']}/${seedInfo['currentVersion']}');
    print('   - Seeds valid: ${seedInfo['isValid']}');
    print('   - Last app open: ${prefs.getString(AppStorageKeys.lastAppOpen) ?? 'Never'}');
    
    // Información de desarrollo
    final devFlags = AppStorageKeys.developmentKeys
        .where((key) => prefs.containsKey(key))
        .toList();
    
    if (devFlags.isNotEmpty) {
      print('🔧 Active dev flags: $devFlags');
    }
    
  } catch (e) {
    print('❌ Error logging app state: $e');
  }
}