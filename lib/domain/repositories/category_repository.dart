import '../entities/category.dart';

abstract class CategoryRepository {
  // Consultas básicas
  Future<List<Category>> getAllCategories();
  Future<Category?> getCategoryById(int id);
  Future<List<Category>> getCategoriesByType(String documentTypeId);
  Future<List<Category>> getCategoriesByParent(int parentId);
  
  // Observación en tiempo real
  Stream<List<Category>> watchAllCategories();
  
  // Operaciones CRUD
  Future<Category> createCategory(Category category);
  Future<void> updateCategory(Category category);
  Future<void> deleteCategory(int id);
}
