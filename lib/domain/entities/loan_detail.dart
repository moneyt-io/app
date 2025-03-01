import 'package:equatable/equatable.dart';

class LoanDetail extends Equatable {
  final int id;
  final int loanId;
  final String currencyId;
  final String paymentTypeId;
  final int paymentId;
  final int journalId;
  final int? transactionId;
  final double amount;
  final double rateExchange;

  const LoanDetail({
    required this.id,
    required this.loanId,
    required this.currencyId,
    required this.paymentTypeId,
    required this.paymentId,
    required this.journalId,
    this.transactionId,
    required this.amount,
    required this.rateExchange,
  });

  @override
  List<Object?> get props => [
    id, loanId, currencyId, paymentTypeId,
    paymentId, journalId, transactionId,
    amount, rateExchange,
  ];
}
