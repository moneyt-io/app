// lib/core/l10n/translations.dart
class Translations {
  final String welcome;
  final String selectLanguage;
  final String continue_;
  final String settings;
  final String darkMode;
  final String darkModeDescription;
  final String language;
  final String availableBalance;
  final String selectCategory;
  final String selectAccount;
  final String category;
  final String account;
  final String toAccount;
  final String amount;
  final String invalidAmount;
  final String details;
  final String additionalInformation;
  final String date;
  final String contact;
  final String description;
  final String reference;
  final String create;
  final String update;
  final String unknown;
  final String newTransaction;
  final String newIncome;
  final String newExpense;
  final String newTransfer;
  final String editTransaction;

  const Translations({
    required this.welcome,
    required this.selectLanguage,
    required this.continue_,
    required this.settings,
    required this.darkMode,
    required this.darkModeDescription,
    required this.language,
    required this.availableBalance,
    required this.selectCategory,
    required this.selectAccount,
    required this.category,
    required this.account,
    required this.toAccount,
    required this.amount,
    required this.invalidAmount,
    required this.details,
    required this.additionalInformation,
    required this.date,
    required this.contact,
    required this.description,
    required this.reference,
    required this.create,
    required this.update,
    required this.unknown,
    required this.newTransaction,
    required this.newIncome,
    required this.newExpense,
    required this.newTransfer,
    required this.editTransaction,
  });

  // English translations
  static const en = Translations(
    welcome: 'Welcome to MoneyT',
    selectLanguage: 'Select your language',
    continue_: 'Continue',
    settings: 'Settings',
    darkMode: 'Dark Mode',
    darkModeDescription: 'Switch between light and dark theme',
    language: 'Language',
    availableBalance: 'Available Balance',
    selectCategory: 'Select Category',
    selectAccount: 'Select Account',
    category: 'Category',
    account: 'Account',
    toAccount: 'To Account',
    amount: 'Amount',
    invalidAmount: 'Please enter a valid amount',
    details: 'Details',
    additionalInformation: 'Additional Information',
    date: 'Date',
    contact: 'Contact',
    description: 'Description',
    reference: 'Reference',
    create: 'Create',
    update: 'Update',
    unknown: 'Unknown',
    newTransaction: 'New Transaction',
    newIncome: 'New Income',
    newExpense: 'New Expense',
    newTransfer: 'New Transfer',
    editTransaction: 'Edit Transaction',
  );

  // Spanish translations
  static const es = Translations(
    welcome: 'Bienvenido a MoneyT',
    selectLanguage: 'Selecciona tu idioma',
    continue_: 'Continuar',
    settings: 'Configuración',
    darkMode: 'Modo Oscuro',
    darkModeDescription: 'Cambiar entre tema claro y oscuro',
    language: 'Idioma',
    availableBalance: 'Saldo Disponible',
    selectCategory: 'Seleccionar Categoría',
    selectAccount: 'Seleccionar Cuenta',
    category: 'Categoría',
    account: 'Cuenta',
    toAccount: 'Cuenta Destino',
    amount: 'Monto',
    invalidAmount: 'Por favor ingrese un monto válido',
    details: 'Detalles',
    additionalInformation: 'Información Adicional',
    date: 'Fecha',
    contact: 'Contacto',
    description: 'Descripción',
    reference: 'Referencia',
    create: 'Crear',
    update: 'Actualizar',
    unknown: 'Desconocido',
    newTransaction: 'Nueva Transacción',
    newIncome: 'Nuevo Ingreso',
    newExpense: 'Nuevo Gasto',
    newTransfer: 'Nueva Transferencia',
    editTransaction: 'Editar Transacción',
  );
}
