import '../entities/chart_account.dart';

abstract class ChartAccountsRepository {
  Future<List<ChartAccountEntity>> getAllChartAccounts();
  Stream<List<ChartAccountEntity>> watchAllChartAccounts();
  Future<ChartAccountEntity> getChartAccountById(int id);
  Future<List<ChartAccountEntity>> getChartAccountsByType(int accountingTypeId);
  Future<List<ChartAccountEntity>> getChildAccounts(int parentId);
  Future<int> createChartAccount(ChartAccountEntity account);
  Future<bool> updateChartAccount(ChartAccountEntity account);
  Future<bool> deleteChartAccount(int id);
}
