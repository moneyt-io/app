import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/chart_accounts_table.dart';

part 'chart_accounts_dao.g.dart';

@DriftAccessor(tables: [ChartAccount])
class ChartAccountsDao extends DatabaseAccessor<AppDatabase> with _$ChartAccountsDaoMixin {
  ChartAccountsDao(AppDatabase db) : super(db);

  // Get All Chart Accounts
  Future<List<ChartAccounts>> getAllChartAccounts() => select(chartAccount).get();
  
  // Get By ID
  Future<ChartAccounts?> getChartAccountById(int id) =>
      (select(chartAccount)..where((t) => t.id.equals(id))).getSingleOrNull();

  // Get By Type
  Future<List<ChartAccounts>> getChartAccountsByType(String accountingTypeId) =>
      (select(chartAccount)..where((t) => t.accountingTypeId.equals(accountingTypeId))).get();
  
  // Get By Parent
  Future<List<ChartAccounts>> getChartAccountsByParent(int parentId) =>
      (select(chartAccount)..where((t) => t.parentId.equals(parentId))).get();

  // Get Active Only
  Future<List<ChartAccounts>> getActiveChartAccounts() =>
      (select(chartAccount)..where((t) => t.active.equals(true))).get();

  // Watch All Chart Accounts (para Stream)
  Stream<List<ChartAccounts>> watchAllChartAccounts() => select(chartAccount).watch();

  // CRUD Operations
  Future<int> insertChartAccount(ChartAccountsCompanion account) =>
      into(chartAccount).insert(account);

  Future<bool> updateChartAccount(ChartAccountsCompanion account) =>
      update(chartAccount).replace(account);

  Future<int> deleteChartAccount(int id) =>
      (delete(chartAccount)..where((t) => t.id.equals(id))).go();

  // Obtener cuentas por código
  Future<List<ChartAccounts>> getChartAccountsByCode(String code) {
    return (select(chartAccount)..where((t) => t.code.equals(code))).get();
  }

  // Obtener hijos directos de una cuenta
  Future<List<ChartAccounts>> getChildAccounts(int parentId) {
    return (select(chartAccount)
      ..where((t) => t.parentId.equals(parentId))
      ..orderBy([(t) => OrderingTerm.asc(t.code)])
    ).get();
  }
}
