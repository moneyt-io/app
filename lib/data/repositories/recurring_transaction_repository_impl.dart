import 'package:drift/drift.dart' as drift;
import 'package:injectable/injectable.dart';
import '../../domain/entities/recurring_transaction.dart';
import '../../domain/repositories/recurring_transaction_repository.dart';
import '../../domain/repositories/category_repository.dart';
import '../../domain/repositories/wallet_repository.dart';
import '../../domain/repositories/contact_repository.dart';
import '../datasources/local/daos/recurring_transaction_dao.dart';
import '../datasources/local/database.dart';
import '../models/recurring_transaction_model.dart';

@Injectable(as: RecurringTransactionRepository)
class RecurringTransactionRepositoryImpl implements RecurringTransactionRepository {
  final RecurringTransactionDao _dao;
  final CategoryRepository _categoryRepository;
  final WalletRepository _walletRepository;
  final ContactRepository _contactRepository;

  RecurringTransactionRepositoryImpl(
    this._dao,
    this._categoryRepository,
    this._walletRepository,
    this._contactRepository,
  );

  Future<RecurringTransaction> _enrichEntity(RecurringTransactionData data) async {
    final base = RecurringTransactionModel.fromDatabase(data).toEntity();

    // Fetch relational data safely
    final category = await _categoryRepository.getCategoryById(base.categoryId);
    final wallet = base.paymentTypeId == 'W'
        ? await _walletRepository.getWalletById(base.paymentId)
        : null;
    final contact = base.contactId != null
        ? await _contactRepository.getContactById(base.contactId!)
        : null;

    return base.copyWith(
      category: category,
      wallet: wallet,
      contact: contact,
    );
  }

  @override
  Future<List<RecurringTransaction>> getAllRecurringTransactions() async {
    final records = await _dao.getAllRecurringTransactions();
    final results = <RecurringTransaction>[];
    for (final r in records) {
      results.add(await _enrichEntity(r));
    }
    return results;
  }

  @override
  Future<List<RecurringTransaction>> getActiveRecurringTransactions() async {
    final records = await _dao.getActiveRecurringTransactions();
    final results = <RecurringTransaction>[];
    for (final r in records) {
      results.add(await _enrichEntity(r));
    }
    return results;
  }

  @override
  Stream<List<RecurringTransaction>> watchActiveRecurringTransactions() {
    return _dao.watchActiveRecurringTransactions().asyncMap((records) async {
      final results = <RecurringTransaction>[];
      for (final r in records) {
        results.add(await _enrichEntity(r));
      }
      return results;
    });
  }

  @override
  Stream<List<RecurringTransaction>> watchAllRecurringTransactions() {
    return _dao.watchAllRecurringTransactions().asyncMap((records) async {
      final results = <RecurringTransaction>[];
      for (final r in records) {
        results.add(await _enrichEntity(r));
      }
      return results;
    });
  }

  @override
  Future<RecurringTransaction?> getRecurringTransactionById(int id) async {
    final record = await _dao.getRecurringTransactionById(id);
    if (record == null) return null;
    return await _enrichEntity(record);
  }

  @override
  Future<RecurringTransaction> createRecurringTransaction({
    required String documentTypeId,
    required String currencyId,
    required int paymentId,
    String paymentTypeId = 'W',
    required int categoryId,
    int? contactId,
    required double amount,
    double rateExchange = 1.0,
    String? description,
    required String frequency,
    required DateTime startDate,
    DateTime? endDate,
    DateTime? lastExecutedAt,
    required DateTime nextExecutionDate,
    bool autoCreate = true,
  }) async {
    final companion = RecurringTransactionDataCompanion(
      documentTypeId: drift.Value(documentTypeId),
      currencyId: drift.Value(currencyId),
      paymentId: drift.Value(paymentId),
      paymentTypeId: drift.Value(paymentTypeId),
      categoryId: drift.Value(categoryId),
      contactId: drift.Value(contactId),
      amount: drift.Value(amount),
      rateExchange: drift.Value(rateExchange),
      description: drift.Value(description),
      frequency: drift.Value(frequency),
      startDate: drift.Value(startDate),
      endDate: drift.Value(endDate),
      lastExecutedAt: drift.Value(lastExecutedAt),
      nextExecutionDate: drift.Value(nextExecutionDate),
      active: const drift.Value(true),
      autoCreate: drift.Value(autoCreate),
      createdAt: drift.Value(DateTime.now()),
      updatedAt: drift.Value(DateTime.now()),
    );

    final newId = await _dao.insertRecurringTransaction(companion);
    final inserted = await _dao.getRecurringTransactionById(newId);
    return await _enrichEntity(inserted!);
  }

  @override
  Future<bool> updateRecurringTransaction(RecurringTransaction recurring) async {
    final model = RecurringTransactionModel.fromEntity(recurring);
    return await _dao.updateRecurringTransaction(model.toCompanion());
  }

  @override
  Future<bool> updateExecutionDates(int id, DateTime lastExecutedAt, DateTime nextExecutionDate) async {
    final affected = await _dao.updateExecutionDates(id, lastExecutedAt, nextExecutionDate);
    return affected > 0;
  }

  @override
  Future<bool> toggleActive(int id, bool active) async {
    final affected = await _dao.toggleActive(id, active);
    return affected > 0;
  }

  @override
  Future<bool> deleteRecurringTransaction(int id) async {
    final affected = await _dao.softDeleteRecurringTransaction(id);
    return affected > 0;
  }
}
