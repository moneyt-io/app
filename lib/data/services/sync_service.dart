import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:drift/drift.dart';
import '../datasources/local/database.dart';

class SyncService {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final AppDatabase localDb;
  bool _initialized = false;

  SyncService({
    required this.auth,
    required this.firestore,
    required this.localDb,
  }) {
    _initialize();
  }

  Future<void> _initialize() async {
    auth.authStateChanges().listen((user) async {
      if (user != null) {
        final userDoc = firestore.collection('users').doc(user.uid);
        if (!(await userDoc.get()).exists) {
          await userDoc.set({
            'syncEnabled': false,
            'email': user.email,
            'createdAt': FieldValue.serverTimestamp(),
          });
        }
        _initialized = true;
      }
    });
  }

  Future<bool> isSyncEnabled() async {
    if (!_initialized) {
      await Future.delayed(const Duration(milliseconds: 500));
    }
    final user = auth.currentUser;
    if (user == null) return false;

    final userDoc = await firestore.collection('users').doc(user.uid).get();
    return userDoc.data()?['syncEnabled'] ?? false;
  }
  
  Future<void> syncData() async {
    // Verificar si la sincronización está habilitada antes de proceder
    if (!await isSyncEnabled()) {
      print('Sync is disabled. Skipping sync process.');
      return;
    }

    final user = auth.currentUser;
    if (user == null) return;

    final userDoc = firestore.collection('users').doc(user.uid);
    final lastSyncDoc = await userDoc.collection('syncInfo').doc('lastSync').get();
    final lastSyncTime = lastSyncDoc.exists 
      ? (lastSyncDoc.data()?['timestamp'] as Timestamp).toDate() 
      : null;

    // Sincronizar cuentas
    await _syncAccounts(userDoc, lastSyncTime);

    // Sincronizar categorías
    await _syncCategories(userDoc, lastSyncTime);

    // Sincronizar transacciones
    await _syncTransactions(userDoc, lastSyncTime);

    // Actualizar timestamp de última sincronización
    await userDoc.collection('syncInfo').doc('lastSync').set({
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> _syncAccounts(DocumentReference userDoc, DateTime? lastSync) async {
    try {
      print('Iniciando sincronización de cuentas...');
      
      // Obtener cuentas locales
      final localAccounts = await localDb.accountDao.getAllAccounts();
      print('Cuentas locales encontradas: ${localAccounts.length}');
      
      // Obtener cuentas remotas
      final remoteAccounts = await userDoc.collection('accounts').get();
      final remoteAccountIds = remoteAccounts.docs.map((doc) => int.parse(doc.id)).toSet();
      
      // Sincronizar cuentas locales
      for (final account in localAccounts) {
        print('Procesando cuenta local: ${account.id} - ${account.name}');
        
        final shouldSync = !remoteAccountIds.contains(account.id) || 
                          lastSync == null ||
                          (account.updatedAt?.isAfter(lastSync) ?? true);
        
        if (shouldSync) {
          print('Subiendo cuenta a Firebase: ${account.id}');
          await userDoc.collection('accounts').doc(account.id.toString()).set({
            'id': account.id,
            'name': account.name,
            'description': account.description,
            'balance': account.balance,
            'createdAt': Timestamp.fromDate(account.createdAt),
            'updatedAt': Timestamp.fromDate(account.updatedAt ?? account.createdAt),
            'isDeleted': false, // Agregamos el flag de eliminación
          }, SetOptions(merge: true));
          print('Cuenta subida exitosamente: ${account.id}');
        }
      }

      // Procesar cuentas remotas
      print('Procesando cuentas remotas...');
      for (final doc in remoteAccounts.docs) {
        print('Procesando cuenta remota: ${doc.id}');
        final data = doc.data();
        
        // Si la cuenta está marcada como eliminada, eliminarla localmente
        if (data['isDeleted'] == true) {
          await localDb.accountDao.deleteAccount(int.parse(doc.id));
          continue;
        }

        final updatedAt = (data['updatedAt'] as Timestamp).toDate();
        
        await localDb.accountDao.upsertAccount(AccountsCompanion(
          id: Value(int.parse(doc.id)),
          name: Value(data['name'] as String),
          description: Value(data['description'] as String? ?? ''),
          balance: Value((data['balance'] as num).toDouble()),
          createdAt: Value((data['createdAt'] as Timestamp).toDate()),
          updatedAt: Value(updatedAt),
        ));
      }
    } catch (e, stackTrace) {
      print('Error en sincronización de cuentas: $e');
      print('Stack trace: $stackTrace');
      rethrow;
    }
  }
    // Add method to handle account deletion
  Future<void> handleAccountDeletion(int accountId) async {
    final user = auth.currentUser;
    if (user == null) return;

    final userDoc = firestore.collection('users').doc(user.uid);
    
    // Marcar la cuenta como eliminada en Firestore
    await userDoc.collection('accounts').doc(accountId.toString()).update({
      'isDeleted': true,
      'deletedAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
    
    // Forzar sincronización después de marcar como eliminado
    await syncData();
  }

  Future<void> deleteAccountAndSync(int accountId) async {
    // Marcar la cuenta como eliminada en Firebase
    await handleAccountDeletion(accountId);

    // Eliminar la cuenta localmente
    await localDb.accountDao.deleteAccount(accountId);

    // Opcional: forzar sincronización
    await syncData();
  }

  Future<void> ensureAccountDeletion(int accountId) async {
    // Llamar siempre a deleteAccountAndSync
    await deleteAccountAndSync(accountId);

    // Comprobar si Firestore pudo actualizar el flag de isDeleted
    final user = auth.currentUser;
    if (user == null) return;
    final userDoc = firestore.collection('users').doc(user.uid);
    final docRef = userDoc.collection('accounts').doc(accountId.toString());
    final docSnap = await docRef.get();

    if (docSnap.exists && docSnap.data()?['isDeleted'] != true) {
      print('No se logró marcar como eliminada. Verifica permisos de Firestore.');
    }
  }

  Future<void> _syncCategories(DocumentReference userDoc, DateTime? lastSync) async {
    // Subir categorías locales nuevas o modificadas
    final localCategories = await localDb.categoryDao.getAllCategories();
    for (final category in localCategories) {
      final categoryUpdatedAt = category.updatedAt;
      if (lastSync == null || (categoryUpdatedAt != null && categoryUpdatedAt.isAfter(lastSync))) {
        await userDoc.collection('categories').doc(category.id.toString()).set({
          'name': category.name,
          'type': category.type,
          'parentId': category.parentId,
          'createdAt': Timestamp.fromDate(category.createdAt),
          'updatedAt': Timestamp.fromDate(category.updatedAt ?? DateTime.now()),
        });
      }
    }

    // Descargar categorías remotas nuevas o modificadas
    final remoteCategories = await userDoc.collection('categories').get();
    for (final doc in remoteCategories.docs) {
      final data = doc.data();
      final updatedAt = (data['updatedAt'] as Timestamp).toDate();
      
      if (lastSync == null || updatedAt.isAfter(lastSync)) {
        await localDb.categoryDao.upsertCategory(CategoriesCompanion(
          id: Value(int.parse(doc.id)),
          name: Value(data['name'] as String),
          type: Value(data['type'] as String),
          parentId: Value(data['parentId'] != null ? (data['parentId'] is String ? 
          int.parse(data['parentId'] as String) : data['parentId'] as int)
  : null),
          createdAt: Value((data['createdAt'] as Timestamp).toDate()),
          updatedAt: Value(updatedAt),
        ));
      }
    }
  }

  Future<void> _syncTransactions(DocumentReference userDoc, DateTime? lastSync) async {
    // Subir transacciones locales nuevas o modificadas
    final localTransactions = await localDb.transactionDao.getAllTransactions();
    for (final transaction in localTransactions) {
      final transactionUpdatedAt = transaction.updatedAt;
      if (lastSync == null || (transactionUpdatedAt != null && transactionUpdatedAt.isAfter(lastSync))) {
        await userDoc.collection('transactions').doc(transaction.id.toString()).set({
          'type': transaction.type,
          'flow': transaction.flow,
          'amount': transaction.amount,
          'accountId': transaction.accountId,
          'categoryId': transaction.categoryId,
          'description': transaction.description,
          'reference': transaction.reference,
          'transactionDate': Timestamp.fromDate(transaction.transactionDate),
          'createdAt': Timestamp.fromDate(transaction.createdAt),
          'updatedAt': Timestamp.fromDate(transaction.updatedAt ?? DateTime.now()),
        });
      }
    }

    // Descargar transacciones remotas nuevas o modificadas
    final remoteTransactions = await userDoc.collection('transactions').get();
    for (final doc in remoteTransactions.docs) {
      final data = doc.data();
      final updatedAtTimestamp = data['updatedAt'] as Timestamp?;
      final updatedAt = updatedAtTimestamp?.toDate() ?? DateTime.now();
      
      if (lastSync == null || (updatedAt.isAfter(lastSync))) {
        await localDb.transactionDao.upsertTransaction(TransactionsCompanion(
          id: Value(int.parse(doc.id)),
          type: Value(data['type'] as String),
          flow: Value(data['flow'] as String),
          amount: Value((data['amount'] as num).toDouble()),
          accountId: Value(int.parse(data['accountId'] as String)),
          categoryId: Value(data['categoryId'] != null ? int.parse(data['categoryId'] as String) : null),
          description: Value(data['description'] as String? ?? ''),
          reference: Value(data['reference'] as String? ?? ''),
          transactionDate: Value((data['transactionDate'] as Timestamp).toDate()),
          createdAt: Value((data['createdAt'] as Timestamp).toDate()),
          updatedAt: Value(updatedAt),
          status: const Value(true),
        ));
      }
    }
  }




  // Método para sincronizar cuando hay cambios locales
  Future<void> syncOnLocalChange() async {
    await syncData();
  }

  // Método para sincronizar cuando hay cambios remotos
  Future<void> syncOnRemoteChange() async {
    await syncData();
  }

  // Método para configurar listeners de cambios remotos
  void setupRemoteChangeListeners() {
    final user = auth.currentUser;
    if (user == null) return;

    final userDoc = firestore.collection('users').doc(user.uid);

    // Escuchar cambios en cuentas
    userDoc.collection('accounts').snapshots().listen((_) {
      syncOnRemoteChange();
    });

    // Escuchar cambios en categorías
    userDoc.collection('categories').snapshots().listen((_) {
      syncOnRemoteChange();
    });

    // Escuchar cambios en transacciones
    userDoc.collection('transactions').snapshots().listen((_) {
      syncOnRemoteChange();
    });
  }

  Future<void> setSyncEnabled(bool enabled) async {
    final user = auth.currentUser;
    if (user == null) return;

    await firestore.collection('users').doc(user.uid).update({
      'syncEnabled': enabled,
    });

    if (enabled) {
      // Si se habilita la sincronización, realizar sincronización inicial
      await syncData();
      setupRemoteChangeListeners();
    } else {
      // Si se deshabilita, remover los listeners
      removeRemoteChangeListeners();
    }
  }

  void removeRemoteChangeListeners() {
    // Implementar la lógica para remover los listeners aquí
  }
}
