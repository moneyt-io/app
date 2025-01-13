// lib/data/repositories/account_repository_impl.dart
import 'package:moneyt_pfm/core/events/sync_event.dart';

import '../../domain/entities/account.dart';
import '../../domain/repositories/account_repository.dart';
import '../local/daos/account_dao.dart';
import '../models/account_model.dart';
import '../services/sync_manager.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountDao _accountDao;
  final SyncManager _syncManager;

  AccountRepositoryImpl(
    this._accountDao,
    this._syncManager,
  );

  @override
  Stream<List<AccountEntity>> watchAccounts() {
    return _accountDao.watchAllAccounts().map((driftAccounts) {
      return driftAccounts
          .map((driftAccount) => AccountModel.fromDriftAccount(driftAccount))
          .toList();
    });
  }

  @override
  Future<List<AccountEntity>> getAccounts() async {
    final driftAccounts = await _accountDao.getAllAccounts();
    return driftAccounts
        .map((driftAccount) => AccountModel.fromDriftAccount(driftAccount))
        .toList();
  }

  @override
  Future<void> createAccount(AccountEntity account) async {
    if (account is AccountModel) {
      await _accountDao.insertAccount(account.toCompanion());
    }
  }

  @override
  Future<void> updateAccount(AccountEntity account) async {
    if (account is AccountModel) {
      await _accountDao.updateAccount(account.toCompanionWithId());
      _syncManager.notifyChange(
        AccountSyncEvent(
          accountId: account.id,
          operation: SyncOperation.update,
        ),
      );
    }
  }

  @override
  Future<void> deleteAccount(int id) async {
    await _accountDao.deleteAccount(id);
    _syncManager.notifyChange(
      AccountSyncEvent(
        accountId: id,
        operation: SyncOperation.delete,
      ),
    );
  }
}