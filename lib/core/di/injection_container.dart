import 'package:get_it/get_it.dart';
import 'data_di_module.dart';
import 'domain_di_module.dart';
import 'app_di_module.dart';

/// Inicializa todas las dependencias de la aplicación
Future<void> initializeDependencies() async {
  // Inicializar la capa de datos
  await initializeDataDependencies();
  
  // Inicializar la capa de dominio
  await initializeDomainDependencies();
  
  // Inicializar la capa de aplicación
  await initializeAppDependencies();
}
