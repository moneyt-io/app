// lib/data/repositories/accou1t_repository_impl.dart
import '../../domain/entities/account.dart';
import '../../domain/repositories/account_repository.dart';
import '../local/daos/account_dao.dart';
import '../models/account_model.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountDao _accountDao;

  AccountRepositoryImpl(this._accountDao);

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
    }
  }

  @override
  Future<void> deleteAccount(int id) async {
    await _accountDao.deleteAccount(id);
  }
}