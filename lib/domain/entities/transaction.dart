// lib/domain/entities/transaction.dart
class TransactionEntity {
  final int? id;
  final String type;
  final String flow;
  final double amount;
  final int accountId;
  final int? categoryId;
  final String? reference;
  final String? contact;
  final String? description;
  final DateTime transactionDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool status;

  TransactionEntity({
    this.id,
    required this.type,
    required this.flow,
    required this.amount,
    required this.accountId,
    this.categoryId,
    this.reference,
    this.contact,
    this.description,
    required this.transactionDate,
    this.createdAt,
    this.updatedAt,
    this.status = true,
  });

  TransactionEntity copyWith({
    int? id,
    String? type,
    String? flow,
    double? amount,
    int? accountId,
    int? categoryId,
    String? reference,
    String? contact,
    String? description,
    DateTime? transactionDate,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? status,
  }) {
    return TransactionEntity(
      id: id ?? this.id,
      type: type ?? this.type,
      flow: flow ?? this.flow,
      amount: amount ?? this.amount,
      accountId: accountId ?? this.accountId,
      categoryId: categoryId ?? this.categoryId,
      reference: reference ?? this.reference,
      contact: contact ?? this.contact,
      description: description ?? this.description,
      transactionDate: transactionDate ?? this.transactionDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      status: status ?? this.status,
    );
  }
}