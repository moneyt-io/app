import 'package:injectable/injectable.dart';
import '../entities/wallet.dart';
import '../entities/credit_card.dart';
import '../repositories/transaction_repository.dart';

@injectable
class BalanceCalculationService {
  final TransactionRepository _transactionRepository;

  BalanceCalculationService(this._transactionRepository);

  /// Calcula el balance actual de un wallet basado en transacciones
  Future<double> calculateWalletBalance(int walletId) async {
    try {
      final transactions = await _transactionRepository.getTransactionsByPaymentTypeAndId('W', walletId);
      
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
      final transactions = await _transactionRepository.getTransactionsByPaymentTypeAndId('C', creditCardId);
      
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
}
