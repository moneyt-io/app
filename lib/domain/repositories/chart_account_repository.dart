import '../entities/chart_account.dart';

abstract class ChartAccountRepository {
  // Consultas básicas
  Future<List<ChartAccount>> getAllChartAccounts();
  Future<ChartAccount?> getChartAccountById(int id);
  Future<List<ChartAccount>> getChartAccountsByType(String accountingTypeId);
  Future<List<ChartAccount>> getChildAccounts(int parentId);
  Future<List<ChartAccount>> getChartAccountsByCode(String code);
  
  // Observación en tiempo real
  Stream<List<ChartAccount>> watchAllChartAccounts();

  // Operaciones CRUD
  Future<ChartAccount> createChartAccount(ChartAccount account);
  Future<void> updateChartAccount(ChartAccount account);
  Future<void> deleteChartAccount(int id);
  
  // Operaciones específicas para el plan de cuentas
  Future<ChartAccount> generateAccountForCategory(String name, String accountingTypeId, {int? parentId});
  Future<ChartAccount> generateAccountForWallet(String name, {int? parentChartAccountId});
  Future<ChartAccount> generateAccountForCreditCard(String name);
  Future<String> generateNextChildCode(int parentId);
}
