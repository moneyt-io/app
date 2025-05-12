import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/datasources/local/database.dart';
import '../../data/repositories/credit_card_repository_impl.dart';
import '../../domain/repositories/chart_account_repository.dart';
import '../../domain/repositories/credit_card_repository.dart';
import '../../domain/usecases/credit_card_usecases.dart';
import '../services/backup_service.dart';
import '../../domain/repositories/backup_repository.dart';
import '../../data/repositories/backup_repository_impl.dart';
import '../../presentation/providers/backup_provider.dart'; // Asegúrate de que esto exista o coméntalo si aún no
import 'app_di_module.dart';
import 'data_di_module.dart';
import 'domain_di_module.dart';
import '../../data/datasources/local/daos/credit_cards_dao.dart';

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
  await initializeDataDependencies();  // Primero los repositorios (incluye AppDatabase)
  await initializeDomainDependencies(); // Luego los casos de uso
  await initializeAppDependencies();   // Finalmente los servicios de aplicación

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

  _dependenciesInitialized = true;
}
