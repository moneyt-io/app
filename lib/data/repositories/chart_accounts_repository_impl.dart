import 'package:drift/drift.dart';
import '../../domain/entities/chart_account.dart';
import '../../domain/repositories/chart_accounts_repository.dart';
import '../local/daos/chart_accounts_dao.dart';
import '../local/database.dart';

class ChartAccountsRepositoryImpl implements ChartAccountsRepository {
  final ChartAccountsDao _chartAccountsDao;

  ChartAccountsRepositoryImpl(this._chartAccountsDao);

  ChartAccountEntity _mapToEntity(ChartAccount account) {
    return ChartAccountEntity(
      id: account.id,
      accountingTypeId: account.accountingTypeId,
      parentId: account.parentId,
      code: account.code,
      name: account.name,
      level: account.level,
      active: account.active,
      createdAt: account.createdAt,
      updatedAt: account.updatedAt,
      deletedAt: account.deletedAt,
    );
  }

  ChartAccountsCompanion _mapToCompanion(ChartAccountEntity account) {
    return ChartAccountsCompanion(
      id: account.id == null ? const Value.absent() : Value(account.id!),
      accountingTypeId: Value(account.accountingTypeId),
      parentId: Value(account.parentId),
      code: Value(account.code),
      name: Value(account.name),
      level: Value(account.level),
      active: Value(account.active),
      createdAt: Value(account.createdAt),
      updatedAt: Value(account.updatedAt),
      deletedAt: Value(account.deletedAt),
    );
  }

  @override
  Future<List<ChartAccountEntity>> getAllChartAccounts() async {
    final accounts = await _chartAccountsDao.getAllChartAccounts();
    return accounts.map(_mapToEntity).toList();
  }

  @override
  Stream<List<ChartAccountEntity>> watchAllChartAccounts() {
    return _chartAccountsDao.watchAllChartAccounts()
        .map((accounts) => accounts.map(_mapToEntity).toList());
  }

  @override
  Future<ChartAccountEntity> getChartAccountById(int id) async {
    final account = await _chartAccountsDao.getChartAccountById(id);
    return _mapToEntity(account);
  }

  @override
  Future<List<ChartAccountEntity>> getChartAccountsByType(int accountingTypeId) async {
    final accounts = await _chartAccountsDao.getChartAccountsByType(accountingTypeId);
    return accounts.map(_mapToEntity).toList();
  }

  @override
  Future<List<ChartAccountEntity>> getChildAccounts(int parentId) async {
    final accounts = await _chartAccountsDao.getChildAccounts(parentId);
    return accounts.map(_mapToEntity).toList();
  }

  @override
  Future<int> createChartAccount(ChartAccountEntity account) {
    final companion = ChartAccountsCompanion.insert(
      accountingTypeId: account.accountingTypeId,
      parentId: Value(account.parentId),
      code: account.code,
      name: account.name,
      level: account.level,
      active: Value(account.active),
      createdAt: Value(account.createdAt),
      updatedAt: Value(account.updatedAt),
      deletedAt: Value(account.deletedAt),
    );
    return _chartAccountsDao.insertChartAccount(companion);
  }

  @override
  Future<bool> updateChartAccount(ChartAccountEntity account) {
    return _chartAccountsDao.updateChartAccount(_mapToCompanion(account));
  }

  @override
  Future<bool> deleteChartAccount(int id) async {
    return await _chartAccountsDao.softDeleteChartAccount(id) > 0;
  }
}
