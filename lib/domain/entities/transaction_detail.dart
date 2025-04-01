import 'package:equatable/equatable.dart';

class TransactionDetail extends Equatable {
  final int id;
  final int transactionId;
  final String currencyId;
  final String flowId;
  final String paymentTypeId;
  final int paymentId;
  final int categoryId;
  final double amount;
  final double rateExchange;

  const TransactionDetail({
    required this.id,
    required this.transactionId,
    required this.currencyId,
    required this.flowId,
    required this.paymentTypeId,
    required this.paymentId,
    required this.categoryId,
    required this.amount,
    required this.rateExchange,
  });

  // Métodos de utilidad
  bool get isInflow => flowId == 'I';
  bool get isOutflow => flowId == 'O';
  bool get isFrom => flowId == 'F';
  bool get isTo => flowId == 'T';
  
  bool get isWalletPayment => paymentTypeId == 'W';
  bool get isCreditCardPayment => paymentTypeId == 'C';
  
  // Retornar el signo según el flujo (positivo para ingresos, negativo para egresos)
  double get signedAmount => isOutflow || isFrom ? -amount : amount;

  @override
  List<Object?> get props => [
    id, transactionId, currencyId, flowId,
    paymentTypeId, paymentId, categoryId,
    amount, rateExchange
  ];
}
