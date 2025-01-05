// lib/domain/entities/account.dart
import '../../presentation/interfaces/list_item_interface.dart';

class AccountEntity implements ListItemInterface {
  @override
  final int id;
  @override
  final String name;
  
  final String? description;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;
  final double balance;

  AccountEntity({
    required this.id,
    required this.name,
    this.description,
    required this.createdAt,
    this.updatedAt,
    this.balance = 0.0,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'AccountEntity(id: $id, name: $name, balance: $balance, updatedAt: $updatedAt)';
}
