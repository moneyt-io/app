import 'package:injectable/injectable.dart';
import '../entities/chart_account.dart';
import '../repositories/chart_account_repository.dart';

@injectable
class ChartAccountUseCases {
  final ChartAccountRepository _repository;
  
  ChartAccountUseCases(this._repository);
  
  // Consultas
  Future<List<ChartAccount>> getAllChartAccounts() => 
      _repository.getAllChartAccounts();
  
  Future<ChartAccount?> getChartAccountById(int id) => 
      _repository.getChartAccountById(id);
  
  Future<List<ChartAccount>> getChartAccountsByType(String accountingTypeId) => 
      _repository.getChartAccountsByType(accountingTypeId);
  
  Future<List<ChartAccount>> getChildAccounts(int parentId) => 
      _repository.getChildAccounts(parentId);
  
  // Observación en tiempo real
  Stream<List<ChartAccount>> watchAllChartAccounts() => 
      _repository.watchAllChartAccounts();
  
  // Operaciones CRUD
  Future<ChartAccount> createChartAccount(ChartAccount account) => 
      _repository.createChartAccount(account);
  
  Future<void> updateChartAccount(ChartAccount account) => 
      _repository.updateChartAccount(account);
  
  Future<void> deleteChartAccount(int id) => 
      _repository.deleteChartAccount(id);
  
  // Métodos de utilidad para el plan de cuentas
  Future<ChartAccount> generateAccountForCategory(String name, String accountingTypeId, {int? parentId}) => 
      _repository.generateAccountForCategory(name, accountingTypeId, parentId: parentId);
  
  Future<ChartAccount> generateAccountForWallet(String name) => 
      _repository.generateAccountForWallet(name);
  
  Future<ChartAccount> generateAccountForCreditCard(String name) => 
      _repository.generateAccountForCreditCard(name);
  
  // Estructura de árbol de cuentas
  Future<Map<ChartAccount, List<ChartAccount>>> getAccountTree() async {
    final allAccounts = await getAllChartAccounts();
    final Map<ChartAccount, List<ChartAccount>> accountTree = {};
    
    // Separar cuentas raíz
    final rootAccounts = allAccounts.where((account) => account.isRootAccount).toList();
    
    // Construir árbol para cada cuenta raíz
    for (var rootAccount in rootAccounts) {
      final children = allAccounts
          .where((account) => account.parentId == rootAccount.id)
          .toList();
      accountTree[rootAccount] = children;
    }
    
    return accountTree;
  }
}
