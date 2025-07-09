import 'package:flutter/material.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/chart_account.dart';
import '../../domain/entities/contact.dart';
import '../../domain/entities/credit_card.dart';
import '../../domain/entities/wallet.dart';
import 'app_routes.dart';
import '../features/dashboard/home_screen.dart';
import '../features/dashboard/dashboard_widgets_screen.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/splash/splash_screen.dart';
import '../features/auth/login_screen.dart';
import '../features/settings/settings_screen.dart';
import '../features/wallets/wallets_screen.dart';
import '../features/wallets/wallet_form_screen.dart';
import '../features/transactions/transactions_screen.dart';
import '../features/transactions/transaction_form_screen.dart';
import '../features/categories/categories_screen.dart';
import '../features/categories/category_form_screen.dart';
import '../features/contacts/contacts_screen.dart';
import '../features/contacts/contact_form_screen.dart';
import '../features/credit_cards/credit_cards_screen.dart';
import '../features/credit_cards/credit_card_form_screen.dart';
import '../features/chart_accounts/chart_accounts_screen.dart';
import '../features/chart_accounts/chart_account_form_screen.dart';
import '../features/backup/backup_screen.dart';
import '../features/loans/loans_screen.dart';
import '../features/loans/loan_form_screen.dart';
import '../features/loans/loan_detail_screen.dart';
import '../features/journals/journals_screen.dart';
import '../features/journals/journal_detail_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // ✅ EXISTENTES: Mantener las rutas que ya funcionan
      case AppRoutes.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );
        
      case AppRoutes.onboarding:
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
          settings: settings,
        );
        
      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
          fullscreenDialog: true,
          settings: settings,
        );

      // ✅ AGREGADAS: Rutas principales que faltaban
      case AppRoutes.home:
      case AppRoutes.dashboard:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
          settings: settings,
        );

      case AppRoutes.settings:
        return MaterialPageRoute(
          builder: (_) => const SettingsScreen(),
          settings: settings,
        );

      // ✅ AGREGADAS: Rutas de Wallets
      case AppRoutes.wallets:
        return MaterialPageRoute(
          builder: (_) => const WalletsScreen(),
          settings: settings,
        );

      case AppRoutes.walletForm:
        final wallet = settings.arguments as Wallet?; // ✅ CORREGIDO: Cast explícito
        return MaterialPageRoute(
          builder: (_) => WalletFormScreen(wallet: wallet),
          settings: settings,
        );

      // ✅ AGREGADAS: Rutas de Transacciones
      case AppRoutes.transactions:
        return MaterialPageRoute(
          builder: (_) => const TransactionsScreen(),
          settings: settings,
        );

      case AppRoutes.transactionForm:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => TransactionFormScreen(
            transaction: args?['transaction'],
            initialType: args?['type'],
          ),
          settings: settings,
        );

      // ✅ AGREGADAS: Rutas de Categorías
      case AppRoutes.categories:
        return MaterialPageRoute(
          builder: (_) => const CategoriesScreen(),
          settings: settings,
        );

      case AppRoutes.categoryForm:
        final category = settings.arguments as Category?; // ✅ CORREGIDO: Cast explícito
        return MaterialPageRoute(
          builder: (_) => CategoryFormScreen(category: category),
          settings: settings,
        );

      // ✅ AGREGADAS: Rutas de Contactos
      case AppRoutes.contacts:
        return MaterialPageRoute(
          builder: (_) => const ContactsScreen(),
          settings: settings,
        );

      case AppRoutes.contactForm:
        final contact = settings.arguments as Contact?; // ✅ CORREGIDO: Cast explícito
        return MaterialPageRoute(
          builder: (_) => ContactFormScreen(contact: contact),
          settings: settings,
        );

      // ✅ AGREGADAS: Rutas de Tarjetas de Crédito
      case AppRoutes.creditCards:
        return MaterialPageRoute(
          builder: (_) => const CreditCardsScreen(),
          settings: settings,
        );

      case AppRoutes.creditCardForm:
        final creditCard = settings.arguments as CreditCard?; // ✅ CORREGIDO: Cast explícito
        return MaterialPageRoute(
          builder: (_) => CreditCardFormScreen(creditCard: creditCard),
          settings: settings,
        );

      // ✅ AGREGADAS: Rutas de Plan de Cuentas
      case AppRoutes.chartAccounts:
        return MaterialPageRoute(
          builder: (_) => const ChartAccountsScreen(),
          settings: settings,
        );

      case AppRoutes.chartAccountForm:
        final chartAccount = settings.arguments as ChartAccount?;
        return MaterialPageRoute(
          builder: (_) => ChartAccountFormScreen(account: chartAccount), // ✅ CORREGIDO: Cambiar a 'account'
          settings: settings,
        );

      // ✅ AGREGADAS: Rutas de Respaldos
      case AppRoutes.backups:
        return MaterialPageRoute(
          builder: (_) => const BackupScreen(),
          settings: settings,
        );

      // ✅ AGREGADAS: Rutas de Préstamos
      case AppRoutes.loans:
        return MaterialPageRoute(
          builder: (_) => const LoansScreen(),
          settings: settings,
        );

      case AppRoutes.loanForm:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => LoanFormScreen(loan: args?['loan']),
          settings: settings,
        );

      case AppRoutes.loanDetail:
        final args = settings.arguments as Map<String, dynamic>?;
        final loanId = args?['loanId'] as int?;
        return MaterialPageRoute(
          builder: (_) => LoanDetailScreen(loanId: loanId ?? 0),
          settings: settings,
        );

      // ✅ AGREGADAS: Rutas de Diarios Contables
      case AppRoutes.journals:
        return MaterialPageRoute(
          builder: (_) => const JournalsScreen(),
          settings: settings,
        );

      case AppRoutes.journalDetail:
        final args = settings.arguments as Map<String, dynamic>?;
        final journalId = args?['journalId'] as int?;
        return MaterialPageRoute(
          builder: (_) => const JournalDetailScreen(), // ✅ CORREGIDO: Constructor sin parámetros
          settings: settings,
        );

      // ✅ AGREGADAS: Rutas de Dashboard Widgets
      case AppRoutes.dashboardWidgets:
        return MaterialPageRoute(
          builder: (_) => const DashboardWidgetsScreen(),
          settings: settings,
        );

      // ✅ AGREGADAS: Rutas legacy para compatibilidad
      case AppRoutes.welcome:
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
          settings: settings,
        );

      // ✅ MEJORADO: Default case más informativo
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold( // ✅ CORREGIDO: Usar 'context' en lugar de '_'
            appBar: AppBar(
              title: const Text('Página no encontrada'),
              backgroundColor: const Color(0xFFEF4444),
              foregroundColor: Colors.white,
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Color(0xFFEF4444),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Ruta no encontrada',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'La ruta "${settings.name}" no existe.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF64748B),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () => Navigator.of(context).pushReplacementNamed(AppRoutes.home),
                      icon: const Icon(Icons.home),
                      label: const Text('Ir al Inicio'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0c7ff2),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          settings: settings,
        );
    }
  }
}