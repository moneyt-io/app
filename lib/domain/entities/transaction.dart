// lib/domain/entities/transaction.dart
class TransactionEntity {
  final int? id;
  final String type;
  final String flow;
  final double amount;
  final int accountId;
  final int? categoryId;
  final String? reference;
  final int? contactId;
  final String? description;
  final DateTime transactionDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  TransactionEntity({
    this.id,
    required this.type,
    required this.flow,
    required this.amount,
    required this.accountId,
    this.categoryId,
    this.reference,
    this.contactId,
    this.description,
    required this.transactionDate,
    this.createdAt,
    this.updatedAt,
  });

  TransactionEntity copyWith({
    int? id,
    String? type,
    String? flow,
    double? amount,
    int? accountId,
    int? categoryId,
    String? reference,
    int? contactId,
    String? description,
    DateTime? transactionDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TransactionEntity(
      id: id ?? this.id,
      type: type ?? this.type,
      flow: flow ?? this.flow,
      amount: amount ?? this.amount,
      accountId: accountId ?? this.accountId,
      categoryId: categoryId ?? this.categoryId,
      reference: reference ?? this.reference,
      contactId: contactId ?? this.contactId,
      description: description ?? this.description,
      transactionDate: transactionDate ?? this.transactionDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'flow': flow,
      'amount': amount,
      'account_id': accountId,
      'category_id': categoryId,
      'reference': reference,
      'contact_id': contactId,
      'description': description,
      'transaction_date': transactionDate.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  factory TransactionEntity.fromMap(Map<String, dynamic> map) {
    return TransactionEntity(
      id: map['id'],
      type: map['type'],
      flow: map['flow'],
      amount: map['amount'],
      accountId: map['account_id'],
      categoryId: map['category_id'],
      reference: map['reference'],
      contactId: map['contact_id'],
      description: map['description'],
      transactionDate: DateTime.parse(map['transaction_date']),
      createdAt: map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      updatedAt: map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
    );
  }
}
