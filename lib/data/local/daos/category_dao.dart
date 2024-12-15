import 'package:drift/drift.dart';
import '../tables/category_table.dart'; // Ruta correcta al archivo de la tabla
import '../database.dart'; // Asegúrate de que la ruta de database.dart sea correcta

part 'category_dao.g.dart';

@DriftAccessor(tables: [Categories]) // Nombre correcto de la tabla
class CategoryDao extends DatabaseAccessor<AppDatabase> with _$CategoryDaoMixin {
  final AppDatabase db;

  CategoryDao(this.db) : super(db);

  // Método para observar todas las categorías
  Stream<List<Category>> watchAllCategories() {
    return select(categories).watch();
  }

  // Obtener todas las categorías
  Future<List<Category>> getAllCategories() => select(categories).get();

  // Insertar una categoría
  Future<int> insertCategory(CategoriesCompanion category) =>
      into(categories).insert(category);

  // Actualizar una categoría
  Future<bool> updateCategory(CategoriesCompanion category) =>
      update(categories).replace(category);

  // Eliminar una categoría
  Future<int> deleteCategory(int id) =>
      (delete(categories)..where((tbl) => tbl.id.equals(id))).go();
}
