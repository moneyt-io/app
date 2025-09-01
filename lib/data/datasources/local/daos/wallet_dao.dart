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

    Future<void> deleteWallet(int walletId) async {
    return db.transaction(() async {
      // 1. Find the chart account associated with the wallet.
      final walletToDelete = await (select(wallet)..where((w) => w.id.equals(walletId))).getSingleOrNull();
      if (walletToDelete == null) {
        throw Exception('Wallet not found.');
      }

      // 2. Check if there are any journal details referencing this chart account.
      final query = select(db.journalDetail, distinct: true)
        ..where((jd) => jd.chartAccountId.equals(walletToDelete.chartAccountId));
      final hasTransactions = await query.getSingleOrNull();

      // 3. If transactions exist, throw an exception to prevent deletion.
      if (hasTransactions != null) {
        throw Exception('Cannot delete wallet: It has associated transactions.');
      }

      // 4. If no transactions, proceed with deletion.
      await (delete(wallet)..where((w) => w.id.equals(walletId))).go();
    });
  }
}
