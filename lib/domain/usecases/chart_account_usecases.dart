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
  
  // Agregar este nuevo método para buscar cuentas por código
  Future<ChartAccount?> getChartAccountByCode(String code) async {
    final accounts = await _repository.getChartAccountsByCode(code);
    return accounts.isNotEmpty ? accounts.first : null;
  }
  
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
  
  Future<ChartAccount> generateAccountForWallet(String name, {int? parentChartAccountId}) => 
      _repository.generateAccountForWallet(name, parentChartAccountId: parentChartAccountId);
  
  /// Genera una cuenta contable para una tarjeta de crédito
  /// 
  /// Crea la cuenta bajo la raíz de Pasivos > Tarjetas de Crédito
  Future<ChartAccount> generateAccountForCreditCard(String creditCardName) async {
    // Buscar la raíz de pasivos - Típicamente tiene código '2'
    final liabilitiesRoot = await _getAccountingTypeRoot('Li'); // Liabilities (Pasivos)
    
    if (liabilitiesRoot == null) {
      throw Exception('No se encontró la raíz de Pasivos en el plan contable');
    }

    // Buscar o crear el grupo para tarjetas de crédito
    const creditCardGroupName = 'Tarjetas de Crédito';
    final creditCardGroup = await _findOrCreateAccountGroup(
      parentCode: liabilitiesRoot.code,
      name: creditCardGroupName,
      accountingTypeId: 'Li',
    );
    
    // Crear la cuenta específica para esta tarjeta dentro del grupo
    return createChartAccount(
      parentCode: creditCardGroup.code,
      name: creditCardName,
      accountingTypeId: 'Li', // Liabilities (Pasivos)
    );
  }
  
  /// Encuentra o crea un grupo de cuentas
  /// 
  /// Método de utilidad para encontrar o crear una cuenta de agrupación
  Future<ChartAccount> _findOrCreateAccountGroup({
    required String parentCode,
    required String name,
    required String accountingTypeId,
  }) async {
    // Intentar encontrar el grupo por nombre bajo el padre
    final parentAccount = await getChartAccountByCode(parentCode);
    if (parentAccount == null) {
      throw Exception('Cuenta padre no encontrada: $parentCode');
    }
    
    final children = await getChildAccounts(parentAccount.id);
    final existingGroup = children.where((account) => account.name == name).firstOrNull;
    
    if (existingGroup != null) {
      return existingGroup;
    }
    
    // Si no existe, crear el grupo
    return createChartAccount(
      parentCode: parentCode,
      name: name,
      accountingTypeId: accountingTypeId,
    );
  }
  
  /// Obtiene la cuenta raíz para un tipo contable
  Future<ChartAccount?> _getAccountingTypeRoot(String accountingTypeId) async {
    final accounts = await getChartAccountsByType(accountingTypeId);
    // Buscar la cuenta que no tiene padre (código corto, generalmente un dígito)
    return accounts.where((a) => a.code.length == 1).firstOrNull;
  }

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

  Future<String> _generateNextCode(int parentAccountId) async {
    final parentAccount = await getChartAccountById(parentAccountId);
    // Obtener el código padre. Si es null o vacío, podría ser la raíz absoluta (manejar según lógica)
    final parentCode = parentAccount?.code ?? '';

    // *** CORRECCIÓN: Usar getChildAccounts en lugar de getChartAccountsByParent ***
    final siblings = await _repository.getChildAccounts(parentAccountId);

    int nextSequence = 1;
    if (siblings.isNotEmpty) {
      int maxSequence = 0;
      for (final sibling in siblings) {
        final parts = sibling.code.split('.');
        if (parts.length > 1) {
          final sequencePart = parts.last;
          final currentSequence = int.tryParse(sequencePart) ?? 0;
          if (currentSequence > maxSequence) {
            maxSequence = currentSequence;
          }
        }
        // Podría necesitar manejar casos donde el código no tiene '.' si hay inconsistencias
      }
      nextSequence = maxSequence + 1;
    }

    // Formatear la secuencia (ej. a dos dígitos con ceros: 1 -> "01", 10 -> "10")
    // Ajustar el padLeft según el formato deseado (ej. 1 para "1", 2 para "01")
    final formattedSequence = nextSequence.toString().padLeft(1, '0'); // Ajustar '1' si se necesitan más dígitos

    // *** CORRECCIÓN: Añadir el punto separador ***
    // Si parentCode está vacío (raíz absoluta), no añadir punto inicial.
    if (parentCode.isEmpty) {
       return formattedSequence;
    } else {
       return '$parentCode.$formattedSequence'; // Asegurar que el '.' esté presente
    }
  }
}
