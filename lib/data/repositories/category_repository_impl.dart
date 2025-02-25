import 'package:injectable/injectable.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';
import '../local/daos/categories_dao.dart';
import '../models/category_model.dart';

@Injectable(as: CategoryRepository)
class CategoryRepositoryImpl implements CategoryRepository {
  final CategoriesDao _dao;

  CategoryRepositoryImpl(this._dao);

  @override
  Stream<List<Category>> watchCategories() {
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
  Future<List<Category>> getCategories() async {
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
    Future<void> createCategory(Category category) async {
    final model = CategoryModel.fromEntity(category);
    final id = await _dao.insertCategory(model.toCompanion());
    final createdCategory = await _dao.getCategoryById(id);
    if (createdCategory == null) {
      throw Exception('Failed to create category');
    }
  }

  @override
  Future<void> updateCategory(Category category) async {
    final model = CategoryModel.fromEntity(category);
    await _dao.updateCategory(model.toCompanion());
  }

  @override
  Future<void> deleteCategory(int id) => _dao.deleteCategory(id);
}