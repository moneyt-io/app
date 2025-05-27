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
  final int transactionId;
  final double amount;
  final double rateExchange;
  final bool active;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  LoanDetailModel({
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

  LoanDetailModel.create({
    required this.loanId,
    required this.currencyId,
    required this.paymentTypeId,
    required this.paymentId,
    required this.journalId,
    required this.transactionId,
    required this.amount,
    required this.rateExchange,
  }) : id = 0,
       active = true,
       createdAt = DateTime.now(),
       updatedAt = DateTime.now(),
       deletedAt = null;

  LoanDetailsCompanion toCompanion() => LoanDetailsCompanion(
    id: id == 0 ? const Value.absent() : Value(id),
    loanId: Value(loanId),
    currencyId: Value(currencyId),
    paymentTypeId: Value(paymentTypeId),
    paymentId: Value(paymentId),
    journalId: Value(journalId),
    transactionId: Value(transactionId),
    amount: Value(amount),
    rateExchange: Value(rateExchange),
    active: Value(active),
    createdAt: Value(createdAt),
    updatedAt: Value(updatedAt),
    deletedAt: Value(deletedAt),
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
    active: active,
    createdAt: createdAt,
    updatedAt: updatedAt,
    deletedAt: deletedAt,
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
    active: entity.active,
    createdAt: entity.createdAt,
    updatedAt: entity.updatedAt,
    deletedAt: entity.deletedAt,
  );

  factory LoanDetailModel.fromDrift(LoanDetails driftModel) => LoanDetailModel(
    id: driftModel.id,
    loanId: driftModel.loanId,
    currencyId: driftModel.currencyId,
    paymentTypeId: driftModel.paymentTypeId,
    paymentId: driftModel.paymentId,
    journalId: driftModel.journalId,
    transactionId: driftModel.transactionId,
    amount: driftModel.amount,
    rateExchange: driftModel.rateExchange,
    active: driftModel.active,
    createdAt: driftModel.createdAt,
    updatedAt: driftModel.updatedAt,
    deletedAt: driftModel.deletedAt,
  );
}
