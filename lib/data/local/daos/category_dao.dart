// lib/data/local/daos/category_dao.dart
import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/category_table.dart';

part 'category_dao.g.dart';

@DriftAccessor(tables: [Categories])
class CategoryDao extends DatabaseAccessor<AppDatabase> with _$CategoryDaoMixin {
  CategoryDao(AppDatabase db) : super(db);

  // Obtener categorías principales (sin parentId)
  Stream<List<Category>> watchMainCategories() {
    return (select(categories)..where((c) => c.parentId.isNull())).watch();
  }

  // Obtener subcategorías de una categoría específica
  Stream<List<Category>> watchSubcategories(int parentId) {
    return (select(categories)..where((c) => c.parentId.equals(parentId))).watch();
  }

  // Obtener todas las categorías con sus subcategorías
  Stream<List<Category>> watchAllCategories() {
    return (select(categories)
      ..orderBy([
        (c) => OrderingTerm(
              expression: c.parentId.isNull(),
              mode: OrderingMode.desc,
            ),
        (c) => OrderingTerm(expression: c.name),
      ]))
        .watch();
  }

    // Obtener categorías por tipo
  Stream<List<Category>> watchCategoriesByType(String type) {
    return (select(categories)..where((c) => c.type.equals(type))).watch();
  }

  Future<List<Category>> getAllCategories() => select(categories).get();

  Future<int> insertCategory(CategoriesCompanion category) =>
      into(categories).insert(category);

  Future<bool> updateCategory(CategoriesCompanion category) =>
      update(categories).replace(category);

  Future<int> deleteCategory(int id) =>
      (delete(categories)..where((tbl) => tbl.id.equals(id))).go();
}