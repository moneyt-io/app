import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/category_table.dart';

part 'category_dao.g.dart';

@DriftAccessor(tables: [Categories])
class CategoryDao extends DatabaseAccessor<AppDatabase> with _$CategoryDaoMixin {
  CategoryDao(AppDatabase db) : super(db);

  Future<List<Category>> getAllCategories() => select(categories).get();

  Stream<List<Category>> watchAllCategories() => select(categories).watch();

  Future<Category> getCategoryById(int id) =>
      (select(categories)..where((c) => c.id.equals(id))).getSingle();

  Future<int> insertCategory(Category category) =>
      into(categories).insert(category);

  Future<bool> updateCategory(Category category) =>
      update(categories).replace(category);

  Future<int> deleteCategory(int id) =>
      (delete(categories)..where((c) => c.id.equals(id))).go();

  Future<Category?> getCategoryByName(String name) =>
      (select(categories)..where((c) => c.name.equals(name))).getSingleOrNull();

  Future<List<Category>> getCategoriesByType(String type) =>
      (select(categories)..where((c) => c.type.equals(type))).get();

  Future<List<Category>> getSubcategories(int parentId) =>
      (select(categories)..where((c) => c.parentId.equals(parentId))).get();
}
