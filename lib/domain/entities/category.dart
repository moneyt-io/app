// lib/domain/entities/category.dart

import 'package:moneyt_pfm/presentation/interfaces/list_item_interface.dart';

class CategoryEntity implements ListItemInterface {
  @override
  final int id;
  final int? parentId;
  @override
  final String name;
  final String type;
  final DateTime createdAt;
  final DateTime? updatedAt;

  CategoryEntity({
    required this.id,
    this.parentId,
    required this.name,
    required this.type,
    required this.createdAt,
    this.updatedAt,
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
  String toString() => 'CategoryEntity(id: $id, name: $name, type: $type, updatedAt: $updatedAt)';
}
