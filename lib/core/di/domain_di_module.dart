import 'package:get_it/get_it.dart';
import '../../domain/usecases/chart_account_usecases.dart';
import '../../domain/repositories/chart_account_repository.dart';
import '../../domain/repositories/contact_repository.dart';
import '../../domain/usecases/contact_usecases.dart';
import '../../domain/repositories/category_repository.dart';
import '../../domain/usecases/category_usecases.dart';
import '../../domain/repositories/wallet_repository.dart';
import '../../domain/usecases/wallet_usecases.dart';
import '../../domain/repositories/journal_repository.dart';
import '../../domain/usecases/journal_usecases.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../../domain/usecases/transaction_usecases.dart';
import '../../domain/repositories/credit_card_repository.dart';
import '../../domain/usecases/credit_card_usecases.dart';
import '../../domain/repositories/loan_repository.dart';
import '../../domain/usecases/loan_usecases.dart';
import '../../domain/usecases/shared_expense_usecases.dart';
import '../../domain/services/balance_calculation_service.dart'; // AGREGADO: Import faltante

final getIt = GetIt.instance;

void registerDomainDependencies() {
  // PRIMERO: Registrar el servicio de cálculo de balances
  getIt.registerLazySingleton<BalanceCalculationService>(
    () => BalanceCalculationService(getIt<TransactionRepository>()),
  );

  // Casos de Uso - Dependen de los repositorios registrados en data_di_module
  
  getIt.registerLazySingleton<LoanUseCases>(
    () => LoanUseCases(
      getIt(), // LoanRepository
      getIt(), // ContactRepository
      getIt(), // JournalRepository
      getIt(), // TransactionRepository
      getIt(), // WalletRepository
      getIt(), // CreditCardRepository
      getIt(), // CategoryRepository
      getIt(), // BalanceCalculationService - AGREGADO: 8vo parámetro faltante
    ),
  );

  getIt.registerLazySingleton<TransactionUseCases>(
    () => TransactionUseCases(
      getIt(), // TransactionRepository
      getIt(), // JournalRepository
      getIt(), // CategoryRepository
      getIt(), // WalletRepository
      getIt(), // ContactRepository
    ),
  );

  getIt.registerLazySingleton<JournalUseCases>(
    () => JournalUseCases(getIt()),
  );

  getIt.registerLazySingleton<ChartAccountUseCases>(
    () => ChartAccountUseCases(getIt()),
  );

  getIt.registerLazySingleton<CategoryUseCases>(
    () => CategoryUseCases(
      getIt(), // CategoryRepository
      getIt(), // ChartAccountRepository
    ),
  );

  getIt.registerLazySingleton<ContactUseCases>(
    () => ContactUseCases(getIt()),
  );

  getIt.registerLazySingleton<WalletUseCases>(
    () => WalletUseCases(
      getIt(), // WalletRepository
      getIt(), // ChartAccountRepository
    ),
  );

  getIt.registerLazySingleton<CreditCardUseCases>(
    () => CreditCardUseCases(
      getIt(), // CreditCardRepository
      getIt(), // ChartAccountRepository
      getIt(), // TransactionRepository
    ),
  );

  getIt.registerLazySingleton<SharedExpenseUseCases>(
    () => SharedExpenseUseCases(getIt()),
  );
}
