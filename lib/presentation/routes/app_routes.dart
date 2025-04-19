/// Clase que define todas las rutas disponibles en la aplicación.
/// 
/// Esta clase contiene únicamente constantes que identifican las rutas,
/// sin lógica de navegación.
class AppRoutes {
  // Rutas principales
  static const String home = '/';
  static const String login = '/login';
  static const String register = '/register';
  
  // Transacciones
  static const String transactions = '/transactions';
  static const String transactionForm = '/transaction-form';
  static const String transactionDetail = '/transaction-detail'; // Asegúrate de que esta ruta exista

  // Screen routes
  static const String wallets = '/wallets';
  static const String walletForm = '/wallets/form';
  static const String creditCards = '/credit-cards';
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
  static const String backup = '/backup';
  static const String transactionDetails = '/transaction-details';
}
