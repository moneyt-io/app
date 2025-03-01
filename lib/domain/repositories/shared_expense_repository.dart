import '../entities/shared_expense_entry.dart';
import '../entities/shared_expense_detail.dart';

abstract class SharedExpenseRepository {
  // Queries básicas
  Future<List<SharedExpenseEntry>> getAllSharedExpenses();
  Future<SharedExpenseEntry?> getSharedExpenseById(int id);
  Stream<List<SharedExpenseEntry>> watchAllSharedExpenses();
  
  // CRUD Operations
  Future<SharedExpenseEntry> createSharedExpense(
    SharedExpenseEntry expense, 
    List<SharedExpenseDetail> details
  );
  Future<void> updateSharedExpense(SharedExpenseEntry expense);
  Future<void> deleteSharedExpense(int id);

  // Operaciones específicas
  Future<void> createExpensePayment(
    int expenseId,
    int detailId,
    double amount,
    String paymentTypeId,
    int paymentId,
    DateTime date,
    {String? description}
  );
}
