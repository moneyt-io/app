import 'package:injectable/injectable.dart';
import '../../domain/entities/shared_expense_entry.dart';
import '../../domain/entities/shared_expense_detail.dart';
import '../../domain/repositories/shared_expense_repository.dart';
import '../datasources/local/daos/shared_expense_dao.dart';
import '../datasources/local/database.dart';
import '../models/shared_expense_entry_model.dart';
import '../models/shared_expense_detail_model.dart';

@Injectable(as: SharedExpenseRepository)
class SharedExpenseRepositoryImpl implements SharedExpenseRepository {
  final SharedExpenseDao _dao;

  SharedExpenseRepositoryImpl(this._dao);

  Future<List<SharedExpenseEntry>> _mapEntriesToEntities(
    List<SharedExpenseEntries> entries
  ) async {
    return Future.wait(entries.map((entry) async {
      final details = await _dao.getSharedExpenseDetailsForEntry(entry.id);
      return SharedExpenseEntryModel(
        id: entry.id,
        documentTypeId: entry.documentTypeId,
        currencyId: entry.currencyId,
        secuencial: entry.secuencial,
        date: entry.date,
        amount: entry.amount,
        rateExchange: entry.rateExchange,
        active: entry.active,
        createdAt: entry.createdAt,
        updatedAt: entry.updatedAt,
        deletedAt: entry.deletedAt,
      ).toEntity(
        details: details.map((detail) => SharedExpenseDetailModel(
          id: detail.id,
          sharedExpenseId: detail.sharedExpenseId,
          currencyId: detail.currencyId,
          loanId: detail.loanId,
          transactionId: detail.transactionId,
          percentage: detail.percentage,
          amount: detail.amount,
          rateExchange: detail.rateExchange,
          status: detail.status,
        ).toEntity()).toList(),
      );
    }));
  }

  @override
  Future<List<SharedExpenseEntry>> getAllSharedExpenses() async {
    final entries = await _dao.getAllSharedExpenses();
    return _mapEntriesToEntities(entries);
  }

  @override
  Stream<List<SharedExpenseEntry>> watchAllSharedExpenses() {
    return _dao.watchAllSharedExpenses().asyncMap(_mapEntriesToEntities);
  }

  @override
  Future<SharedExpenseEntry?> getSharedExpenseById(int id) async {
    final entry = await _dao.getSharedExpenseById(id);
    if (entry == null) return null;

    final details = await _dao.getSharedExpenseDetailsForEntry(entry.id);
    return SharedExpenseEntryModel(
      id: entry.id,
      documentTypeId: entry.documentTypeId,
      currencyId: entry.currencyId,
      secuencial: entry.secuencial,
      date: entry.date,
      amount: entry.amount,
      rateExchange: entry.rateExchange,
      active: entry.active,
      createdAt: entry.createdAt,
      updatedAt: entry.updatedAt,
      deletedAt: entry.deletedAt,
    ).toEntity(
      details: details.map((detail) => SharedExpenseDetailModel(
        id: detail.id,
        sharedExpenseId: detail.sharedExpenseId,
        currencyId: detail.currencyId,
        loanId: detail.loanId,
        transactionId: detail.transactionId,
        percentage: detail.percentage,
        amount: detail.amount,
        rateExchange: detail.rateExchange,
        status: detail.status,
      ).toEntity()).toList(),
    );
  }

  @override
  Future<SharedExpenseEntry> createSharedExpense(
    SharedExpenseEntry expense,
    List<SharedExpenseDetail> details
  ) async {
    final model = SharedExpenseEntryModel.fromEntity(expense);
    final id = await _dao.insertSharedExpense(model.toCompanion());

    for (var detail in details) {
      final detailModel = SharedExpenseDetailModel.create(
        sharedExpenseId: id,
        currencyId: detail.currencyId,
        loanId: detail.loanId,
        transactionId: detail.transactionId,
        percentage: detail.percentage,
        amount: detail.amount,
        rateExchange: detail.rateExchange,
        status: detail.status,
      );
      await _dao.insertSharedExpenseDetail(detailModel.toCompanion());
    }

    final createdExpense = await getSharedExpenseById(id);
    if (createdExpense == null) {
      throw Exception('Failed to create shared expense');
    }
    return createdExpense;
  }

  @override
  Future<void> updateSharedExpense(SharedExpenseEntry expense) async {
    final model = SharedExpenseEntryModel.fromEntity(expense);
    await _dao.updateSharedExpense(model.toCompanion());
  }

  @override
  Future<void> deleteSharedExpense(int id) async {
    await _dao.deleteSharedExpenseDetails(id);
    await _dao.deleteSharedExpense(id);
  }

  @override
  Future<void> createExpensePayment(
    int expenseId,
    int detailId,
    double amount,
    String paymentTypeId,
    int paymentId,
    DateTime date,
    {String? description}
  ) async {
    // TODO: Implementar lógica de pago
    throw UnimplementedError();
  }
}
