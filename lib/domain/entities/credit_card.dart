import 'package:equatable/equatable.dart';

class CreditCard extends Equatable {
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

  const CreditCard({
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

  @override
  List<Object?> get props => [
    id,
    currencyId,
    chartAccountId,
    name,
    description,
    quota,
    closingDate,
    active,
    createdAt,
    updatedAt,
    deletedAt,
  ];
}
