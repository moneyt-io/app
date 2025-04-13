import 'package:get_it/get_it.dart';
import '../../data/datasources/local/database.dart';
import '../../data/datasources/local/daos/chart_accounts_dao.dart';
import '../../data/repositories/chart_account_repository_impl.dart';
import '../../domain/repositories/chart_account_repository.dart';
import '../../data/repositories/contact_repository_impl.dart';
import '../../domain/repositories/contact_repository.dart';
import '../../data/datasources/local/daos/contact_dao.dart';
import '../../data/repositories/category_repository_impl.dart';
import '../../domain/repositories/category_repository.dart';
import '../../data/datasources/local/daos/categories_dao.dart';
import '../../data/datasources/local/daos/wallet_dao.dart'; // Añadir importación
import '../../data/repositories/wallet_repository_impl.dart'; // Añadir importación
import '../../domain/repositories/wallet_repository.dart'; // Añadir importación

final getIt = GetIt.instance;

Future<void> initializeDataDependencies() async {
  // Base de datos
  final database = AppDatabase();
  getIt.registerSingleton<AppDatabase>(database);
  
  // DAOs
  getIt.registerSingleton<ChartAccountsDao>(ChartAccountsDao(database));
  getIt.registerLazySingleton<ContactDao>(() => ContactDao(getIt<AppDatabase>()));
  getIt.registerLazySingleton<CategoriesDao>(() => CategoriesDao(getIt<AppDatabase>()));
  getIt.registerLazySingleton<WalletDao>(() => WalletDao(getIt<AppDatabase>())); // Añadir DAO de Wallet
  
  // Repositorios
  getIt.registerSingleton<ChartAccountRepository>(
    ChartAccountRepositoryImpl(getIt<ChartAccountsDao>())
  );
  getIt.registerSingleton<ContactRepository>(
    ContactRepositoryImpl(getIt<ContactDao>())
  );
  getIt.registerSingleton<CategoryRepository>(
    CategoryRepositoryImpl(getIt<CategoriesDao>())
  );
  getIt.registerSingleton<WalletRepository>( // Añadir Repositorio de Wallet
    WalletRepositoryImpl(getIt<WalletDao>())
  );
}
