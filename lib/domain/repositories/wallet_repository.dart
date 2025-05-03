import '../entities/wallet.dart';

abstract class WalletRepository {
  // Queries básicas
  Future<List<Wallet>> getAllWallets();
  Future<Wallet?> getWalletById(int id);
  Future<List<Wallet>> getWalletsByParent(int parentId);

  // Observación en tiempo real
  Stream<List<Wallet>> watchWallets();

  // Operaciones CRUD
  Future<Wallet> createWallet(Wallet wallet);
  Future<void> updateWallet(Wallet wallet);
  Future<void> deleteWallet(int id);
}
