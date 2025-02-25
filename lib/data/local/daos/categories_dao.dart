import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/categories_table.dart';

part 'categories_dao.g.dart';

@DriftAccessor(tables: [Category])
class CategoriesDao extends DatabaseAccessor<AppDatabase> with _$CategoriesDaoMixin {
  CategoriesDao(AppDatabase db) : super(db);

  // Queries básicas
  Future<List<Categories>> getAllCategories() => select(category).get();
  
  Future<Categories?> getCategoryById(int id) =>
      (select(category)..where((t) => t.id.equals(id))).getSingleOrNull();
  
  Future<List<Categories>> getCategoriesByDocumentType(String documentTypeId) =>
      (select(category)..where((t) => t.documentTypeId.equals(documentTypeId))).get();

  Future<List<Categories>> getCategoriesByParent(int parentId) =>
      (select(category)..where((t) => t.parentId.equals(parentId))).get();

  Stream<List<Categories>> watchAllCategories() => select(category).watch();

  // CRUD Operations
  Future<int> insertCategory(CategoriesCompanion category) =>
      into(this.category).insert(category);

  Future<bool> updateCategory(CategoriesCompanion category) =>
      update(this.category).replace(category);

  Future<int> deleteCategory(int id) =>
      (delete(category)..where((t) => t.id.equals(id))).go();
}
