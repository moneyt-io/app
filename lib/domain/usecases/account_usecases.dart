// lib/domain/usecases/account_usecases.dart
import 'package:moneyt_pfm/data/services/sync_service.dart';

import '../entities/account.dart';
import '../repositories/account_repository.dart';

class GetAccounts {
  final AccountRepository repository;

  GetAccounts(this.repository);

  Stream<List<AccountEntity>> call() => repository.watchAccounts();
}

class CreateAccount {
  final AccountRepository repository;

  CreateAccount(this.repository);

  Future<void> call(AccountEntity account) => repository.createAccount(account);
}

class UpdateAccount {
  final AccountRepository repository;

  UpdateAccount(this.repository);

  Future<void> call(AccountEntity account) => repository.updateAccount(account);
}

class DeleteAccount {
  final AccountRepository repository;
  final SyncService syncService;

  DeleteAccount(this.repository, this.syncService);

  Future<void> call(int id) async {
    await syncService.handleAccountDeletion(id);
    // La eliminación local ocurrirá en la próxima sincronización
  }
}