import 'package:injectable/injectable.dart';
import '../entities/recurring_transaction.dart';
import '../repositories/recurring_transaction_repository.dart';

@injectable
class RecurringTransactionUseCases {
  final RecurringTransactionRepository _repository;

  RecurringTransactionUseCases(this._repository);

  Future<List<RecurringTransaction>> getAllRecurringTransactions() =>
      _repository.getAllRecurringTransactions();

  Future<List<RecurringTransaction>> getActiveRecurringTransactions() =>
      _repository.getActiveRecurringTransactions();

  Stream<List<RecurringTransaction>> watchActiveRecurringTransactions() =>
      _repository.watchActiveRecurringTransactions();

  Stream<List<RecurringTransaction>> watchAllRecurringTransactions() =>
      _repository.watchAllRecurringTransactions();

  Future<RecurringTransaction?> getRecurringTransactionById(int id) =>
      _repository.getRecurringTransactionById(id);

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
  }) =>
      _repository.createRecurringTransaction(
        documentTypeId: documentTypeId,
        currencyId: currencyId,
        paymentId: paymentId,
        paymentTypeId: paymentTypeId,
        categoryId: categoryId,
        contactId: contactId,
        amount: amount,
        rateExchange: rateExchange,
        description: description,
        frequency: frequency,
        startDate: startDate,
        endDate: endDate,
        lastExecutedAt: lastExecutedAt,
        nextExecutionDate: nextExecutionDate,
        autoCreate: autoCreate,
      );

  Future<bool> updateRecurringTransaction(RecurringTransaction recurring) =>
      _repository.updateRecurringTransaction(recurring);

  Future<bool> updateExecutionDates(int id, DateTime lastExecutedAt, DateTime nextExecutionDate) =>
      _repository.updateExecutionDates(id, lastExecutedAt, nextExecutionDate);

  Future<bool> toggleActive(int id, bool active) =>
      _repository.toggleActive(id, active);

  Future<bool> deleteRecurringTransaction(int id) =>
      _repository.deleteRecurringTransaction(id);
}
