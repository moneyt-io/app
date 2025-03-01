import '../entities/loan_entry.dart';
import '../entities/loan_detail.dart';

abstract class LoanRepository {
  // Queries básicas
  Future<List<LoanEntry>> getAllLoans();
  Future<LoanEntry?> getLoanById(int id);
  Future<List<LoanEntry>> getLoansByContact(int contactId);
  Stream<List<LoanEntry>> watchAllLoans();
  
  // CRUD Operations
  Future<LoanEntry> createLoan(LoanEntry loan, List<LoanDetail> details);
  Future<void> updateLoan(LoanEntry loan);
  Future<void> deleteLoan(int id);

  // Operaciones específicas
  Future<void> createLoanPayment(
    int loanId,
    double amount,
    String paymentTypeId,
    int paymentId,
    DateTime date,
    {String? description}
  );
}
