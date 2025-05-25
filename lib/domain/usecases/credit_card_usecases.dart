import 'package:get_it/get_it.dart';
import '../entities/credit_card.dart';
import '../entities/chart_account.dart';
import '../repositories/credit_card_repository.dart';
import '../repositories/chart_account_repository.dart';
import '../repositories/transaction_repository.dart'; // ← NUEVA IMPORTACIÓN
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

@injectable
class CreditCardUseCases {
  final CreditCardRepository _creditCardRepository;
  final ChartAccountRepository _chartAccountRepository;
  final TransactionRepository _transactionRepository; // ← NUEVA DEPENDENCIA

  CreditCardUseCases(
    this._creditCardRepository, 
    this._chartAccountRepository,
    this._transactionRepository, // ← AGREGAR AL CONSTRUCTOR
  );

  Future<List<CreditCard>> getAllCreditCards() {
    return _creditCardRepository.getAllCreditCards();
  }

  Future<CreditCard?> getCreditCardById(int id) {
    return _creditCardRepository.getCreditCardById(id);
  }

  Stream<List<CreditCard>> watchAllCreditCards() {
    return _creditCardRepository.watchAllCreditCards();
  }

  Future<CreditCard> createCreditCardWithAccount({
    required String name,
    String? description,
    required String currencyId,
    required double quota,
    required int closingDay,
    required int paymentDueDay,
    required double interestRate,
  }) async {
    // Use the specialized method for creating credit card chart accounts
    final chartAccount = await _chartAccountRepository.generateAccountForCreditCard('Tarjeta $name');
    
    // Create the credit card with the generated chart account
    final creditCard = CreditCard(
      id: 0,
      currencyId: currencyId,
      chartAccountId: chartAccount.id,
      name: name,
      description: description,
      quota: quota,
      closingDay: closingDay,
      paymentDueDay: paymentDueDay,
      interestRate: interestRate,
      active: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      deletedAt: null,
    );
    
    return _creditCardRepository.createCreditCard(creditCard);
  }

  Future<void> updateCreditCard(CreditCard creditCard) {
    return _creditCardRepository.updateCreditCard(creditCard);
  }

  Future<void> deleteCreditCard(int id) {
    return _creditCardRepository.deleteCreditCard(id);
  }

  /// Calcula el saldo utilizado de una tarjeta de crédito
  /// Considera todos los gastos hechos con la tarjeta menos los pagos realizados
  Future<double> getUsedAmount(CreditCard creditCard) async {
    try {
      print('DEBUG: Calculando saldo utilizado para tarjeta ID: ${creditCard.id}');
      
      // 1. Obtener TODOS los gastos (documentTypeId = 'E') y filtrar los que usan esta tarjeta
      final allExpenseTransactions = await _transactionRepository.getTransactionsByType('E');
      print('DEBUG: Total transacciones de gasto: ${allExpenseTransactions.length}');
      
      final totalExpenses = allExpenseTransactions.fold<double>(0.0, (sum, transaction) {
        // Buscar si esta transacción de gasto usa nuestra tarjeta
        final cardDetails = transaction.details.where((detail) => 
          detail.paymentTypeId == 'C' && 
          detail.paymentId == creditCard.id &&
          detail.flowId == 'O' // Outflow - salida/gasto
        );
        
        if (cardDetails.isNotEmpty) {
          final amount = cardDetails.fold<double>(0.0, (detailSum, detail) => detailSum + detail.amount.abs());
          print('DEBUG: Gasto con tarjeta encontrado: $amount en transacción ${transaction.id}');
          return sum + amount;
        }
        return sum;
      });
      
      // 2. Obtener TODOS los pagos a tarjetas (documentTypeId = 'C') y filtrar los de esta tarjeta
      final allCardPayments = await _transactionRepository.getTransactionsByType('C');
      print('DEBUG: Total transacciones de pago de tarjeta: ${allCardPayments.length}');
      
      final totalPayments = allCardPayments.fold<double>(0.0, (sum, transaction) {
        // Buscar si esta transacción de pago es hacia nuestra tarjeta
        final paymentDetails = transaction.details.where((detail) => 
          detail.paymentTypeId == 'C' && 
          detail.paymentId == creditCard.id &&
          detail.flowId == 'T' // To - hacia/pago
        );
        
        if (paymentDetails.isNotEmpty) {
          final amount = paymentDetails.fold<double>(0.0, (detailSum, detail) => detailSum + detail.amount.abs());
          print('DEBUG: Pago a tarjeta encontrado: $amount en transacción ${transaction.id}');
          return sum + amount;
        }
        return sum;
      });
      
      // 3. Saldo utilizado = gastos - pagos
      final usedAmount = totalExpenses - totalPayments;
      print('DEBUG: Total gastos: $totalExpenses, Total pagos: $totalPayments, Saldo utilizado: $usedAmount');
      
      return usedAmount > 0 ? usedAmount : 0.0;
    } catch (e) {
      print('ERROR en getUsedAmount: $e');
      print('ERROR stackTrace: ${StackTrace.current}');
      return 0.0;
    }
  }

  /// Calcula el crédito disponible
  Future<double> getAvailableCredit(CreditCard creditCard) async {
    final usedAmount = await getUsedAmount(creditCard);
    final available = creditCard.quota - usedAmount;
    return available > 0 ? available : 0.0;
  }

  /// Calcula la próxima fecha de pago para una tarjeta de crédito.
  /// 
  /// Basado en el día de pago (paymentDueDay) y el mes actual.
  /// Si el día de pago ya pasó este mes, devuelve la fecha del próximo mes.
  /// 
  /// @param creditCard La tarjeta de crédito para la que se calcula la fecha de pago
  /// @return Un objeto DateTime con la fecha del próximo pago
  DateTime getNextPaymentDate(CreditCard creditCard) {
    final now = DateTime.now();
    
    // Crear una fecha con el día de pago de este mes
    DateTime paymentDate = DateTime(now.year, now.month, creditCard.paymentDueDay);
    
    // Si el día de pago ya pasó este mes, calcular para el próximo mes
    if (paymentDate.isBefore(now)) {
      // Avanzar al próximo mes
      int nextMonth = now.month + 1;
      int year = now.year;
      
      // Manejar cambio de año
      if (nextMonth > 12) {
        nextMonth = 1;
        year++;
      }
      
      paymentDate = DateTime(year, nextMonth, creditCard.paymentDueDay);
    }
    
    return paymentDate;
  }
}
