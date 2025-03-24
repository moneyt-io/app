import 'package:get_it/get_it.dart';
import '../../domain/usecases/chart_account_usecases.dart';
import '../../domain/repositories/chart_account_repository.dart';
import '../../domain/repositories/contact_repository.dart';
import '../../domain/usecases/contact_usecases.dart';
import '../../domain/repositories/category_repository.dart';
import '../../domain/usecases/category_usecases.dart';
import '../../domain/repositories/wallet_repository.dart'; // Añadir importación
import '../../domain/usecases/wallet_usecases.dart'; // Añadir importación

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
  
  // Registro del caso de uso de Wallet
  getIt.registerSingleton<WalletUseCases>(
    WalletUseCases(getIt<WalletRepository>())
  );
}
