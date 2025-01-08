// lib/core/l10n/translations.dart
class Translations {
  final String welcome;
  final String selectLanguage;
  final String continue_;
  final String signIn;
  final String signUp;
  final String signInWithEmail;
  final String signInWithGoogle;
  final String email;
  final String password;
  final String emailRequired;
  final String invalidEmail;
  final String passwordRequired;
  final String passwordTooShort;
  final String forgotPassword;
  final String alreadyHaveAccount;
  final String dontHaveAccount;
  final String settings;
  final String darkMode;
  final String darkModeDescription;
  final String language;
  final String availableBalance;
  final String selectCategory;
  final String selectAccount;
  final String selectContact;
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
  final String importContacts;
  final String contactsPermissionDenied;

  const Translations({
    required this.welcome,
    required this.selectLanguage,
    required this.continue_,
    required this.signIn,
    required this.signUp,
    required this.signInWithEmail,
    required this.signInWithGoogle,
    required this.email,
    required this.password,
    required this.emailRequired,
    required this.invalidEmail,
    required this.passwordRequired,
    required this.passwordTooShort,
    required this.forgotPassword,
    required this.alreadyHaveAccount,
    required this.dontHaveAccount,
    required this.settings,
    required this.darkMode,
    required this.darkModeDescription,
    required this.language,
    required this.availableBalance,
    required this.selectCategory,
    required this.selectAccount,
    required this.selectContact,
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
    required this.importContacts,
    required this.contactsPermissionDenied,
  });

  String contactsImportedMessage(int count) {
    switch (languageCode) {
      case 'es':
        return '$count contactos importados exitosamente';
      default:
        return '$count contacts imported successfully';
    }
  }

  String get languageCode => 'en';

  // English translations
  static const en = Translations(
    welcome: 'Welcome to MoneyT',
    selectLanguage: 'Select your language',
    continue_: 'Continue',
    signIn: 'Sign In',
    signUp: 'Sign Up',
    signInWithEmail: 'Sign in with Email',
    signInWithGoogle: 'Sign in with Google',
    email: 'Email',
    password: 'Password',
    emailRequired: 'Email is required',
    invalidEmail: 'Please enter a valid email',
    passwordRequired: 'Password is required',
    passwordTooShort: 'Password must be at least 6 characters',
    forgotPassword: 'Forgot Password?',
    alreadyHaveAccount: 'Already have an account? Sign in',
    dontHaveAccount: 'Don\'t have an account? Sign up',
    settings: 'Settings',
    darkMode: 'Dark Mode',
    darkModeDescription: 'Switch between light and dark theme',
    language: 'Language',
    availableBalance: 'Available Balance',
    selectCategory: 'Select Category',
    selectAccount: 'Select Account',
    selectContact: 'Select Contact',
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
    importContacts: 'Import Contacts',
    contactsPermissionDenied: 'Permission to access contacts is required',
  );

  // Spanish translations
  static const es = _SpanishTranslations(
    welcome: 'Bienvenido a MoneyT',
    selectLanguage: 'Selecciona tu idioma',
    continue_: 'Continuar',
    signIn: 'Iniciar Sesión',
    signUp: 'Registrarse',
    signInWithEmail: 'Iniciar sesión con Email',
    signInWithGoogle: 'Iniciar sesión con Google',
    email: 'Correo electrónico',
    password: 'Contraseña',
    emailRequired: 'El correo electrónico es requerido',
    invalidEmail: 'Por favor ingrese un correo válido',
    passwordRequired: 'La contraseña es requerida',
    passwordTooShort: 'La contraseña debe tener al menos 6 caracteres',
    forgotPassword: '¿Olvidaste tu contraseña?',
    alreadyHaveAccount: '¿Ya tienes una cuenta? Inicia sesión',
    dontHaveAccount: '¿No tienes una cuenta? Regístrate',
    settings: 'Configuración',
    darkMode: 'Modo Oscuro',
    darkModeDescription: 'Cambiar entre tema claro y oscuro',
    language: 'Idioma',
    availableBalance: 'Saldo Disponible',
    selectCategory: 'Seleccionar Categoría',
    selectAccount: 'Seleccionar Cuenta',
    selectContact: 'Seleccionar Contacto',
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
    importContacts: 'Importar Contactos',
    contactsPermissionDenied: 'Se requiere permiso para acceder a los contactos',
  );
}

class _SpanishTranslations extends Translations {
  const _SpanishTranslations({
    required super.welcome,
    required super.selectLanguage,
    required super.continue_,
    required super.signIn,
    required super.signUp,
    required super.signInWithEmail,
    required super.signInWithGoogle,
    required super.email,
    required super.password,
    required super.emailRequired,
    required super.invalidEmail,
    required super.passwordRequired,
    required super.passwordTooShort,
    required super.forgotPassword,
    required super.alreadyHaveAccount,
    required super.dontHaveAccount,
    required super.settings,
    required super.darkMode,
    required super.darkModeDescription,
    required super.language,
    required super.availableBalance,
    required super.selectCategory,
    required super.selectAccount,
    required super.selectContact,
    required super.category,
    required super.account,
    required super.toAccount,
    required super.amount,
    required super.invalidAmount,
    required super.details,
    required super.additionalInformation,
    required super.date,
    required super.contact,
    required super.description,
    required super.reference,
    required super.create,
    required super.update,
    required super.unknown,
    required super.newTransaction,
    required super.newIncome,
    required super.newExpense,
    required super.newTransfer,
    required super.editTransaction,
    required super.importContacts,
    required super.contactsPermissionDenied,
  });

  @override
  String get languageCode => 'es';
}
