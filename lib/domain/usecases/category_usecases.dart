// lib/domain/usecases/category_usecases.dart
import '../entities/category.dart';
import '../repositories/category_repository.dart';

class GetCategories {
  final CategoryRepository repository;

  GetCategories(this.repository);

  Stream<List<CategoryEntity>> call() => repository.watchCategories();
}

class CreateCategory {
  final CategoryRepository repository;

  CreateCategory(this.repository);

  Future<void> call(CategoryEntity category) => repository.createCategory(category);
}

class UpdateCategory {
  final CategoryRepository repository;

  UpdateCategory(this.repository);

  Future<void> call(CategoryEntity category) => repository.updateCategory(category);
}

class DeleteCategory {
  final CategoryRepository repository;

  DeleteCategory(this.repository);

  Future<void> call(int id) => repository.deleteCategory(id);
}