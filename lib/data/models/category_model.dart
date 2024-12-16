// lib/data/models/category_model.dart
import 'package:drift/drift.dart';
import '../../domain/entities/category.dart';
import '../local/database.dart';

class CategoryModel implements CategoryEntity {
  @override
  final int id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final DateTime createdAt;

  CategoryModel({
    required this.id,
    required this.name,
    this.description,
    required this.createdAt,
  });

  // Desde la tabla Drift a CategoryModel
  factory CategoryModel.fromDriftCategory(Category driftCategory) {
    return CategoryModel(
      id: driftCategory.id,
      name: driftCategory.name,
      description: driftCategory.description,
      createdAt: driftCategory.createdAt,
    );
  }

  CategoriesCompanion toCompanion() {
    return CategoriesCompanion(
      name: Value(name),
      description: Value(description),
      createdAt: Value(createdAt),
    );
  }

  CategoriesCompanion toCompanionWithId() {
    return CategoriesCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      createdAt: Value(createdAt),
    );
  }
}