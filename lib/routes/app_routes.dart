// lib/routes/app_routes.dart
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import '../presentation/screens/home_screen.dart';
import '../presentation/screens/category_screen.dart';
import '../presentation/screens/account_screen.dart';
import '../presentation/screens/transaction_screen.dart';
import '../presentation/screens/settings_screen.dart';
import '../presentation/screens/transaction_form.dart';
import '../presentation/screens/category_form.dart';
import '../presentation/screens/account_form.dart';
import '../presentation/screens/welcome_screen.dart';
import '../presentation/screens/transaction_details_screen.dart';
import '../presentation/screens/contact_screen.dart';
import '../presentation/screens/contact_form.dart';
import '../domain/usecases/category_usecases.dart';
import '../domain/usecases/account_usecases.dart';
import '../domain/usecases/transaction_usecases.dart';
import '../domain/usecases/contact_usecases.dart';
import '../domain/entities/transaction.dart';
import '../presentation/screens/backup_screen.dart';

final getIt = GetIt.instance;

class AppRoutes {
  static const String welcome = '/welcome';
  static const String home = '/';
  static const String categories = '/categories';
  static const String categoryForm = '/category-form';
  static const String accounts = '/accounts';
  static const String accountForm = '/account-form';
  static const String transactions = '/transactions';
  static const String transactionForm = '/transaction-form';
  static const String transactionDetails = '/transaction-details';
  static const String contacts = '/contacts';
  static const String contactForm = '/contact-form';
  static const String settings = '/settings';
  static const String backup = '/backup';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final String? routeName = settings.name;

    switch (routeName) {
      case AppRoutes.welcome:
        return MaterialPageRoute(
          builder: (context) => const WelcomeScreen(),
        );

      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(
            transactionUseCases: getIt<TransactionUseCases>(),
          ),
        );

      case AppRoutes.categories:
        return MaterialPageRoute(
          builder: (context) => CategoryScreen(
            getCategories: getIt<GetCategories>(),
            createCategory: getIt<CreateCategory>(),
            updateCategory: getIt<UpdateCategory>(),
            deleteCategory: getIt<DeleteCategory>(),
          ),
        );

      case AppRoutes.categoryForm:
        final args = settings.arguments as CategoryFormArgs;
        return MaterialPageRoute(
          builder: (context) => CategoryForm(
            category: args.category,
            createCategory: getIt<CreateCategory>(),
            updateCategory: getIt<UpdateCategory>(),
            getCategories: getIt<GetCategories>(),
          ),
        );

      case AppRoutes.accounts:
        return MaterialPageRoute(
          builder: (context) => AccountScreen(
            getAccounts: getIt<GetAccounts>(),
            createAccount: getIt<CreateAccount>(),
            updateAccount: getIt<UpdateAccount>(),
            deleteAccount: getIt<DeleteAccount>(),
            transactionUseCases: getIt<TransactionUseCases>(),
          ),
        );

      case AppRoutes.accountForm:
        final args = settings.arguments as AccountFormArgs;
        return MaterialPageRoute(
          builder: (context) => AccountForm(
            account: args.account,
            createAccount: getIt<CreateAccount>(),
            updateAccount: getIt<UpdateAccount>(),
          ),
        );

      case AppRoutes.transactions:
        return MaterialPageRoute(
          builder: (context) => TransactionScreen(
            transactionUseCases: getIt<TransactionUseCases>(),
          ),
        );

      case AppRoutes.transactionForm:
        String type;
        TransactionEntity? transaction;
        
        if (settings.arguments != null) {
          if (settings.arguments is String) {
            type = settings.arguments as String;
          } else if (settings.arguments is Map) {
            final args = settings.arguments as Map;
            type = args['type'] as String;
            transaction = args['transaction'] as TransactionEntity?;
          } else {
            type = 'E'; // Default to expense
          }
        } else {
          type = 'E'; // Default to expense
        }

        return MaterialPageRoute(
          builder: (context) => TransactionForm(
            type: type,
            transaction: transaction,
            transactionUseCases: getIt<TransactionUseCases>(),
            getAccounts: getIt<GetAccounts>(),
            getCategories: getIt<GetCategories>(),
          ),
        );

      case AppRoutes.transactionDetails:
        final transaction = settings.arguments as TransactionEntity;
        return MaterialPageRoute(
          builder: (context) => MultiProvider(
            providers: [
              Provider<GetAccounts>(
                create: (_) => getIt<GetAccounts>(),
              ),
              Provider<GetCategories>(
                create: (_) => getIt<GetCategories>(),
              ),
              Provider<TransactionUseCases>(
                create: (_) => getIt<TransactionUseCases>(),
              ),
            ],
            child: TransactionDetailsScreen(
              transaction: transaction,
            ),
          ),
        );

      case AppRoutes.contacts:
        return MaterialPageRoute(
          builder: (_) => ContactScreen(
            getContacts: getIt<GetContacts>(),
            createContact: getIt<CreateContact>(),
            updateContact: getIt<UpdateContact>(),
            deleteContact: getIt<DeleteContact>(),
          ),
        );

      case AppRoutes.contactForm:
        final args = settings.arguments as ContactFormArgs;
        return MaterialPageRoute(
          builder: (_) => ContactForm(
            contact: args.contact,
            createContact: getIt<CreateContact>(),
            updateContact: getIt<UpdateContact>(),
          ),
        );

      case AppRoutes.settings:
        return MaterialPageRoute(
          builder: (context) => const SettingsScreen(),
        );

      case AppRoutes.backup:
        return MaterialPageRoute(
          builder: (_) => const BackupScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('Route not found'),
            ),
          ),
        );
    }
  }

  // Método auxiliar para obtener argumentos tipados de forma segura
  static T? getArguments<T>(BuildContext context) {
    return ModalRoute.of(context)?.settings.arguments as T?;
  }

  // Método para navegar a una ruta con argumentos
  static Future<T?> navigateTo<T>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushNamed(
      context,
      routeName,
      arguments: arguments,
    );
  }

  // Método para reemplazar la ruta actual
  static Future<T?> replaceTo<T>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushReplacementNamed(
      context,
      routeName,
      arguments: arguments,
    );
  }

  // Método para navegar al home y limpiar el stack
  static void navigateToHomeAndClear(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      home,
      (route) => false,
    );
  }
}