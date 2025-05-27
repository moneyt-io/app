import 'package:flutter/material.dart';
import '../../domain/entities/credit_card.dart';
import '../../domain/entities/journal_entry.dart';
import '../../domain/entities/loan_entry.dart';
import '../../domain/entities/transaction_entry.dart';
import '../../domain/entities/wallet.dart';
import '../pages/journals/journal_detail_screen.dart';
import '../pages/journals/journals_screen.dart';
import '../pages/welcome_screen.dart';
import '../pages/login_screen.dart';
import '../pages/home_screen.dart'; // Usar home_screen en lugar de dashboard
import '../pages/settings_screen.dart';
import '../pages/contacts/contacts_screen.dart';
import '../pages/contacts/contact_form_screen.dart';
import '../pages/categories/categories_screen.dart';
import '../pages/categories/category_form_screen.dart';
import '../pages/transactions/transactions_screen.dart';
import '../pages/transactions/transaction_form_screen.dart';
import '../pages/chart_accounts/chart_accounts_screen.dart';
import '../pages/chart_accounts/chart_account_form_screen.dart';
import '../pages/wallets/wallets_screen.dart';
import '../pages/wallets/wallet_form_screen.dart';
import '../pages/wallets/wallet_detail_screen.dart';
import '../pages/transactions/transaction_detail_screen.dart';
import '../pages/backup_screen.dart';
import '../pages/credit_cards/credit_cards_screen.dart';
import '../pages/credit_cards/credit_card_form_screen.dart';
import '../pages/credit_cards/credit_card_payment_screen.dart';
import '../pages/loans/loans_screen.dart';
import '../pages/loans/loan_form_screen.dart';
import '../pages/loans/loan_detail_screen.dart';
import 'app_routes.dart';
import '../../domain/entities/contact.dart';
import '../../domain/entities/category.dart';
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
      case AppRoutes.dashboard:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(), // Cambiar a HomeScreen
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
      
      // RUTAS PARA TRANSACCIONES
      case AppRoutes.transactions:
        return MaterialPageRoute(
          builder: (_) => const TransactionsScreen(),
        );
        
      case AppRoutes.transactionForm:
        if (args is Map<String, dynamic>) {
          return MaterialPageRoute(
            builder: (_) => TransactionFormScreen(
              transaction: args['transaction'],
              initialType: args['type'] ?? 'all',
            ),
          );
        }
        return _errorRoute();
        
      case AppRoutes.transactionDetail:
        if (args != null && args is TransactionEntry) {
          return MaterialPageRoute(
            builder: (_) => TransactionDetailScreen(
              transaction: args,
            ),
          );
        }
        return _errorRoute();
      
      // RUTAS PARA EL PLAN DE CUENTAS
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
      
      case AppRoutes.walletDetail:
        final wallet = settings.arguments as Wallet;
        return MaterialPageRoute(builder: (_) => WalletDetailScreen(wallet: wallet));
      
      // Credit Card Routes
      case AppRoutes.creditCards:
        return MaterialPageRoute(builder: (_) => const CreditCardsScreen());
      
      case AppRoutes.creditCardForm:
        final creditCard = settings.arguments as CreditCard?;
        return MaterialPageRoute(builder: (_) => CreditCardFormScreen(creditCard: creditCard));
      
      // Ruta para el pago de tarjeta de crédito
      case AppRoutes.creditCardPayment:
        if (args is CreditCard) {
          return MaterialPageRoute(builder: (_) => CreditCardPaymentScreen(creditCard: args));
        }
        return _errorRoute();

      // Rutas para journals
      case AppRoutes.journals:
        return MaterialPageRoute(
          builder: (_) => const JournalsScreen(),
        );

      case AppRoutes.journalDetail:
        JournalEntry? journal;
        
        if (args != null && args is JournalEntry) {
          journal = args;
          
          return MaterialPageRoute(
            builder: (_) => JournalDetailScreen(
              journal: journal,
            ),
          );
        } else {
          return MaterialPageRoute(
            builder: (_) => const JournalsScreen(),
          );
        }

      // Ruta para respaldos
      case AppRoutes.backups:
        return MaterialPageRoute(
          builder: (_) => const BackupScreen(),
        );
      
      // Rutas para préstamos
      case AppRoutes.loans:
        return MaterialPageRoute(
          builder: (_) => const LoansScreen(),
        );
        
      case AppRoutes.loanForm:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => LoanFormScreen(
            loanType: args?['loanType'] ?? 'L',
            editingLoan: args?['editingLoan'],
          ),
        );
        
      case AppRoutes.loanDetail:
        if (args != null && args is LoanEntry) {
          return MaterialPageRoute(
            builder: (_) => LoanDetailScreen(
              loan: args,
            ),
          );
        }
        return _errorRoute();
        
      default:
        return _errorRoute();
    }
  }
  
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Ruta no encontrada'),
        ),
      );
    });
  }
}
