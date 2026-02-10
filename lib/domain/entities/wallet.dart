import 'package:equatable/equatable.dart';

class Wallet extends Equatable {
  final int id;
  final int? parentId; // Added parentId
  final String currencyId;
  final int chartAccountId;
  final String name;
  final String? description;
  final bool active;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  const Wallet({
    required this.id,
    this.parentId, // Added parentId
    required this.currencyId,
    required this.chartAccountId,
    required this.name,
    this.description,
    required this.active,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  // Helper to check if it's a root wallet
  bool get isRootWallet => parentId == null;

  Wallet copyWith({
    int? id,
    int? parentId,
    String? currencyId,
    int? chartAccountId,
    String? name,
    String? description,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return Wallet(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      currencyId: currencyId ?? this.currencyId,
      chartAccountId: chartAccountId ?? this.chartAccountId,
      name: name ?? this.name,
      description: description ?? this.description,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        parentId, // Added parentId
        currencyId,
        chartAccountId,
        name,
        description,
        active,
        createdAt,
        updatedAt,
        deletedAt,
      ];
}
