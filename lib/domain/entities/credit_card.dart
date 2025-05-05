import 'package:equatable/equatable.dart';

class CreditCard extends Equatable {
  final int id;
  final String name;
  final String? description;
  final String currencyId;
  final int chartAccountId;
  final double quota;
  final int closingDay;
  final int paymentDueDay;
  final double interestRate;
  final bool active;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  const CreditCard({
    required this.id,
    required this.name,
    this.description,
    required this.currencyId,
    required this.chartAccountId,
    required this.quota,
    required this.closingDay,
    required this.paymentDueDay,
    required this.interestRate,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  CreditCard copyWith({
    int? id,
    String? name,
    String? description,
    String? currencyId,
    int? chartAccountId,
    double? quota,
    int? closingDay,
    int? paymentDueDay,
    double? interestRate,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return CreditCard(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      currencyId: currencyId ?? this.currencyId,
      chartAccountId: chartAccountId ?? this.chartAccountId,
      quota: quota ?? this.quota,
      closingDay: closingDay ?? this.closingDay,
      paymentDueDay: paymentDueDay ?? this.paymentDueDay,
      interestRate: interestRate ?? this.interestRate,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  @override
  List<Object?> get props => [
    id, name, description, currencyId, chartAccountId, 
    quota, closingDay, paymentDueDay, interestRate, active, 
    createdAt, updatedAt, deletedAt
  ];
}
