import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../l10n/generated/strings.g.dart';

class LanguageProvider extends ChangeNotifier {
  static const String _languageKey = 'selected_language';
  final SharedPreferences _prefs;
  
  AppLocale _currentLocale = AppLocale.es; // Cambiar default a español
  
  LanguageProvider(this._prefs) {
    _loadLanguage();
  }
  
  AppLocale get currentLocale => _currentLocale;
  
  List<AppLocale> get supportedLocales => [AppLocale.es, AppLocale.en]; // Solo los que tenemos
  
  String getLanguageName(AppLocale locale) {
    switch (locale) {
      case AppLocale.en:
        return 'English';
      case AppLocale.es:
        return 'Español';
      default:
        return locale.languageCode;
    }
  }
  
  Future<void> setLanguage(AppLocale locale) async {
    if (_currentLocale == locale) return;
    
    _currentLocale = locale;
    
    // Actualizar slang MANUALMENTE
    LocaleSettings.setLocale(locale);
    
    await _prefs.setString(_languageKey, locale.languageCode);
    notifyListeners();
  }
  
  void _loadLanguage() {
    final savedLanguage = _prefs.getString(_languageKey);
    if (savedLanguage != null) {
      try {
        _currentLocale = AppLocale.values.firstWhere(
          (locale) => locale.languageCode == savedLanguage,
        );
        LocaleSettings.setLocale(_currentLocale);
      } catch (e) {
        _currentLocale = AppLocale.es; // Default español
      }
    } else {
      // Si no hay idioma guardado, usar español por defecto
      _currentLocale = AppLocale.es;
      LocaleSettings.setLocale(_currentLocale);
    }
  }
}
