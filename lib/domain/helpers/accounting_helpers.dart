import '../entities/journal_detail.dart';
import '../constants/document_types.dart';
import '../constants/loan_constants.dart';

class AccountingHelpers {
  
  // Validar partida doble
  static bool isBalanced(List<JournalDetail> details) {
    final totalDebits = details.fold<double>(0, (sum, detail) => sum + detail.debit);
    final totalCredits = details.fold<double>(0, (sum, detail) => sum + detail.credit);
    
    // Tolerancia para decimales
    return (totalDebits - totalCredits).abs() < LoanConstants.decimalTolerance;
  }

  // Calcular totales de débitos y créditos
  static Map<String, dynamic> calculateTotals(List<JournalDetail> details) {
    double totalDebits = 0;
    double totalCredits = 0;

    for (final detail in details) {
      totalDebits += detail.debit;
      totalCredits += detail.credit;
    }

    return {
      'debits': totalDebits,
      'credits': totalCredits,
      'difference': totalDebits - totalCredits,
      'isBalanced': isBalanced(details),
    };
  }

  // Generar número secuencial
  static String generateSecuencial(String documentType, int number) {
    return '$documentType${number.toString().padLeft(6, '0')}';
  }

  // Crear asiento contable básico
  static List<JournalDetail> createBasicEntry({
    required int journalId,
    required String currencyId,
    required int debitAccountId,
    required int creditAccountId,
    required double amount,
    double rateExchange = 1.0,
  }) {
    return [
      JournalDetail(
        id: 0,
        journalId: journalId,
        currencyId: currencyId,
        chartAccountId: debitAccountId,
        debit: amount,
        credit: 0,
        rateExchange: rateExchange,
      ),
      JournalDetail(
        id: 0,
        journalId: journalId,
        currencyId: currencyId,
        chartAccountId: creditAccountId,
        debit: 0,
        credit: amount,
        rateExchange: rateExchange,
      ),
    ];
  }

  // Formatear monto para mostrar
  static String formatAmount(double amount, String currencySymbol) {
    return '$currencySymbol${amount.toStringAsFixed(2)}';
  }

  // Calcular saldo de cuenta
  static double calculateAccountBalance({
    required List<JournalDetail> details,
    required int accountId,
    required bool isDebitAccount, // true para activos y gastos, false para pasivos e ingresos
  }) {
    double balance = 0;

    for (final detail in details.where((d) => d.chartAccountId == accountId)) {
      if (isDebitAccount) {
        balance += detail.debit - detail.credit;
      } else {
        balance += detail.credit - detail.debit;
      }
    }

    return balance;
  }

  // Validar tipo de cuenta para operación
  static bool isValidAccountType(String accountingType, String operationType) {
    switch (operationType) {
      case 'DEBIT':
        return [AccountingType.assets.code, AccountingType.expenses.code].contains(accountingType);
      case 'CREDIT':
        return [AccountingType.liabilities.code, AccountingType.equity.code, AccountingType.income.code].contains(accountingType);
      default:
        return false;
    }
  }

  // Generar descripción automática para asientos
  static String generateJournalDescription({
    required String operationType,
    required String contactName,
    required double amount,
    String? customDescription,
  }) {
    if (customDescription != null && customDescription.isNotEmpty) {
      return customDescription;
    }

    final formattedAmount = '\$${amount.toStringAsFixed(2)}';

    switch (operationType) {
      case 'LEND_WALLET':
        return 'Préstamo otorgado a $contactName por $formattedAmount';
      case 'LEND_CREDIT':
        return 'Préstamo otorgado a $contactName con tarjeta por $formattedAmount';
      case 'LEND_SERVICE':
        return 'Préstamo por servicios a $contactName por $formattedAmount';
      case 'BORROW_WALLET':
        return 'Préstamo recibido de $contactName por $formattedAmount';
      case 'BORROW_SERVICE':
        return 'Préstamo por servicios de $contactName por $formattedAmount';
      case 'LOAN_PAYMENT':
        return 'Pago de préstamo de $contactName por $formattedAmount';
      case 'WRITE_OFF':
        return 'Cancelación de saldo pendiente de $contactName por $formattedAmount';
      default:
        return 'Operación financiera con $contactName por $formattedAmount';
    }
  }

  // Determinar cuentas automáticamente según tipo de operación
  static Map<String, int> getDefaultAccountIds(String operationType) {
    // Estos IDs deberían venir de configuración o base de datos
    // Por ahora usamos valores por defecto que se pueden configurar después
    switch (operationType) {
      case 'LEND_WALLET':
        return {
          'debitAccount': 1200, // Cuentas por Cobrar - Préstamos
          'creditAccount': 1100, // Caja y Bancos
        };
      case 'LEND_CREDIT':
        return {
          'debitAccount': 1200, // Cuentas por Cobrar - Préstamos
          'creditAccount': 2100, // Tarjetas de Crédito
        };
      case 'LEND_SERVICE':
        return {
          'debitAccount': 1200, // Cuentas por Cobrar - Préstamos
          'creditAccount': 4100, // Ingresos por Servicios
        };
      case 'BORROW_WALLET':
        return {
          'debitAccount': 1100, // Caja y Bancos
          'creditAccount': 2200, // Cuentas por Pagar - Préstamos
        };
      case 'BORROW_SERVICE':
        return {
          'debitAccount': 5100, // Gastos por Servicios
          'creditAccount': 2200, // Cuentas por Pagar - Préstamos
        };
      default:
        return {
          'debitAccount': 1000, // Cuenta genérica de activos
          'creditAccount': 2000, // Cuenta genérica de pasivos
        };
    }
  }

  // Validar montos para evitar errores de redondeo
  static double normalizeAmount(double amount) {
    return double.parse(amount.toStringAsFixed(2));
  }

  // Verificar si dos montos son equivalentes (considerando tolerancia)
  static bool areAmountsEqual(double amount1, double amount2) {
    return (amount1 - amount2).abs() < LoanConstants.decimalTolerance;
  }

  // Calcular porcentaje pagado de un préstamo
  static double calculatePaymentPercentage(double totalPaid, double totalAmount) {
    if (totalAmount == 0) return 0;
    return (totalPaid / totalAmount) * 100;
  }

  // Determinar próxima fecha de pago sugerida (para futuras implementaciones)
  static DateTime suggestNextPaymentDate(DateTime lastPaymentDate, {int intervalDays = 30}) {
    return lastPaymentDate.add(Duration(days: intervalDays));
  }
}
