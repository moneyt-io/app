import 'package:get_it/get_it.dart';
// ✅ AGREGADO: Firebase imports con alias para evitar conflictos
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
// ✅ CORREGIDO: Auth imports con alias para evitar conflicto de nombres
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/auth_usecases.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../presentation/features/auth/auth_provider.dart' as app_auth;
import '../../domain/usecases/chart_account_usecases.dart';
import '../../domain/usecases/contact_usecases.dart';
import '../../domain/usecases/category_usecases.dart';
import '../../domain/usecases/wallet_usecases.dart';
import '../../domain/usecases/journal_usecases.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../../domain/usecases/transaction_usecases.dart';
import '../../domain/usecases/credit_card_usecases.dart';
import '../../domain/usecases/loan_usecases.dart';
import '../../domain/usecases/shared_expense_usecases.dart';
import '../../domain/services/balance_calculation_service.dart'; // AGREGADO: Import faltante

final getIt = GetIt.instance;

void registerDomainDependencies() {
  
  // ✅ AGREGADO: Firebase services
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  getIt.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());
  
  // ✅ AGREGADO: Auth Repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      auth: getIt<FirebaseAuth>(),
      firestore: getIt<FirebaseFirestore>(),
      googleSignIn: getIt<GoogleSignIn>(),
    ),
  );
  
  // ✅ AGREGADO: Auth Use Cases
  getIt.registerLazySingleton<AuthUseCases>(
    () => AuthUseCases(getIt<AuthRepository>()),
  );
  
  // ✅ CORREGIDO: Auth Provider usando alias
  getIt.registerLazySingleton<app_auth.AuthProvider>(
    () => app_auth.AuthProvider(getIt<AuthUseCases>()),
  );
  
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
