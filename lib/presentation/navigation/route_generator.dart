import 'package:flutter/material.dart';
import '../../domain/entities/credit_card.dart';
import '../../domain/entities/journal_entry.dart';
import '../../domain/entities/loan_entry.dart';
import '../../domain/entities/transaction_entry.dart';
import '../../domain/entities/wallet.dart';
import '../../domain/entities/contact.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/chart_account.dart';
// Comentar el import de contacts_service por ahora ya que no está instalado
// import 'package:contacts_service/contacts_service.dart' as device_contacts;
import '../features/journals/journal_detail_screen.dart';
import '../features/journals/journals_screen.dart';
import '../features/auth/welcome_screen.dart';
import '../features/auth/login_screen.dart';
import '../features/dashboard/home_screen.dart';
import '../features/settings/settings_screen.dart';
import '../features/contacts/contacts_screen.dart';
import '../features/contacts/contact_form_screen.dart';
import '../features/categories/categories_screen.dart';
import '../features/categories/category_form_screen.dart';
import '../features/transactions/transactions_screen.dart';
import '../features/transactions/transaction_form_screen.dart';
import '../features/chart_accounts/chart_accounts_screen.dart';
import '../features/chart_accounts/chart_account_form_screen.dart';
import '../features/wallets/wallets_screen.dart';
import '../features/wallets/wallet_form_screen.dart';
import '../features/wallets/wallet_detail_screen.dart';
import '../features/transactions/transaction_detail_screen.dart';
import '../features/backup/backup_screen.dart';
import '../features/credit_cards/credit_cards_screen.dart';
import '../features/credit_cards/credit_card_form_screen.dart';
import '../features/credit_cards/credit_card_payment_screen.dart';
import '../features/loans/loans_screen.dart';
import '../features/loans/loan_form_screen.dart';
import '../features/loans/loan_detail_screen.dart';
import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Extract arguments safely
    final args = settings.arguments as Map<String, dynamic>?;

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
        // Comentar por ahora hasta que se instale el paquete contacts_service
        // device_contacts.Contact? deviceContact;
        
        if (args != null && args is Map<String, dynamic>) {
          contact = args['contact'] as Contact?;
          // deviceContact = args['deviceContact'] as device_contacts.Contact?;
        }
        
        return MaterialPageRoute(
          builder: (_) => ContactFormScreen(
            contact: contact,
            // deviceContact: deviceContact,
          ),
        );
        
      case AppRoutes.categories:
        return MaterialPageRoute(
          builder: (_) => const CategoriesScreen(),
        );
        
      case AppRoutes.categoryForm:
        Category? category;
        
        if (args != null && args is Map<String, dynamic>) {
          category = args['category'] as Category?;
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
        if (args != null && args is Map<String, dynamic>) {
          final transaction = args['transaction'] as TransactionEntry?;
          if (transaction != null) {
            return MaterialPageRoute(
              builder: (_) => TransactionDetailScreen(
                transaction: transaction,
              ),
            );
          }
        }
        return _errorRoute('Transaction is required');
      
      // RUTAS PARA EL PLAN DE CUENTAS
      case AppRoutes.chartAccounts:
        return MaterialPageRoute(
          builder: (_) => const ChartAccountsScreen(),
        );
        
      case AppRoutes.chartAccountForm:
        ChartAccount? account;
        
        if (args != null && args is Map<String, dynamic>) {
          account = args['account'] as ChartAccount?;
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
        if (args != null && args is Map<String, dynamic>) {
          final creditCard = args['creditCard'] as CreditCard?;
          if (creditCard != null) {
            return MaterialPageRoute(builder: (_) => CreditCardPaymentScreen(creditCard: creditCard));
          }
        }
        return _errorRoute('Credit card is required');

      // Rutas para journals
      case AppRoutes.journals:
        return MaterialPageRoute(
          builder: (_) => const JournalsScreen(),
        );

      case AppRoutes.journalDetail:
        JournalEntry? journal;
        
        if (args != null && args is Map<String, dynamic>) {
          journal = args['journal'] as JournalEntry?;
        }
        
        if (journal != null) {
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
          settings: settings,
        );
        
      case AppRoutes.loanForm:
        return MaterialPageRoute(
          builder: (_) => LoanFormScreen(
            loan: args?['loan'] as LoanEntry?,
          ),
          settings: settings,
        );
        
      case AppRoutes.loanDetail:
        final loanId = args?['loanId'] as int?;
        if (loanId == null) {
          return _errorRoute('Loan ID is required');
        }
        return MaterialPageRoute(
          builder: (_) => LoanDetailScreen(loanId: loanId),
          settings: settings,
        );
        
      default:
        return _errorRoute('Route not found: ${settings.name}');
    }
  }

  static Route<dynamic> _errorRoute([String? message]) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(child: Text(message ?? 'Route not found')),
      ),
    );
  }
}