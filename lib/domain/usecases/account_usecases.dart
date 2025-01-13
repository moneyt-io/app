// lib/domain/usecases/account_usecases.dart
import 'package:moneyt_pfm/core/events/sync_event.dart';
import 'package:moneyt_pfm/data/services/sync_manager.dart';
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
  final SyncManager syncManager;

  CreateAccount(this.repository, this.syncManager);

  Future<void> call(AccountEntity account) async {
    await repository.createAccount(account);
    try {
      // Notificar cambio y sincronizar inmediatamente
      await syncManager.notifyChange(
        AccountSyncEvent(
          accountId: account.id,
          operation: SyncOperation.create,
        ),
      );
      await syncManager.syncNow();
    } catch (e) {
      print('Error during sync: $e');
    }
  }
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
    // Primero marcamos como eliminado en Firebase
    await syncService.handleAccountDeletion(id);
    // La eliminación local ocurrirá en la próxima sincronización
  }
}