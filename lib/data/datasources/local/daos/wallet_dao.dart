import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/wallets_table.dart';

part 'wallet_dao.g.dart';

@DriftAccessor(tables: [Wallet])
class WalletDao extends DatabaseAccessor<AppDatabase> with _$WalletDaoMixin {
  WalletDao(AppDatabase db) : super(db);

  Future<List<Wallets>> getAllWallets() => select(wallet).get();
  
  Future<Wallets?> getWalletById(int id) =>
      (select(wallet)..where((t) => t.id.equals(id))).getSingleOrNull();

  Stream<List<Wallets>> watchAllWallets() => select(wallet).watch();

  Future<List<Wallets>> getWalletsByParent(int parentId) =>
      (select(wallet)..where((t) => t.parentId.equals(parentId))).get();

  Future<int> insertWallet(WalletsCompanion wallet) =>
      into(this.wallet).insert(wallet);

  Future<bool> updateWallet(WalletsCompanion wallet) =>
      update(this.wallet).replace(wallet);

  Future<int> deleteWallet(int id) =>
      (delete(wallet)..where((t) => t.id.equals(id))).go();
}
