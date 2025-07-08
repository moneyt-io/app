import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';
import '../constants/app_storage_keys.dart';
import '../../data/datasources/local/database.dart';
import '../../data/datasources/local/seeds/reference_seeds.dart';

/// Servicio para gestionar la inicialización de datos (seeds) de la aplicación
/// 
/// Se encarga de:
/// - Verificar si los seeds ya fueron ejecutados
/// - Ejecutar seeds solo cuando sea necesario
/// - Manejar versionado de seeds para futuras actualizaciones
/// - Validar integridad de datos base
class DataSeedService {
  static const int _currentSeedVersion = 1;
  static const String _logTag = 'DataSeedService';
  
  /// Verifica si los seeds ya fueron completados
  static Future<bool> areSeedsCompleted() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final completed = prefs.getBool(AppStorageKeys.seedsCompleted) ?? false;
      final version = prefs.getInt(AppStorageKeys.seedsVersion) ?? 0;
      
      print('🌱 $_logTag: Seeds completed: $completed, version: $version');
      
      // Seeds están completados si la flag está en true Y la versión es actual
      return completed && version >= _currentSeedVersion;
    } catch (e) {
      print('❌ $_logTag: Error checking seeds completion: $e');
      return false;
    }
  }
  
  /// Ejecuta los seeds si es necesario
  static Future<bool> runSeedsIfNeeded() async {
    try {
      final needsSeeds = !(await areSeedsCompleted());
      
      if (!needsSeeds) {
        print('✅ $_logTag: Seeds already completed, skipping');
        return true;
      }
      
      print('🌱 $_logTag: Starting seed execution...');
      return await _executeSeedsWithValidation();
      
    } catch (e) {
      print('❌ $_logTag: Error in runSeedsIfNeeded: $e');
      return false;
    }
  }
  
  /// Fuerza la ejecución de seeds (útil para development)
  static Future<bool> forceRunSeeds() async {
    try {
      print('🔄 $_logTag: Force running seeds...');
      await _clearSeedFlags();
      return await _executeSeedsWithValidation();
    } catch (e) {
      print('❌ $_logTag: Error in forceRunSeeds: $e');
      return false;
    }
  }
  
  /// Valida que los datos esenciales estén presentes
  static Future<bool> validateSeedData() async {
    try {
      final database = GetIt.instance<AppDatabase>();
      
      // CORREGIDO: Usar queries directas en lugar de DAOs inexistentes
      final accountingTypes = await database.select(database.accountingType).get();
      final documentTypes = await database.select(database.documentType).get();
      final currencies = await database.select(database.currency).get();
      final chartAccounts = await database.select(database.chartAccount).get();
      
      final isValid = accountingTypes.isNotEmpty && 
                     documentTypes.isNotEmpty && 
                     currencies.isNotEmpty &&
                     chartAccounts.isNotEmpty;
      
      print('🔍 $_logTag: Seed validation - AccountingTypes: ${accountingTypes.length}, '
            'DocumentTypes: ${documentTypes.length}, Currencies: ${currencies.length}, '
            'ChartAccounts: ${chartAccounts.length}');
      
      return isValid;
    } catch (e) {
      print('❌ $_logTag: Error validating seed data: $e');
      return false;
    }
  }
  
  /// Marca los seeds como completados
  static Future<void> markSeedsCompleted() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(AppStorageKeys.seedsCompleted, true);
      await prefs.setInt(AppStorageKeys.seedsVersion, _currentSeedVersion);
      await prefs.setString(AppStorageKeys.seedsLastRun, DateTime.now().toIso8601String());
      
      print('✅ $_logTag: Seeds marked as completed (version $_currentSeedVersion)');
    } catch (e) {
      print('❌ $_logTag: Error marking seeds as completed: $e');
    }
  }
  
  /// Limpia las flags de seeds (para development/testing)
  static Future<void> resetSeeds() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(AppStorageKeys.seedsCompleted);
      await prefs.remove(AppStorageKeys.seedsVersion);
      await prefs.remove(AppStorageKeys.seedsLastRun);
      
      print('🔄 $_logTag: Seed flags cleared');
    } catch (e) {
      print('❌ $_logTag: Error resetting seeds: $e');
    }
  }
  
  /// Obtiene información sobre el estado de los seeds
  static Future<Map<String, dynamic>> getSeedInfo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final completed = prefs.getBool(AppStorageKeys.seedsCompleted) ?? false;
      final version = prefs.getInt(AppStorageKeys.seedsVersion) ?? 0;
      final lastRun = prefs.getString(AppStorageKeys.seedsLastRun);
      
      return {
        'completed': completed,
        'version': version,
        'currentVersion': _currentSeedVersion,
        'needsUpdate': version < _currentSeedVersion,
        'lastRun': lastRun,
        'isValid': await validateSeedData(),
      };
    } catch (e) {
      print('❌ $_logTag: Error getting seed info: $e');
      return {
        'completed': false,
        'version': 0,
        'currentVersion': _currentSeedVersion,
        'needsUpdate': true,
        'lastRun': null,
        'isValid': false,
        'error': e.toString(),
      };
    }
  }
  
  // MÉTODOS PRIVADOS
  
  /// Ejecuta los seeds con validación
  static Future<bool> _executeSeedsWithValidation() async {
    try {
      final database = GetIt.instance<AppDatabase>();
      
      print('🌱 $_logTag: Executing reference seeds...');
      
      // Ejecutar seeds principales
      await ReferenceSeeds.seedAll(database);
      
      print('🔍 $_logTag: Validating seed data...');
      
      // Validar que los datos se insertaron correctamente
      final isValid = await validateSeedData();
      
      if (isValid) {
        await markSeedsCompleted();
        print('✅ $_logTag: Seeds executed and validated successfully');
        return true;
      } else {
        print('❌ $_logTag: Seed validation failed');
        return false;
      }
      
    } catch (e) {
      print('❌ $_logTag: Error executing seeds: $e');
      return false;
    }
  }
  
  /// Limpia las flags de seeds
  static Future<void> _clearSeedFlags() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppStorageKeys.seedsCompleted);
    await prefs.remove(AppStorageKeys.seedsVersion);
  }
}
