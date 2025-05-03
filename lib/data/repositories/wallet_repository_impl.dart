import 'package:injectable/injectable.dart';
import '../../domain/entities/wallet.dart';
import '../../domain/repositories/wallet_repository.dart';
import '../datasources/local/daos/wallet_dao.dart';
import '../models/wallet_model.dart';

@Injectable(as: WalletRepository)
class WalletRepositoryImpl implements WalletRepository {
  final WalletDao _dao;

  WalletRepositoryImpl(this._dao);

  @override
  Future<List<Wallet>> getAllWallets() async {
    final wallets = await _dao.getAllWallets();
    return wallets.map((wallet) => WalletModel(
      id: wallet.id,
      parentId: wallet.parentId,
      currencyId: wallet.currencyId,
      chartAccountId: wallet.chartAccountId,
      name: wallet.name,
      description: wallet.description,
      active: wallet.active,
      createdAt: wallet.createdAt,
      updatedAt: wallet.updatedAt,
      deletedAt: wallet.deletedAt,
    ).toEntity()).toList();
  }

  @override
  Stream<List<Wallet>> watchWallets() {
    return _dao.watchAllWallets().map(
      (wallets) => wallets.map((wallet) => WalletModel(
        id: wallet.id,
        parentId: wallet.parentId,
        currencyId: wallet.currencyId,
        chartAccountId: wallet.chartAccountId,
        name: wallet.name,
        description: wallet.description,
        active: wallet.active,
        createdAt: wallet.createdAt,
        updatedAt: wallet.updatedAt,
        deletedAt: wallet.deletedAt,
      ).toEntity()).toList()
    );
  }

  @override
  Future<Wallet> createWallet(Wallet wallet) async {
    final model = WalletModel.fromEntity(wallet);
    final id = await _dao.insertWallet(model.toCompanion());
    final createdWallet = await _dao.getWalletById(id);
    if (createdWallet == null) {
      throw Exception('Failed to create wallet');
    }
    return WalletModel(
      id: createdWallet.id,
      parentId: createdWallet.parentId,
      currencyId: createdWallet.currencyId,
      chartAccountId: createdWallet.chartAccountId,
      name: createdWallet.name,
      description: createdWallet.description,
      active: createdWallet.active,
      createdAt: createdWallet.createdAt,
      updatedAt: createdWallet.updatedAt,
      deletedAt: createdWallet.deletedAt,
    ).toEntity();
  }

  @override
  Future<void> updateWallet(Wallet wallet) async {
    final model = WalletModel.fromEntity(wallet);
    await _dao.updateWallet(model.toCompanion());
  }

  @override
  Future<void> deleteWallet(int id) => _dao.deleteWallet(id);

  @override
  Future<Wallet?> getWalletById(int id) async {
    final wallet = await _dao.getWalletById(id);
    if (wallet == null) return null;
    
    return WalletModel(
      id: wallet.id,
      parentId: wallet.parentId,
      currencyId: wallet.currencyId,
      chartAccountId: wallet.chartAccountId,
      name: wallet.name,
      description: wallet.description,
      active: wallet.active,
      createdAt: wallet.createdAt,
      updatedAt: wallet.updatedAt,
      deletedAt: wallet.deletedAt,
    ).toEntity();
  }

  @override
  Future<List<Wallet>> getWalletsByParent(int parentId) async {
    final wallets = await _dao.getWalletsByParent(parentId);
    return wallets.map((wallet) => WalletModel(
      id: wallet.id,
      parentId: wallet.parentId,
      currencyId: wallet.currencyId,
      chartAccountId: wallet.chartAccountId,
      name: wallet.name,
      description: wallet.description,
      active: wallet.active,
      createdAt: wallet.createdAt,
      updatedAt: wallet.updatedAt,
      deletedAt: wallet.deletedAt,
    ).toEntity()).toList();
  }
}
