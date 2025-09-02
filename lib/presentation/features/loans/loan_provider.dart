import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import '../../../domain/entities/loan_entry.dart';
import '../../../domain/entities/contact.dart';
import '../../../domain/usecases/loan_usecases.dart';
import '../../../domain/usecases/contact_usecases.dart';

class LoanProvider extends ChangeNotifier {
  final LoanUseCases _loanUseCases = GetIt.instance<LoanUseCases>();
  final ContactUseCases _contactUseCases = GetIt.instance<ContactUseCases>();

  List<LoanEntry> _loans = [];
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  List<LoanEntry> get loans => _loans;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Getters para listas filtradas
  List<LoanEntry> get activeLends => _loans
      .where((loan) =>
          loan.documentTypeId == 'L' && loan.status == LoanStatus.active)
      .toList();

  List<LoanEntry> get activeBorrows => _loans
      .where((loan) =>
          loan.documentTypeId == 'B' && loan.status == LoanStatus.active)
      .toList();

  List<LoanEntry> get outstandingLoans => _loans
      .where((loan) =>
          loan.status == LoanStatus.active && loan.outstandingBalance > 0)
      .toList();

  // Métodos para gestión de estado
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
  }

  // Cargar préstamos
  Future<void> loadLoans() async {
    if (_isLoading) return;

    _setLoading(true);
    try {
      // Load loans first
      final loans = await _loanUseCases.getAllLoans();
      
      // Load contacts for each loan and populate the contact field
      final loansWithContacts = <LoanEntry>[];
      for (final loan in loans) {
        if (loan.contactId > 0) {
          try {
            final contact = await _contactUseCases.getContactById(loan.contactId);
            final loanWithContact = loan.copyWith(contact: contact);
            loansWithContacts.add(loanWithContact);
          } catch (e) {
            // If contact loading fails, add loan without contact
            debugPrint('Failed to load contact ${loan.contactId}: $e');
            loansWithContacts.add(loan);
          }
        } else {
          loansWithContacts.add(loan);
        }
      }
      
      _loans = loansWithContacts;
      _clearError();
    } catch (e) {
      _setError('Error al cargar préstamos: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  // Crear préstamo simple
  Future<LoanEntry?> createLoan({
    required String documentTypeId,
    required int contactId,
    required double amount,
    required String currencyId,
    required DateTime date,
    String? description,
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
      );

      await loadLoans(); // Recargar lista
      _clearError();
      return loan;
    } catch (e) {
      _setError('Error al crear préstamo: ${e.toString()}');
      return null;
    } finally {
      _setLoading(false);
    }
  }

  // Obtener estadísticas de préstamos
  Future<Map<String, double>> getStatistics() async {
    try {
      final allLoans = _loans;

      double totalLent = 0.0;
      double totalBorrowed = 0.0;
      double outstandingLent = 0.0;
      double outstandingBorrowed = 0.0;

      for (final loan in allLoans) {
        if (loan.documentTypeId == 'L') {
          totalLent += loan.amount;
          outstandingLent += loan.outstandingBalance;
        } else {
          totalBorrowed += loan.amount;
          outstandingBorrowed += loan.outstandingBalance;
        }
      }

      final netBalance = totalLent - totalBorrowed;

      return {
        'totalLent': totalLent,
        'totalBorrowed': totalBorrowed,
        'outstandingLent': outstandingLent,
        'outstandingBorrowed': outstandingBorrowed,
        'netBalance': netBalance,
      };
    } catch (e) {
      _setError('Error al cargar estadísticas: ${e.toString()}');
      return {};
    }
  }

  // Crear préstamo con método de pago específico
  Future<LoanEntry?> createLoanWithPaymentMethod({
    required String documentTypeId,
    required int contactId,
    required double amount,
    required String currencyId,
    required DateTime date,
    required String paymentType,
    required int? paymentId,
    String? description,
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
      );

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

  // Crear pago de préstamo
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

      await loadLoans();
      _clearError();
    } catch (e) {
      _setError('Error al registrar pago: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  // Cancelar saldo de préstamo
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

      await loadLoans();
      _clearError();
    } catch (e) {
      _setError('Error al cancelar saldo: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  // Actualizar estado de préstamo
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

      await loadLoans();
      _clearError();
    } catch (e) {
      _setError('Error al actualizar estado: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  // Eliminar préstamo
  Future<void> deleteLoan(int id) async {
    if (_isLoading) return;

    _setLoading(true);
    try {
      await _loanUseCases.deleteLoan(id);
      await loadLoans();
      _clearError();
    } catch (e) {
      _setError('Error al eliminar préstamo: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }
}
