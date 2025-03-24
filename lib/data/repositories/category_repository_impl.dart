import 'package:injectable/injectable.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasources/local/daos/categories_dao.dart';
import '../models/category_model.dart';

@Injectable(as: CategoryRepository)
class CategoryRepositoryImpl implements CategoryRepository {
  final CategoriesDao _dao;

  CategoryRepositoryImpl(this._dao);

  @override
  Future<List<Category>> getAllCategories() async {
    final categories = await _dao.getAllCategories();
    return categories.map((category) => CategoryModel(
      id: category.id,
      parentId: category.parentId,
      documentTypeId: category.documentTypeId,
      chartAccountId: category.chartAccountId,
      name: category.name,
      icon: category.icon,
      active: category.active,
      createdAt: category.createdAt,
      updatedAt: category.updatedAt,
      deletedAt: category.deletedAt,
    ).toEntity()).toList();
  }

  @override
  Future<Category?> getCategoryById(int id) async {
    final category = await _dao.getCategoryById(id);
    if (category == null) return null;
    
    return CategoryModel(
      id: category.id,
      parentId: category.parentId,
      documentTypeId: category.documentTypeId,
      chartAccountId: category.chartAccountId,
      name: category.name,
      icon: category.icon,
      active: category.active,
      createdAt: category.createdAt,
      updatedAt: category.updatedAt,
      deletedAt: category.deletedAt,
    ).toEntity();
  }

  @override
  Future<List<Category>> getCategoriesByType(String documentTypeId) async {
    final categories = await _dao.getCategoriesByDocumentType(documentTypeId);
    return categories.map((category) => CategoryModel(
      id: category.id,
      parentId: category.parentId,
      documentTypeId: category.documentTypeId,
      chartAccountId: category.chartAccountId,
      name: category.name,
      icon: category.icon,
      active: category.active,
      createdAt: category.createdAt,
      updatedAt: category.updatedAt,
      deletedAt: category.deletedAt,
    ).toEntity()).toList();
  }

  @override
  Future<List<Category>> getCategoriesByParent(int parentId) async {
    final categories = await _dao.getCategoriesByParent(parentId);
    return categories.map((category) => CategoryModel(
      id: category.id,
      parentId: category.parentId,
      documentTypeId: category.documentTypeId,
      chartAccountId: category.chartAccountId,
      name: category.name,
      icon: category.icon,
      active: category.active,
      createdAt: category.createdAt,
      updatedAt: category.updatedAt,
      deletedAt: category.deletedAt,
    ).toEntity()).toList();
  }

  @override
  Stream<List<Category>> watchAllCategories() {
    return _dao.watchAllCategories().map(
      (categories) => categories.map((category) => CategoryModel(
        id: category.id,
        parentId: category.parentId,
        documentTypeId: category.documentTypeId,
        chartAccountId: category.chartAccountId,
        name: category.name,
        icon: category.icon,
        active: category.active,
        createdAt: category.createdAt,
        updatedAt: category.updatedAt,
        deletedAt: category.deletedAt,
      ).toEntity()).toList()
    );
  }

  @override
  Future<Category> createCategory(Category category) async {
    final model = CategoryModel.fromEntity(category);
    final id = await _dao.insertCategory(model.toCompanion());
    
    // Recuperar la categoría recién creada
    final createdCategory = await getCategoryById(id);
    if (createdCategory == null) {
      throw Exception('Failed to create category');
    }
    return createdCategory;
  }

  @override
  Future<void> updateCategory(Category category) async {
    final model = CategoryModel.fromEntity(category);
    await _dao.updateCategory(model.toCompanion());
  }

  @override
  Future<void> deleteCategory(int id) => _dao.deleteCategory(id);
}
