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
  
  Future<List<Wallet>> getWalletsByParent(int parentId) =>
      _repository.getWalletsByParent(parentId);

  // Observación en tiempo real
  Stream<List<Wallet>> watchWallets() => _repository.watchWallets();

  // Operaciones CRUD
  Future<Wallet> createWallet(Wallet wallet) => _repository.createWallet(wallet);
  
  Future<void> updateWallet(Wallet wallet) => _repository.updateWallet(wallet);
  
  Future<void> deleteWallet(int id) => _repository.deleteWallet(id);

  /// Crear una billetera con generación automática de cuenta contable
  Future<Wallet> createWalletWithAccount({
    int? parentId, // Wallet parent ID
    required String name,
    required String currencyId,
    String? description,
  }) async {
    int? parentChartAccountId; // ChartAccount parent ID

    if (parentId != null) {
      // Si es una sub-billetera, buscar la cuenta contable del padre
      final parentWallet = await _repository.getWalletById(parentId);
      if (parentWallet == null) {
        throw Exception('Billetera padre no encontrada con ID $parentId');
      }
      parentChartAccountId = parentWallet.chartAccountId;
    }
    // Si parentId es null, parentChartAccountId permanecerá null,
    // y la lógica en ChartAccountUseCases/Repository buscará la raíz de Activos.

    // 1. Crear la cuenta contable, pasando el parentChartAccountId si existe
    final chartAccount = await _chartAccountUseCases.generateAccountForWallet(
      name,
      parentChartAccountId: parentChartAccountId, // Pasar el ID del padre contable
    );

    // 2. Crear la wallet asociándola a la cuenta contable
    final wallet = Wallet(
      id: 0, // Se asignará al crear
      parentId: parentId, // Asignar el parentId de la wallet
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
