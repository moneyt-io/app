import 'package:drift/drift.dart';
import 'package:moneyt_pfm/data/datasources/local/database.dart';
import '../../domain/entities/credit_card.dart';

class CreditCardModel {
  final int id;
  final String currencyId;
  final int chartAccountId;
  final String name;
  final String? description;
  final double quota;
  final int closingDay;
  final int paymentDueDay;
  final double interestRate;
  final bool active;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  CreditCardModel({
    required this.id,
    required this.currencyId,
    required this.chartAccountId,
    required this.name,
    this.description,
    required this.quota,
    required this.closingDay,
    required this.paymentDueDay,
    this.interestRate = 0.0,
    this.active = true,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  // Constructor para crear una nueva tarjeta
  factory CreditCardModel.create({
    required String currencyId,
    required int chartAccountId,
    required String name,
    String? description,
    required double quota,
    required int closingDay,
    required int paymentDueDay,
    double interestRate = 0.0,
  }) =>
      CreditCardModel(
        id: 0,
        currencyId: currencyId,
        chartAccountId: chartAccountId,
        name: name,
        description: description,
        quota: quota,
        closingDay: closingDay,
        paymentDueDay: paymentDueDay,
        interestRate: interestRate,
        active: true,
        createdAt: DateTime.now(),
        updatedAt: null,
        deletedAt: null,
      );

  CreditCardsCompanion toCompanion() => CreditCardsCompanion(
    id: id == 0 ? const Value.absent() : Value(id),
    currencyId: Value(currencyId),
    chartAccountId: Value(chartAccountId),
    name: Value(name),
    description: Value(description),
    quota: Value(quota),
    closingDay: Value(closingDay),
    paymentDueDay: Value(paymentDueDay),
    interestRate: Value(interestRate),
    active: Value(active),
    createdAt: Value(createdAt),
    updatedAt: Value(updatedAt),
    deletedAt: Value(deletedAt),
  );

  CreditCard toEntity() => CreditCard(
    id: id,
    currencyId: currencyId,
    chartAccountId: chartAccountId,
    name: name,
    description: description,
    quota: quota,
    closingDay: closingDay, 
    paymentDueDay: paymentDueDay,
    interestRate: interestRate,
    active: active,
    createdAt: createdAt,
    updatedAt: updatedAt ?? DateTime.now(), // Provide a default value when null
    deletedAt: deletedAt,
  );

  factory CreditCardModel.fromEntity(CreditCard entity) => CreditCardModel(
    id: entity.id,
    currencyId: entity.currencyId,
    chartAccountId: entity.chartAccountId,
    name: entity.name,
    description: entity.description,
    quota: entity.quota,
    closingDay: entity.closingDay,
    paymentDueDay: entity.paymentDueDay,
    interestRate: entity.interestRate,
    active: entity.active,
    createdAt: entity.createdAt,
    updatedAt: entity.updatedAt,
    deletedAt: entity.deletedAt,
  );
}
