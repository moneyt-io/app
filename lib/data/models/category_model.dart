// lib/data/models/category_model.dart
import 'package:drift/drift.dart';
import '../../domain/entities/category.dart';
import '../local/database.dart';

class CategoryModel implements CategoryEntity {
  @override
  final int id;
  @override
  final int? parentId;
  @override
  final String name;
  @override
  final String? description;
  @override
  final String type;
  @override
  final DateTime createdAt;

  // Implementamos el getter isMainCategory
  @override
  bool get isMainCategory => parentId == null;

  CategoryModel({
    required this.id,
    this.parentId,
    required this.name,
    this.description,
    required this.type,
    required this.createdAt,
  });

  factory CategoryModel.fromDriftCategory(Category driftCategory) {
    return CategoryModel(
      id: driftCategory.id,
      parentId: driftCategory.parentId,
      name: driftCategory.name,
      description: driftCategory.description,
      type: driftCategory.type,
      createdAt: driftCategory.createdAt,
    );
  }

  CategoriesCompanion toCompanion() {
    return CategoriesCompanion(
      parentId: Value(parentId),
      name: Value(name),
      description: Value(description),
      type: Value(type),
      createdAt: Value(createdAt),
    );
  }

  CategoriesCompanion toCompanionWithId() {
    return CategoriesCompanion(
      id: Value(id),
      parentId: Value(parentId),
      name: Value(name),
      description: Value(description),
      type: Value(type),
      createdAt: Value(createdAt),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'CategoryModel(id: $id, name: $name)';
  
}