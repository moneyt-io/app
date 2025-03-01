import 'package:injectable/injectable.dart';
import '../entities/shared_expense_entry.dart';
import '../entities/shared_expense_detail.dart';
import '../repositories/shared_expense_repository.dart';

@injectable
class SharedExpenseUseCases {
  final SharedExpenseRepository _repository;

  SharedExpenseUseCases(this._repository);

  // Observación de gastos compartidos
  Stream<List<SharedExpenseEntry>> watchAllSharedExpenses() => 
      _repository.watchAllSharedExpenses();

  // Crear un nuevo gasto compartido
  Future<SharedExpenseEntry> createSharedExpense(
    SharedExpenseEntry expense,
    List<SharedExpenseDetail> details
  ) => _repository.createSharedExpense(expense, details);

  // Registrar un pago de un gasto compartido
  Future<void> paySharedExpense(
    int expenseId,
    int detailId,
    double amount,
    String paymentTypeId,
    int paymentId,
    DateTime date,
    {String? description}
  ) => _repository.createExpensePayment(
    expenseId,
    detailId,
    amount,
    paymentTypeId,
    paymentId,
    date,
    description: description,
  );

  // Eliminar un gasto compartido
  Future<void> deleteSharedExpense(int id) => _repository.deleteSharedExpense(id);
}
