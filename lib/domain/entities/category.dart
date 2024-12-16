// lib/domain/entities/category.dart
class CategoryEntity {  // Cambiamos el nombre de Category a CategoryEntity
  final int id;
  final String name;
  final String? description;
  final DateTime createdAt;

  CategoryEntity({
    required this.id,
    required this.name,
    this.description,
    required this.createdAt,
  });
}