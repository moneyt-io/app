import 'package:drift/drift.dart';
import '../../domain/entities/wallet.dart';
import '../datasources/local/database.dart';

class WalletModel {
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

  WalletModel({
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

  // Constructor para nuevas wallets
  WalletModel.create({
    this.parentId, // Added parentId
    required this.currencyId,
    required this.chartAccountId,
    required this.name,
    this.description,
    bool? active,
  })  : id = 0,
        active = active ?? true,
        createdAt = DateTime.now(),
        updatedAt = null,
        deletedAt = null;

  // Convertir a Companion para Drift
  WalletsCompanion toCompanion() => WalletsCompanion(
    id: id == 0 ? const Value.absent() : Value(id),
    parentId: Value(parentId), // Added parentId
    currencyId: Value(currencyId),
    chartAccountId: Value(chartAccountId),
    name: Value(name),
    description: Value(description),
    active: Value(active),
    createdAt: Value(createdAt),
    updatedAt: Value(updatedAt),
    deletedAt: Value(deletedAt),
  );

  // Conversión desde/hacia Domain Entity
  Wallet toEntity() => Wallet(
    id: id,
    parentId: parentId, // Added parentId
    currencyId: currencyId,
    chartAccountId: chartAccountId,
    name: name,
    description: description,
    active: active,
    createdAt: createdAt,
    updatedAt: updatedAt,
    deletedAt: deletedAt,
  );

  factory WalletModel.fromEntity(Wallet entity) => WalletModel(
    id: entity.id,
    parentId: entity.parentId, // Added parentId
    currencyId: entity.currencyId,
    chartAccountId: entity.chartAccountId,
    name: entity.name,
    description: entity.description,
    active: entity.active,
    createdAt: entity.createdAt,
    updatedAt: entity.updatedAt,
    deletedAt: entity.deletedAt,
  );
}
