import 'package:injectable/injectable.dart';
import '../entities/wallet.dart';
import '../repositories/wallet_repository.dart';
import '../usecases/chart_account_usecases.dart';

@injectable
class WalletUseCases {
  final WalletRepository _repository;
  final ChartAccountUseCases _chartAccountUseCases;

  WalletUseCases(this._repository, this._chartAccountUseCases);

  // Consultas básicas
  Future<List<Wallet>> getAllWallets() => _repository.getAllWallets();
  
  Future<Wallet?> getWalletById(int id) => _repository.getWalletById(id);
  
  // Observación en tiempo real
  Stream<List<Wallet>> watchWallets() => _repository.watchWallets();

  // Operaciones CRUD
  Future<Wallet> createWallet(Wallet wallet) => _repository.createWallet(wallet);
  
  Future<void> updateWallet(Wallet wallet) => _repository.updateWallet(wallet);
  
  Future<void> deleteWallet(int id) => _repository.deleteWallet(id);

  /// Crear una billetera con generación automática de cuenta contable
  Future<Wallet> createWalletWithAccount({
    required String name,
    required String currencyId,
    String? description,
  }) async {
    // 1. Crear la cuenta contable en el plan de cuentas (en la sección Activos)
    final chartAccount = await _chartAccountUseCases.createChartAccount(
      parentCode: '11', // Asumiendo que 11 es el código para Activos Corrientes
      name: 'Billetera: $name',
      accountingTypeId: 'As', // Tipo Activo
    );
    
    // 2. Crear la wallet asociándola a la cuenta contable
    final wallet = Wallet(
      id: 0, // Se asignará al crear
      currencyId: currencyId,
      chartAccountId: chartAccount.id,
      name: name,
      description: description,
      active: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      deletedAt: null,
    );
    
    return createWallet(wallet);
  }
}
