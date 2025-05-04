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
    int? parentChartAccountId = parentId; // Renombrar para claridad interna
    int level;
    String codePrefix;
    String numericTypeId; // Necesario para el código raíz

    // Determinar el tipo numérico
    switch (accountingTypeId) {
      case 'As': numericTypeId = '1'; break; // Assets
      case 'Li': numericTypeId = '2'; break; // Liabilities
      case 'Eq': numericTypeId = '3'; break; // Equity
      case 'In': numericTypeId = '4'; break; // Income
      case 'Ex': numericTypeId = '5'; break; // Expenses
      default: throw Exception('Tipo de cuenta desconocido: $accountingTypeId');
    }

    if (parentChartAccountId == null) {
      // Buscar cuenta raíz del tipo correspondiente (ej. '1' para Activos)
      final baseAccounts = await _dao.getChartAccountsByCode(numericTypeId);
      if (baseAccounts.isEmpty) {
        throw Exception('Cuenta base $numericTypeId no encontrada.');
      }
      final baseAccount = baseAccounts.first;

      // Asegurarse que la cuenta base encontrada es realmente del tipo esperado (defensivo)
      if (baseAccount.accountingTypeId != accountingTypeId) {
         throw Exception('La cuenta base encontrada ($numericTypeId) no es del tipo esperado ($accountingTypeId).');
      }
      // Asegurarse que la cuenta base es de nivel 0 (defensivo)
      if (baseAccount.level != 0) {
         throw Exception('La cuenta base encontrada ($numericTypeId) no tiene nivel 0.');
      }


      parentChartAccountId = baseAccount.id;
      level = baseAccount.level + 1; // Nivel 1
      codePrefix = '$numericTypeId.'; // Prefijo para cuentas bajo la raíz del tipo
    } else {
      // Obtener cuenta padre para determinar nivel y prefijo
      final parentAccount = await _dao.getChartAccountById(parentChartAccountId);
      if (parentAccount == null) {
        throw Exception('Cuenta padre contable con ID $parentChartAccountId no encontrada.');
      }

      // *** Añadir Verificación Defensiva ***
      // Asegurarse que la cuenta padre pertenece al mismo tipo principal (Assets, Liab, etc.)
      // Esto previene crear, por ejemplo, un Activo bajo un Pasivo si se pasara un ID incorrecto.
      final parentNumericTypeId = _accountingTypeNumberMap[parentAccount.accountingTypeId];
      if (parentNumericTypeId != numericTypeId) {
         throw Exception('La cuenta padre (${parentAccount.code}) pertenece a un tipo diferente (${parentAccount.accountingTypeId}) al esperado ($accountingTypeId).');
      }
      // *** Fin Verificación Defensiva ***

      level = parentAccount.level + 1;
      codePrefix = '${parentAccount.code}.';
    }

    // Obtener el próximo número disponible bajo el padre contable determinado
    final siblings = await _dao.getChildAccounts(parentChartAccountId);
    final nextNumber = siblings.length + 1;

    // Generar el código completo
    final code = '$codePrefix$nextNumber';

    // Crear la nueva cuenta contable
    final now = DateTime.now();
    final newAccountEntity = ChartAccount(
      id: 0,
      parentId: parentChartAccountId, // Usar el ID del padre contable
      accountingTypeId: accountingTypeId,
      code: code,
      level: level,
      name: name,
      active: true,
      createdAt: now,
      updatedAt: now,
      deletedAt: null,
    );

    // Guardar y devolver
    final companion = ChartAccountModel.fromEntity(newAccountEntity).toCompanion();
    final createdId = await _dao.insertChartAccount(companion);
    final createdData = await _dao.getChartAccountById(createdId);
     if (createdData == null) throw Exception('Failed to retrieve created chart account');
    return ChartAccountModel(
      id: createdData.id,
      parentId: createdData.parentId,
      accountingTypeId: createdData.accountingTypeId,
      code: createdData.code,
      level: createdData.level,
      name: createdData.name,
      active: createdData.active,
      createdAt: createdData.createdAt,
      updatedAt: createdData.updatedAt,
      deletedAt: createdData.deletedAt,
    ).toEntity();
  }

  @override
  Future<ChartAccount> generateAccountForWallet(String name, {int? parentChartAccountId}) async {
    // Las cuentas de wallet son activos (Assets)
    // Llamar a generateAccountForCategory pasando el parentChartAccountId (que puede ser null)
    return generateAccountForCategory(
      'Cuenta: $name',
      AccountingType.assets.id,
      parentId: parentChartAccountId, // Pasar el ID del padre contable (puede ser null)
    );
  }

  @override
  Future<ChartAccount> generateAccountForCreditCard(String name) async {
    // Las tarjetas de crédito son pasivos (Liabilities)
    // Asumimos que las tarjetas de crédito no tienen jerarquía aquí,
    // por lo que no pasamos parentId.
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
