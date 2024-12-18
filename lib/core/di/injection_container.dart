// lib/core/di/injection_container.dart
import 'package:get_it/get_it.dart';
import '../../data/local/database.dart';
import '../../data/local/daos/category_dao.dart';
import '../../data/repositories/category_repository_impl.dart';
import '../../domain/repositories/category_repository.dart';
import '../../domain/usecases/category_usecases.dart';

final GetIt getIt = GetIt.instance;

void setupDependencies() {
  // Infrastructure Layer (Database)
  getIt.registerLazySingleton<AppDatabase>(() => AppDatabase());
  getIt.registerLazySingleton<CategoryDao>(
    () => CategoryDao(getIt<AppDatabase>())
  );

  // Repository Layer
  getIt.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(getIt<CategoryDao>())
  );

  // Use Cases Layer
  getIt.registerLazySingleton(() => GetCategories(getIt<CategoryRepository>()));
  getIt.registerLazySingleton(() => CreateCategory(getIt<CategoryRepository>()));
  getIt.registerLazySingleton(() => UpdateCategory(getIt<CategoryRepository>()));
  getIt.registerLazySingleton(() => DeleteCategory(getIt<CategoryRepository>()));
}