import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/cash_bank_table.dart';

part 'cash_bank_dao.g.dart';

@DriftAccessor(tables: [CashBanks])
class CashBankDao extends DatabaseAccessor<AppDatabase> with _$CashBankDaoMixin {
  CashBankDao(AppDatabase db) : super(db);

  // Consultas básicas
  Future<List<CashBank>> getAllCashBanks() => 
      (select(cashBanks)..where((b) => b.active.equals(true))).get();

  Stream<List<CashBank>> watchAllCashBanks() => 
      (select(cashBanks)..where((b) => b.active.equals(true))).watch();

  Future<CashBank> getCashBankById(int id) =>
      (select(cashBanks)..where((b) => b.id.equals(id))).getSingle();

  // Operaciones CRUD
  Future<int> insertCashBank(Insertable<CashBank> cashBank) =>
      into(cashBanks).insert(cashBank);

  Future<bool> updateCashBank(Insertable<CashBank> cashBank) =>
      update(cashBanks).replace(cashBank);

  // Soft delete
  Future<int> softDeleteCashBank(int id) =>
      customUpdate(
        'UPDATE cash_banks SET active = FALSE, deleted_at = ? WHERE id = ?',
        variables: [Variable.withDateTime(DateTime.now()), Variable.withInt(id)],
        updates: {cashBanks},
      );

  // Consultas específicas
  Future<List<CashBank>> getCashBanksByDocumentType(int documentTypeId) =>
      (select(cashBanks)
        ..where((b) => b.documentTypeId.equals(documentTypeId) & b.active.equals(true)))
        .get();

  Future<List<CashBank>> getCashBanksByChartAccount(int chartAccountId) =>
      (select(cashBanks)
        ..where((b) => b.chartAccountId.equals(chartAccountId) & b.active.equals(true)))
        .get();
}
