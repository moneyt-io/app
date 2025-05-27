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

final getIt = GetIt.instance;

Future<void> initializeDomainDependencies() async {
  // Casos de uso existentes
  getIt.registerSingleton<ChartAccountUseCases>(
    ChartAccountUseCases(getIt<ChartAccountRepository>())
  );
  
  getIt.registerSingleton<ContactUseCases>(
    ContactUseCases(getIt<ContactRepository>())
  );
  
  getIt.registerSingleton<CategoryUseCases>(
    CategoryUseCases(
      getIt<CategoryRepository>(),
      getIt<ChartAccountUseCases>()
    )
  );
  
  getIt.registerSingleton<WalletUseCases>(
    WalletUseCases(
      getIt<WalletRepository>(),
      getIt<ChartAccountUseCases>()
    )
  );
  
  // Registrar JournalUseCases
  getIt.registerLazySingleton<JournalUseCases>(
    () => JournalUseCases(getIt<JournalRepository>()),
  );
  
  // Registro de CreditCardUseCases
  getIt.registerSingleton<CreditCardUseCases>(
    CreditCardUseCases(
      getIt<CreditCardRepository>(),
      getIt<ChartAccountRepository>(),
      getIt<TransactionRepository>(), // ← AGREGAR el TransactionRepository faltante
    )
  );
  
  // Registro del caso de uso de Transacciones con CreditCardRepository
  getIt.registerSingleton<TransactionUseCases>(
    TransactionUseCases(
      getIt<TransactionRepository>(),
      getIt<JournalRepository>(),
      getIt<WalletRepository>(),
      getIt<CategoryRepository>(),
      getIt<CreditCardRepository>()
    )
  );

  // Registrar LoanUseCases
  getIt.registerLazySingleton<LoanUseCases>(
    () => LoanUseCases(
      getIt<LoanRepository>(),
      getIt<ContactRepository>(),
      getIt<JournalRepository>(),
      getIt<TransactionRepository>(),
      getIt<WalletRepository>(),
      getIt<CreditCardRepository>(),
      getIt<CategoryRepository>(),
    ),
  );
}
