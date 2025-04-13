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
  Future<ChartAccount> createChartAccount({
    required String parentCode,
    required String name,
    required String accountingTypeId,
  }) async {
    // 1. Buscar la cuenta padre por su código
    final parentAccounts = await _repository.getChartAccountsByCode(parentCode);
    if (parentAccounts.isEmpty) {
      throw Exception('No se encontró la cuenta padre con código $parentCode');
    }
    
    final parentAccount = parentAccounts.first;
    
    // 2. Generar el siguiente código hijo disponible
    final childCode = await _repository.generateNextChildCode(parentAccount.id);
    
    // 3. Crear la nueva cuenta con el código generado
    final newAccount = ChartAccount(
      id: 0, // Se asignará automáticamente
      parentId: parentAccount.id,
      accountingTypeId: accountingTypeId,
      code: childCode,
      level: parentAccount.level + 1,
      name: name,
      active: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      deletedAt: null,
    );
    
    // 4. Guardar y devolver la cuenta creada
    return _repository.createChartAccount(newAccount);
  }
  
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
