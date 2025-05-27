import 'package:get_it/get_it.dart';

// Importar servicios de aplicación cuando existan

final getIt = GetIt.instance;

void registerAppDependencies() {
  // Servicios de aplicación
  // Por ahora vacío, se pueden agregar servicios como:
  // - NavigationService
  // - AnalyticsService
  // - CrashReportingService
  // - etc.
  
  // Ejemplo para futuro:
  // getIt.registerLazySingleton<NavigationService>(
  //   () => NavigationService(),
  // );
}
