import 'package:injectable/injectable.dart';
import '../entities/wallet.dart';
import '../repositories/wallet_repository.dart';

@injectable
class WalletUseCases {
  final WalletRepository _repository;

  WalletUseCases(this._repository);

  // Consultas básicas
  Future<List<Wallet>> getAllWallets() => _repository.getAllWallets();
  
  Future<Wallet?> getWalletById(int id) => _repository.getWalletById(id);
  
  // Observación en tiempo real
  Stream<List<Wallet>> watchWallets() => _repository.watchWallets();

  // Operaciones CRUD
  Future<Wallet> createWallet(Wallet wallet) => _repository.createWallet(wallet);
  
  Future<void> updateWallet(Wallet wallet) => _repository.updateWallet(wallet);
  
  Future<void> deleteWallet(int id) => _repository.deleteWallet(id);
}
