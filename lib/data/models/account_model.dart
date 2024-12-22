// lib/data/models/account_model.dart
import 'package:drift/drift.dart';
import '../../domain/entities/account.dart';
import '../local/database.dart';

class AccountModel implements AccountEntity {
  @override
  final int id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final DateTime createdAt;
  @override
  final double balance;  // Nuevo campo

  AccountModel({
    required this.id,
    required this.name,
    this.description,
    required this.createdAt,
    this.balance = 0.0,  // Valor por defecto
  });

  factory AccountModel.fromDriftAccount(Account driftAccount) {
    return AccountModel(
      id: driftAccount.id,
      name: driftAccount.name,
      description: driftAccount.description,
      createdAt: driftAccount.createdAt,
      balance: 0.0,  // El balance se calculará después con las transacciones
    );
  }

  AccountsCompanion toCompanion() {
    return AccountsCompanion(
      name: Value(name),
      description: Value(description),
      createdAt: Value(createdAt),
    );
  }

  AccountsCompanion toCompanionWithId() {
    return AccountsCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      createdAt: Value(createdAt),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'AccountModel(id: $id, name: $name, balance: $balance)';
}