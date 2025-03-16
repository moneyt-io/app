import 'package:get_it/get_it.dart';
import '../../data/datasources/local/database.dart';
import '../../data/datasources/local/daos/chart_accounts_dao.dart';
import '../../data/repositories/chart_account_repository_impl.dart';
import '../../domain/repositories/chart_account_repository.dart';

final getIt = GetIt.instance;

Future<void> initializeDataDependencies() async {
  // Base de datos
  final database = AppDatabase();
  getIt.registerSingleton<AppDatabase>(database);
  
  // DAOs
  getIt.registerSingleton<ChartAccountsDao>(ChartAccountsDao(database));
  
  // Repositorios
  getIt.registerSingleton<ChartAccountRepository>(
    ChartAccountRepositoryImpl(getIt<ChartAccountsDao>())
  );
}
