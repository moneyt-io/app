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

  Future<int> deleteCategory(int id) async {
    return db.transaction(() async {
      // 1. Check if any transaction detail references this category.
      final query = select(db.transactionDetail, distinct: true)
        ..where((td) => td.categoryId.equals(id));
      final hasTransactions = await query.getSingleOrNull();

      // 2. If transactions exist, throw an exception to prevent deletion.
      if (hasTransactions != null) {
        throw Exception('Cannot delete category: It has associated transactions.');
      }

      // 3. Proceed with deletion.
      return await (delete(category)..where((t) => t.id.equals(id))).go();
    });
  }
}
