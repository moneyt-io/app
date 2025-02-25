import 'package:drift/drift.dart';
import 'package:moneyt_pfm/data/local/database.dart';
import '../../domain/entities/credit_card.dart';

class CreditCardModel {
  final int id;
  final String currencyId;
  final int chartAccountId;
  final String name;
  final String? description;
  final double quota;
  final int closingDate;
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
    required this.closingDate,
    required this.active,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  CreditCardModel.create({
    required this.currencyId,
    required this.chartAccountId,
    required this.name,
    this.description,
    required this.quota,
    required this.closingDate,
    bool? active,
  })  : id = 0,
        active = active ?? true,
        createdAt = DateTime.now(),
        updatedAt = null,
        deletedAt = null;

  CreditCardsCompanion toCompanion() => CreditCardsCompanion(
    id: id == 0 ? const Value.absent() : Value(id),
    currencyId: Value(currencyId),
    chartAccountId: Value(chartAccountId),
    name: Value(name),
    description: Value(description),
    quota: Value(quota),
    closingDate: Value(closingDate),
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
    closingDate: closingDate,
    active: active,
    createdAt: createdAt,
    updatedAt: updatedAt,
    deletedAt: deletedAt,
  );

  factory CreditCardModel.fromEntity(CreditCard entity) => CreditCardModel(
    id: entity.id,
    currencyId: entity.currencyId,
    chartAccountId: entity.chartAccountId,
    name: entity.name,
    description: entity.description,
    quota: entity.quota,
    closingDate: entity.closingDate,
    active: entity.active,
    createdAt: entity.createdAt,
    updatedAt: entity.updatedAt,
    deletedAt: entity.deletedAt,
  );
}
