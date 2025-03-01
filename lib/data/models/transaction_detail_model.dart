import 'package:drift/drift.dart';
import '../../domain/entities/transaction_detail.dart';
import '../datasources/local/database.dart';

class TransactionDetailModel {
  final int id;
  final int transactionId;
  final String currencyId;
  final String flowId;
  final String paymentTypeId;
  final int paymentId;
  final int categoryId;
  final double amount;
  final double rateExchange;

  TransactionDetailModel({
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

  // Constructor para nuevos detalles
  TransactionDetailModel.create({
    required this.transactionId,
    required this.currencyId,
    required this.flowId,
    required this.paymentTypeId,
    required this.paymentId,
    required this.categoryId,
    required this.amount,
    required this.rateExchange,
  }) : id = 0;

  // Convertir a Companion para Drift
  TransactionDetailsCompanion toCompanion() => TransactionDetailsCompanion(
    id: id == 0 ? const Value.absent() : Value(id),
    transactionId: Value(transactionId),
    currencyId: Value(currencyId),
    flowId: Value(flowId),
    paymentTypeId: Value(paymentTypeId),
    paymentId: Value(paymentId),
    categoryId: Value(categoryId),
    amount: Value(amount),
    rateExchange: Value(rateExchange),
  );

  // Conversión desde/hacia Domain Entity
  TransactionDetail toEntity() => TransactionDetail(
    id: id,
    transactionId: transactionId,
    currencyId: currencyId,
    flowId: flowId,
    paymentTypeId: paymentTypeId,
    paymentId: paymentId,
    categoryId: categoryId,
    amount: amount,
    rateExchange: rateExchange,
  );

  factory TransactionDetailModel.fromEntity(TransactionDetail entity) => TransactionDetailModel(
    id: entity.id,
    transactionId: entity.transactionId,
    currencyId: entity.currencyId,
    flowId: entity.flowId,
    paymentTypeId: entity.paymentTypeId,
    paymentId: entity.paymentId,
    categoryId: entity.categoryId,
    amount: entity.amount,
    rateExchange: entity.rateExchange,
  );
}
