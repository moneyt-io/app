// import 'package:flutter/material.dart';
// import '../../core/services/sync_service.dart';

// class SyncProvider extends ChangeNotifier {
//   //final SyncService syncService;
//   bool _isSyncEnabled = false;
//   bool _isInitialized = false;

//   bool get isSyncEnabled => _isSyncEnabled;

//   SyncProvider({required this.syncService}) {
//     _loadSyncStatus();
//   }

//   Future<void> _loadSyncStatus() async {
//     _isSyncEnabled = await syncService.isSyncEnabled();
//     _isInitialized = true;
//     notifyListeners();
//   }

//   Future<void> setSyncEnabled(bool value) async {
//     await syncService.setSyncEnabled(value);
//     _isSyncEnabled = value;
//     notifyListeners();
//   }

//   Future<void> forceSyncNow() async {
//     if (!_isInitialized) {
//       await _loadSyncStatus();
//     }
    
//     if (!_isSyncEnabled) {
//       throw Exception('Sync is disabled');
//     }

//     _isInitialized = true;
//     notifyListeners();

//     try {
//       await syncService.syncData();
//     } finally {
//       _isInitialized = false;
//       notifyListeners();
//     }
//   }
// }