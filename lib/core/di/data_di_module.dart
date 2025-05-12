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
import '../../data/datasources/local/daos/wallet_dao.dart';
import '../../data/repositories/wallet_repository_impl.dart';
import '../../domain/repositories/wallet_repository.dart';
import '../../data/datasources/local/daos/journal_dao.dart';
import '../../domain/repositories/journal_repository.dart';
import '../../data/repositories/journal_repository_impl.dart';
import '../../data/datasources/local/daos/transaction_dao.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../../data/repositories/transaction_repository_impl.dart';
import '../../data/datasources/local/daos/credit_cards_dao.dart';
import '../../domain/repositories/credit_card_repository.dart';
import '../../data/repositories/credit_card_repository_impl.dart';

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
  getIt.registerLazySingleton<JournalDao>(() => JournalDao(getIt<AppDatabase>())); // Registrar el JournalDao
  getIt.registerLazySingleton<TransactionDao>(() => TransactionDao(getIt<AppDatabase>()));
  getIt.registerLazySingleton<CreditCardDao>(() => CreditCardDao(getIt<AppDatabase>())); // Registrar CreditCardDao
  
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
  getIt.registerLazySingleton<JournalRepository>( // Registrar el JournalRepository
    () => JournalRepositoryImpl(getIt<JournalDao>()),
  );
  // Registrar TransactionRepository con todas sus dependencias
  getIt.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(
      getIt<TransactionDao>(),
      getIt<JournalRepository>(),
      getIt<CategoryRepository>(), 
      getIt<WalletRepository>(),
      getIt<ContactRepository>(),
    ),
  );
  
  // Registrar CreditCardRepository aquí, no en injection_container.dart
  getIt.registerLazySingleton<CreditCardRepository>(
    () => CreditCardRepositoryImpl(getIt<CreditCardDao>()),
  );
}
