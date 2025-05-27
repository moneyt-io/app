import '../entities/loan_entry.dart';
import '../entities/loan_detail.dart';

abstract class LoanRepository {
  // Consultas básicas
  Future<List<LoanEntry>> getAllLoans();
  Future<LoanEntry?> getLoanById(int id);
  Stream<List<LoanEntry>> watchAllLoans();
  
  // Consultas especializadas
  Future<List<LoanEntry>> getLoansByContact(int contactId);
  Future<List<LoanEntry>> getLoansByType(String documentTypeId);
  Future<List<LoanEntry>> getLoansByStatus(LoanStatus status);
  
  // CRUD Operations
  Future<LoanEntry> createLoan(LoanEntry loan, List<LoanDetail> details);
  Future<void> updateLoan(LoanEntry loan);
  Future<void> deleteLoan(int id);
  
  // Gestión de pagos básica
  Future<void> createLoanPayment(
    int loanId,
    double amount,
    String paymentTypeId,
    int paymentId,
    DateTime date,
    {String? description}
  );
  
  // Estadísticas básicas
  Future<double> getTotalLentAmount();
  Future<double> getTotalBorrowedAmount();
  Future<double> getOutstandingLentAmount();
  Future<double> getOutstandingBorrowedAmount();
  
  // Utilidades
  Future<int> getNextSecuencial(String documentTypeId);
}
