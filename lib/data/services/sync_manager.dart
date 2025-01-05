import 'dart:async';
import '../services/sync_service.dart';
import '../../core/events/sync_event.dart';

class SyncManager {
  final SyncService _syncService;
  Timer? _debounceTimer;
  bool _isSyncing = false;
  final Duration _debounceTime = const Duration(seconds: 2);

  SyncManager(this._syncService);

  Future<void> notifyChange(SyncEvent event) async {
    // Cancelar el timer anterior si existe
    _debounceTimer?.cancel();
    
    // Crear un nuevo timer
    _debounceTimer = Timer(_debounceTime, () {
      _handleSyncEvent(event);
    });
  }

  Future<void> _handleSyncEvent(SyncEvent event) async {
    if (_isSyncing) return;
    
    try {
      _isSyncing = true;
      await _syncService.syncData();
    } catch (e) {
      print('Error during sync: $e');
    } finally {
      _isSyncing = false;
    }
  }

  void dispose() {
    _debounceTimer?.cancel();
  }

  // Método para sincronización manual
  Future<void> forceSyncNow() async {
    if (_isSyncing) return;
    
    try {
      _isSyncing = true;
      await _syncService.syncData();
    } finally {
      _isSyncing = false;
    }
  }

  // Configurar listeners para cambios remotos
  void setupRemoteListeners() {
    _syncService.setupRemoteChangeListeners();
  }
}
