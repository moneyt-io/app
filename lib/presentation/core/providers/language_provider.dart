import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../l10n/generated/strings.g.dart';

class LanguageProvider extends ChangeNotifier {
  static const String _languageKey = 'selected_language';
  final SharedPreferences _prefs;

  AppLocale _currentLocale = AppLocale.es; // Default español

  LanguageProvider(this._prefs) {
    _loadSavedLanguage();
  }

  AppLocale get currentLocale => _currentLocale;

  /// ✅ CORREGIDO: Método que sincroniza slang + provider + persistencia
  Future<void> setLocale(AppLocale locale) async {
    try {
      // 1. Actualizar slang globalmente
      LocaleSettings.setLocale(locale);

      // 2. Actualizar provider
      _currentLocale = locale;

      // 3. Persistir en SharedPreferences
      await _prefs.setString(_languageKey, locale.languageCode);

      // 4. Notificar a todos los widgets Consumer
      notifyListeners();

      debugPrint('✅ Language changed to: ${locale.languageCode}');
    } catch (e) {
      debugPrint('❌ Error changing language: $e');
      rethrow;
    }
  }

  /// ✅ AGREGADO: Cargar idioma guardado al inicializar
  Future<void> _loadSavedLanguage() async {
    try {
      final savedLanguageCode = _prefs.getString(_languageKey);

      if (savedLanguageCode != null) {
        // Convertir código a AppLocale
        final locale = AppLocale.values.firstWhere(
          (l) => l.languageCode == savedLanguageCode,
          orElse: () => AppLocale.es, // Default español
        );

        // Aplicar sin persistir (ya está guardado)
        LocaleSettings.setLocale(locale);
        _currentLocale = locale;
        notifyListeners();

        debugPrint('✅ Loaded saved language: $savedLanguageCode');
      }
    } catch (e) {
      debugPrint('❌ Error loading saved language: $e');
    }
  }

  /// ✅ AGREGADO: Método helper para obtener nombre del idioma
  String getCurrentLanguageName() {
    switch (_currentLocale) {
      case AppLocale.en:
        return 'English';
      case AppLocale.es:
        return 'Español';
      default:
        return 'Unknown';
    }
  }
}
