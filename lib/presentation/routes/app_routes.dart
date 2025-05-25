/// Clase que define todas las rutas disponibles en la aplicación.
/// 
/// Esta clase contiene únicamente constantes que identifican las rutas,
/// sin lógica de navegación.
class AppRoutes {
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String home = '/home';
  static const String settings = '/settings';
  static const String contacts = '/contacts';
  static const String contactForm = '/contactForm';
  static const String categories = '/categories';
  static const String categoryForm = '/categoryForm';
  static const String transactions = '/transactions';
  static const String transactionForm = '/transactionForm';
  static const String transactionDetail = '/transactionDetail';
  static const String wallets = '/wallets';
  static const String walletForm = '/wallet-form';
  static const String walletDetail = '/wallet-detail';
  
  // Credit Card Routes
  static const String creditCards = '/credit-cards';
  static const String creditCardForm = '/credit-card-form';
  static const String creditCardPayment = '/credit-card-payment'; // Nueva ruta
  
  static const String chartAccounts = '/chartAccounts';
  static const String chartAccountForm = '/chartAccountForm';
  static const String journals = '/journals';
  static const String journalDetail = '/journalDetail';
  static const String backups = '/backups'; // Nueva ruta
}
