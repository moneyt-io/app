import 'generated/strings.g.dart';

// Variable global para acceso fácil a las traducciones
// Usar buildSync() para acceso síncrono en slang 4.7
AppStrings get t => LocaleSettings.currentLocale.buildSync();
