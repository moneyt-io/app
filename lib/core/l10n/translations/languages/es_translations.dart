import '../base_translations.dart';

class EsTranslations extends BaseTranslations {
  @override
  String get languageCode => 'es';

  // App general
  @override
  String get appName => 'MoneyT';

  @override
  String get welcome => 'Bienvenido';

  @override
  String get welcomeTitle => 'Gestiona tus finanzas con facilidad';

  @override
  String get selectLanguage => 'Seleccionar idioma';

  @override
  String get continue_ => 'Continuar';

  @override
  String get save => 'Guardar';

  @override
  String get add => 'Agregar';

  @override
  String get error => 'Error';

  @override
  String get noDescription => 'Sin descripción';

  @override
  String get unknown => 'Desconocido';

  // Navigation
  @override
  String get home => 'Inicio';

  @override
  String get accounts => 'Cuentas';

  @override
  String get categories => 'Categorías';

  @override
  String get transactions => 'Transacciones';

  // Account related
  @override
  String get account => 'Cuenta';

  @override
  String get accountName => 'Nombre de la cuenta';

  @override
  String get accountDescription => 'Descripción de la cuenta';

  @override
  String get balance => 'Balance';

  @override
  String get availableBalance => 'Saldo Disponible';

  @override
  String get newAccount => 'Nueva cuenta';

  @override
  String get editAccount => 'Editar cuenta';

  @override
  String get deleteAccount => 'Eliminar cuenta';

  @override
  String get deleteAccountConfirmation => '¿Está seguro que desea eliminar esta cuenta?';

  @override
  String get accountDeleted => 'Cuenta eliminada exitosamente';

  @override
  String get noAccounts => 'No se encontraron cuentas';

  // Category related
  @override
  String get category => 'Categoría';

  @override
  String get categoryName => 'Nombre de la categoría';

  @override
  String get categoryDescription => 'Descripción de la categoría';

  @override
  String get newCategory => 'Nueva categoría';

  @override
  String get editCategory => 'Editar categoría';

  @override
  String get deleteCategory => 'Eliminar categoría';

  @override
  String get deleteCategoryConfirmation => '¿Está seguro que desea eliminar esta categoría?';

  @override
  String get categoryDeleted => 'Categoría eliminada exitosamente';

  @override
  String get noCategories => 'No se encontraron categorías';

  @override
  String get basicInformation => 'Información básica';

  @override
  String get categoryHierarchy => 'Jerarquía de categoría';

  @override
  String get mainCategory => 'Categoría principal';

  @override
  String get mainCategoryDescription => 'Una categoría principal que puede contener subcategorías';

  @override
  String get subcategory => 'Subcategoría';

  @override
  String get subcategoryDescription => 'Una subcategoría que pertenece a una categoría principal';

  @override
  String get parentCategory => 'Categoría padre';

  @override
  String get selectParentCategory => 'Seleccione una categoría padre';

  @override
  String get categoryType => 'Tipo de categoría';

  @override
  String noMainCategoriesAvailable(String type) => 'No hay categorías principales de $type disponibles';

  @override
  String get errorLoadingCategories => 'Error al cargar las categorías';

  // Transaction related
  @override
  String get transaction => 'Transacción';

  @override
  String get newTransaction => 'Nueva transacción';

  @override
  String get editTransaction => 'Editar transacción';

  @override
  String get deleteTransaction => 'Eliminar transacción';

  @override
  String get deleteTransactionConfirmation => '¿Estás seguro de que deseas eliminar esta transacción?';

  @override
  String get noTransactions => 'No se encontraron transacciones';

  @override
  String get amount => 'Monto';

  @override
  String get date => 'Fecha';

  @override
  String get description => 'Descripción';

  @override
  String get reference => 'Referencia';

  @override
  String get contact => 'Contacto';

  @override
  String get details => 'Detalles';

  @override
  String get additionalInformation => 'Información adicional';

  @override
  String get toAccount => 'A la cuenta';

  @override
  String get income => 'Ingreso';

  @override
  String get expense => 'Gasto';

  @override
  String get transfer => 'Transferencia';

  @override
  String get newExpense => 'Nuevo gasto';

  @override
  String get newIncome => 'Nuevo ingreso';

  @override
  String get newTransfer => 'Nueva transferencia';

  @override
  String get invalidAmount => 'Monto inválido';

  @override
  String get selectAccount => 'Seleccionar Cuenta';

  @override
  String get selectCategory => 'Seleccionar Categoría';

  // Filter related
  String get filter => 'Filtro';

  @override
  String get filterAll => 'Todos';

  @override
  String get filterIncome => 'Ingresos';

  @override
  String get filterExpense => 'Gastos';

  @override
  String get filterTransfer => 'Transferencias';

  @override
  String get all => 'Todo';

  @override
  String get apply => 'Aplicar';

  @override
  String get filters => 'Filtros';

  @override
  String get from => 'Desde';

  @override
  String get to => 'Hasta';

  // Settings related
  @override
  String get settings => 'Configuración';

  @override
  String get appearance => 'Apariencia';

  @override
  String get about => 'Acerca de';

  @override
  String get language => 'Idioma';

  @override
  String get english => 'Inglés';

  @override
  String get spanish => 'Español';

  @override
  String get darkTheme => 'Tema oscuro';

  @override
  String get darkThemeDescription => 'Activar modo oscuro para una mejor experiencia nocturna';

  // Form Fields and Sections
  @override
  String get name => 'Nombre';

  @override
  String get nameRequired => 'El nombre es requerido';

  @override
  String get mainCategoryRequired => 'Por favor seleccione una categoría principal';

  @override
  String get incomeDescription => 'Dinero que ingresa a tus cuentas';

  @override
  String get expenseDescription => 'Dinero que sale de tus cuentas';

  @override
  String get create => 'Crear';

  @override
  String get update => 'Actualizar';

  @override
  String get fieldRequired => 'Este campo es requerido';

  @override
  String get required => 'Este campo es requerido';

  // Menu sections
  @override
  String get main => 'Principal';

  @override
  String get management => 'Gestión';

  @override
  String get preferences => 'Preferencias';

  // Stats and Balance
  @override
  String get totalBalance => 'Balance total';

  @override
  String get monthlyStats => 'Estadísticas mensuales';

  @override
  String get expenses => 'Gastos';

  @override
  String get monthlyBalance => 'Balance mensual';

  @override
  String get recentTransactions => 'Transacciones recientes';

  @override
  String get viewAll => 'Ver todo';

  @override
  String get noRecentTransactions => 'No hay transacciones recientes';

  @override
  String get share => 'Compartir';

  @override
  String get deleteConfirmation => 'Confirmar eliminación';

  @override
  String get sortDateAsc => 'Fecha ↑';

  @override
  String get sortDateDesc => 'Fecha ↓';

  @override
  String get sortAmountAsc => 'Monto ↑';

  @override
  String get sortAmountDesc => 'Monto ↓';

  // Contact related
  @override
  String get contacts => 'Contactos';

  @override
  String get newContact => 'Nuevo Contacto';

  @override
  String get editContact => 'Editar Contacto';

  @override
  String get deleteContact => 'Eliminar Contacto';

  @override
  String get deleteContactTitle => 'Eliminar Contacto';

  @override
  String deleteContactMessage(String name) => '¿Estás seguro de que deseas eliminar a $name?';

  @override
  String get contactDeleted => 'Contacto eliminado exitosamente';

  @override
  String get noContactsMessage => '¡No hay contactos aún. ¡Añade tu primer contacto!';

  @override
  String get searchContacts => 'Buscar contactos...';

  @override
  String get allContacts => 'Todos';

  @override
  String get addContact => 'Añadir Contacto';

  @override
  String get contactName => 'Nombre';

  @override
  String get contactEmail => 'Correo electrónico';

  @override
  String get contactPhone => 'Teléfono';

  @override
  String get contactNotes => 'Notas';

  @override
  String get contactSaved => 'Contacto guardado exitosamente';

  @override
  String get contactNameRequired => 'El nombre del contacto es requerido';

  @override
  String get contactInformation => 'Información del Contacto';

  @override
  String getText(String key) => key;
}
