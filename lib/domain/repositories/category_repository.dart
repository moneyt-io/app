// lib/domain/repositories/category_repository.dart
import '../entities/category.dart';

abstract class CategoryRepository {
  Stream<List<Category>> watchCategories();
  Future<List<Category>> getCategories();
  Future<void> createCategory(Category category);
  Future<void> updateCategory(Category category);
  Future<void> deleteCategory(int id);
}