/// Clase que define todas las rutas disponibles en la aplicación.
/// 
/// Esta clase contiene únicamente constantes que identifican las rutas,
/// sin lógica de navegación.
class AppRoutes {
  // Screen routes
  static const String home = '/';
  // Cambiamos la ruta de 'accounts' a 'wallets'
  static const String wallets = '/wallets';
  static const String walletForm = '/wallets/form';
  static const String creditCards = '/credit-cards';
  static const String transactions = '/transactions';
  static const String transactionForm = '/transactions/form';
  static const String transactionDetail = '/transactions/detail'; // Nueva ruta añadida
  static const String categories = '/categories';
  static const String categoryForm = '/categories/form';
  static const String contacts = '/contacts';
  static const String contactForm = '/contacts/form';
  static const String chartAccounts = '/chart-accounts';
  static const String chartAccountForm = '/chart-accounts/form';
  static const String settings = '/settings';
  static const String profile = '/profile';
  static const String journals = '/journals'; // Nueva ruta para diarios
  static const String journalDetail = '/journals/detail'; // Nueva ruta para detalle de diario
  
  // Auth routes
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String backup = '/backup';
  static const String transactionDetails = '/transaction-details';
}
