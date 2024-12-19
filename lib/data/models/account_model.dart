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

  AccountModel({
    required this.id,
    required this.name,
    this.description,
    required this.createdAt,
  });

  factory AccountModel.fromDriftAccount(Account driftAccount) {
    return AccountModel(
      id: driftAccount.id,
      name: driftAccount.name,
      description: driftAccount.description,
      createdAt: driftAccount.createdAt,
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
      other is AccountEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}