// Clase base para eventos de sincronización
abstract class SyncEvent {
  final String entityType;
  final DateTime timestamp;

  SyncEvent({
    required this.entityType,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}

// Evento específico para cambios en cuentas
class AccountSyncEvent extends SyncEvent {
  final int accountId;
  final SyncOperation operation;

  AccountSyncEvent({
    required this.accountId,
    required this.operation,
  }) : super(entityType: 'account');
}

// Tipos de operaciones de sincronización
enum SyncOperation {
  create,
  update,
  delete,
}
