import 'package:shared_preferences/shared_preferences.dart';
import '../local/database.dart';
import '../../core/l10n/language_manager.dart';

class InitializationService {
  static const String _initKey = 'db_data_initialized';
  final AppDatabase _database;
  final SharedPreferences _prefs;
  final LanguageManager _languageManager;

  InitializationService(this._database, this._prefs, this._languageManager);

  /// Verifica si hay datos en la base de datos
  Future<bool> _hasData() async {
    final categories = await _database.categoryDao.getAllCategories();
    final accounts = await _database.accountDao.getAllAccounts();
    return categories.isNotEmpty && accounts.isNotEmpty;
  }

  /// Inicializa los datos por defecto si es necesario
  Future<void> initializeDefaultDataIfNeeded() async {
    // Verificar si hay datos en la base de datos
    if (await _hasData()) {
      print('La base de datos ya contiene datos');
      return;
    }

    try {
      print('Iniciando inicialización de datos por defecto...');
      final defaultData = _languageManager.defaultData;

      print('Inicializando categorías por defecto...');
      final categories = defaultData.getDefaultCategories();
      for (final category in categories) {
        await _database.categoryDao.insertCategory(category);
      }
      print('Categorías inicializadas correctamente');

      print('Inicializando cuentas por defecto...');
      final accounts = defaultData.getDefaultAccounts();
      for (final account in accounts) {
        await _database.accountDao.insertAccount(account);
      }
      print('Cuentas inicializadas correctamente');

      print('Inicialización de datos completada exitosamente');
    } catch (e) {
      print('Error al inicializar datos por defecto: $e');
      rethrow;
    }
  }

  /// Reinicia el estado de inicialización (útil para testing o reset de la app)
  Future<void> resetInitializationState() async {
    await _prefs.remove(_initKey);
  }
}
