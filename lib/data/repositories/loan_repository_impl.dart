import 'package:injectable/injectable.dart';
import '../../domain/entities/loan_entry.dart';
import '../../domain/entities/loan_detail.dart';
import '../../domain/repositories/loan_repository.dart';
import '../datasources/local/daos/loan_dao.dart';
import '../models/loan_entry_model.dart';
import '../models/loan_detail_model.dart';

@LazySingleton(as: LoanRepository)
class LoanRepositoryImpl implements LoanRepository {
  final LoanDao _dao;

  LoanRepositoryImpl(this._dao);

  @override
  Future<List<LoanEntry>> getAllLoans() async {
    final entries = await _dao.getAllLoans();
    return Future.wait(entries.map((entry) async {
      final details = await _dao.getLoanDetailsForEntry(entry.id);
      return LoanEntryModel.fromDrift(entry).toEntity(
        details: details.map((detail) => 
            LoanDetailModel.fromDrift(detail).toEntity()).toList(),
      );
    }));
  }

  @override
  Future<LoanEntry?> getLoanById(int id) async {
    final entry = await _dao.getLoanById(id);
    if (entry == null) return null;

    final details = await _dao.getLoanDetailsForEntry(entry.id);
    return LoanEntryModel.fromDrift(entry).toEntity(
      details: details.map((detail) => 
          LoanDetailModel.fromDrift(detail).toEntity()).toList(),
    );
  }

  @override
  Stream<List<LoanEntry>> watchAllLoans() {
    return _dao.watchAllLoans().asyncMap((entries) async {
      return Future.wait(entries.map((entry) async {
        final details = await _dao.getLoanDetailsForEntry(entry.id);
        return LoanEntryModel.fromDrift(entry).toEntity(
          details: details.map((detail) => 
              LoanDetailModel.fromDrift(detail).toEntity()).toList(),
        );
      }));
    });
  }

  @override
  Future<List<LoanEntry>> getLoansByContact(int contactId) async {
    final entries = await _dao.getLoansByContact(contactId);
    return Future.wait(entries.map((entry) async {
      final details = await _dao.getLoanDetailsForEntry(entry.id);
      return LoanEntryModel.fromDrift(entry).toEntity(
        details: details.map((detail) => 
            LoanDetailModel.fromDrift(detail).toEntity()).toList(),
      );
    }));
  }

  @override
  Future<List<LoanEntry>> getLoansByType(String documentTypeId) async {
    final entries = await _dao.getLoansByType(documentTypeId);
    return Future.wait(entries.map((entry) async {
      final details = await _dao.getLoanDetailsForEntry(entry.id);
      return LoanEntryModel.fromDrift(entry).toEntity(
        details: details.map((detail) => 
            LoanDetailModel.fromDrift(detail).toEntity()).toList(),
      );
    }));
  }

  @override
  Future<List<LoanEntry>> getLoansByStatus(LoanStatus status) async {
    final results = await _dao.getLoansByStatus(status.name.toUpperCase());
    return results.map((loan) => LoanEntryModel.fromDrift(loan).toEntity()).toList();
  }

  @override
  Future<LoanEntry> createLoan(LoanEntry loan, List<LoanDetail> details) async {
    // Crear el préstamo principal
    final loanModel = LoanEntryModel.fromEntity(loan);
    final loanId = await _dao.insertLoan(loanModel.toCompanion());

    // Crear los detalles
    for (final detail in details) {
      final detailModel = LoanDetailModel.fromEntity(detail.copyWith(loanId: loanId));
      await _dao.insertLoanDetail(detailModel.toCompanion());
    }

    // Retornar el préstamo creado
    final createdLoan = await getLoanById(loanId);
    return createdLoan!;
  }

  @override
  Future<void> updateLoan(LoanEntry loan) async {
    final model = LoanEntryModel.fromEntity(loan);
    await _dao.updateLoan(model.toCompanion());
  }

  @override
  Future<void> deleteLoan(int id) async {
    await _dao.softDeleteLoan(id);
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
    // TODO: Implementar en fases posteriores
    throw UnimplementedError('Pagos serán implementados en fase posterior');
  }

  @override
  Future<double> getTotalLentAmount() async {
    final result = await _dao.getTotalByType('L');
    return result ?? 0.0;
  }

  @override
  Future<double> getTotalBorrowedAmount() async {
    final result = await _dao.getTotalByType('B');
    return result ?? 0.0;
  }

  @override
  Future<double> getOutstandingLentAmount() async {
    final result = await _dao.getOutstandingByType('L');
    return result ?? 0.0;
  }

  @override
  Future<double> getOutstandingBorrowedAmount() async {
    final result = await _dao.getOutstandingByType('B');
    return result ?? 0.0;
  }

  @override
  Future<int> getNextSecuencial(String documentTypeId) async {
    return await _dao.getNextSecuencial(documentTypeId);
  }

  // Helper method
  String _statusToString(LoanStatus status) {
    switch (status) {
      case LoanStatus.active:
        return 'ACTIVE';
      case LoanStatus.paid:
        return 'PAID';
      case LoanStatus.cancelled:
        return 'CANCELLED';
      case LoanStatus.writtenOff:
        return 'WRITTEN_OFF';
    }
  }
}
