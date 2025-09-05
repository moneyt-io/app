/// Clase que define todas las rutas disponibles en la aplicación.
/// 
/// Esta clase contiene únicamente constantes que identifican las rutas,
/// sin lógica de navegación.
class AppRoutes {
  // Pantallas principales
  static const String splash = '/splash';
  static const String welcome = '/welcome';
  static const String onboarding = '/onboarding';
  static const String paywall = '/paywall'; // Legacy, for UI prototype
  static const String paywallLauncher = '/paywall-launcher';
  static const String login = '/login'; // ✅ VERIFICADO: Debe existir esta línea
  static const String home = '/home';
  static const String dashboard = '/dashboard';
  
  // Settings
  static const String settings = '/settings';
  
  // Contactos
  static const String contacts = '/contacts';
  static const String contactForm = '/contacts/form';
  
  // Categorías
  static const String categories = '/categories';
  static const String categoryForm = '/categories/form';
  
  // Transacciones
  static const String transactions = '/transactions';
  static const String transactionForm = '/transactions/form';
  static const String transactionDetail = '/transactions/detail';
  static const String transactionShare = '/transactions/share';
  
  // Plan de cuentas
  static const String chartAccounts = '/chart-accounts';
  static const String chartAccountForm = '/chart-accounts/form';
  
  // Wallets
  static const String wallets = '/wallets';
  static const String walletForm = '/wallets/form';
  static const String walletDetail = '/wallets/detail';
  
  // Tarjetas de crédito
  static const String creditCards = '/credit-cards';
  static const String creditCardForm = '/credit-cards/form';
  static const String creditCardPayment = '/credit-cards/payment';
  
  // Journals
  static const String journals = '/journals';
  static const String journalDetail = '/journals/detail';
  
  // Respaldos
  static const String backups = '/backups';
  
  // Préstamos
  static const String loans = '/loans';
  static const String loanForm = '/loans/form';
  static const String loanDetail = '/loans/detail';
  
  // ✅ AGREGADO: Ruta para configuración de widgets
  static const String dashboardWidgets = '/dashboard/widgets';
}
