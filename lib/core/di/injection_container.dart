import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/datasources/local/database.dart';
import '../services/backup_service.dart';
import '../../domain/repositories/backup_repository.dart';
import '../../data/repositories/backup_repository_impl.dart';
import 'app_di_module.dart';
import 'data_di_module.dart';
import 'domain_di_module.dart';
import '../services/data_seed_service.dart';
import '../services/auth_service.dart';
import '../services/paywall_service.dart'; // ✅ AÑADIDO
import '../../presentation/features/auth/auth_provider.dart' as app_auth;
import '../../presentation/features/backup/backup_provider.dart';

final getIt = GetIt.instance;

bool _dependenciesInitialized = false;

@InjectableInit()
Future<void> initializeDependencies() async {
  // No inicializar más de una vez
  if (_dependenciesInitialized) {
    return;
  }

  // Permitir la reasignación para evitar errores si se llama más de una vez
  getIt.allowReassignment = true;

  // Inicializar SharedPreferences si no está registrado
  if (!getIt.isRegistered<SharedPreferences>()) {
    final prefs = await SharedPreferences.getInstance();
    getIt.registerSingleton<SharedPreferences>(prefs);
  }

  // Inicializar los módulos en el orden correcto
  registerDataDependencies();     // CORREGIDO: usar nombre correcto
  registerDomainDependencies();   // CORREGIDO: usar nombre correcto
  registerAppDependencies();      // CORREGIDO: usar nombre correcto

  // --- Registro de Dependencias de Backup ---

  // Registrar BackupRepository (implementación)
  // Necesita AppDatabase y SharedPreferences, que ya deberían estar registrados
  // por initializeDataDependencies y este mismo archivo.
  getIt.registerLazySingleton<BackupRepository>(
    () => BackupRepositoryImpl(
      database: getIt<AppDatabase>(),
      prefs: getIt<SharedPreferences>(),
    ),
  );

  // Registrar BackupService
  // Necesita BackupRepository
  getIt.registerLazySingleton<BackupService>(
    () => BackupService(getIt<BackupRepository>()),
  );

  // Registrar BackupProvider (si ya existe, si no, se hará después)
  // Necesita BackupService
  getIt.registerLazySingleton<BackupProvider>(
    () => BackupProvider(getIt<BackupService>()),
  );
  // --- Fin Registro Dependencias de Backup ---

  // Services
  getIt.registerLazySingleton<DataSeedService>(() => DataSeedService()); // ✅ CORREGIDO
  getIt.registerLazySingleton<AuthService>(() => AuthService());
  getIt.registerLazySingleton<PaywallService>(() => PaywallService()); // ✅ AÑADIDO

  // Providers
  getIt.registerLazySingleton<app_auth.AuthProvider>(() => app_auth.AuthProvider(getIt())); // ✅ CORREGIDO

  _dependenciesInitialized = true;
}

Future<void> resetDependencies() async {
  await getIt.reset(dispose: true);
  _dependenciesInitialized = false;
  await initializeDependencies();
}
