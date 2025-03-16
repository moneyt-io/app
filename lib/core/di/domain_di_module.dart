import 'package:get_it/get_it.dart';
import '../../domain/usecases/chart_account_usecases.dart';
import '../../domain/repositories/chart_account_repository.dart';

final getIt = GetIt.instance;

Future<void> initializeDomainDependencies() async {
  // Casos de uso
  getIt.registerSingleton<ChartAccountUseCases>(
    ChartAccountUseCases(getIt<ChartAccountRepository>())
  );
}
