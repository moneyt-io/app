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
      // 1. Verify wallet exists
      final walletToDelete = await (select(wallet)..where((w) => w.id.equals(walletId))).getSingleOrNull();
      if (walletToDelete == null) {
        throw Exception('Wallet not found.');
      }

      // 2. Check if there are active transactions referencing this wallet
      // Join with transactionEntry to ensure we only check existing transactions
      final txQuery = select(db.transactionDetail).join([
        innerJoin(
          db.transactionEntry,
          db.transactionEntry.id.equalsExp(db.transactionDetail.transactionId),
        )
      ])..where(
          db.transactionDetail.paymentId.equals(walletId) &
          db.transactionDetail.paymentTypeId.equals('W'),
        );
      final hasTxTransactions = await txQuery.getSingleOrNull();

      if (hasTxTransactions != null) {
        throw Exception('Cannot delete wallet: It has associated transactions.');
      }

      // 3. Check if there are active recurring transactions referencing this wallet
      final recurringQuery = select(db.recurringTransactions)
        ..where((rt) => rt.paymentId.equals(walletId) & rt.paymentTypeId.equals('W'));
      final hasRecurring = await recurringQuery.getSingleOrNull();
      if (hasRecurring != null) {
        throw Exception('Cannot delete wallet: It has associated transactions.');
      }

      // 4. If this wallet has children, unlink them to avoid foreign key violation
      final childWallets = await (select(wallet)..where((w) => w.parentId.equals(walletId))).get();
      if (childWallets.isNotEmpty) {
        await (update(wallet)..where((w) => w.parentId.equals(walletId)))
            .write(const WalletsCompanion(parentId: Value(null)));
      }

      // 5. Proceed with deletion
      await (delete(wallet)..where((w) => w.id.equals(walletId))).go();
    });
  }
}
