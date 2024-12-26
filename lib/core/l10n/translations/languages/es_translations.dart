import '../base_translations.dart';

class SpanishTranslations extends BaseTranslations {
  @override
  String get languageCode => 'es';

  // App general
  @override
  String get appName => 'MoneyT';
  @override
  String get welcome => 'Bienvenido';
  @override
  String get welcomeTitle => 'Bienvenido a MoneyT';
  @override
  String get selectLanguage => 'Selecciona tu idioma';
  @override
  String get continue_ => 'Continuar';
  @override
  String get cancel => 'Cancelar';
  @override
  String get save => 'Guardar';
  @override
  String get delete => 'Eliminar';
  @override
  String get edit => 'Editar';
  @override
  String get add => 'Agregar';
  @override
  String get error => 'Error';
  @override
  String get noDescription => 'Sin descripción';
  @override
  String get unknown => 'Desconocido';

  // Login
  @override
  String get signInWithGoogle => 'Iniciar sesión con Google';
  @override
  String get skipSignIn => 'Omitir inicio de sesión';
  @override
  String get termsAndConditions => 'Términos y Condiciones';
  @override
  String get acceptTerms => 'Acepto los Términos y Condiciones';
  @override
  String get acceptTermsAndConditions => 'Acepto los Términos y Condiciones';
  @override
  String get acceptMarketing => 'Me gustaría recibir correos de marketing';
  @override
  String get termsText => '''
Al usar esta aplicación, aceptas nuestros Términos de Servicio y Política de Privacidad.

1. Tus datos serán almacenados de forma segura
2. Nunca compartiremos tus datos con terceros
3. Puedes solicitar la eliminación de tus datos en cualquier momento
''';
  @override
  String get readTerms => 'Leer Términos y Condiciones';

  // Navigation
  @override
  String get home => 'Inicio';
  @override
  String get accounts => 'Cuentas';
  @override
  String get categories => 'Categorías';
  @override
  String get transactions => 'Transacciones';
  @override
  String get settings => 'Configuración';

  // Account related
  @override
  String get account => 'Cuenta';
  @override
  String get accountName => 'Nombre de la cuenta';
  @override
  String get accountDescription => 'Descripción de la cuenta';
  @override
  String get balance => 'Saldo';
  @override
  String get newAccount => 'Nueva cuenta';
  @override
  String get editAccount => 'Editar cuenta';
  @override
  String get deleteAccount => 'Eliminar cuenta';
  @override
  String get deleteAccountConfirmation => '¿Estás seguro de que deseas eliminar esta cuenta?';

  // Category related
  @override
  String get category => 'Categoría';
  @override
  String get categoryName => 'Nombre de la categoría';
  @override
  String get categoryDescription => 'Descripción de la categoría';
  @override
  String get categoryType => 'Tipo de categoría';
  @override
  String get newCategory => 'Nueva categoría';
  @override
  String get editCategory => 'Editar categoría';
  @override
  String get deleteCategory => 'Eliminar categoría';
  @override
  String get deleteCategoryConfirmation => '¿Estás seguro de que deseas eliminar esta categoría?';
  @override
  String get income => 'Ingreso';
  @override
  String get expense => 'Gasto';

  // Transaction related
  @override
  String get transaction => 'Transacción';
  @override
  String get amount => 'Monto';
  @override
  String get date => 'Fecha';
  @override
  String get description => 'Descripción';
  @override
  String get reference => 'Referencia';
  @override
  String get newTransaction => 'Nueva transacción';
  @override
  String get editTransaction => 'Editar transacción';
  @override
  String get deleteTransaction => 'Eliminar transacción';
  @override
  String get deleteTransactionConfirmation => '¿Estás seguro de que deseas eliminar esta transacción?';
  @override
  String get transfer => 'Transferencia';
  @override
  String get from => 'Desde';
  @override
  String get to => 'Hacia';

  // Validation messages
  @override
  String get fieldRequired => 'Este campo es requerido';
  @override
  String get invalidAmount => 'Monto inválido';
  @override
  String get selectCategory => 'Selecciona una categoría';
  @override
  String get selectAccount => 'Selecciona una cuenta';

  // Dynamic text retrieval
  final Map<String, String> _translations = {
    'darkTheme': 'Modo Oscuro',
    'darkThemeDescription': 'Cambiar entre tema claro y oscuro',
    'version': 'Versión 0.1.0',
    'recentTransactions': 'Transacciones Recientes',
    'viewAll': 'Ver todas',
    'noRecentTransactions': 'No hay transacciones recientes',
    'noDescription': 'Sin descripción',
    'sortDateAsc': 'Fecha ↑',
    'sortDateDesc': 'Fecha ↓',
    'sortAmountAsc': 'Monto ↑',
    'sortAmountDesc': 'Monto ↓',
    'all': 'Todas',
    'filters': 'Filtros',
    'apply': 'Aplicar',
    'noTransactions': 'No hay transacciones',
    'error': 'Error',
    'noAccounts': 'No hay cuentas',
    'noCategories': 'No hay categorías',
    'settings': 'Configuración',
    'language': 'Idioma',
    'deleteAccount': 'Eliminar cuenta',
    'deleteAccountConfirmation': '¿Estás seguro de que deseas eliminar esta cuenta?',
    'cancel': 'Cancelar',
    'delete': 'Eliminar',
    'edit': 'Editar',
    'unknown': 'Desconocido',
    'signInWithGoogle': 'Iniciar sesión con Google',
    'skipSignIn': 'Omitir inicio de sesión',
    'termsAndConditions': 'Términos y Condiciones',
    'acceptTerms': 'Acepto los Términos y Condiciones',
    'acceptMarketing': 'Me gustaría recibir correos de marketing',
    'termsText': 'Al usar esta aplicación, aceptas nuestros Términos de Servicio y Política de Privacidad...',
    'welcomeTitle': 'Bienvenido a MoneyT',
    'readTerms': 'Leer Términos y Condiciones',
  };

  @override
  String get noAccounts => getText('noAccounts');

  @override
  String get noCategories => getText('noCategories');

  @override
  String get noTransactions => getText('noTransactions');

  @override
  String get recentTransactions => getText('recentTransactions');

  @override
  String get viewAll => getText('viewAll');

  @override
  String get noRecentTransactions => getText('noRecentTransactions');

  @override
  String get sortDateAsc => getText('sortDateAsc');

  @override
  String get sortDateDesc => getText('sortDateDesc');

  @override
  String get sortAmountAsc => getText('sortAmountAsc');

  @override
  String get sortAmountDesc => getText('sortAmountDesc');

  @override
  String get all => getText('all');

  @override
  String get filters => getText('filters');

  @override
  String get apply => getText('apply');

  @override
  String get darkTheme => getText('darkTheme');

  @override
  String get darkThemeDescription => getText('darkThemeDescription');

  @override
  String getText(String key) {
    return _translations[key] ?? key;
  }
}
