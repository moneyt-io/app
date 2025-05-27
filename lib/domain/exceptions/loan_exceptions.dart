abstract class LoanException implements Exception {
  final String message;
  final String? code;
  
  const LoanException(this.message, [this.code]);
  
  @override
  String toString() => 'LoanException: $message${code != null ? ' (Code: $code)' : ''}';
}

// Excepciones específicas de préstamos
class LoanNotFoundException extends LoanException {
  const LoanNotFoundException([String? message]) 
      : super(message ?? 'Préstamo no encontrado', 'LOAN_NOT_FOUND');
}

class InvalidLoanStatusException extends LoanException {
  const InvalidLoanStatusException([String? message]) 
      : super(message ?? 'Estado del préstamo inválido para esta operación', 'INVALID_LOAN_STATUS');
}

class InsufficientFundsException extends LoanException {
  const InsufficientFundsException([String? message]) 
      : super(message ?? 'Fondos insuficientes', 'INSUFFICIENT_FUNDS');
}

class CreditLimitExceededException extends LoanException {
  const CreditLimitExceededException([String? message]) 
      : super(message ?? 'Límite de crédito excedido', 'CREDIT_LIMIT_EXCEEDED');
}

class InvalidPaymentAmountException extends LoanException {
  const InvalidPaymentAmountException([String? message]) 
      : super(message ?? 'Monto de pago inválido', 'INVALID_PAYMENT_AMOUNT');
}

class CannotWriteOffException extends LoanException {
  const CannotWriteOffException([String? message]) 
      : super(message ?? 'No se puede cancelar este préstamo', 'CANNOT_WRITE_OFF');
}

class AccountingImbalanceException extends LoanException {
  const AccountingImbalanceException([String? message]) 
      : super(message ?? 'Los asientos contables no están balanceados', 'ACCOUNTING_IMBALANCE');
}

class InvalidCategoryTypeException extends LoanException {
  const InvalidCategoryTypeException([String? message]) 
      : super(message ?? 'Tipo de categoría inválido para esta operación', 'INVALID_CATEGORY_TYPE');
}

class ContactNotFoundException extends LoanException {
  const ContactNotFoundException([String? message]) 
      : super(message ?? 'Contacto no encontrado', 'CONTACT_NOT_FOUND');
}

class PaymentMethodNotFoundException extends LoanException {
  const PaymentMethodNotFoundException([String? message]) 
      : super(message ?? 'Método de pago no encontrado', 'PAYMENT_METHOD_NOT_FOUND');
}

// Wrapper para múltiples errores de validación
class LoanValidationException extends LoanException {
  final List<String> errors;
  
  const LoanValidationException(this.errors) 
      : super('Errores de validación encontrados', 'VALIDATION_ERRORS');
  
  @override
  String toString() => 'LoanValidationException: ${errors.join(', ')}';
}
