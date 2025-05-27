import 'package:equatable/equatable.dart';

class LoanDetail extends Equatable {
  final int id;
  final int loanId;
  final String currencyId;
  final String paymentTypeId; // 'W', 'C', 'T'
  final int paymentId;
  final int journalId;
  final int transactionId;
  final double amount;
  final double rateExchange;
  final bool active;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  const LoanDetail({
    required this.id,
    required this.loanId,
    required this.currencyId,
    required this.paymentTypeId,
    required this.paymentId,
    required this.journalId,
    required this.transactionId,
    required this.amount,
    required this.rateExchange,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  // Helper methods
  bool get isWallet => paymentTypeId == 'W';
  bool get isCreditCard => paymentTypeId == 'C';
  bool get isTransaction => paymentTypeId == 'T';

  LoanDetail copyWith({
    int? id,
    int? loanId,
    String? currencyId,
    String? paymentTypeId,
    int? paymentId,
    int? journalId,
    int? transactionId,
    double? amount,
    double? rateExchange,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return LoanDetail(
      id: id ?? this.id,
      loanId: loanId ?? this.loanId,
      currencyId: currencyId ?? this.currencyId,
      paymentTypeId: paymentTypeId ?? this.paymentTypeId,
      paymentId: paymentId ?? this.paymentId,
      journalId: journalId ?? this.journalId,
      transactionId: transactionId ?? this.transactionId,
      amount: amount ?? this.amount,
      rateExchange: rateExchange ?? this.rateExchange,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        loanId,
        currencyId,
        paymentTypeId,
        paymentId,
        journalId,
        transactionId,
        amount,
        rateExchange,
        active,
        createdAt,
        updatedAt,
        deletedAt,
      ];

  @override
  String toString() {
    return 'LoanDetail{id: $id, loanId: $loanId, paymentTypeId: $paymentTypeId, amount: $amount}';
  }
}
