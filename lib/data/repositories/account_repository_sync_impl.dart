import '../../domain/entities/account.dart';
import '../../domain/repositories/account_repository.dart';
import '../services/sync_service.dart';

class AccountRepositorySyncImpl implements AccountRepository {
  final AccountRepository _baseRepository;
  final SyncService _syncService;

  AccountRepositorySyncImpl(this._baseRepository, this._syncService);

  @override
  Stream<List<AccountEntity>> watchAccounts() {
    return _baseRepository.watchAccounts();
  }

  @override
  Future<List<AccountEntity>> getAccounts() async {
    return _baseRepository.getAccounts();
  }

  @override
  Future<void> createAccount(AccountEntity account) async {
    await _baseRepository.createAccount(account);
    await _syncService.syncOnLocalChange();
  }

  @override
  Future<void> updateAccount(AccountEntity account) async {
    await _baseRepository.updateAccount(account);
    await _syncService.syncOnLocalChange();
  }

  @override
  Future<void> deleteAccount(int id) async {
    await _baseRepository.deleteAccount(id);
    await _syncService.syncOnLocalChange();
  }
}
