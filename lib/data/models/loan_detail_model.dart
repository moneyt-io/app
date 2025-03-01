import 'package:drift/drift.dart';
import '../../domain/entities/loan_detail.dart';
import '../datasources/local/database.dart';


class LoanDetailModel {
  final int id;
  final int loanId;
  final String currencyId;
  final String paymentTypeId;
  final int paymentId;
  final int journalId;
  final int? transactionId;
  final double amount;
  final double rateExchange;

  LoanDetailModel({
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

  LoanDetailModel.create({
    required this.loanId,
    required this.currencyId,
    required this.paymentTypeId,
    required this.paymentId,
    required this.journalId,
    this.transactionId,
    required this.amount,
    required this.rateExchange,
  }) : id = 0;

  LoanDetailsCompanion toCompanion() => LoanDetailsCompanion(
    id: id == 0 ? const Value.absent() : Value(id),
    loanId: Value(loanId),
    currencyId: Value(currencyId),
    paymentTypeId: Value(paymentTypeId),
    paymentId: Value(paymentId),
    journalId: Value(journalId),
    transactionId: Value(transactionId!),
    amount: Value(amount),
    rateExchange: Value(rateExchange),
  );

  LoanDetail toEntity() => LoanDetail(
    id: id,
    loanId: loanId,
    currencyId: currencyId,
    paymentTypeId: paymentTypeId,
    paymentId: paymentId,
    journalId: journalId,
    transactionId: transactionId,
    amount: amount,
    rateExchange: rateExchange,
  );

  factory LoanDetailModel.fromEntity(LoanDetail entity) => LoanDetailModel(
    id: entity.id,
    loanId: entity.loanId,
    currencyId: entity.currencyId,
    paymentTypeId: entity.paymentTypeId,
    paymentId: entity.paymentId,
    journalId: entity.journalId,
    transactionId: entity.transactionId,
    amount: entity.amount,
    rateExchange: entity.rateExchange,
  );
}
