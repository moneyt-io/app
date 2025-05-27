import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'dart:async';
import '../../domain/entities/loan_entry.dart';
import '../../domain/entities/contact.dart';
import '../../domain/usecases/loan_usecases.dart';

class LoanProvider with ChangeNotifier {
  final LoanUseCases _loanUseCases = GetIt.instance<LoanUseCases>();

  // Estado interno
  List<LoanEntry> _loans = [];
  bool _isLoading = false;
  String? _errorMessage;

  // Getters públicos
  List<LoanEntry> get loans => _loans;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Getters especializados
  List<LoanEntry> get activeLends => _loans
      .where((loan) => loan.documentTypeId == 'L' && loan.status == LoanStatus.active)
      .toList();

  List<LoanEntry> get activeBorrows => _loans
      .where((loan) => loan.documentTypeId == 'B' && loan.status == LoanStatus.active)
      .toList();

  List<LoanEntry> get outstandingLoans => _loans
      .where((loan) => loan.status == LoanStatus.active && loan.outstandingBalance > 0)
      .toList();

  /// Carga todos los préstamos
  Future<void> loadLoans() async {
    if (_isLoading) return;

    _setLoading(true);
    try {
      _loans = await _loanUseCases.getAllLoans();
      _clearError();
    } catch (e) {
      _setError('Error al cargar préstamos: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  /// Crea un préstamo simple
  Future<LoanEntry?> createSimpleLoan({
    required String documentTypeId,
    required int contactId,
    required double amount,
    required String currencyId,
    required DateTime date,
    String? description,
    double rateExchange = 1.0,
  }) async {
    if (_isLoading) return null;

    _setLoading(true);
    try {
      final loan = await _loanUseCases.createSimpleLoan(
        documentTypeId: documentTypeId,
        contactId: contactId,
        amount: amount,
        currencyId: currencyId,
        date: date,
        description: description,
        rateExchange: rateExchange,
      );

      // Recargar la lista
      await loadLoans();
      _clearError();
      return loan;
    } catch (e) {
      _setError('Error al crear préstamo: ${e.toString()}');
      return null;
    } finally {
      _setLoading(false);
    }
  }

  /// Actualiza el estado de un préstamo
  Future<void> updateLoanStatus({
    required int loanId,
    required LoanStatus newStatus,
  }) async {
    if (_isLoading) return;

    _setLoading(true);
    try {
      await _loanUseCases.updateLoanStatus(
        loanId: loanId,
        newStatus: newStatus,
      );

      // Recargar la lista
      await loadLoans();
      _clearError();
    } catch (e) {
      _setError('Error al actualizar préstamo: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  /// Marca un préstamo como pagado
  Future<void> markLoanAsPaid(int loanId) async {
    if (_isLoading) return;

    _setLoading(true);
    try {
      await _loanUseCases.markLoanAsPaid(loanId);

      // Recargar la lista
      await loadLoans();
      _clearError();
    } catch (e) {
      _setError('Error al marcar préstamo como pagado: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  /// Registra un pago simple de préstamo
  Future<void> createLoanPayment({
    required int loanId,
    required double paymentAmount,
    required DateTime date,
    String? description,
  }) async {
    if (_isLoading) return;

    _setLoading(true);
    try {
      await _loanUseCases.createSimpleLoanPayment(
        loanId: loanId,
        paymentAmount: paymentAmount,
        date: date,
        description: description,
      );

      // Recargar la lista
      await loadLoans();
      _clearError();
    } catch (e) {
      _setError('Error al registrar pago: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  /// Cancela el saldo pendiente de un préstamo
  Future<void> writeOffLoan({
    required int loanId,
    String? description,
  }) async {
    if (_isLoading) return;

    _setLoading(true);
    try {
      await _loanUseCases.writeOffLoanBalance(
        loanId: loanId,
        description: description,
      );

      // Recargar la lista
      await loadLoans();
      _clearError();
    } catch (e) {
      _setError('Error al cancelar saldo: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  /// Elimina un préstamo
  Future<void> deleteLoan(int id) async {
    if (_isLoading) return;

    _setLoading(true);
    try {
      await _loanUseCases.deleteLoan(id);

      // Recargar la lista
      await loadLoans();
      _clearError();
    } catch (e) {
      _setError('Error al eliminar préstamo: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  /// Obtiene estadísticas básicas
  Future<Map<String, double>> getStatistics() async {
    try {
      final totalLent = await _loanUseCases.getTotalLentAmount();
      final totalBorrowed = await _loanUseCases.getTotalBorrowedAmount();
      final outstandingLent = await _loanUseCases.getOutstandingLentAmount();
      final outstandingBorrowed = await _loanUseCases.getOutstandingBorrowedAmount();
      final netBalance = await _loanUseCases.getNetLoanBalance();
      
      return {
        'totalLent': totalLent,
        'totalBorrowed': totalBorrowed,
        'outstandingLent': outstandingLent,
        'outstandingBorrowed': outstandingBorrowed,
        'netBalance': netBalance,
      };
    } catch (e) {
      _setError('Error al calcular estadísticas: ${e.toString()}');
      return {};
    }
  }

  /// Filtra préstamos por contacto
  List<LoanEntry> getLoansByContact(int contactId) {
    return _loans.where((loan) => loan.contactId == contactId).toList();
  }

  /// Filtra préstamos por tipo
  List<LoanEntry> getLoansByType(String documentTypeId) {
    return _loans.where((loan) => loan.documentTypeId == documentTypeId).toList();
  }

  // Métodos helper
  double getOutstandingBalance(LoanEntry loan) {
    return _loanUseCases.getOutstandingBalance(loan);
  }

  bool canWriteOffLoan(LoanEntry loan) {
    return _loanUseCases.canWriteOffLoan(loan);
  }

  bool isLoanFullyPaid(LoanEntry loan) {
    return _loanUseCases.isLoanFullyPaid(loan);
  }

  // Métodos privados para gestión de estado - CORREGIDOS
  void _setLoading(bool loading) {
    if (_isLoading != loading) {
      _isLoading = loading;
      // Usar scheduleMicrotask para evitar setState durante build
      scheduleMicrotask(() => notifyListeners());
    }
  }

  void _setError(String error) {
    if (_errorMessage != error) {
      _errorMessage = error;
      scheduleMicrotask(() => notifyListeners());
    }
  }

  void _clearError() {
    if (_errorMessage != null) {
      _errorMessage = null;
      scheduleMicrotask(() => notifyListeners());
    }
  }
}
