// lib/data/repositories/category_repository_impl.dart
import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';
import '../local/daos/category_dao.dart';
import '../models/category_model.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryDao _categoryDao;

  CategoryRepositoryImpl(this._categoryDao);

  @override
  Stream<List<CategoryEntity>> watchCategories() {
    return _categoryDao.watchAllCategories().map((driftCategories) {
      return driftCategories
          .map((driftCategory) => CategoryModel.fromDriftCategory(driftCategory))
          .toList();
    });
  }

  @override
  Future<List<CategoryEntity>> getCategories() async {
    final driftCategories = await _categoryDao.getAllCategories();
    return driftCategories
        .map((driftCategory) => CategoryModel.fromDriftCategory(driftCategory))
        .toList();
  }

  @override
  Future<void> createCategory(CategoryEntity category) async {
    if (category is CategoryModel) {
      await _categoryDao.insertCategory(category.toCompanion());
    }
  }

  @override
  Future<void> updateCategory(CategoryEntity category) async {
    if (category is CategoryModel) {
      await _categoryDao.updateCategory(category.toCompanionWithId());
    }
  }

  @override
  Future<void> deleteCategory(int id) async {
    await _categoryDao.deleteCategory(id);
  }
}