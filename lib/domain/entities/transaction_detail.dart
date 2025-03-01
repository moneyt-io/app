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

  @override
  List<Object?> get props => [
    id, transactionId, currencyId, flowId,
    paymentTypeId, paymentId, categoryId,
    amount, rateExchange
  ];
}
