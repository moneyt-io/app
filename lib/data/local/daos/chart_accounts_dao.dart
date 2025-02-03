import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/chart_accounts_table.dart';

part 'chart_accounts_dao.g.dart';

@DriftAccessor(tables: [ChartAccounts])
class ChartAccountsDao extends DatabaseAccessor<AppDatabase> with _$ChartAccountsDaoMixin {
  ChartAccountsDao(AppDatabase db) : super(db);

  Future<List<ChartAccount>> getAllChartAccounts() => select(chartAccounts).get();
  
  Stream<List<ChartAccount>> watchAllChartAccounts() => select(chartAccounts).watch();
  
  Future<ChartAccount> getChartAccountById(int id) =>
      (select(chartAccounts)..where((t) => t.id.equals(id))).getSingle();
  
  Future<List<ChartAccount>> getChartAccountsByType(int accountingTypeId) =>
      (select(chartAccounts)..where((t) => t.accountingTypeId.equals(accountingTypeId))).get();
  
  Future<List<ChartAccount>> getChildAccounts(int parentId) =>
      (select(chartAccounts)..where((t) => t.parentId.equals(parentId))).get();

  Future<int> insertChartAccount(ChartAccount account) =>
      into(chartAccounts).insert(account);

  Future<bool> updateChartAccount(ChartAccount account) =>
      update(chartAccounts).replace(account);

  Future<int> softDeleteChartAccount(int id) =>
      customUpdate(
        'UPDATE chart_accounts SET active = FALSE, deleted_at = ? WHERE id = ?',
        variables: [Variable.withDateTime(DateTime.now()), Variable.withInt(id)],
        updates: {chartAccounts},
      );
}