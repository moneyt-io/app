// lib/domain/entities/account.dart
import '../../presentation/interfaces/list_item_interface.dart';

class AccountEntity implements ListItemInterface {
  @override
  final int id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final DateTime createdAt;
  final double balance;  // Nuevo campo

  AccountEntity({
    required this.id,
    required this.name,
    this.description,
    required this.createdAt,
    this.balance = 0.0,  // Valor por defecto
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
  String toString() => 'AccountEntity(id: $id, name: $name, balance: $balance)';
}