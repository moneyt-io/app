import 'package:flutter/material.dart';
import '../../domain/entities/journal_entry.dart';
import '../pages/journal_detail_screen.dart';
import '../pages/journals_screen.dart';
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
import '../pages/wallets_screen.dart';
import '../pages/wallet_form_screen.dart';
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
      
      case AppRoutes.wallets:
        return MaterialPageRoute(
          builder: (_) => const WalletsScreen(),
        );
        
      case AppRoutes.walletForm:
        return MaterialPageRoute(
          builder: (_) => WalletFormScreen(wallet: args as dynamic),
        );
      
      // Nuevas rutas para diarios contables
      case AppRoutes.journals:
        return MaterialPageRoute(
          builder: (_) => const JournalsScreen(),
        );
        
      case AppRoutes.journalDetail:
        if (args is JournalEntry) {
          return MaterialPageRoute(
            builder: (_) => JournalDetailScreen(journal: args),
          );
        }
        return _errorRoute('Se requiere un JournalEntry como argumento');
      
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

  // Añadir este método para manejar rutas con error
  static Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Error'),
            centerTitle: true,
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 64,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Error de Navegación',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(_).pushNamedAndRemoveUntil(
                        AppRoutes.home,
                        (route) => false,
                      );
                    },
                    child: const Text('Ir al Inicio'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
