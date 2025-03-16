import 'package:flutter/material.dart';
import '../pages/welcome_screen.dart';
import '../pages/login_screen.dart';
import '../pages/home_screen.dart';
import '../pages/settings_screen.dart';
import '../pages/contacts_screen.dart';
import '../pages/contact_form_screen.dart';
import '../pages/categories_screen.dart';
import '../pages/category_form_screen.dart';
import '../pages/transactions_screen.dart';
import '../pages/transaction_form_screen.dart';
import '../pages/chart_accounts_screen.dart';
import '../pages/chart_account_form_screen.dart';
import './app_routes.dart';
import '../../domain/entities/contact.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/entities/chart_account.dart';
import 'package:flutter_contacts/flutter_contacts.dart' as device_contacts;

/// Genera las rutas para el sistema de navegación de la app.
/// 
/// Esta clase contiene la lógica para crear las pantallas y pasarles
/// los argumentos necesarios.
class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case AppRoutes.welcome:
        return MaterialPageRoute(
          builder: (_) => const WelcomeScreen(),
        );
        
      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
          fullscreenDialog: true,
        );
        
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
        
      case AppRoutes.settings:
        return MaterialPageRoute(
          builder: (_) => const SettingsScreen(),
        );
      
      case AppRoutes.contacts:
        return MaterialPageRoute(
          builder: (_) => const ContactsScreen(),
        );
        
      case AppRoutes.contactForm:
        Contact? contact;
        device_contacts.Contact? deviceContact;
        
        if (args != null && args is Map<String, dynamic>) {
          contact = args['contact'] as Contact?;
          deviceContact = args['deviceContact'] as device_contacts.Contact?;
        }
        
        return MaterialPageRoute(
          builder: (_) => ContactFormScreen(
            contact: contact,
            deviceContact: deviceContact,
          ),
        );
        
      case AppRoutes.categories:
        return MaterialPageRoute(
          builder: (_) => const CategoriesScreen(),
        );
        
      case AppRoutes.categoryForm:
        Category? category;
        
        if (args != null && args is Category) {
          category = args;
        }
        
        return MaterialPageRoute(
          builder: (_) => CategoryFormScreen(
            category: category,
          ),
        );
      
      // NUEVAS RUTAS AÑADIDAS PARA TRANSACCIONES
      case AppRoutes.transactions:
        return MaterialPageRoute(
          builder: (_) => const TransactionsScreen(),
        );
        
      case AppRoutes.transactionForm:
        TransactionEntity? transaction;
        String initialType = 'all';
        
        if (args != null && args is Map<String, dynamic>) {
          transaction = args['transaction'] as TransactionEntity?;
          initialType = args['type'] as String? ?? 'all';
        }
        
        return MaterialPageRoute(
          builder: (_) => TransactionFormScreen(
            transaction: transaction,
            initialType: initialType,
          ),
        );
      
      // NUEVAS RUTAS PARA EL PLAN DE CUENTAS
      case AppRoutes.chartAccounts:
        return MaterialPageRoute(
          builder: (_) => const ChartAccountsScreen(),
        );
        
      case AppRoutes.chartAccountForm:
        ChartAccount? account;
        
        if (args != null && args is ChartAccount) {
          account = args;
        }
        
        return MaterialPageRoute(
          builder: (_) => ChartAccountFormScreen(
            account: account,
          ),
        );
      
      // En el futuro, agregar las demás rutas aquí
      
      default:
        // Ruta no encontrada
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No se encontró la ruta: ${settings.name}'),
            ),
          ),
        );
    }
  }
}
