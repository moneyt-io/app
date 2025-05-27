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

  // Constructor para crear nuevos detalles
  LoanDetailModel.create({
    required this.loanId,
    required this.currencyId,
    required this.paymentTypeId,
    required this.paymentId,
    required this.journalId,
    required this.transactionId,
    required this.amount,
    this.rateExchange = 1.0,
    this.active = true,
  }) : id = 0,
       createdAt = DateTime.now(),
       updatedAt = DateTime.now(),
       deletedAt = null;

  // Factory desde entidad de base de datos
  factory LoanDetailModel.fromDatabase(LoanDetails detail) {
    return LoanDetailModel(
      id: detail.id,
      loanId: detail.loanId,
      currencyId: detail.currencyId,
      paymentTypeId: detail.paymentTypeId,
      paymentId: detail.paymentId,
      journalId: detail.journalId,
      transactionId: detail.transactionId,
      amount: detail.amount,
      rateExchange: detail.rateExchange,
      active: detail.active,
      createdAt: detail.createdAt,
      updatedAt: detail.updatedAt,
      deletedAt: detail.deletedAt,
    );
  }

  // Factory desde entidad del dominio
  factory LoanDetailModel.fromEntity(LoanDetail entity) {
    return LoanDetailModel(
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
  }

  // Convertir a Companion para operaciones de BD
  LoanDetailsCompanion toCompanion() {
    return LoanDetailsCompanion(
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
  }

  // Convertir a entidad del dominio
  LoanDetail toEntity() {
    return LoanDetail(
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
  }
}
