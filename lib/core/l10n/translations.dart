// lib/core/l10n/translations.dart
class Translations {
  final String welcome;
  final String selectLanguage;
  final String continue_;
  final String settings;
  final String darkMode;
  final String darkModeDescription;
  final String language;

  const Translations({
    required this.welcome,
    required this.selectLanguage,
    required this.continue_,
    required this.settings,
    required this.darkMode,
    required this.darkModeDescription,
    required this.language,
  });

  // English translations
  static const en = Translations(
    welcome: 'Welcome to MoneyT',
    selectLanguage: 'Select your language',
    continue_: 'Continue',
    settings: 'Settings',
    darkMode: 'Dark Mode',
    darkModeDescription: 'Switch between light and dark theme',
    language: 'Language',
  );

  // Spanish translations
  static const es = Translations(
    welcome: 'Bienvenido a MoneyT',
    selectLanguage: 'Selecciona tu idioma',
    continue_: 'Continuar',
    settings: 'Configuración',
    darkMode: 'Modo Oscuro',
    darkModeDescription: 'Cambiar entre tema claro y oscuro',
    language: 'Idioma',
  );
}
