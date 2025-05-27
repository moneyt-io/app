class LoanConstants {
  // Tipos de documentos
  static const String lendDocumentType = 'L';
  static const String borrowDocumentType = 'B';
  
  // Tipos de pago
  static const String walletPaymentType = 'W';
  static const String creditCardPaymentType = 'C';
  static const String transactionPaymentType = 'T';
  
  // Estados de préstamo
  static const String activeStatus = 'ACTIVE';
  static const String paidStatus = 'PAID';
  static const String cancelledStatus = 'CANCELLED';
  static const String writtenOffStatus = 'WRITTEN_OFF';
  
  // Flujos de dinero
  static const String fromFlow = 'F';
  static const String toFlow = 'T';
  
  // Mensajes de error
  static const String loanNotFoundError = 'Préstamo no encontrado';
  static const String cannotMakePaymentError = 'No se puede hacer pago en este préstamo';
  static const String cannotWriteOffError = 'No se puede cancelar este préstamo';
  static const String invalidPaymentAmountError = 'Monto de pago inválido';
  
  // Descripciones por defecto
  static const String defaultLendFromWalletDescription = 'Préstamo otorgado desde wallet';
  static const String defaultLendFromCreditCardDescription = 'Préstamo otorgado desde tarjeta de crédito';
  static const String defaultLendFromServiceDescription = 'Préstamo otorgado por servicios';
  static const String defaultBorrowToWalletDescription = 'Préstamo recibido hacia wallet';
  static const String defaultBorrowFromServiceDescription = 'Préstamo recibido por servicios';
  
  // Límites
  static const double maxLoanAmount = 9999999.99;
  static const double minLoanAmount = 0.01;
  static const double paymentTolerancePercentage = 1.5; // 150% del saldo pendiente
  static const double decimalTolerance = 0.01;
}
