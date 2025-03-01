import 'package:injectable/injectable.dart';
import '../entities/loan_entry.dart';
import '../entities/loan_detail.dart';
import '../repositories/loan_repository.dart';

@injectable
class LoanUseCases {
  final LoanRepository _repository;

  LoanUseCases(this._repository);

  Stream<List<LoanEntry>> watchAllLoans() => _repository.watchAllLoans();
  
  Future<List<LoanEntry>> getLoansByContact(int contactId) => 
      _repository.getLoansByContact(contactId);

  Future<LoanEntry> createLoan(LoanEntry loan, List<LoanDetail> details) =>
      _repository.createLoan(loan, details);

  Future<void> payLoan(
    int loanId,
    double amount,
    String paymentTypeId,
    int paymentId,
    DateTime date,
    {String? description}
  ) => _repository.createLoanPayment(
    loanId, 
    amount, 
    paymentTypeId, 
    paymentId, 
    date,
    description: description
  );

  Future<void> deleteLoan(int id) => _repository.deleteLoan(id);
}
