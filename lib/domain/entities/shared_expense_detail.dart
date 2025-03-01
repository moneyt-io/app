import 'package:equatable/equatable.dart';

class SharedExpenseDetail extends Equatable {
  final int id;
  final int sharedExpenseId;
  final String currencyId;
  final int loanId;
  final int transactionId;
  final double percentage;
  final double amount;
  final double rateExchange;
  final String status;

  const SharedExpenseDetail({
    required this.id,
    required this.sharedExpenseId,
    required this.currencyId,
    required this.loanId,
    required this.transactionId,
    required this.percentage,
    required this.amount,
    required this.rateExchange,
    required this.status,
  });

  @override
  List<Object?> get props => [
    id, sharedExpenseId, currencyId, loanId,
    transactionId, percentage, amount, rateExchange,
    status,
  ];
}
