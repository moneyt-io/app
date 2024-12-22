// lib/routes/app_routes.dart
import 'package:flutter/material.dart';
import 'package:moenyt_drift/domain/entities/transaction.dart';
import 'package:moenyt_drift/domain/usecases/transaction_usecases.dart';
import 'package:moenyt_drift/presentation/screens/transaction_form.dart';
import 'package:moenyt_drift/presentation/screens/transaction_screen.dart';
import '../domain/entities/category.dart';
import '../domain/entities/account.dart';
import '../domain/usecases/category_usecases.dart';
import '../domain/usecases/account_usecases.dart';
import '../presentation/screens/home_screen.dart';
import '../presentation/screens/category_screen.dart';
import '../presentation/screens/category_form.dart';
import '../presentation/screens/account_screen.dart';
import '../presentation/screens/account_form.dart';
import '../core/di/injection_container.dart';

class AppRoutes {
  static const String home = '/';
  static const String categories = '/categories';
  static const String categoryForm = '/category-form';
  static const String accounts = '/accounts';
  static const String accountForm = '/account-form';
  static const String transactions = '/transactions';  // Nueva
  static const String transactionForm = '/transaction-form';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(
            // Categorías
            getCategories: getIt<GetCategories>(),
            createCategory: getIt<CreateCategory>(),
            updateCategory: getIt<UpdateCategory>(),
            deleteCategory: getIt<DeleteCategory>(),
            // Cuentas
            getAccounts: getIt<GetAccounts>(),
            createAccount: getIt<CreateAccount>(),
            updateAccount: getIt<UpdateAccount>(),
            deleteAccount: getIt<DeleteAccount>(),

            transactionUseCases: getIt<TransactionUseCases>(),  // Agregamos esta línea

          ),
        );

      case categories:
        return MaterialPageRoute(
          builder: (_) => CategoryScreen(
            // Categorías
            getCategories: getIt<GetCategories>(),
            createCategory: getIt<CreateCategory>(),
            updateCategory: getIt<UpdateCategory>(),
            deleteCategory: getIt<DeleteCategory>(),
            // Cuentas
            getAccounts: getIt<GetAccounts>(),
            createAccount: getIt<CreateAccount>(),
            updateAccount: getIt<UpdateAccount>(),
            deleteAccount: getIt<DeleteAccount>(),

            transactionUseCases: getIt<TransactionUseCases>(),

          ),
        );

      case categoryForm:
        final args = settings.arguments as CategoryFormArgs;
        return MaterialPageRoute(
          builder: (_) => CategoryForm(
            category: args.category,
            createCategory: args.createCategory,
            updateCategory: args.updateCategory,
            getCategories: args.getCategories,
          ),
        );

      case accounts:
        return MaterialPageRoute(
          builder: (_) => AccountScreen(
            // Categorías
            getCategories: getIt<GetCategories>(),
            createCategory: getIt<CreateCategory>(),
            updateCategory: getIt<UpdateCategory>(),
            deleteCategory: getIt<DeleteCategory>(),
            // Cuentas
            getAccounts: getIt<GetAccounts>(),
            createAccount: getIt<CreateAccount>(),
            updateAccount: getIt<UpdateAccount>(),
            deleteAccount: getIt<DeleteAccount>(),

            transactionUseCases: getIt<TransactionUseCases>(),

          ),
        );

      case accountForm:
        final args = settings.arguments as AccountFormArgs;
        return MaterialPageRoute(
          builder: (_) => AccountForm(
            account: args.account,
            createAccount: args.createAccount,
            updateAccount: args.updateAccount,
          ),
        );

          case transactions:
      return MaterialPageRoute(
        builder: (_) => TransactionScreen(
          transactionUseCases: getIt<TransactionUseCases>(),
          // Categorías
          getCategories: getIt<GetCategories>(),
          createCategory: getIt<CreateCategory>(),
          updateCategory: getIt<UpdateCategory>(),
          deleteCategory: getIt<DeleteCategory>(),
          // Cuentas
          getAccounts: getIt<GetAccounts>(),
          createAccount: getIt<CreateAccount>(),
          updateAccount: getIt<UpdateAccount>(),
          deleteAccount: getIt<DeleteAccount>(),
        ),
      );

    case transactionForm:
      final args = settings.arguments as TransactionFormArgs?;
      return MaterialPageRoute(
        builder: (_) => TransactionForm(
          transaction: args?.transaction,
          transactionUseCases: args?.transactionUseCases ?? getIt<TransactionUseCases>(),
          getAccounts: args?.getAccounts ?? getIt<GetAccounts>(),
          getCategories: args?.getCategories ?? getIt<GetCategories>(),
        ),
      );

      default:
        // Ruta por defecto o manejo de error
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Ruta no encontrada: ${settings.name}'),
            ),
          ),
        );
    }
  }
}

class CategoryFormArgs {
  final CategoryEntity? category;
  final CreateCategory createCategory;
  final UpdateCategory updateCategory;
  final GetCategories getCategories;

  CategoryFormArgs({
    this.category,
    required this.createCategory,
    required this.updateCategory,
    required this.getCategories,
  });
}

class AccountFormArgs {
  final AccountEntity? account;
  final CreateAccount createAccount;
  final UpdateAccount updateAccount;

  AccountFormArgs({
    this.account,
    required this.createAccount,
    required this.updateAccount,
  });
}

// lib/routes/app_routes.dart
class TransactionFormArgs {
  final TransactionEntity? transaction;
  final TransactionUseCases transactionUseCases;
  final GetAccounts getAccounts;
  final GetCategories getCategories;

  TransactionFormArgs({
    this.transaction,
    required this.transactionUseCases,
    required this.getAccounts,
    required this.getCategories,
  });
}