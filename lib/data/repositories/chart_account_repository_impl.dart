import 'package:injectable/injectable.dart';
import '../../domain/entities/chart_account.dart';
import '../../domain/entities/accounting_type.dart';
import '../../domain/repositories/chart_account_repository.dart';
import '../datasources/local/daos/chart_accounts_dao.dart';
import '../models/chart_account_model.dart';

@Injectable(as: ChartAccountRepository)
class ChartAccountRepositoryImpl implements ChartAccountRepository {
  final ChartAccountsDao _dao;

  ChartAccountRepositoryImpl(this._dao);

  // Mapa de conversión de códigos de tipo de cuenta a valores numéricos
  final Map<String, String> _accountingTypeNumberMap = {
    'As': '1', // Assets
    'Li': '2', // Liabilities
    'Eq': '3', // Equity
    'In': '4', // Income
    'Ex': '5', // Expenses
  };

  @override
  Future<List<ChartAccount>> getAllChartAccounts() async {
    final accounts = await _dao.getAllChartAccounts();
    return accounts.map((account) => ChartAccountModel(
      id: account.id,
      parentId: account.parentId,
      accountingTypeId: account.accountingTypeId,
      code: account.code,
      level: account.level,
      name: account.name,
      active: account.active,
      createdAt: account.createdAt,
      updatedAt: account.updatedAt,
      deletedAt: account.deletedAt,
    ).toEntity()).toList();
  }

  @override
  Future<ChartAccount?> getChartAccountById(int id) async {
    final account = await _dao.getChartAccountById(id);
    if (account == null) return null;
    
    return ChartAccountModel(
      id: account.id,
      parentId: account.parentId,
      accountingTypeId: account.accountingTypeId,
      code: account.code,
      level: account.level,
      name: account.name,
      active: account.active,
      createdAt: account.createdAt,
      updatedAt: account.updatedAt,
      deletedAt: account.deletedAt,
    ).toEntity();
  }

  @override
  Future<List<ChartAccount>> getChartAccountsByType(String accountingTypeId) async {
    final accounts = await _dao.getChartAccountsByType(accountingTypeId);
    return accounts.map((account) => ChartAccountModel(
      id: account.id,
      parentId: account.parentId,
      accountingTypeId: account.accountingTypeId,
      code: account.code,
      level: account.level,
      name: account.name,
      active: account.active,
      createdAt: account.createdAt,
      updatedAt: account.updatedAt,
      deletedAt: account.deletedAt,
    ).toEntity()).toList();
  }

  @override
  Future<void> deleteChartAccount(int id) => _dao.deleteChartAccount(id);

  @override
  Stream<List<ChartAccount>> watchAllChartAccounts() {
    return _dao.watchAllChartAccounts().map(
      (accounts) => accounts.map((account) => ChartAccountModel(
        id: account.id,
        parentId: account.parentId,
        accountingTypeId: account.accountingTypeId,
        code: account.code,
        level: account.level,
        name: account.name,
        active: account.active,
        createdAt: account.createdAt,
        updatedAt: account.updatedAt,
        deletedAt: account.deletedAt,
      ).toEntity()).toList()
    );
  }

  @override
  Future<ChartAccount> createChartAccount(ChartAccount account) async {
    final model = ChartAccountModel.fromEntity(account);
    final id = await _dao.insertChartAccount(model.toCompanion());
    final createdAccount = await getChartAccountById(id);
    if (createdAccount == null) {
      throw Exception('Failed to create chart account');
    }
    return createdAccount;
  }

  @override
  Future<void> updateChartAccount(ChartAccount account) async {
    final model = ChartAccountModel.fromEntity(account);
    await _dao.updateChartAccount(model.toCompanion());
  }

  @override
  Future<List<ChartAccount>> getChildAccounts(int parentId) async {
    final accounts = await _dao.getChartAccountsByParent(parentId);
    return accounts.map((account) => ChartAccountModel(
      id: account.id,
      parentId: account.parentId,
      accountingTypeId: account.accountingTypeId,
      code: account.code,
      level: account.level,
      name: account.name,
      active: account.active,
      createdAt: account.createdAt,
      updatedAt: account.updatedAt,
      deletedAt: account.deletedAt,
    ).toEntity()).toList();
  }

  @override
  Future<ChartAccount> generateAccountForCategory(String name, String accountingTypeId, {int? parentId}) async {
    // 1. Determinar el nivel y código basado en el padre (si existe)
    int level = 1;
    String codePrefix = '';
    
    // Convertir el ID de tipo de cuenta a formato numérico
    final numericTypeId = _accountingTypeNumberMap[accountingTypeId] ?? accountingTypeId;
    
    if (parentId != null) {
      final parentAccount = await getChartAccountById(parentId);
      if (parentAccount != null) {
        level = parentAccount.level + 1;
        codePrefix = '${parentAccount.code}.';
      }
    }
    
    // 2. Obtener el próximo número disponible para este tipo de cuenta
    final accountsOfType = await getChartAccountsByType(accountingTypeId);
    final sameLevelAccounts = accountsOfType
        .where((a) => a.level == level && (parentId == null ? a.parentId == null : a.parentId == parentId))
        .toList();
    final nextNumber = sameLevelAccounts.length + 1;
    
    // 3. Generar el código completo - Ahora usando el ID numérico
    final code = parentId == null 
        ? '$numericTypeId$nextNumber' 
        : '$codePrefix$nextNumber';
    
    // 4. Crear la nueva cuenta contable
    final now = DateTime.now();
    final newAccount = ChartAccount(
      id: 0, // Se generará automáticamente
      parentId: parentId,
      accountingTypeId: accountingTypeId,
      code: code,
      level: level,
      name: name,
      active: true,
      createdAt: now,
      updatedAt: now,
      deletedAt: null,
    );
    
    // 5. Insertar y devolver la cuenta creada
    return createChartAccount(newAccount);
  }

  @override
  Future<ChartAccount> generateAccountForWallet(String name) async {
    // Las cuentas de wallet son activos (Assets)
    return generateAccountForCategory(
      'Cuenta: $name', 
      AccountingType.assets.id,
    );
  }

  @override
  Future<ChartAccount> generateAccountForCreditCard(String name) async {
    // Las tarjetas de crédito son pasivos (Liabilities)
    return generateAccountForCategory(
      'Tarjeta: $name',
      AccountingType.liabilities.id,
    );
  }

  @override
  Future<List<ChartAccount>> getChartAccountsByCode(String code) async {
    final accounts = await _dao.getChartAccountsByCode(code);
    return accounts.map((account) => ChartAccountModel(
      id: account.id,
      parentId: account.parentId,
      accountingTypeId: account.accountingTypeId,
      code: account.code,
      level: account.level,
      name: account.name,
      active: account.active,
      createdAt: account.createdAt,
      updatedAt: account.updatedAt,
      deletedAt: account.deletedAt,
    ).toEntity()).toList();
  }

  @override
  Future<String> generateNextChildCode(int parentId) async {
    final parent = await _dao.getChartAccountById(parentId);
    if (parent == null) {
      throw Exception('Cuenta padre no encontrada');
    }
    
    final parentCode = parent.code;
    
    // Obtener todas las cuentas hijas de este padre
    final childAccounts = await _dao.getChildAccounts(parentId);
    
    if (childAccounts.isEmpty) {
      // Si no hay hijos, crear el primer código hijo (parent.code + ".01")
      return '$parentCode.01';
    } else {
      // Obtener los códigos y buscar el último
      List<String> childCodes = childAccounts.map((a) => a.code).toList();
      
      // Ordenar los códigos para encontrar el último
      childCodes.sort();
      String lastCode = childCodes.last;
      
      // Extraer el número secuencial de la última parte del código
      String lastCodeSuffix = lastCode.substring(lastCode.lastIndexOf('.') + 1);
      
      // Convertir a entero, incrementar y formatear
      int nextNumber = int.parse(lastCodeSuffix) + 1;
      String formattedNumber = nextNumber.toString().padLeft(2, '0');
      
      return '$parentCode.$formattedNumber';
    }
  }
}
