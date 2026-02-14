import 'package:injectable/injectable.dart';
import '../../domain/entities/loan_entry.dart';
import '../../domain/entities/loan_detail.dart';
import '../../domain/repositories/loan_repository.dart';
import '../datasources/local/daos/loan_dao.dart';
import '../datasources/local/database.dart';
import '../models/loan_entry_model.dart';
import '../models/loan_detail_model.dart';

@Injectable(as: LoanRepository)
class LoanRepositoryImpl implements LoanRepository {
  final LoanDao _loanDao;

  LoanRepositoryImpl(this._loanDao);

  // Helper para convertir entidad de BD a entidad de dominio
  Future<LoanEntry> _convertToLoanEntry(LoanEntries entry) async {
    final details = await _loanDao.getLoanDetailsForEntry(entry.id);
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
      status: _parseStatus(entry.status),
      totalPaid: entry.totalPaid,
      active: entry.active,
      createdAt: entry.createdAt,
      updatedAt: entry.updatedAt,
      deletedAt: entry.deletedAt,
      details: details.map((d) => LoanDetailModel.fromDatabase(d).toEntity()).toList(), // CORREGIDO: Agregar .toEntity()
    ).toEntity();
  }

  LoanStatus _parseStatus(String status) {
    switch (status.toUpperCase()) {
      case 'ACTIVE':
        return LoanStatus.active;
      case 'PAID':
        return LoanStatus.paid;
      case 'CANCELLED':
        return LoanStatus.cancelled;
      case 'WRITTEN_OFF':
        return LoanStatus.writtenOff;
      default:
        return LoanStatus.active;
    }
  }

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

  @override
  Future<List<LoanEntry>> getAllLoans() async {
    final results = await _loanDao.getAllLoans();
    final loans = <LoanEntry>[];
    
    for (final result in results) {
      loans.add(await _convertToLoanEntry(result));
    }
    
    return loans;
  }

  @override
  Future<LoanEntry?> getLoanById(int id) async {
    final result = await _loanDao.getLoanById(id);
    if (result == null) return null;
    
    return await _convertToLoanEntry(result);
  }

  @override
  Stream<List<LoanEntry>> watchAllLoans() {
    return _loanDao.watchAllLoans().asyncMap((results) async {
      final loans = <LoanEntry>[];
      for (final result in results) {
        loans.add(await _convertToLoanEntry(result));
      }
      return loans;
    });
  }

  @override
  Future<LoanEntry> createLoan(LoanEntry loan, List<LoanDetail> details) async {
    final loanModel = LoanEntryModel.fromEntity(loan);
    final loanCompanion = loanModel.toCompanion();
    
    // Insertar loan entry
    final loanId = await _loanDao.insertLoan(loanCompanion);
    
    // Insertar details
    for (final detail in details) {
      final detailModel = LoanDetailModel.fromEntity(detail.copyWith(loanId: loanId));
      await _loanDao.insertLoanDetail(detailModel.toCompanion());
    }
    
    // Retornar el loan creado
    final createdLoan = await getLoanById(loanId);
    return createdLoan!;
  }

  @override
  Future<void> updateLoan(LoanEntry loan) async {
    final loanModel = LoanEntryModel.fromEntity(loan);
    await _loanDao.updateLoan(loanModel.toCompanion());
  }

  @override
  Future<void> deleteLoan(int id) async {
    await _loanDao.deleteLoan(id);
  }

  @override
  Future<List<LoanEntry>> getLoansByContact(int contactId) async {
    final results = await _loanDao.getLoansByContact(contactId);
    final loans = <LoanEntry>[];
    
    for (final result in results) {
      loans.add(await _convertToLoanEntry(result));
    }
    
    return loans;
  }

  @override
  Future<List<LoanEntry>> getLoansByType(String documentTypeId) async {
    final results = await _loanDao.getLoansByType(documentTypeId);
    final loans = <LoanEntry>[];
    
    for (final result in results) {
      loans.add(await _convertToLoanEntry(result));
    }
    
    return loans;
  }

  @override
  Future<List<LoanEntry>> getLoansByStatus(LoanStatus status) async {
    final results = await _loanDao.getLoansByStatus(_statusToString(status));
    final loans = <LoanEntry>[];
    
    for (final result in results) {
      loans.add(await _convertToLoanEntry(result));
    }
    
    return loans;
  }

  @override
  Future<double> getTotalLentAmount() {
    return _loanDao.getTotalLentAmount();
  }

  @override
  Future<double> getTotalBorrowedAmount() {
    return _loanDao.getTotalBorrowedAmount();
  }

  @override
  Future<double> getOutstandingLentAmount() {
    return _loanDao.getOutstandingLentAmount();
  }

  @override
  Future<double> getOutstandingBorrowedAmount() {
    return _loanDao.getOutstandingBorrowedAmount();
  }

  @override
  Future<int> getNextSecuencial(String documentTypeId) {
    return _loanDao.getNextSecuencial(documentTypeId);
  }

  // MÉTODO FALTANTE IMPLEMENTADO:
  @override
  Future<void> createLoanPayment(
    int loanId,
    double amount,
    String paymentTypeId,
    int paymentId,
    DateTime date,
    {String? description}
  ) async {
    // Obtener el préstamo actual
    final loan = await getLoanById(loanId);
    if (loan == null) {
      throw Exception('Préstamo no encontrado');
    }

    // Validar que el préstamo esté activo
    if (loan.status != LoanStatus.active) {
      throw Exception('No se puede registrar pago en un préstamo no activo');
    }

    // Calcular nuevo total pagado
    final newTotalPaid = loan.totalPaid + amount;
    
    // Determinar nuevo estado
    LoanStatus newStatus;
    if (newTotalPaid >= loan.amount) {
      newStatus = LoanStatus.paid;
    } else {
      newStatus = LoanStatus.active;
    }

    // Crear el detalle del pago
    final loanDetail = LoanDetail(
      id: 0,
      loanId: loanId,
      currencyId: loan.currencyId,
      paymentTypeId: paymentTypeId,
      paymentId: paymentId,
      journalId: 0, // Se puede vincular posteriormente
      transactionId: 0, // Se puede vincular posteriormente
      amount: amount,
      rateExchange: 1.0,
      active: true,
      createdAt: date,
      updatedAt: date,
    );

    // Insertar el detalle del pago
    final detailModel = LoanDetailModel.fromEntity(loanDetail);
    await _loanDao.insertLoanDetail(detailModel.toCompanion());

    // Actualizar el préstamo
    final updatedLoan = loan.copyWith(
      totalPaid: newTotalPaid,
      status: newStatus,
      updatedAt: DateTime.now(),
    );

    await updateLoan(updatedLoan);
  }
}
