import 'package:injectable/injectable.dart';
import '../../domain/entities/chart_account.dart';
import '../../domain/repositories/chart_account_repository.dart';
import '../datasources/local/daos/chart_accounts_dao.dart';
import '../models/chart_account_model.dart';

@Injectable(as: ChartAccountRepository)
class ChartAccountRepositoryImpl implements ChartAccountRepository {
  final ChartAccountsDao _dao;

  ChartAccountRepositoryImpl(this._dao);

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
}
