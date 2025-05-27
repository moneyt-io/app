import '../entities/loan_entry.dart';
import '../entities/wallet.dart';
import '../entities/credit_card.dart';
import '../constants/loan_constants.dart';
import '../services/balance_calculation_service.dart';

class LoanValidators {
  
  // Validación de montos
  static bool isValidAmount(double amount) {
    return amount >= LoanConstants.minLoanAmount && 
           amount <= LoanConstants.maxLoanAmount;
  }

  // Validación de saldo suficiente en wallet (VERSIÓN SÍNCRONA SIMPLIFICADA)
  static bool hasInsufficientFunds(Wallet wallet, double amount) {
    // Validación básica sin cálculo de balance real
    // Esta es una versión simplificada para validaciones síncronas
    // Para validaciones reales, usar BalanceCalculationService
    return amount <= 0; // Solo validamos que el monto sea válido
  }

  // Validación de límite de crédito disponible (VERSIÓN SÍNCRONA SIMPLIFICADA)
  static bool exceedsCreditLimit(CreditCard creditCard, double amount) {
    // Validación básica contra la quota total
    // Para validaciones reales, usar BalanceCalculationService
    return amount > creditCard.quota;
  }

  // Validación de estado de préstamo para pagos
  static bool canReceivePayment(LoanEntry loan) {
    return loan.status == LoanStatus.active && loan.outstandingBalance > 0;
  }

  // Validación de monto de pago
  static bool isValidPaymentAmount(LoanEntry loan, double paymentAmount) {
    if (paymentAmount <= 0) return false;
    
    final maxAllowed = loan.outstandingBalance * LoanConstants.paymentTolerancePercentage;
    return paymentAmount <= maxAllowed;
  }

  // Validación para write-off
  static bool canWriteOff(LoanEntry loan) {
    return loan.status == LoanStatus.active && 
           loan.outstandingBalance > LoanConstants.decimalTolerance;
  }

  // Validación de categorías para write-off
  static bool isValidWriteOffCategory(String categoryType, String loanType) {
    if (loanType == LoanConstants.lendDocumentType) { // Préstamo otorgado
      return categoryType == 'E'; // Solo categorías de gasto
    } else { // Préstamo recibido
      return categoryType == 'I'; // Solo categorías de ingreso
    }
  }

  // Validación de datos completos para préstamo
  static List<String> validateLoanData({
    required int contactId,
    required double amount,
    required String currencyId,
    required String paymentType,
    required int paymentId,
    Wallet? wallet,
    CreditCard? creditCard,
  }) {
    final errors = <String>[];

    if (contactId <= 0) {
      errors.add('Debe seleccionar un contacto válido');
    }

    if (!isValidAmount(amount)) {
      errors.add('El monto debe estar entre \$${LoanConstants.minLoanAmount} y \$${LoanConstants.maxLoanAmount.toStringAsFixed(2)}');
    }

    if (currencyId.isEmpty) {
      errors.add('Debe seleccionar una moneda');
    }

    if (paymentType == LoanConstants.walletPaymentType && wallet != null) {
      if (hasInsufficientFunds(wallet, amount)) {
        errors.add('Fondos insuficientes en el wallet seleccionado');
      }
    }

    if (paymentType == LoanConstants.creditCardPaymentType && creditCard != null) {
      if (exceedsCreditLimit(creditCard, amount)) {
        errors.add('El monto excede el límite de crédito disponible');
      }
    }

    return errors;
  }

  // Validación de datos de pago
  static List<String> validatePaymentData({
    required LoanEntry loan,
    required double paymentAmount,
    double? writeOffAmount,
    double? extraAmount,
  }) {
    final errors = <String>[];

    if (!canReceivePayment(loan)) {
      errors.add('Este préstamo no puede recibir pagos');
    }

    if (!isValidPaymentAmount(loan, paymentAmount)) {
      errors.add('Monto de pago inválido. Máximo permitido: \$${(loan.outstandingBalance * LoanConstants.paymentTolerancePercentage).toStringAsFixed(2)}');
    }

    final totalAdjustments = (writeOffAmount ?? 0) + (extraAmount ?? 0);
    if (totalAdjustments > paymentAmount) {
      errors.add('Los ajustes no pueden ser mayores al monto del pago');
    }

    final regularPayment = paymentAmount - totalAdjustments;
    if (regularPayment < 0) {
      errors.add('El pago regular no puede ser negativo');
    }

    if (writeOffAmount != null && writeOffAmount > 0) {
      if (writeOffAmount > loan.outstandingBalance) {
        errors.add('El monto a cancelar no puede ser mayor al saldo pendiente');
      }
    }

    return errors;
  }

  // Validación de fecha
  static bool isValidLoanDate(DateTime date) {
    final now = DateTime.now();
    final oneYearAgo = now.subtract(const Duration(days: 365));
    final oneYearFromNow = now.add(const Duration(days: 365));
    
    return date.isAfter(oneYearAgo) && date.isBefore(oneYearFromNow);
  }

  // Validación de descripción
  static bool isValidDescription(String? description) {
    if (description == null || description.trim().isEmpty) return true;
    return description.trim().length <= 500;
  }

  // MÉTODOS ASÍNCRONOS PARA VALIDACIONES REALES
  
  /// Validación de datos con cálculo real de balances
  static Future<List<String>> validateLoanDataWithBalances({
    required int contactId,
    required double amount,
    required String currencyId,
    required String paymentType,
    required int paymentId,
    Wallet? wallet,
    CreditCard? creditCard,
    BalanceCalculationService? balanceService,
  }) async {
    final errors = <String>[];

    if (contactId <= 0) {
      errors.add('Debe seleccionar un contacto válido');
    }

    if (!isValidAmount(amount)) {
      errors.add('El monto debe estar entre \$${LoanConstants.minLoanAmount} y \$${LoanConstants.maxLoanAmount.toStringAsFixed(2)}');
    }

    if (currencyId.isEmpty) {
      errors.add('Debe seleccionar una moneda');
    }

    // Validaciones de balance solo si se proporciona el servicio
    if (balanceService != null) {
      if (paymentType == LoanConstants.walletPaymentType && wallet != null) {
        final hasInsufficient = await balanceService.hasInsufficientFunds(wallet, amount);
        if (hasInsufficient) {
          errors.add('Fondos insuficientes en el wallet seleccionado');
        }
      }

      if (paymentType == LoanConstants.creditCardPaymentType && creditCard != null) {
        final exceedsLimit = await balanceService.exceedsCreditLimit(creditCard, amount);
        if (exceedsLimit) {
          errors.add('El monto excede el límite de crédito disponible');
        }
      }
    }

    return errors;
  }

  // Validación completa para crear préstamo (VERSIÓN MEJORADA ASÍNCRONA)
  static Future<List<String>> validateCompleteNewLoanWithBalances({
    required int contactId,
    required double amount,
    required String currencyId,
    required DateTime date,
    required String paymentType,
    required int paymentId,
    String? description,
    Wallet? wallet,
    CreditCard? creditCard,
    BalanceCalculationService? balanceService,
  }) async {
    final errors = <String>[];

    // Validaciones básicas con balance real
    final balanceErrors = await validateLoanDataWithBalances(
      contactId: contactId,
      amount: amount,
      currencyId: currencyId,
      paymentType: paymentType,
      paymentId: paymentId,
      wallet: wallet,
      creditCard: creditCard,
      balanceService: balanceService,
    );
    
    errors.addAll(balanceErrors);

    // Validación de fecha
    if (!isValidLoanDate(date)) {
      errors.add('La fecha debe estar dentro del rango de un año');
    }

    // Validación de descripción
    if (!isValidDescription(description)) {
      errors.add('La descripción no puede tener más de 500 caracteres');
    }

    return errors;
  }

  // VALIDACIÓN COMPLETA SÍNCRONA (MÉTODO REQUERIDO)
  static List<String> validateCompleteNewLoan({
    required int contactId,
    required double amount,
    required String currencyId,
    required DateTime date,
    required String paymentType,
    required int paymentId,
    String? description,
    Wallet? wallet,
    CreditCard? creditCard,
  }) {
    final errors = <String>[];

    // Validaciones básicas
    errors.addAll(validateLoanData(
      contactId: contactId,
      amount: amount,
      currencyId: currencyId,
      paymentType: paymentType,
      paymentId: paymentId,
      wallet: wallet,
      creditCard: creditCard,
    ));

    // Validación de fecha
    if (!isValidLoanDate(date)) {
      errors.add('La fecha debe estar dentro del rango de un año');
    }

    // Validación de descripción
    if (!isValidDescription(description)) {
      errors.add('La descripción no puede tener más de 500 caracteres');
    }

    return errors;
  }
}
