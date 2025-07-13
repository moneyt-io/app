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
