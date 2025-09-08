import 'package:injectable/injectable.dart';
import '../entities/wallet.dart';
import '../entities/credit_card.dart';
import '../repositories/credit_card_repository.dart';
import '../repositories/transaction_repository.dart';
import '../entities/transaction_entry.dart';

@injectable
class BalanceCalculationService {
  final TransactionRepository _transactionRepository;
  final CreditCardRepository _creditCardRepository;

  BalanceCalculationService(this._transactionRepository, this._creditCardRepository);

  /// Calcula el balance actual de un wallet basado en transacciones
  Future<double> calculateWalletBalance(int walletId) async {
    try {
      final transactions = await _transactionRepository
          .getTransactionsByPaymentTypeAndId('W', walletId);

      double balance = 0.0;

      for (final transaction in transactions) {
        for (final detail in transaction.details) {
          if (detail.paymentId == walletId && detail.paymentTypeId == 'W') {
            // Si es 'T' (To), es dinero que entra al wallet
            // Si es 'F' (From), es dinero que sale del wallet
            if (detail.flowId == 'T') {
              balance += detail.amount;
            } else if (detail.flowId == 'F') {
              balance -= detail.amount;
            }
          }
        }
      }

      return balance;
    } catch (e) {
      // En caso de error, retornar 0
      return 0.0;
    }
  }

  /// Calcula el saldo actual usado de una tarjeta de crédito
  Future<double> calculateCreditCardUsedBalance(int creditCardId) async {
    try {
      final transactions = await _transactionRepository
          .getTransactionsByPaymentTypeAndId('C', creditCardId);

      double usedBalance = 0.0;

      for (final transaction in transactions) {
        for (final detail in transaction.details) {
          if (detail.paymentId == creditCardId && detail.paymentTypeId == 'C') {
            // Para tarjetas de crédito:
            // 'F' (From) significa usar la tarjeta (aumenta la deuda)
            // 'T' (To) significa pagar la tarjeta (reduce la deuda)
            if (detail.flowId == 'F') {
              usedBalance += detail.amount;
            } else if (detail.flowId == 'T') {
              usedBalance -= detail.amount;
            }
          }
        }
      }

      return usedBalance;
    } catch (e) {
      // En caso de error, retornar 0
      return 0.0;
    }
  }

  /// Calcula el crédito disponible de una tarjeta
  Future<double> calculateAvailableCredit(CreditCard creditCard) async {
    final usedBalance = await calculateCreditCardUsedBalance(creditCard.id);
    return creditCard.quota - usedBalance;
  }

  /// Calcula el crédito disponible de una tarjeta a partir de su ID.
  Future<double> calculateAvailableCreditFromId(int creditCardId) async {
    final creditCard = await _creditCardRepository.getCreditCardById(creditCardId);
    if (creditCard == null) {
      return 0.0;
    }
    return calculateAvailableCredit(creditCard);
  }

  /// Verifica si un wallet tiene fondos suficientes
  Future<bool> hasInsufficientFunds(Wallet wallet, double amount) async {
    final currentBalance = await calculateWalletBalance(wallet.id);
    return currentBalance < amount;
  }

  /// Verifica si una operación excede el límite de crédito
  Future<bool> exceedsCreditLimit(CreditCard creditCard, double amount) async {
    final availableCredit = await calculateAvailableCredit(creditCard);
    return amount > availableCredit;
  }

  /// Calcula el total de ingresos de una lista de transacciones.
  double calculateTotalIncome(List<TransactionEntry> transactions) {
    return transactions
        .where((t) => t.isIncome)
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  /// Calcula el total de egresos de una lista de transacciones.
  double calculateTotalExpense(List<TransactionEntry> transactions) {
    return transactions
        .where((t) => t.isExpense)
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  /// Calcula el total de transferencias de una lista de transacciones.
  double calculateTotalTransfer(List<TransactionEntry> transactions) {
    return transactions
        .where((t) => t.isTransfer)
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  /// Calcula el total de ingresos para el mes actual.
  Future<double> calculateMonthlyIncome() async {
    try {
      final now = DateTime.now();
      // Usar DateTime.utc para construir las fechas y evitar problemas de zona horaria.
      final startDate = DateTime.utc(now.year, now.month, 1);
      final endDate = DateTime.utc(now.year, now.month + 1, 1);

      final transactions = await _transactionRepository
          .getTransactionsByDateRange(startDate, endDate);

      double totalIncome = 0.0;

      for (final transaction in transactions) {
        for (final detail in transaction.details) {
          // Un ingreso es cualquier flujo de dinero HACIA ('T') un Wallet ('W')
          if (detail.flowId == 'T' && detail.paymentTypeId == 'W') {
            totalIncome += detail.amount;
          }
        }
      }

      return totalIncome;
    } catch (e) {
      print('Error calculating monthly income: $e');
      // En caso de error, retornar 0
      return 0.0;
    }
  }
}
