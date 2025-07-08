/// Claves para SharedPreferences utilizadas en la app
/// 
/// Centraliza todas las claves de almacenamiento para evitar duplicados
/// y facilitar el mantenimiento.
class AppStorageKeys {
  // 🎬 Onboarding
  static const String onboardingCompleted = 'onboarding_completed';
  static const String appFirstLaunch = 'app_first_launch';
  
  // 🌱 Data Seeds
  static const String seedsCompleted = 'seeds_completed';
  static const String seedsVersion = 'seeds_version';
  static const String seedsLastRun = 'seeds_last_run';
  
  // 🔐 Authentication
  static const String authRequired = 'auth_required';
  static const String authCompleted = 'auth_completed';
  static const String userLoggedIn = 'user_logged_in';
  static const String authSkipped = 'auth_skipped'; // Para modo invitado
  
  // 🔧 Development & Testing
  static const String devForceReset = 'dev_force_reset';
  static const String devSkipOnboarding = 'dev_skip_onboarding';
  static const String devSkipAuth = 'dev_skip_auth';
  static const String devForceReseed = 'dev_force_reseed';
  
  // 🎨 User Preferences (existentes)
  static const String themeMode = 'theme_mode';
  static const String selectedLanguage = 'selected_language';
  
  // 🔄 Backup (existentes)
  static const String backupEnabled = 'backup_enabled';
  static const String backupFrequencyHours = 'backup_frequency_hours';
  static const String backupScheduledTime = 'backup_scheduled_time';
  static const String backupRetentionDays = 'backup_retention_days';
  static const String backupDirectory = 'backup_directory_path';
  
  // 📊 App Metadata
  static const String appVersion = 'app_version';
  static const String databaseVersion = 'database_version';
  static const String lastAppOpen = 'last_app_open';
  static const String installDate = 'install_date';
  
  // 🚫 Private constructor para evitar instanciación
  AppStorageKeys._();
  
  /// Lista de claves que se deben limpiar en desarrollo
  static const List<String> developmentKeys = [
    devForceReset,
    devSkipOnboarding,
    devSkipAuth,
    devForceReseed,
  ];
  
  /// Lista de claves críticas para el funcionamiento de la app
  static const List<String> criticalKeys = [
    onboardingCompleted,
    appFirstLaunch,
    seedsCompleted,
    seedsVersion,
  ];
  
  /// Lista de claves relacionadas con el usuario
  static const List<String> userDataKeys = [
    authCompleted,
    userLoggedIn,
    authSkipped,
    themeMode,
    selectedLanguage,
  ];
}
