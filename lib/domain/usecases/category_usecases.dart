import 'package:injectable/injectable.dart';
import '../entities/category.dart';
import '../repositories/category_repository.dart';
import '../entities/chart_account.dart';
import '../usecases/chart_account_usecases.dart';

@injectable
class CategoryUseCases {
  final CategoryRepository _repository;
  final ChartAccountUseCases _chartAccountUseCases;

  CategoryUseCases(this._repository, this._chartAccountUseCases);

  // Consultas
  Future<List<Category>> getAllCategories() => 
      _repository.getAllCategories();

  Future<Category?> getCategoryById(int id) => 
      _repository.getCategoryById(id);
  
  Future<List<Category>> getCategoriesByType(String documentTypeId) => 
      _repository.getCategoriesByType(documentTypeId);
  
  Future<List<Category>> getCategoriesByParent(int parentId) => 
      _repository.getCategoriesByParent(parentId);
      
  // Observación en tiempo real
  Stream<List<Category>> watchAllCategories() => 
      _repository.watchAllCategories();

  Future<ChartAccount?> getCategoryChartAccount(int chartAccountId) async {
    if (chartAccountId <= 0) return null;
    return await _chartAccountUseCases.getChartAccountById(chartAccountId);
  }

  // Operaciones CRUD
  Future<Category> createCategory(Category category) async {
    // Si la categoría no tiene cuenta contable asociada, crearla
    if (category.chartAccountId <= 0) {
      // 1. Determinar tipo de cuenta contable según el tipo de categoría
      final accountingTypeId = category.documentTypeId == 'E' ? 'Ex' : 'In';  // Ex=Expenses, In=Income
      
      ChartAccount? parentChartAccount;
      
      // 2. Si tiene categoría padre, buscar su cuenta contable
      if (category.parentId != null) {
        final parentCategory = await getCategoryById(category.parentId!);
        if (parentCategory != null) {
          parentChartAccount = await _chartAccountUseCases.getChartAccountById(parentCategory.chartAccountId);
        }
      }

      // 3. Generar cuenta contable adecuada según la jerarquía
      final chartAccount = parentChartAccount != null 
          ? await _chartAccountUseCases.generateAccountForCategory(category.name, accountingTypeId, parentId: parentChartAccount.id)
          : await _chartAccountUseCases.generateAccountForCategory(category.name, accountingTypeId);
      
      // 4. Asignar la cuenta generada a la categoría
      final updatedCategory = Category(
        id: category.id,
        name: category.name,
        icon: category.icon,
        parentId: category.parentId,
        documentTypeId: category.documentTypeId,
        chartAccountId: chartAccount.id,
        active: category.active,
        createdAt: category.createdAt,
        updatedAt: category.updatedAt,
        deletedAt: category.deletedAt,
      );
      
      return _repository.createCategory(updatedCategory);
    } else {
      // Si ya tiene cuenta contable asociada, crear normalmente
      return _repository.createCategory(category);
    }
  }
      
  Future<void> updateCategory(Category category) => 
      _repository.updateCategory(category);
      
  Future<void> deleteCategory(int id) => 
      _repository.deleteCategory(id);
}
