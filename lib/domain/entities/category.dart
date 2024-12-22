// lib/domain/entities/category.dart

import 'package:moenyt_drift/presentation/interfaces/list_item_interface.dart';

class CategoryEntity implements ListItemInterface {
  @override
  final int id;
  final int? parentId;
  @override
  final String name;
  @override
  final String? description;
  final String type;
  @override
  final DateTime createdAt;
  final bool status;  // Nuevo campo

  CategoryEntity({
    required this.id,
    this.parentId,
    required this.name,
    this.description,
    required this.type,
    required this.createdAt,
    this.status = true,  // Valor por defecto
  });

  bool get isMainCategory => parentId == null;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'CategoryEntity(id: $id, name: $name, type: $type)';
}