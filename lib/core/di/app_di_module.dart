import 'package:get_it/get_it.dart';

// Importar servicios de aplicación cuando existan

final getIt = GetIt.instance;

void registerAppDependencies() {
  // SIMPLIFICADO: Por ahora solo comentarios
  // TODO: Agregar servicios cuando sean necesarios:
  // - NavigationService (ya existe como static)
  // - AnalyticsService (futuro)
  // - CrashReportingService (futuro)
  // - AuthService (cuando implementemos Google Sign-In)
  
  print('📱 App dependencies registered (minimal setup)');
}
  //   () => NavigationService(),
  // );

