import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/language.dart';
import 'translations/base_translations.dart';
import 'translations/languages/en_translations.dart';
import 'translations/languages/es_translations.dart';
import 'default_data/base_default_data.dart';
import 'default_data/languages/en_default_data.dart';
import 'default_data/languages/es_default_data.dart';

class LanguageManager extends ChangeNotifier {
  static final LanguageManager _instance = LanguageManager._internal();
  factory LanguageManager() => _instance;
  LanguageManager._internal();

  static const String _languageKey = 'selected_language';
  static const String defaultLanguage = 'en';

  late SharedPreferences _prefs;
  final List<Language> _supportedLanguages = [
    const Language(
      code: 'en',
      name: 'English',
      nativeName: 'English',
      flag: '🇺🇸',
    ),
    const Language(
      code: 'es',
      name: 'Spanish',
      nativeName: 'Español',
      flag: '🇪🇸',
    ),
  ];

  late Language _currentLanguage;
  late BaseTranslations _currentTranslations;
  late BaseDefaultData _currentDefaultData;
  bool _isInitialized = false;

  // Getters
  Language get currentLanguage => _currentLanguage;
  BaseTranslations get translations => _currentTranslations;
  BaseDefaultData get defaultData => _currentDefaultData;
  List<Language> get supportedLanguages => List.unmodifiable(_supportedLanguages);
  bool get isInitialized => _isInitialized;

  // Inicialización
  Future<void> initialize() async {
    if (_isInitialized) return;

    _prefs = await SharedPreferences.getInstance();
    final savedLanguageCode = _prefs.getString(_languageKey) ?? defaultLanguage;
    await changeLanguage(savedLanguageCode);
    _isInitialized = true;
  }

  // Cambio de idioma
  Future<void> changeLanguage(String languageCode) async {
    // Validar que el idioma esté soportado
    if (!_supportedLanguages.any((lang) => lang.code == languageCode)) {
      throw UnsupportedError('Language $languageCode is not supported');
    }

    // Actualizar idioma actual
    _currentLanguage = _supportedLanguages.firstWhere(
      (lang) => lang.code == languageCode,
    );

    // Cargar traducciones
    _currentTranslations = _getTranslationsForLanguage(languageCode);
    if (!_currentTranslations.validateTranslations()) {
      throw StateError('Invalid translations for language $languageCode');
    }

    // Cargar datos por defecto
    _currentDefaultData = _getDefaultDataForLanguage(languageCode);
    if (!_currentDefaultData.validateDefaultData()) {
      throw StateError('Invalid default data for language $languageCode');
    }

    // Guardar preferencia
    await _prefs.setString(_languageKey, languageCode);
    notifyListeners();
  }

  // Obtener traducciones según el idioma
  BaseTranslations _getTranslationsForLanguage(String languageCode) {
    switch (languageCode) {
      case 'es':
        return SpanishTranslations();
      case 'en':
        return EnglishTranslations();
      default:
        throw UnsupportedError('Translations not available for $languageCode');
    }
  }

  // Obtener datos por defecto según el idioma
  BaseDefaultData _getDefaultDataForLanguage(String languageCode) {
    switch (languageCode) {
      case 'es':
        return SpanishDefaultData();
      case 'en':
        return EnglishDefaultData();
      default:
        throw UnsupportedError('Default data not available for $languageCode');
    }
  }

  // Método para agregar soporte para nuevos idiomas
  void addSupportedLanguage({
    required String code,
    required String name,
    required String nativeName,
    required String flag,
    required BaseTranslations translations,
    required BaseDefaultData defaultData,
  }) {
    // Validar que el idioma no esté ya soportado
    if (_supportedLanguages.any((lang) => lang.code == code)) {
      throw StateError('Language $code is already supported');
    }

    // Validar traducciones y datos por defecto
    if (!translations.validateTranslations()) {
      throw StateError('Invalid translations for language $code');
    }
    if (!defaultData.validateDefaultData()) {
      throw StateError('Invalid default data for language $code');
    }

    // Agregar nuevo idioma
    _supportedLanguages.add(Language(
      code: code,
      name: name,
      nativeName: nativeName,
      flag: flag,
    ));

    notifyListeners();
  }

  // Método para verificar si un idioma está soportado
  bool isLanguageSupported(String languageCode) {
    return _supportedLanguages.any((lang) => lang.code == languageCode);
  }

  // Método para obtener un idioma por su código
  Language? getLanguageByCode(String code) {
    try {
      return _supportedLanguages.firstWhere((lang) => lang.code == code);
    } catch (_) {
      return null;
    }
  }
}
