import 'package:injectable/injectable.dart';
import '../../domain/entities/loan_entry.dart';
import '../../domain/entities/loan_detail.dart';
import '../../domain/repositories/loan_repository.dart';
import '../datasources/local/daos/loan_dao.dart';
import '../models/loan_entry_model.dart';
import '../models/loan_detail_model.dart';

@Injectable(as: LoanRepository)
class LoanRepositoryImpl implements LoanRepository {
  final LoanDao _dao;

  LoanRepositoryImpl(this._dao);

  @override
  Future<List<LoanEntry>> getAllLoans() async {
    final entries = await _dao.getAllLoans();
    return Future.wait(entries.map((entry) async {
      final details = await _dao.getLoanDetailsForEntry(entry.id);
      return LoanEntryModel(
        id: entry.id,
        documentTypeId: entry.documentTypeId,
        currencyId: entry.currencyId,
        contactId: entry.contactId,
        secuencial: entry.secuencial,
        date: entry.date,
        amount: entry.amount,
        rateExchange: entry.rateExchange,
        description: entry.description,
        status: entry.status,
        active: entry.active,
        createdAt: entry.createdAt,
        updatedAt: entry.updatedAt,
        deletedAt: entry.deletedAt,
      ).toEntity(
        details: details.map((detail) => LoanDetailModel(
          id: detail.id,
          loanId: detail.loanId,
          currencyId: detail.currencyId,
          paymentTypeId: detail.paymentTypeId,
          paymentId: detail.paymentId,
          journalId: detail.journalId,
          transactionId: detail.transactionId,
          amount: detail.amount,
          rateExchange: detail.rateExchange,
        ).toEntity()).toList(),
      );
    }));
  }

  @override
  Future<LoanEntry?> getLoanById(int id) async {
    final entry = await _dao.getLoanById(id);
    if (entry == null) return null;

    final details = await _dao.getLoanDetailsForEntry(entry.id);
    return LoanEntryModel(
      id: entry.id,
      documentTypeId: entry.documentTypeId,
      currencyId: entry.currencyId,
      contactId: entry.contactId,
      secuencial: entry.secuencial,
      date: entry.date,
      amount: entry.amount,
      rateExchange: entry.rateExchange,
      description: entry.description,
      status: entry.status,
      active: entry.active,
      createdAt: entry.createdAt,
      updatedAt: entry.updatedAt,
      deletedAt: entry.deletedAt,
    ).toEntity(
      details: details.map((detail) => LoanDetailModel(
        id: detail.id,
        loanId: detail.loanId,
        currencyId: detail.currencyId,
        paymentTypeId: detail.paymentTypeId,
        paymentId: detail.paymentId,
        journalId: detail.journalId,
        transactionId: detail.transactionId,
        amount: detail.amount,
        rateExchange: detail.rateExchange,
      ).toEntity()).toList(),
    );
  }

  @override
  Stream<List<LoanEntry>> watchAllLoans() {
    return _dao.watchAllLoans().asyncMap((entries) async {
      return Future.wait(entries.map((entry) async {
        final details = await _dao.getLoanDetailsForEntry(entry.id);
        return LoanEntryModel(
          id: entry.id,
          documentTypeId: entry.documentTypeId,
          currencyId: entry.currencyId,
          contactId: entry.contactId,
          secuencial: entry.secuencial,
          date: entry.date,
          amount: entry.amount,
          rateExchange: entry.rateExchange,
          description: entry.description,
          status: entry.status,
          active: entry.active,
          createdAt: entry.createdAt,
          updatedAt: entry.updatedAt,
          deletedAt: entry.deletedAt,
        ).toEntity(
          details: details.map((detail) => LoanDetailModel(
            id: detail.id,
            loanId: detail.loanId,
            currencyId: detail.currencyId,
            paymentTypeId: detail.paymentTypeId,
            paymentId: detail.paymentId,
            journalId: detail.journalId,
            transactionId: detail.transactionId,
            amount: detail.amount,
            rateExchange: detail.rateExchange,
          ).toEntity()).toList(),
        );
      }));
    });
  }

  @override
  Future<LoanEntry> createLoan(LoanEntry loan, List<LoanDetail> details) async {
    final model = LoanEntryModel.fromEntity(loan);
    final id = await _dao.insertLoan(model.toCompanion());

    // Insertar detalles
    for (var detail in details) {
      final detailModel = LoanDetailModel.create(
        loanId: id,
        currencyId: detail.currencyId,
        paymentTypeId: detail.paymentTypeId,
        paymentId: detail.paymentId,
        journalId: detail.journalId,
        transactionId: detail.transactionId,
        amount: detail.amount,
        rateExchange: detail.rateExchange,
      );
      await _dao.insertLoanDetail(detailModel.toCompanion());
    }

    final createdLoan = await getLoanById(id);
    if (createdLoan == null) {
      throw Exception('Failed to create loan');
    }
    return createdLoan;
  }

  @override
  Future<void> updateLoan(LoanEntry loan) async {
    final model = LoanEntryModel.fromEntity(loan);
    await _dao.updateLoan(model.toCompanion());
  }

  @override
  Future<void> deleteLoan(int id) async {
    await _dao.deleteLoanDetails(id);
    await _dao.deleteLoan(id);
  }

  @override
  Future<List<LoanEntry>> getLoansByContact(int contactId) async {
    final entries = await _dao.getLoansByContact(contactId);
    return Future.wait(entries.map((entry) async {
      final details = await _dao.getLoanDetailsForEntry(entry.id);
      return LoanEntryModel(
        id: entry.id,
        documentTypeId: entry.documentTypeId,
        currencyId: entry.currencyId,
        contactId: entry.contactId,
        secuencial: entry.secuencial,
        date: entry.date,
        amount: entry.amount,
        rateExchange: entry.rateExchange,
        description: entry.description,
        status: entry.status,
        active: entry.active,
        createdAt: entry.createdAt,
        updatedAt: entry.updatedAt,
        deletedAt: entry.deletedAt,
      ).toEntity(
        details: details.map((detail) => LoanDetailModel(
          id: detail.id,
          loanId: detail.loanId,
          currencyId: detail.currencyId,
          paymentTypeId: detail.paymentTypeId,
          paymentId: detail.paymentId,
          journalId: detail.journalId,
          transactionId: detail.transactionId,
          amount: detail.amount,
          rateExchange: detail.rateExchange,
        ).toEntity()).toList(),
      );
    }));
  }

  @override
  Future<void> createLoanPayment(
    int loanId,
    double amount,
    String paymentTypeId,
    int paymentId,
    DateTime date,
    {String? description}
  ) async {
    // TODO: Implementar lógica de pago de préstamo
    throw UnimplementedError();
  }
}
