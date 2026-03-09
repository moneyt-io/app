///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class AppStringsEs extends AppStrings {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	AppStringsEs({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, AppStrings>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.es,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <es>.
	@override final TranslationMetadata<AppLocale, AppStrings> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final AppStringsEs _root = this; // ignore: unused_field

	@override 
	AppStringsEs $copyWith({TranslationMetadata<AppLocale, AppStrings>? meta}) => AppStringsEs(meta: meta ?? this.$meta);

	// Translations
	@override late final _AppStringsAppEs app = _AppStringsAppEs._(_root);
	@override late final _AppStringsCommonEs common = _AppStringsCommonEs._(_root);
	@override late final _AppStringsComponentsEs components = _AppStringsComponentsEs._(_root);
	@override late final _AppStringsNavigationEs navigation = _AppStringsNavigationEs._(_root);
	@override late final _AppStringsTransactionsEs transactions = _AppStringsTransactionsEs._(_root);
	@override late final _AppStringsContactsEs contacts = _AppStringsContactsEs._(_root);
	@override late final _AppStringsErrorsEs errors = _AppStringsErrorsEs._(_root);
	@override late final _AppStringsSettingsEs settings = _AppStringsSettingsEs._(_root);
	@override late final _AppStringsOnboardingEs onboarding = _AppStringsOnboardingEs._(_root);
	@override late final _AppStringsDashboardEs dashboard = _AppStringsDashboardEs._(_root);
	@override late final _AppStringsWalletsEs wallets = _AppStringsWalletsEs._(_root);
	@override late final _AppStringsLoansEs loans = _AppStringsLoansEs._(_root);
	@override late final _AppStringsCategoriesEs categories = _AppStringsCategoriesEs._(_root);
	@override late final _AppStringsBackupsEs backups = _AppStringsBackupsEs._(_root);
}

// Path: app
class _AppStringsAppEs extends AppStringsAppEn {
	_AppStringsAppEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get name => 'MoneyT';
	@override String get description => 'Gestor Financiero';
}

// Path: common
class _AppStringsCommonEs extends AppStringsCommonEn {
	_AppStringsCommonEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get save => 'Guardar';
	@override String get cancel => 'Cancelar';
	@override String get delete => 'Eliminar';
	@override String get edit => 'Editar';
	@override String get loading => 'Cargando...';
	@override String get error => 'Error';
	@override String get success => 'Éxito';
	@override String get search => 'Buscar';
	@override String get clearSearch => 'Limpiar búsqueda';
	@override String get viewAll => 'Ver todo';
	@override String get retry => 'Reintentar';
	@override String get add => 'Agregar';
	@override String get remove => 'Quitar';
	@override String get moreOptions => 'Más opciones';
	@override String get addToFavorites => 'Agregar a favoritos';
	@override String get removeFromFavorites => 'Eliminar de favoritos';
	@override String get today => 'Hoy';
	@override String get yesterday => 'Ayer';
}

// Path: components
class _AppStringsComponentsEs extends AppStringsComponentsEn {
	_AppStringsComponentsEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override late final _AppStringsComponentsDateSelectionEs dateSelection = _AppStringsComponentsDateSelectionEs._(_root);
	@override late final _AppStringsComponentsSelectionEs selection = _AppStringsComponentsSelectionEs._(_root);
	@override late final _AppStringsComponentsContactSelectionEs contactSelection = _AppStringsComponentsContactSelectionEs._(_root);
	@override late final _AppStringsComponentsCategorySelectionEs categorySelection = _AppStringsComponentsCategorySelectionEs._(_root);
	@override late final _AppStringsComponentsCurrencySelectionEs currencySelection = _AppStringsComponentsCurrencySelectionEs._(_root);
	@override late final _AppStringsComponentsAccountSelectionEs accountSelection = _AppStringsComponentsAccountSelectionEs._(_root);
	@override late final _AppStringsComponentsParentWalletSelectionEs parentWalletSelection = _AppStringsComponentsParentWalletSelectionEs._(_root);
	@override late final _AppStringsComponentsWalletTypesEs walletTypes = _AppStringsComponentsWalletTypesEs._(_root);
}

// Path: navigation
class _AppStringsNavigationEs extends AppStringsNavigationEn {
	_AppStringsNavigationEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get home => 'Inicio';
	@override String get transactions => 'Transacciones';
	@override String get contacts => 'Contactos';
	@override String get settings => 'Configuración';
	@override String get wallets => 'Cuentas';
	@override String get categories => 'Categorías';
	@override String get loans => 'Préstamos';
	@override String get charts => 'Plan de Cuentas';
	@override String get backups => 'Respaldos';
	@override String get creditCards => 'Tarjetas de Crédito';
	@override late final _AppStringsNavigationSectionsEs sections = _AppStringsNavigationSectionsEs._(_root);
}

// Path: transactions
class _AppStringsTransactionsEs extends AppStringsTransactionsEn {
	_AppStringsTransactionsEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Transacciones';
	@override late final _AppStringsTransactionsTypesEs types = _AppStringsTransactionsTypesEs._(_root);
	@override late final _AppStringsTransactionsFilterEs filter = _AppStringsTransactionsFilterEs._(_root);
	@override late final _AppStringsTransactionsFormEs form = _AppStringsTransactionsFormEs._(_root);
	@override late final _AppStringsTransactionsErrorsEs errors = _AppStringsTransactionsErrorsEs._(_root);
	@override late final _AppStringsTransactionsEmptyEs empty = _AppStringsTransactionsEmptyEs._(_root);
	@override late final _AppStringsTransactionsListEs list = _AppStringsTransactionsListEs._(_root);
	@override late final _AppStringsTransactionsDetailEs detail = _AppStringsTransactionsDetailEs._(_root);
	@override late final _AppStringsTransactionsShareEs share = _AppStringsTransactionsShareEs._(_root);
}

// Path: contacts
class _AppStringsContactsEs extends AppStringsContactsEn {
	_AppStringsContactsEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Contactos';
	@override String get addContact => 'Agregar Contacto';
	@override String get editContact => 'Editar Contacto';
	@override String get newContact => 'Nuevo contacto';
	@override String get noContacts => 'No hay contactos';
	@override String get noContactsMessage => 'Agrega tu primer contacto con el botón "+"';
	@override String get searchContacts => 'Buscar contactos';
	@override String get deleteContact => 'Eliminar contacto';
	@override String get confirmDelete => '¿Estás seguro de eliminar';
	@override String get contactDeleted => 'Contacto eliminado exitosamente';
	@override String get errorDeleting => 'Error al eliminar contacto';
	@override String get noSearchResults => 'Sin resultados';
	@override String noContactsMatch({required Object query}) => 'No hay contactos que coincidan con "${query}". Intenta con otro término.';
	@override String get errorLoading => 'Error al cargar contactos';
	@override String get contactSaved => 'Contacto guardado exitosamente';
	@override String get errorSaving => 'Error al guardar contacto';
	@override String get noContactInfo => 'Sin información de contacto';
	@override String get importContact => 'Importar contacto';
	@override String get importContacts => 'Importar contactos';
	@override String get importContactSoon => 'Función de importar contacto próximamente';
	@override late final _AppStringsContactsFieldsEs fields = _AppStringsContactsFieldsEs._(_root);
	@override late final _AppStringsContactsPlaceholdersEs placeholders = _AppStringsContactsPlaceholdersEs._(_root);
	@override late final _AppStringsContactsValidationEs validation = _AppStringsContactsValidationEs._(_root);
}

// Path: errors
class _AppStringsErrorsEs extends AppStringsErrorsEn {
	_AppStringsErrorsEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String loadingAccounts({required Object error}) => 'Error al cargar las cuentas: ${error}';
	@override String get unexpected => 'Error inesperado';
}

// Path: settings
class _AppStringsSettingsEs extends AppStringsSettingsEn {
	_AppStringsSettingsEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Configuración';
	@override late final _AppStringsSettingsAccountEs account = _AppStringsSettingsAccountEs._(_root);
	@override late final _AppStringsSettingsAppearanceEs appearance = _AppStringsSettingsAppearanceEs._(_root);
	@override late final _AppStringsSettingsDataEs data = _AppStringsSettingsDataEs._(_root);
	@override late final _AppStringsSettingsInfoEs info = _AppStringsSettingsInfoEs._(_root);
	@override late final _AppStringsSettingsLogoutEs logout = _AppStringsSettingsLogoutEs._(_root);
	@override late final _AppStringsSettingsSocialEs social = _AppStringsSettingsSocialEs._(_root);
	@override late final _AppStringsSettingsLanguageEs language = _AppStringsSettingsLanguageEs._(_root);
	@override late final _AppStringsSettingsMessagesEs messages = _AppStringsSettingsMessagesEs._(_root);
}

// Path: onboarding
class _AppStringsOnboardingEs extends AppStringsOnboardingEn {
	_AppStringsOnboardingEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override late final _AppStringsOnboardingWelcomeEs welcome = _AppStringsOnboardingWelcomeEs._(_root);
	@override late final _AppStringsOnboardingProblemStatementEs problemStatement = _AppStringsOnboardingProblemStatementEs._(_root);
	@override late final _AppStringsOnboardingSpecificProblemEs specificProblem = _AppStringsOnboardingSpecificProblemEs._(_root);
	@override late final _AppStringsOnboardingPersonalGoalEs personalGoal = _AppStringsOnboardingPersonalGoalEs._(_root);
	@override late final _AppStringsOnboardingSolutionPreviewEs solutionPreview = _AppStringsOnboardingSolutionPreviewEs._(_root);
	@override late final _AppStringsOnboardingCurrentMethodEs currentMethod = _AppStringsOnboardingCurrentMethodEs._(_root);
	@override late final _AppStringsOnboardingFeaturesShowcaseEs featuresShowcase = _AppStringsOnboardingFeaturesShowcaseEs._(_root);
	@override late final _AppStringsOnboardingCompleteEs complete = _AppStringsOnboardingCompleteEs._(_root);
	@override late final _AppStringsOnboardingButtonsEs buttons = _AppStringsOnboardingButtonsEs._(_root);
}

// Path: dashboard
class _AppStringsDashboardEs extends AppStringsDashboardEn {
	_AppStringsDashboardEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get greeting => 'Bienvenido a MoneyT';
	@override late final _AppStringsDashboardBalanceEs balance = _AppStringsDashboardBalanceEs._(_root);
	@override late final _AppStringsDashboardActionsEs actions = _AppStringsDashboardActionsEs._(_root);
	@override late final _AppStringsDashboardWalletsEs wallets = _AppStringsDashboardWalletsEs._(_root);
	@override late final _AppStringsDashboardTransactionsEs transactions = _AppStringsDashboardTransactionsEs._(_root);
	@override String get customize => 'Personalizar';
	@override late final _AppStringsDashboardWidgetsEs widgets = _AppStringsDashboardWidgetsEs._(_root);
}

// Path: wallets
class _AppStringsWalletsEs extends AppStringsWalletsEn {
	_AppStringsWalletsEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Billeteras';
	@override late final _AppStringsWalletsEmptyEs empty = _AppStringsWalletsEmptyEs._(_root);
	@override late final _AppStringsWalletsEmptyArchivedEs emptyArchived = _AppStringsWalletsEmptyArchivedEs._(_root);
	@override late final _AppStringsWalletsFilterEs filter = _AppStringsWalletsFilterEs._(_root);
	@override late final _AppStringsWalletsFormEs form = _AppStringsWalletsFormEs._(_root);
	@override late final _AppStringsWalletsDeleteEs delete = _AppStringsWalletsDeleteEs._(_root);
	@override late final _AppStringsWalletsErrorsEs errors = _AppStringsWalletsErrorsEs._(_root);
	@override late final _AppStringsWalletsSubtitleEs subtitle = _AppStringsWalletsSubtitleEs._(_root);
	@override late final _AppStringsWalletsOptionsEs options = _AppStringsWalletsOptionsEs._(_root);
}

// Path: loans
class _AppStringsLoansEs extends AppStringsLoansEn {
	_AppStringsLoansEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Préstamos';
	@override late final _AppStringsLoansFilterEs filter = _AppStringsLoansFilterEs._(_root);
	@override late final _AppStringsLoansSummaryEs summary = _AppStringsLoansSummaryEs._(_root);
	@override late final _AppStringsLoansCardEs card = _AppStringsLoansCardEs._(_root);
	@override late final _AppStringsLoansFormEs form = _AppStringsLoansFormEs._(_root);
	@override late final _AppStringsLoansDetailEs detail = _AppStringsLoansDetailEs._(_root);
	@override late final _AppStringsLoansShareEs share = _AppStringsLoansShareEs._(_root);
	@override late final _AppStringsLoansPaymentEs payment = _AppStringsLoansPaymentEs._(_root);
	@override late final _AppStringsLoansContactDetailEs contactDetail = _AppStringsLoansContactDetailEs._(_root);
	@override String get given => 'Préstamo otorgado';
	@override String get received => 'Préstamo recibido';
	@override late final _AppStringsLoansHistoryEs history = _AppStringsLoansHistoryEs._(_root);
	@override late final _AppStringsLoansItemEs item = _AppStringsLoansItemEs._(_root);
	@override late final _AppStringsLoansSectionEs section = _AppStringsLoansSectionEs._(_root);
	@override late final _AppStringsLoansEmptyEs empty = _AppStringsLoansEmptyEs._(_root);
}

// Path: categories
class _AppStringsCategoriesEs extends AppStringsCategoriesEn {
	_AppStringsCategoriesEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Categorías';
	@override late final _AppStringsCategoriesFormEs form = _AppStringsCategoriesFormEs._(_root);
	@override late final _AppStringsCategoriesParentSelectionEs parentSelection = _AppStringsCategoriesParentSelectionEs._(_root);
	@override String get incomeCategory => 'Categoría de ingreso';
	@override String get expenseCategory => 'Categoría de gasto';
	@override late final _AppStringsCategoriesReportEs report = _AppStringsCategoriesReportEs._(_root);
}

// Path: backups
class _AppStringsBackupsEs extends AppStringsBackupsEn {
	_AppStringsBackupsEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Copia de Seguridad';
	@override late final _AppStringsBackupsMenuEs menu = _AppStringsBackupsMenuEs._(_root);
	@override late final _AppStringsBackupsFiltersEs filters = _AppStringsBackupsFiltersEs._(_root);
	@override late final _AppStringsBackupsStatusEs status = _AppStringsBackupsStatusEs._(_root);
	@override late final _AppStringsBackupsActionsEs actions = _AppStringsBackupsActionsEs._(_root);
	@override late final _AppStringsBackupsDialogsEs dialogs = _AppStringsBackupsDialogsEs._(_root);
	@override late final _AppStringsBackupsStatsEs stats = _AppStringsBackupsStatsEs._(_root);
	@override late final _AppStringsBackupsOptionsEs options = _AppStringsBackupsOptionsEs._(_root);
	@override late final _AppStringsBackupsFormatEs format = _AppStringsBackupsFormatEs._(_root);
}

// Path: components.dateSelection
class _AppStringsComponentsDateSelectionEs extends AppStringsComponentsDateSelectionEn {
	_AppStringsComponentsDateSelectionEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Seleccionar fecha';
	@override String get subtitle => 'Elige la fecha de la transacción';
	@override String get selectedDate => 'Fecha seleccionada';
	@override String get confirm => 'Seleccionar';
}

// Path: components.selection
class _AppStringsComponentsSelectionEs extends AppStringsComponentsSelectionEn {
	_AppStringsComponentsSelectionEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Cancelar';
	@override String get confirm => 'Confirmar';
	@override String get select => 'Seleccionar';
}

// Path: components.contactSelection
class _AppStringsComponentsContactSelectionEs extends AppStringsComponentsContactSelectionEn {
	_AppStringsComponentsContactSelectionEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Seleccionar contacto';
	@override String get subtitle => 'Elige con quién es esta transacción';
	@override String get searchPlaceholder => 'Buscar contactos';
	@override String get noContact => 'Sin contacto';
	@override String get noContactDetails => 'Transacción sin contacto específico';
	@override String get allContacts => 'Todos los contactos';
	@override String get create => 'Crear nuevo contacto';
}

// Path: components.categorySelection
class _AppStringsComponentsCategorySelectionEs extends AppStringsComponentsCategorySelectionEn {
	_AppStringsComponentsCategorySelectionEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Seleccionar categoría';
	@override String get subtitle => 'Elige una categoría para esta transacción';
	@override String get searchPlaceholder => 'Buscar categorías';
}

// Path: components.currencySelection
class _AppStringsComponentsCurrencySelectionEs extends AppStringsComponentsCurrencySelectionEn {
	_AppStringsComponentsCurrencySelectionEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Seleccionar moneda';
	@override String get subtitle => 'Elige la moneda para esta cuenta';
	@override String get searchPlaceholder => 'Buscar monedas';
}

// Path: components.accountSelection
class _AppStringsComponentsAccountSelectionEs extends AppStringsComponentsAccountSelectionEn {
	_AppStringsComponentsAccountSelectionEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Seleccionar cuenta';
	@override String get subtitle => 'Elige una cuenta para esta transacción';
	@override String get searchPlaceholder => 'Buscar cuentas';
	@override String get wallets => 'Billeteras';
	@override String get creditCards => 'Tarjetas de Crédito';
	@override String get selectAccount => 'Seleccionar cuenta';
	@override String get confirm => 'Confirmar';
}

// Path: components.parentWalletSelection
class _AppStringsComponentsParentWalletSelectionEs extends AppStringsComponentsParentWalletSelectionEn {
	_AppStringsComponentsParentWalletSelectionEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Seleccionar billetera padre';
	@override String get subtitle => 'Elige una billetera padre para organizar esta cuenta';
	@override String get searchPlaceholder => 'Buscar billeteras';
	@override String get noParent => 'Sin billetera padre';
	@override String get createRoot => 'Crear como billetera principal';
	@override String get available => 'Billeteras disponibles';
}

// Path: components.walletTypes
class _AppStringsComponentsWalletTypesEs extends AppStringsComponentsWalletTypesEn {
	_AppStringsComponentsWalletTypesEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get checking => 'Corriente';
	@override String get savings => 'Ahorros';
	@override String get cash => 'Efectivo';
	@override String get creditCard => 'Tarjeta de Crédito';
}

// Path: navigation.sections
class _AppStringsNavigationSectionsEs extends AppStringsNavigationSectionsEn {
	_AppStringsNavigationSectionsEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get operations => 'OPERACIONES';
	@override String get financialTools => 'HERRAMIENTAS FINANCIERAS';
	@override String get management => 'GESTIÓN';
	@override String get advanced => 'AVANZADO';
}

// Path: transactions.types
class _AppStringsTransactionsTypesEs extends AppStringsTransactionsTypesEn {
	_AppStringsTransactionsTypesEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get all => 'Todas';
	@override String get income => 'Ingreso';
	@override String get expense => 'Gasto';
	@override String get transfer => 'Transferencia';
}

// Path: transactions.filter
class _AppStringsTransactionsFilterEs extends AppStringsTransactionsFilterEn {
	_AppStringsTransactionsFilterEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Filtrar Transacciones';
	@override String get date => 'Fecha';
	@override String get categories => 'Categorías';
	@override String get accounts => 'Cuentas';
	@override String get contacts => 'Contactos';
	@override String get amount => 'Monto';
	@override String get apply => 'Aplicar filtros';
	@override String get clear => 'Limpiar filtros';
	@override String get add => 'Agregar filtro';
	@override String get minAmount => 'Monto Mínimo';
	@override String get maxAmount => 'Monto Máximo';
	@override String get selectDate => 'Seleccionar fecha';
	@override String get selectCategory => 'Seleccionar categoría';
	@override String get selectAccount => 'Seleccionar cuenta';
	@override String get selectContact => 'Seleccionar contacto';
	@override String get quickFilters => 'Filtros rápidos';
	@override late final _AppStringsTransactionsFilterRangesEs ranges = _AppStringsTransactionsFilterRangesEs._(_root);
	@override String get customRange => 'Rango de fechas';
	@override String get startDate => 'Desde';
	@override String get endDate => 'Hasta';
	@override String get active => 'Filtros activos';
	@override late final _AppStringsTransactionsFilterSubtitlesEs subtitles = _AppStringsTransactionsFilterSubtitlesEs._(_root);
}

// Path: transactions.form
class _AppStringsTransactionsFormEs extends AppStringsTransactionsFormEn {
	_AppStringsTransactionsFormEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get newTitle => 'Nueva Transacción';
	@override String get editTitle => 'Editar Transacción';
	@override String get amount => 'Monto';
	@override String get type => 'Tipo de transacción';
	@override String get amountRequired => 'Monto requerido';
	@override String get date => 'Fecha';
	@override String get account => 'Cuenta';
	@override String get toAccount => 'Cuenta Destino';
	@override String get category => 'Categoría';
	@override String get contact => 'Contacto';
	@override String get contactOptional => 'Contacto (opcional)';
	@override String get description => 'Descripción';
	@override String get descriptionOptional => 'Descripción opcional';
	@override String get selectAccount => 'Seleccionar cuenta';
	@override String get selectDestination => 'Seleccionar destino';
	@override String get selectCategory => 'Seleccionar categoría';
	@override String get selectContact => 'Seleccionar contacto';
	@override String get saveSuccess => 'Transacción guardada exitosamente';
	@override String get updateSuccess => 'Transacción actualizada exitosamente';
	@override String get saveError => 'Error al guardar transacción';
	@override String get share => 'Compartir';
	@override String get created => 'Transacción creada exitosamente';
}

// Path: transactions.errors
class _AppStringsTransactionsErrorsEs extends AppStringsTransactionsErrorsEn {
	_AppStringsTransactionsErrorsEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get load => 'Error al cargar las transacciones';
}

// Path: transactions.empty
class _AppStringsTransactionsEmptyEs extends AppStringsTransactionsEmptyEn {
	_AppStringsTransactionsEmptyEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'No hay transacciones';
	@override String get message => 'No se encontraron transacciones con los filtros aplicados';
	@override String get clearFilters => 'Limpiar filtros';
}

// Path: transactions.list
class _AppStringsTransactionsListEs extends AppStringsTransactionsListEn {
	_AppStringsTransactionsListEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String count({required Object n}) => '${n} transacciones';
}

// Path: transactions.detail
class _AppStringsTransactionsDetailEs extends AppStringsTransactionsDetailEn {
	_AppStringsTransactionsDetailEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Detalle de Transacción';
	@override String get delete => 'Eliminar Transacción';
	@override String get deleteConfirmation => '¿Estás seguro? Esta acción no se puede deshacer.';
	@override String get deleted => 'Transacción eliminada';
	@override String get duplicate => 'Duplicar';
	@override String get duplicateNotImplemented => 'Duplicar no implementado';
	@override String get edit => 'Editar';
	@override String get errorLoad => 'Error al cargar los detalles de la transacción.';
	@override String errorPrepareEdit({required Object error}) => 'Error al preparar la edición: ${error}';
	@override String errorDelete({required Object error}) => 'Error al eliminar: ${error}';
	@override String get category => 'Categoría';
	@override String get account => 'Cuenta';
	@override String get contact => 'Contacto';
	@override String get description => 'Descripción';
	@override String get transferDetails => 'Detalles de Transferencia';
	@override String get from => 'Desde';
	@override String get to => 'Hacia';
	@override String get unknownAccount => 'Cuenta desconocida';
	@override String errorUrl({required Object url}) => 'No se pudo abrir ${url}';
	@override String get date => 'Fecha';
	@override String get time => 'Hora';
	@override String get loanLinkedWarning => 'Esta transacción está vinculada a un préstamo y gestionada automáticamente.';
}

// Path: transactions.share
class _AppStringsTransactionsShareEs extends AppStringsTransactionsShareEn {
	_AppStringsTransactionsShareEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Compartir Transacción';
	@override String get copyText => 'Copiar Texto';
	@override String get shareButton => 'Compartir';
	@override String get shareMessage => 'Aquí está mi recibo de transacción:';
	@override String get copied => '¡Detalles copiados al portapapeles!';
	@override String errorImage({required Object error}) => 'Error al compartir imagen: ${error}';
	@override String get paymentMethod => 'Método de Pago';
	@override String get receiptTitle => 'Recibo de Transacción';
	@override String get poweredBy => 'Impulsado por MoneyT • moneyt.io';
	@override String generatedOn({required Object date}) => 'Generado el ${date}';
	@override late final _AppStringsTransactionsShareReceiptEs receipt = _AppStringsTransactionsShareReceiptEs._(_root);
}

// Path: contacts.fields
class _AppStringsContactsFieldsEs extends AppStringsContactsFieldsEn {
	_AppStringsContactsFieldsEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get name => 'Nombre';
	@override String get fullName => 'Nombre completo';
	@override String get email => 'Email';
	@override String get phone => 'Teléfono';
	@override String get address => 'Dirección';
	@override String get notes => 'Notas';
}

// Path: contacts.placeholders
class _AppStringsContactsPlaceholdersEs extends AppStringsContactsPlaceholdersEn {
	_AppStringsContactsPlaceholdersEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get enterFullName => 'Ingrese el nombre completo';
	@override String get enterPhone => 'Ingrese el número de teléfono';
	@override String get enterEmail => 'Ingrese el email';
}

// Path: contacts.validation
class _AppStringsContactsValidationEs extends AppStringsContactsValidationEn {
	_AppStringsContactsValidationEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get nameRequired => 'El nombre es requerido';
	@override String get invalidEmail => 'Email no válido';
	@override String get invalidPhone => 'Teléfono no válido';
}

// Path: settings.account
class _AppStringsSettingsAccountEs extends AppStringsSettingsAccountEn {
	_AppStringsSettingsAccountEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Cuenta';
	@override String get profile => 'Perfil';
	@override String get profileSubtitle => 'Gestiona la información de tu cuenta';
}

// Path: settings.appearance
class _AppStringsSettingsAppearanceEs extends AppStringsSettingsAppearanceEn {
	_AppStringsSettingsAppearanceEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Apariencia';
	@override String get darkMode => 'Modo oscuro';
	@override String get darkModeSubtitle => 'Cambiar a tema oscuro';
	@override String get language => 'Idioma';
	@override String get darkTheme => 'Tema oscuro';
	@override String get lightTheme => 'Tema claro';
	@override String get systemTheme => 'Tema del sistema';
}

// Path: settings.data
class _AppStringsSettingsDataEs extends AppStringsSettingsDataEn {
	_AppStringsSettingsDataEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Datos y Almacenamiento';
	@override String get backup => 'Copia de seguridad';
	@override String get backupSubtitle => 'Gestiona tus copias de seguridad';
}

// Path: settings.info
class _AppStringsSettingsInfoEs extends AppStringsSettingsInfoEn {
	_AppStringsSettingsInfoEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Información';
	@override String get contact => 'Contacto y Redes';
	@override String get contactSubtitle => 'Obtén soporte y síguenos en línea';
	@override String get privacy => 'Política de privacidad';
	@override String get privacySubtitle => 'Lee nuestra política de privacidad';
	@override String get share => 'Compartir MoneyT';
	@override String get shareSubtitle => 'Cuéntale a tus amigos sobre la app';
}

// Path: settings.logout
class _AppStringsSettingsLogoutEs extends AppStringsSettingsLogoutEn {
	_AppStringsSettingsLogoutEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get button => 'Cerrar sesión';
	@override String get dialogTitle => 'Cerrar sesión';
	@override String get dialogMessage => '¿Estás seguro de que quieres cerrar sesión?';
	@override String get cancel => 'Cancelar';
	@override String get confirm => 'Cerrar sesión';
}

// Path: settings.social
class _AppStringsSettingsSocialEs extends AppStringsSettingsSocialEn {
	_AppStringsSettingsSocialEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Contacto y Redes';
	@override String get follow => 'Sigue a MoneyT';
	@override String get description => 'Mantente conectado con nosotros en redes sociales para actualizaciones y consejos.';
	@override String get networks => 'Redes Sociales';
	@override String get github => 'GitHub';
	@override String get githubSubtitle => 'Ver código fuente y contribuir';
	@override String get linkedin => 'LinkedIn';
	@override String get linkedinSubtitle => 'Actualizaciones profesionales';
	@override String get twitter => 'X (Twitter)';
	@override String get twitterSubtitle => 'Últimas noticias y anuncios';
	@override String get reddit => 'Reddit';
	@override String get redditSubtitle => 'Únete a las discusiones';
	@override String get discord => 'Discord';
	@override String get discordSubtitle => 'Chat con la comunidad';
	@override String get contact => 'Contacto';
	@override String get email => 'Soporte por Email';
	@override String get website => 'Sitio Web Oficial';
}

// Path: settings.language
class _AppStringsSettingsLanguageEs extends AppStringsSettingsLanguageEn {
	_AppStringsSettingsLanguageEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Idioma';
	@override String get available => 'IDIOMAS DISPONIBLES';
	@override String get apply => 'Aplicar Idioma';
}

// Path: settings.messages
class _AppStringsSettingsMessagesEs extends AppStringsSettingsMessagesEn {
	_AppStringsSettingsMessagesEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get profileComingSoon => 'Pantalla de perfil próximamente';
	@override String get privacyError => 'No se pudo abrir la política de privacidad';
	@override String get logoutComingSoon => 'Función de cerrar sesión próximamente';
}

// Path: onboarding.welcome
class _AppStringsOnboardingWelcomeEs extends AppStringsOnboardingWelcomeEn {
	_AppStringsOnboardingWelcomeEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Bienvenido a MoneyT 👋';
	@override String get subtitle => 'Controla tu dinero en minutos ✨';
}

// Path: onboarding.problemStatement
class _AppStringsOnboardingProblemStatementEs extends AppStringsOnboardingProblemStatementEn {
	_AppStringsOnboardingProblemStatementEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => '¿Sientes que el dinero se te escapa?';
	@override String get subtitle => 'No estás solo. El 70% de las personas no sabe en qué se va su ingreso.';
}

// Path: onboarding.specificProblem
class _AppStringsOnboardingSpecificProblemEs extends AppStringsOnboardingSpecificProblemEn {
	_AppStringsOnboardingSpecificProblemEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => '¿Qué es lo que más te cuesta?';
	@override late final _AppStringsOnboardingSpecificProblemOptionsEs options = _AppStringsOnboardingSpecificProblemOptionsEs._(_root);
}

// Path: onboarding.personalGoal
class _AppStringsOnboardingPersonalGoalEs extends AppStringsOnboardingPersonalGoalEn {
	_AppStringsOnboardingPersonalGoalEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => '¿Cuál es tu meta principal?';
	@override late final _AppStringsOnboardingPersonalGoalOptionsEs options = _AppStringsOnboardingPersonalGoalOptionsEs._(_root);
}

// Path: onboarding.solutionPreview
class _AppStringsOnboardingSolutionPreviewEs extends AppStringsOnboardingSolutionPreviewEn {
	_AppStringsOnboardingSolutionPreviewEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'MoneyT te da claridad';
	@override String get subtitle => 'Ve todas tus cuentas, deudas y gastos en un solo lugar. Sin excels, sin estrés.';
	@override late final _AppStringsOnboardingSolutionPreviewBenefitsEs benefits = _AppStringsOnboardingSolutionPreviewBenefitsEs._(_root);
}

// Path: onboarding.currentMethod
class _AppStringsOnboardingCurrentMethodEs extends AppStringsOnboardingCurrentMethodEn {
	_AppStringsOnboardingCurrentMethodEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => '¿Cómo llevas tus cuentas hoy?';
	@override String get subtitle => 'Selecciona la opción que mejor te describe.';
	@override late final _AppStringsOnboardingCurrentMethodOptionsEs options = _AppStringsOnboardingCurrentMethodOptionsEs._(_root);
}

// Path: onboarding.featuresShowcase
class _AppStringsOnboardingFeaturesShowcaseEs extends AppStringsOnboardingFeaturesShowcaseEn {
	_AppStringsOnboardingFeaturesShowcaseEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Funciones disponibles y en desarrollo ✨';
	@override String get subtitle => 'Transacciones listas para usar. Más funciones en camino.';
	@override String get available => 'DISPONIBLE AHORA';
	@override String get comingSoon => 'PRÓXIMAMENTE';
	@override late final _AppStringsOnboardingFeaturesShowcaseFeaturesEs features = _AppStringsOnboardingFeaturesShowcaseFeaturesEs._(_root);
}

// Path: onboarding.complete
class _AppStringsOnboardingCompleteEs extends AppStringsOnboardingCompleteEn {
	_AppStringsOnboardingCompleteEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => '¡Estás listo para despegar! 🚀';
	@override String get subtitle => 'Registra tu primera transacción y mira cómo sube tu probabilidad de éxito 📈';
	@override late final _AppStringsOnboardingCompleteStatsEs stats = _AppStringsOnboardingCompleteStatsEs._(_root);
}

// Path: onboarding.buttons
class _AppStringsOnboardingButtonsEs extends AppStringsOnboardingButtonsEn {
	_AppStringsOnboardingButtonsEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get start => 'Comenzar ahora 🚀';
	@override String get fixIt => 'Solucionalo hoy ⚡';
	@override String get actionContinue => 'Continuar';
	@override String get setGoal => 'Fijar mi meta 🎯';
	@override String get wantControl => '¡Quiero este control!';
	@override String get great => '¡Genial, vamos a verlo!';
	@override String get firstTransaction => 'Registrar mi primera transacción ➕';
	@override String get skip => 'Saltar';
}

// Path: dashboard.balance
class _AppStringsDashboardBalanceEs extends AppStringsDashboardBalanceEn {
	_AppStringsDashboardBalanceEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get total => 'Balance Total';
	@override String get income => 'INGRESOS';
	@override String get expenses => 'GASTOS';
	@override String get thisMonth => 'este mes';
}

// Path: dashboard.actions
class _AppStringsDashboardActionsEs extends AppStringsDashboardActionsEn {
	_AppStringsDashboardActionsEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get income => 'Ingreso';
	@override String get expense => 'Gasto';
	@override String get transfer => 'Transferencia';
	@override String get all => 'Ver todos';
}

// Path: dashboard.wallets
class _AppStringsDashboardWalletsEs extends AppStringsDashboardWalletsEn {
	_AppStringsDashboardWalletsEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Cuentas';
	@override String count({required Object n}) => '${n} cuentas';
	@override String more({required Object n}) => '+${n} cuentas más';
	@override String viewDetails({required Object name}) => 'Ver detalles de ${name}';
}

// Path: dashboard.transactions
class _AppStringsDashboardTransactionsEs extends AppStringsDashboardTransactionsEn {
	_AppStringsDashboardTransactionsEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Transacciones Recientes';
	@override String get subtitle => 'Últimas 5 transacciones';
	@override String get empty => 'No hay transacciones recientes';
	@override String get emptySubtitle => 'Tus transacciones aparecerán aquí';
	@override String more({required Object n}) => '+${n} transacciones más';
}

// Path: dashboard.widgets
class _AppStringsDashboardWidgetsEs extends AppStringsDashboardWidgetsEn {
	_AppStringsDashboardWidgetsEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override late final _AppStringsDashboardWidgetsBalanceEs balance = _AppStringsDashboardWidgetsBalanceEs._(_root);
	@override late final _AppStringsDashboardWidgetsQuickActionsEs quickActions = _AppStringsDashboardWidgetsQuickActionsEs._(_root);
	@override late final _AppStringsDashboardWidgetsWalletsEs wallets = _AppStringsDashboardWidgetsWalletsEs._(_root);
	@override late final _AppStringsDashboardWidgetsLoansEs loans = _AppStringsDashboardWidgetsLoansEs._(_root);
	@override late final _AppStringsDashboardWidgetsTransactionsEs transactions = _AppStringsDashboardWidgetsTransactionsEs._(_root);
	@override late final _AppStringsDashboardWidgetsCategoryBreakdownEs categoryBreakdown = _AppStringsDashboardWidgetsCategoryBreakdownEs._(_root);
	@override late final _AppStringsDashboardWidgetsChartAccountsEs chartAccounts = _AppStringsDashboardWidgetsChartAccountsEs._(_root);
	@override late final _AppStringsDashboardWidgetsCreditCardsEs creditCards = _AppStringsDashboardWidgetsCreditCardsEs._(_root);
	@override late final _AppStringsDashboardWidgetsSettingsEs settings = _AppStringsDashboardWidgetsSettingsEs._(_root);
}

// Path: wallets.empty
class _AppStringsWalletsEmptyEs extends AppStringsWalletsEmptyEn {
	_AppStringsWalletsEmptyEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'No hay billeteras';
	@override String get message => 'Añade tu primera billetera para comenzar a rastrear tus finanzas.';
	@override String get action => 'Crear Billetera';
}

// Path: wallets.emptyArchived
class _AppStringsWalletsEmptyArchivedEs extends AppStringsWalletsEmptyArchivedEn {
	_AppStringsWalletsEmptyArchivedEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'No hay billeteras archivadas';
	@override String get message => 'Las billeteras archivadas aparecerán aquí.';
}

// Path: wallets.filter
class _AppStringsWalletsFilterEs extends AppStringsWalletsFilterEn {
	_AppStringsWalletsFilterEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get active => 'Activas';
	@override String get archived => 'Archivadas';
	@override String get all => 'Todas';
}

// Path: wallets.form
class _AppStringsWalletsFormEs extends AppStringsWalletsFormEn {
	_AppStringsWalletsFormEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get newTitle => 'Nueva billetera';
	@override String get editTitle => 'Editar billetera';
	@override String get name => 'Nombre de billetera';
	@override String get namePlaceholder => 'Ingresa el nombre de la billetera';
	@override String get nameRequired => 'El nombre es requerido';
	@override String get description => 'Descripción';
	@override String get descriptionPlaceholder => 'Descripción opcional para esta billetera';
	@override String get currency => 'Moneda';
	@override String get parent => 'Billetera padre (opcional)';
	@override String get parentEmpty => 'No hay billeteras disponibles como padre';
	@override String get chartAccount => 'Cuenta contable asociada';
	@override String get chartAccountLocked => 'La cuenta contable no puede ser modificada';
	@override String get createSuccess => 'Billetera creada con éxito';
	@override String get updateSuccess => 'Billetera actualizada con éxito';
	@override String loadParentError({required Object error}) => 'Error al cargar billeteras padre: ${error}';
	@override String loadChartAccountError({required Object error}) => 'Error al cargar cuenta contable: ${error}';
}

// Path: wallets.delete
class _AppStringsWalletsDeleteEs extends AppStringsWalletsDeleteEn {
	_AppStringsWalletsDeleteEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get dialogTitle => 'Eliminar billetera';
	@override String dialogMessage({required Object name}) => '¿Estás seguro de eliminar ${name}?';
	@override String get cancel => 'Cancelar';
	@override String get confirm => 'Eliminar';
	@override String get success => 'Billetera eliminada con éxito';
	@override String error({required Object error}) => 'Error al eliminar: ${error}';
}

// Path: wallets.errors
class _AppStringsWalletsErrorsEs extends AppStringsWalletsErrorsEn {
	_AppStringsWalletsErrorsEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get load => 'Error al cargar las billeteras';
	@override String get retry => 'Reintentar';
	@override String comingSoon({required Object name}) => '${name} próximamente';
}

// Path: wallets.subtitle
class _AppStringsWalletsSubtitleEs extends AppStringsWalletsSubtitleEn {
	_AppStringsWalletsSubtitleEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get mainAccount => 'Cuenta principal';
	@override String get cashDigital => 'Efectivo y digital';
	@override String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} billetera',
		other: '${n} billeteras',
	);
	@override String get account => 'Cuenta';
	@override String get physicalCash => 'Efectivo físico';
	@override String get digitalWallet => 'Billetera digital';
}

// Path: wallets.options
class _AppStringsWalletsOptionsEs extends AppStringsWalletsOptionsEn {
	_AppStringsWalletsOptionsEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get viewTransactions => 'Ver transacciones';
	@override String get viewTransactionsSubtitle => 'Ver todas las transacciones';
	@override String get transferFunds => 'Transferir fondos';
	@override String get transferFundsSubtitle => 'Mover dinero entre billeteras';
	@override String get editWallet => 'Editar billetera';
	@override String get editWalletSubtitle => 'Modificar detalles';
	@override String get duplicateWallet => 'Duplicar billetera';
	@override String get duplicateWalletSubtitle => 'Crear copia de esta billetera';
	@override String get archiveWallet => 'Archivar billetera';
	@override String get archiveWalletSubtitle => 'Ocultar de la vista principal';
	@override String get unarchiveWallet => 'Desarchivar billetera';
	@override String get unarchiveWalletSubtitle => 'Restaurar a la vista principal';
	@override String get deleteWallet => 'Eliminar billetera';
	@override String get deleteWalletSubtitle => 'Eliminar permanentemente';
	@override String get defaultTitle => 'Billetera';
}

// Path: loans.filter
class _AppStringsLoansFilterEs extends AppStringsLoansFilterEn {
	_AppStringsLoansFilterEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get active => 'Préstamos Activos';
	@override String get history => 'Historial';
	@override String get all => 'Todos';
	@override String get pending => 'Pendientes';
	@override String get lent => 'Prestados';
	@override String get borrowed => 'Recibidos';
}

// Path: loans.summary
class _AppStringsLoansSummaryEs extends AppStringsLoansSummaryEn {
	_AppStringsLoansSummaryEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get netBalance => 'BALANCE NETO';
	@override String get activeLoans => 'PRÉSTAMOS ACTIVOS';
	@override String get noActive => 'Sin préstamos activos';
	@override String lent({required Object n}) => '${n} prestados';
	@override String borrowed({required Object n}) => '${n} recibidos';
	@override String pending({required Object n}) => '${n} pendientes';
}

// Path: loans.card
class _AppStringsLoansCardEs extends AppStringsLoansCardEn {
	_AppStringsLoansCardEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get lent => 'Has prestado';
	@override String get borrowed => 'Te han prestado';
	@override String active({required Object n}) => '${n} activos';
	@override String multiple({required Object n}) => '${n} préstamos';
	@override String transactions({required Object n}) => '${n} transacciones';
	@override String overdue({required Object n}) => 'Vencido por ${n} días';
	@override String due({required Object date}) => 'Vence ${date}';
}

// Path: loans.form
class _AppStringsLoansFormEs extends AppStringsLoansFormEn {
	_AppStringsLoansFormEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get newTitle => 'Nuevo Préstamo';
	@override String get editTitle => 'Editar Préstamo';
	@override String get type => 'Tipo de préstamo';
	@override String get lend => 'Yo presto';
	@override String get borrow => 'Me prestan';
	@override String get contact => 'Contacto';
	@override String get contactPlaceholder => 'Seleccionar contacto';
	@override String get account => 'Desde cuenta';
	@override String get accountPlaceholder => 'Seleccionar cuenta';
	@override String get amount => 'Monto';
	@override String get description => 'Descripción';
	@override String get date => 'Fecha';
	@override String get dueDate => 'Fecha límite';
	@override String get selectDate => 'Seleccionar fecha';
	@override String get optional => '(Opcional)';
	@override String get createTransaction => 'Crear registro de transacción';
	@override String get recordAutomatically => 'Registrar transacción automáticamente';
	@override String get transactionCategory => 'Categoría de transacción';
	@override String get category => 'Categoría';
	@override String get categoryPlaceholder => 'Seleccionar categoría';
	@override String get save => 'Guardar Préstamo';
	@override String get successCreate => 'Préstamo creado con éxito';
	@override String get successUpdate => 'Préstamo actualizado con éxito';
	@override String get contactRequired => 'El contacto es obligatorio';
	@override String get accountRequired => 'La cuenta es obligatoria';
	@override String get amountRequired => 'El monto es obligatorio';
}

// Path: loans.detail
class _AppStringsLoansDetailEs extends AppStringsLoansDetailEn {
	_AppStringsLoansDetailEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Detalles del Préstamo';
	@override String get deleteTitle => 'Eliminar Préstamo';
	@override String get deleteMessage => '¿Estás seguro de que deseas eliminar este préstamo?';
	@override String get deleteSuccess => 'Préstamo eliminado exitosamente';
	@override String deleteError({required Object error}) => 'Error al eliminar el préstamo: ${error}';
	@override String get notFound => 'Préstamo no encontrado';
	@override String get progress => 'Progreso del Préstamo';
	@override String get info => 'Información del Préstamo';
	@override String get pay => 'Pagar';
	@override String get viewHistory => 'Ver Historial Completo';
	@override String original({required Object amount}) => 'Original: ${amount}';
	@override String get section => 'Información del Préstamo';
	@override String get activeSummary => 'Resumen Activo';
	@override String get activeLent => 'Prestaste (Activo)';
	@override String get activeBorrowed => 'Te Prestaron (Activo)';
	@override String get activeNet => 'Posición Neta (Activa)';
	@override String get activeTotal => 'Total Préstamos Activos';
	@override String get startDate => 'Inicio del Préstamo';
	@override String get dueDate => 'Fecha de Vencimiento';
	@override late final _AppStringsLoansDetailTypeEs type = _AppStringsLoansDetailTypeEs._(_root);
	@override late final _AppStringsLoansDetailPaymentEs payment = _AppStringsLoansDetailPaymentEs._(_root);
}

// Path: loans.share
class _AppStringsLoansShareEs extends AppStringsLoansShareEn {
	_AppStringsLoansShareEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Compartir Préstamo';
	@override String get contactTitle => 'Compartir Préstamos';
	@override String get button => 'Compartir';
	@override String get copy => 'Copiar Texto';
	@override String get message => 'Aquí está mi estado de cuenta del préstamo:';
	@override String contactMessage({required Object name}) => 'Resumen de Préstamos con ${name}:';
	@override String error({required Object error}) => 'Error al compartir imagen: ${error}';
	@override String get contactCopied => '¡Resumen copiado al portapapeles!';
	@override String activeLoans({required Object n}) => 'Préstamos Activos (${n}):';
	@override String loanItem({required Object description, required Object amount, required Object date, required Object percent}) => '• ${description}: ${amount} (Fecha: ${date}) - ${percent}% pagado';
	@override String get loanStatement => 'MoneyT - Estado de Cuenta';
	@override String get loanSummary => 'MoneyT - Resumen de Préstamos';
	@override String get personalLoan => 'Préstamo Personal';
	@override String remaining({required Object amount}) => 'Saldo Restante: ${amount}';
	@override String get remainingLabel => 'Saldo Restante';
	@override String original({required Object amount}) => 'de ${amount} original';
	@override String progress({required Object percent}) => 'Progreso: ${percent}% Pagado';
	@override String get progressLabel => 'Progreso de Pago';
	@override String get paidSuffix => 'Pagado';
	@override String date({required Object date}) => 'Fecha: ${date}';
	@override String get dateLabel => 'Fecha del Préstamo';
	@override String contact({required Object name}) => 'Contacto: ${name}';
	@override String get contactLabel => 'Contacto';
	@override String generated({required Object date}) => 'Generado el ${date}';
	@override String generatedLabel({required Object date}) => 'Generado el ${date}';
	@override String totalActive({required Object n}) => 'Total Activos: ${n} préstamos';
	@override String get active => 'activos';
	@override String get poweredBy => 'Desarrollado por MoneyT • moneyt.io';
	@override String get copied => '¡Detalles copiados al portapapeles!';
	@override String netBalance({required Object amount, required Object status}) => 'Balance Neto: ${amount} (${status})';
	@override String get netBalanceLabel => 'Balance Neto';
	@override String get owed => 'Te deben';
	@override String get owe => 'Debes';
	@override String lent({required Object amount}) => 'Prestaste: ${amount}';
	@override String get lentLabel => 'Prestaste';
	@override String borrowed({required Object amount}) => 'Pediste: ${amount}';
	@override String get borrowedLabel => 'Pediste';
	@override String contactSummary({required Object name}) => '${name} - Resumen de Préstamos';
}

// Path: loans.payment
class _AppStringsLoansPaymentEs extends AppStringsLoansPaymentEn {
	_AppStringsLoansPaymentEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Registrar Pago';
	@override String get amount => 'Monto del Pago';
	@override String get amountPlaceholder => '0.00';
	@override String get amountRequired => 'El monto es requerido';
	@override String get invalidAmount => 'Ingresa un monto válido';
	@override String get exceedsBalance => 'El monto no puede exceder el saldo restante';
	@override String get date => 'Fecha de Pago';
	@override String get account => 'Recibido en cuenta';
	@override String get selectAccount => 'Seleccionar cuenta';
	@override String get details => 'Detalles del pago';
	@override String get detailsPlaceholder => 'Agregar notas (opcional)';
	@override String get success => 'Pago registrado con éxito';
	@override String error({required Object error}) => 'Error al registrar pago: ${error}';
	@override String get errorAmount => 'Ingresa un monto de pago válido';
	@override String get errorAccount => 'Por favor selecciona una cuenta';
	@override String errorLoading({required Object error}) => 'Error al cargar datos: ${error}';
	@override late final _AppStringsLoansPaymentSummaryEs summary = _AppStringsLoansPaymentSummaryEs._(_root);
	@override late final _AppStringsLoansPaymentQuickEs quick = _AppStringsLoansPaymentQuickEs._(_root);
}

// Path: loans.contactDetail
class _AppStringsLoansContactDetailEs extends AppStringsLoansContactDetailEn {
	_AppStringsLoansContactDetailEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String titleWith({required Object name}) => 'Préstamos con ${name}';
}

// Path: loans.history
class _AppStringsLoansHistoryEs extends AppStringsLoansHistoryEn {
	_AppStringsLoansHistoryEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Historial de Préstamos';
	@override String get section => 'Historial completo';
	@override String get totalLoaned => 'Total prestado';
	@override String get noLoans => 'No se encontraron préstamos con este filtro.';
	@override late final _AppStringsLoansHistoryFilterEs filter = _AppStringsLoansHistoryFilterEs._(_root);
	@override late final _AppStringsLoansHistoryHeadersEs headers = _AppStringsLoansHistoryHeadersEs._(_root);
	@override late final _AppStringsLoansHistoryItemEs item = _AppStringsLoansHistoryItemEs._(_root);
	@override late final _AppStringsLoansHistorySummaryEs summary = _AppStringsLoansHistorySummaryEs._(_root);
}

// Path: loans.item
class _AppStringsLoansItemEs extends AppStringsLoansItemEn {
	_AppStringsLoansItemEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String due({required Object date}) => 'Vence: ${date}';
	@override String paidAmount({required Object amount}) => 'Pagado: ${amount}';
	@override String remaining({required Object amount}) => 'Restante: ${amount}';
	@override String percentPaid({required Object percent}) => '${percent}% pagado';
}

// Path: loans.section
class _AppStringsLoansSectionEs extends AppStringsLoansSectionEn {
	_AppStringsLoansSectionEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get activeLoans => 'Préstamos Activos';
	@override String loansCount({required Object n}) => '${n} préstamos';
}

// Path: loans.empty
class _AppStringsLoansEmptyEs extends AppStringsLoansEmptyEn {
	_AppStringsLoansEmptyEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'No hay préstamos activos';
	@override String get message => 'Comienza a llevar el registro de tus préstamos.';
	@override String get action => 'Agregar Préstamo';
}

// Path: categories.form
class _AppStringsCategoriesFormEs extends AppStringsCategoriesFormEn {
	_AppStringsCategoriesFormEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get newTitle => 'Nueva Categoría';
	@override String get editTitle => 'Editar Categoría';
	@override String get name => 'Nombre de categoría';
	@override String get namePlaceholder => 'Ingresa el nombre de la categoría';
	@override String get nameRequired => 'El nombre es requerido';
	@override String get parent => 'Categoría Padre (Opcional)';
	@override String get noParent => 'Sin categoría padre';
	@override String get asSubcategory => 'Se creará como subcategoría';
	@override String get asRoot => 'Se creará como categoría principal';
	@override String get active => 'Categoría Activa';
	@override String get activeDescription => 'Habilitar esta categoría para nuevas transacciones';
	@override String get selectIcon => 'Seleccionar Icono';
	@override String get selectColor => 'Seleccionar Color';
	@override String get saveSuccess => 'Categoría guardada exitosamente';
	@override String saveError({required Object error}) => 'Error al guardar categoría: ${error}';
}

// Path: categories.parentSelection
class _AppStringsCategoriesParentSelectionEs extends AppStringsCategoriesParentSelectionEn {
	_AppStringsCategoriesParentSelectionEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Seleccionar Categoría Padre';
	@override String get subtitle => 'Toca para seleccionar una categoría padre';
	@override String get noParent => 'Sin categoría padre';
}

// Path: categories.report
class _AppStringsCategoriesReportEs extends AppStringsCategoriesReportEn {
	_AppStringsCategoriesReportEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Desglose Avanzado';
	@override String get timeFilter => 'Filtro Temporal';
	@override String get thisMonth => 'Este Mes';
	@override String get lastMonth => 'Mes Pasado';
	@override String get thisYear => 'Este Año';
	@override String get allTime => 'Todo el Tiempo';
	@override String get details => 'Detalle por Categorías';
	@override String get noTransactions => 'Sin transacciones';
	@override String get income => 'Ingresos';
	@override String get expense => 'Gastos';
}

// Path: backups.menu
class _AppStringsBackupsMenuEs extends AppStringsBackupsMenuEn {
	_AppStringsBackupsMenuEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get settings => 'Configuración de copia de seguridad';
	@override String get comingSoon => 'Configuración de copia de seguridad próximamente';
}

// Path: backups.filters
class _AppStringsBackupsFiltersEs extends AppStringsBackupsFiltersEn {
	_AppStringsBackupsFiltersEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get all => 'Todos';
	@override String get auto => 'Auto';
	@override String get manual => 'Manual';
	@override String get thisMonth => 'Este Mes';
	@override String get lastMonth => 'Mes Pasado';
	@override String get thisYear => 'Este Año';
	@override String get lastYear => 'Año Pasado';
}

// Path: backups.status
class _AppStringsBackupsStatusEs extends AppStringsBackupsStatusEn {
	_AppStringsBackupsStatusEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get loading => 'Cargando...';
	@override String get error => 'Error al cargar copias de seguridad';
	@override String get empty => 'No se encontraron copias de seguridad';
	@override String get emptyAction => 'Crea tu primera copia de seguridad usando el botón +';
	@override String get success => 'Éxito';
	@override String get created => 'Copia de seguridad creada con éxito';
	@override String createError({required Object error}) => 'Error al crear copia: ${error}';
	@override String restoreError({required Object error}) => 'Error al restaurar copia: ${error}';
	@override String deleteError({required Object error}) => 'Error al eliminar copia: ${error}';
}

// Path: backups.actions
class _AppStringsBackupsActionsEs extends AppStringsBackupsActionsEn {
	_AppStringsBackupsActionsEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get create => 'Crear Copia';
	@override String get import => 'Importar Copia';
	@override String get restore => 'Restaurar';
	@override String get delete => 'Eliminar';
	@override String get share => 'Compartir';
	@override String get cancel => 'Cancelar';
	@override String get retry => 'Reintentar';
	@override String get ok => 'OK';
}

// Path: backups.dialogs
class _AppStringsBackupsDialogsEs extends AppStringsBackupsDialogsEn {
	_AppStringsBackupsDialogsEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override late final _AppStringsBackupsDialogsInfoEs info = _AppStringsBackupsDialogsInfoEs._(_root);
	@override late final _AppStringsBackupsDialogsRestoreEs restore = _AppStringsBackupsDialogsRestoreEs._(_root);
	@override late final _AppStringsBackupsDialogsDeleteEs delete = _AppStringsBackupsDialogsDeleteEs._(_root);
}

// Path: backups.stats
class _AppStringsBackupsStatsEs extends AppStringsBackupsStatsEn {
	_AppStringsBackupsStatsEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Estadísticas de Copias';
	@override String get totalBackups => 'Total de Copias';
	@override String get totalSize => 'Tamaño Total';
	@override String get oldest => 'Copia Más Antigua';
	@override String get latest => 'Copia Más Reciente';
	@override String get autoBackupStatus => 'Estado de Copia Auto';
	@override String get active => 'Activo';
	@override String get inactive => 'Inactivo';
}

// Path: backups.options
class _AppStringsBackupsOptionsEs extends AppStringsBackupsOptionsEn {
	_AppStringsBackupsOptionsEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override late final _AppStringsBackupsOptionsRestoreEs restore = _AppStringsBackupsOptionsRestoreEs._(_root);
	@override late final _AppStringsBackupsOptionsShareEs share = _AppStringsBackupsOptionsShareEs._(_root);
	@override late final _AppStringsBackupsOptionsDeleteEs delete = _AppStringsBackupsOptionsDeleteEs._(_root);
	@override String get latestBadge => 'Reciente';
	@override String get latestFile => 'Copia más reciente';
	@override String get backupFile => 'Archivo de copia';
}

// Path: backups.format
class _AppStringsBackupsFormatEs extends AppStringsBackupsFormatEn {
	_AppStringsBackupsFormatEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String auto({required Object date}) => 'Copia Auto - ${date}';
	@override String manual({required Object date}) => 'Copia Manual - ${date}';
	@override String get initial => 'Copia Inicial';
	@override String generic({required Object date}) => 'Copia - ${date}';
}

// Path: transactions.filter.ranges
class _AppStringsTransactionsFilterRangesEs extends AppStringsTransactionsFilterRangesEn {
	_AppStringsTransactionsFilterRangesEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get thisMonth => 'Mes Actual';
	@override String get lastMonth => 'Mes Anterior';
	@override String get thisYear => 'Año Actual';
	@override String get lastYear => 'Año Anterior';
}

// Path: transactions.filter.subtitles
class _AppStringsTransactionsFilterSubtitlesEs extends AppStringsTransactionsFilterSubtitlesEn {
	_AppStringsTransactionsFilterSubtitlesEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get income => 'Dinero recibido';
	@override String get expense => 'Dinero gastado';
	@override String get transfer => 'Dinero movido';
}

// Path: transactions.share.receipt
class _AppStringsTransactionsShareReceiptEs extends AppStringsTransactionsShareReceiptEn {
	_AppStringsTransactionsShareReceiptEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => '--- Detalle de Transacción ---';
	@override String amount({required Object amount}) => 'Monto: ${amount}';
	@override String description({required Object description}) => 'Descripción: ${description}';
	@override String category({required Object category}) => 'Categoría: ${category}';
	@override String date({required Object date}) => 'Fecha: ${date}';
	@override String time({required Object time}) => 'Hora: ${time}';
	@override String wallet({required Object wallet}) => 'Cuenta: ${wallet}';
	@override String contact({required Object contact}) => 'Contacto: ${contact}';
	@override String id({required Object id}) => 'ID Transacción: ${id}';
	@override String get separator => '--------------------------';
}

// Path: onboarding.specificProblem.options
class _AppStringsOnboardingSpecificProblemOptionsEs extends AppStringsOnboardingSpecificProblemOptionsEn {
	_AppStringsOnboardingSpecificProblemOptionsEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get debts => 'Deudas y préstamos';
	@override String get savings => 'No poder ahorrar';
	@override String get unknown => 'No saber en qué gasté';
	@override String get chaos => 'Caos financiero';
}

// Path: onboarding.personalGoal.options
class _AppStringsOnboardingPersonalGoalOptionsEs extends AppStringsOnboardingPersonalGoalOptionsEn {
	_AppStringsOnboardingPersonalGoalOptionsEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get debtFree => 'Salir de deudas';
	@override String get saveTrip => 'Ahorrar para viaje/auto';
	@override String get invest => 'Comenzar a invertir';
	@override String get peace => 'Tranquilidad financiera';
}

// Path: onboarding.solutionPreview.benefits
class _AppStringsOnboardingSolutionPreviewBenefitsEs extends AppStringsOnboardingSolutionPreviewBenefitsEn {
	_AppStringsOnboardingSolutionPreviewBenefitsEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get visualize => 'Visualiza todos tus gastos en tiempo real';
	@override String get goals => 'Establece metas y sigue tu progreso';
	@override String get smart => 'Toma decisiones financieras inteligentes';
}

// Path: onboarding.currentMethod.options
class _AppStringsOnboardingCurrentMethodOptionsEs extends AppStringsOnboardingCurrentMethodOptionsEn {
	_AppStringsOnboardingCurrentMethodOptionsEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get excel => 'Excel / Hojas de cálculo';
	@override String get notebook => 'Cuaderno / Notas';
	@override String get mental => 'Memoria (Mental)';
	@override String get none => 'No llevo control';
}

// Path: onboarding.featuresShowcase.features
class _AppStringsOnboardingFeaturesShowcaseFeaturesEs extends AppStringsOnboardingFeaturesShowcaseFeaturesEn {
	_AppStringsOnboardingFeaturesShowcaseFeaturesEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get income => 'Ingresos';
	@override String get expense => 'Egresos';
	@override String get transfer => 'Transfer';
	@override String get loans => 'Préstamos';
	@override String get goals => 'Metas';
	@override String get budgets => 'Presupuestos';
	@override String get investments => 'Inversiones';
	@override String get cloud => 'MoneyT Cloud';
	@override String get openBanking => 'Open Banking';
}

// Path: onboarding.complete.stats
class _AppStringsOnboardingCompleteStatsEs extends AppStringsOnboardingCompleteStatsEn {
	_AppStringsOnboardingCompleteStatsEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Probabilidad de éxito';
	@override String get before => 'Antes de MoneyT';
	@override String get after => 'Con MoneyT';
}

// Path: dashboard.widgets.balance
class _AppStringsDashboardWidgetsBalanceEs extends AppStringsDashboardWidgetsBalanceEn {
	_AppStringsDashboardWidgetsBalanceEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Balance Total';
	@override String get description => 'Muestra tu estado financiero general';
}

// Path: dashboard.widgets.quickActions
class _AppStringsDashboardWidgetsQuickActionsEs extends AppStringsDashboardWidgetsQuickActionsEn {
	_AppStringsDashboardWidgetsQuickActionsEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Acciones Rápidas';
	@override String get description => 'Acceso rápido a transacciones comunes';
}

// Path: dashboard.widgets.wallets
class _AppStringsDashboardWidgetsWalletsEs extends AppStringsDashboardWidgetsWalletsEn {
	_AppStringsDashboardWidgetsWalletsEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Cuentas';
	@override String get description => 'Resumen de tus cuentas';
}

// Path: dashboard.widgets.loans
class _AppStringsDashboardWidgetsLoansEs extends AppStringsDashboardWidgetsLoansEn {
	_AppStringsDashboardWidgetsLoansEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Préstamos';
	@override String get description => 'Rastrea dinero prestado';
}

// Path: dashboard.widgets.transactions
class _AppStringsDashboardWidgetsTransactionsEs extends AppStringsDashboardWidgetsTransactionsEn {
	_AppStringsDashboardWidgetsTransactionsEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Transacciones Recientes';
	@override String get description => 'Última actividad financiera';
}

// Path: dashboard.widgets.categoryBreakdown
class _AppStringsDashboardWidgetsCategoryBreakdownEs extends AppStringsDashboardWidgetsCategoryBreakdownEn {
	_AppStringsDashboardWidgetsCategoryBreakdownEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Desglose por Categoría';
	@override String get description => 'Desglose mensual';
	@override String get empty_message => 'No hay transacciones registradas este mes.';
	@override String get others => 'Otros';
	@override String get back => 'Atrás';
	@override String get monthlyBudget => 'Presupuesto mensual';
	@override String leftover({required Object amount}) => 'Te quedan ${amount} de ingresos.';
	@override String exceeded({required Object amount}) => 'Has excedido tus ingresos por ${amount}.';
	@override String noIncome({required Object amount}) => 'Gastos registrados: ${amount} (Sin ingresos)';
}

// Path: dashboard.widgets.chartAccounts
class _AppStringsDashboardWidgetsChartAccountsEs extends AppStringsDashboardWidgetsChartAccountsEn {
	_AppStringsDashboardWidgetsChartAccountsEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Plan de Cuentas';
	@override String get description => 'Resumen de estructura de cuentas';
}

// Path: dashboard.widgets.creditCards
class _AppStringsDashboardWidgetsCreditCardsEs extends AppStringsDashboardWidgetsCreditCardsEn {
	_AppStringsDashboardWidgetsCreditCardsEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tarjetas de Crédito';
	@override String get description => 'Balances y límites de tarjetas';
}

// Path: dashboard.widgets.settings
class _AppStringsDashboardWidgetsSettingsEs extends AppStringsDashboardWidgetsSettingsEn {
	_AppStringsDashboardWidgetsSettingsEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Personalizar Dashboard';
	@override String get subtitle => 'Organiza y gestiona los widgets de tu inicio.';
	@override late final _AppStringsDashboardWidgetsSettingsResetEs reset = _AppStringsDashboardWidgetsSettingsResetEs._(_root);
	@override String get saveSuccess => '¡Cambios guardados exitosamente!';
	@override String saveError({required Object error}) => 'Error al guardar cambios: ${error}';
	@override String get saving => 'Guardando...';
	@override String get save => 'Guardar Cambios';
}

// Path: loans.detail.type
class _AppStringsLoansDetailTypeEs extends AppStringsLoansDetailTypeEn {
	_AppStringsLoansDetailTypeEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get label => 'Tipo de Préstamo';
	@override String get personal => 'Préstamo Personal';
	@override String get borrowed => 'Préstamo Recibido';
	@override String get auto => 'Préstamo Automotriz';
	@override String get mortgage => 'Hipoteca';
	@override String get student => 'Préstamo Estudiantil';
}

// Path: loans.detail.payment
class _AppStringsLoansDetailPaymentEs extends AppStringsLoansDetailPaymentEn {
	_AppStringsLoansDetailPaymentEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get history => 'Historial de Pagos';
	@override String date({required Object date}) => 'Pago el ${date}';
	@override String transactionId({required Object id}) => 'ID Transacción: ${id}';
	@override String paid({required Object amount}) => '${amount} pagado';
	@override String remaining({required Object amount}) => '${amount} restante';
}

// Path: loans.payment.summary
class _AppStringsLoansPaymentSummaryEs extends AppStringsLoansPaymentSummaryEn {
	_AppStringsLoansPaymentSummaryEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Resumen del pago';
	@override String get defaultTitle => 'Préstamo';
	@override String get amount => 'Monto del pago';
	@override String get remaining => 'Saldo restante';
	@override String get progress => 'Nuevo progreso';
	@override String description({required Object loan, required Object contact}) => '${loan} a ${contact}';
	@override String get unknownContact => 'Contacto Desconocido';
	@override String total({required Object amount}) => '${amount} total';
	@override String paid({required Object amount}) => 'Pagado: ${amount}';
	@override String remainingLabel({required Object amount}) => 'Restante: ${amount}';
}

// Path: loans.payment.quick
class _AppStringsLoansPaymentQuickEs extends AppStringsLoansPaymentQuickEn {
	_AppStringsLoansPaymentQuickEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String full({required Object amount}) => 'Pago Completo (${amount})';
	@override String half({required Object amount}) => 'Mitad (${amount})';
}

// Path: loans.history.filter
class _AppStringsLoansHistoryFilterEs extends AppStringsLoansHistoryFilterEn {
	_AppStringsLoansHistoryFilterEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get all => 'Todos';
	@override String get lent => 'Prestados';
	@override String get borrowed => 'Recibidos';
	@override String get completed => 'Completados';
	@override String get title => 'Filtrar Historial';
	@override String get reset => 'Restablecer';
	@override String get apply => 'Aplicar Filtros';
	@override String get dateRange => 'Rango de Fechas';
	@override String get amountRange => 'Rango de Montos';
	@override String get startDate => 'Fecha Inicio';
	@override String get endDate => 'Fecha Fin';
	@override String get select => 'Seleccionar';
}

// Path: loans.history.headers
class _AppStringsLoansHistoryHeadersEs extends AppStringsLoansHistoryHeadersEn {
	_AppStringsLoansHistoryHeadersEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get lent => 'Préstamos Otorgados';
	@override String get borrowed => 'Préstamos Recibidos';
	@override String get completed => 'Préstamos Completados';
	@override String get active => 'Préstamos Activos';
	@override String get cancelled => 'Préstamos Cancelados';
	@override String get writtenOff => 'Préstamos Anulados';
}

// Path: loans.history.item
class _AppStringsLoansHistoryItemEs extends AppStringsLoansHistoryItemEn {
	_AppStringsLoansHistoryItemEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get defaultTitle => 'Préstamo';
	@override String date({required Object date}) => 'Fecha: ${date}';
	@override String get lent => 'Prestado';
	@override String get borrowed => 'Recibido';
	@override late final _AppStringsLoansHistoryItemStatusEs status = _AppStringsLoansHistoryItemStatusEs._(_root);
}

// Path: loans.history.summary
class _AppStringsLoansHistorySummaryEs extends AppStringsLoansHistorySummaryEn {
	_AppStringsLoansHistorySummaryEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Resumen Histórico';
	@override String get viewDetails => 'Ver Detalles';
	@override String get hideDetails => 'Ocultar Detalles';
	@override String get outstandingLent => 'Pendiente de Cobro';
	@override String get outstandingBorrowed => 'Pendiente de Pago';
	@override String get netPosition => 'Posición Neta (Activa)';
	@override String get totalLent => 'Total Prestado Histórico';
	@override String get totalBorrowed => 'Total Recibido Histórico';
	@override String get totalRepaidToYou => 'Total Reembolsado a Ti';
	@override String get totalYouRepaid => 'Total que Reembolsaste';
	@override String get totalLoans => 'Total de Préstamos';
	@override String get completedLoans => 'Préstamos Completados';
}

// Path: backups.dialogs.info
class _AppStringsBackupsDialogsInfoEs extends AppStringsBackupsDialogsInfoEn {
	_AppStringsBackupsDialogsInfoEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Información de Copia';
	@override String get file => 'Archivo:';
	@override String get size => 'Tamaño:';
	@override String get created => 'Creado:';
	@override String get transactions => 'Transacciones:';
}

// Path: backups.dialogs.restore
class _AppStringsBackupsDialogsRestoreEs extends AppStringsBackupsDialogsRestoreEn {
	_AppStringsBackupsDialogsRestoreEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Restaurar Copia';
	@override String content({required Object file}) => '¿Estás seguro de que deseas restaurar desde "${file}"? La base de datos actual será reemplazada.';
	@override String get success => 'Restauración iniciada. La aplicación podría necesitar reiniciarse.';
}

// Path: backups.dialogs.delete
class _AppStringsBackupsDialogsDeleteEs extends AppStringsBackupsDialogsDeleteEn {
	_AppStringsBackupsDialogsDeleteEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Eliminar Copia';
	@override String content({required Object file}) => '¿Estás seguro de que deseas eliminar el archivo "${file}"? Esta acción no se puede deshacer.';
	@override String get success => 'Copia de seguridad eliminada.';
}

// Path: backups.options.restore
class _AppStringsBackupsOptionsRestoreEs extends AppStringsBackupsOptionsRestoreEn {
	_AppStringsBackupsOptionsRestoreEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Restaurar copia';
	@override String get subtitle => 'Reemplazar datos actuales con esta copia';
}

// Path: backups.options.share
class _AppStringsBackupsOptionsShareEs extends AppStringsBackupsOptionsShareEn {
	_AppStringsBackupsOptionsShareEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Compartir copia';
	@override String get subtitle => 'Enviar archivo a otro dispositivo';
}

// Path: backups.options.delete
class _AppStringsBackupsOptionsDeleteEs extends AppStringsBackupsOptionsDeleteEn {
	_AppStringsBackupsOptionsDeleteEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Eliminar copia';
	@override String get subtitle => 'Esta acción no se puede deshacer';
}

// Path: dashboard.widgets.settings.reset
class _AppStringsDashboardWidgetsSettingsResetEs extends AppStringsDashboardWidgetsSettingsResetEn {
	_AppStringsDashboardWidgetsSettingsResetEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get button => 'Restaurar diseño por defecto';
	@override String get dialogTitle => 'Restaurar diseño';
	@override String get dialogContent => '¿Restaurar el dashboard al diseño por defecto? Esto devolverá todos los widgets a su posición original.';
	@override String get cancel => 'Cancelar';
	@override String get confirm => 'Restaurar';
	@override String get success => 'Diseño restaurado por defecto';
}

// Path: loans.history.item.status
class _AppStringsLoansHistoryItemStatusEs extends AppStringsLoansHistoryItemStatusEn {
	_AppStringsLoansHistoryItemStatusEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get completed => 'Completado';
	@override String get active => 'Activo';
	@override String get cancelled => 'Cancelado';
	@override String get writtenOff => 'Anulado';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on AppStringsEs {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'app.name': return 'MoneyT';
			case 'app.description': return 'Gestor Financiero';
			case 'common.save': return 'Guardar';
			case 'common.cancel': return 'Cancelar';
			case 'common.delete': return 'Eliminar';
			case 'common.edit': return 'Editar';
			case 'common.loading': return 'Cargando...';
			case 'common.error': return 'Error';
			case 'common.success': return 'Éxito';
			case 'common.search': return 'Buscar';
			case 'common.clearSearch': return 'Limpiar búsqueda';
			case 'common.viewAll': return 'Ver todo';
			case 'common.retry': return 'Reintentar';
			case 'common.add': return 'Agregar';
			case 'common.remove': return 'Quitar';
			case 'common.moreOptions': return 'Más opciones';
			case 'common.addToFavorites': return 'Agregar a favoritos';
			case 'common.removeFromFavorites': return 'Eliminar de favoritos';
			case 'common.today': return 'Hoy';
			case 'common.yesterday': return 'Ayer';
			case 'components.dateSelection.title': return 'Seleccionar fecha';
			case 'components.dateSelection.subtitle': return 'Elige la fecha de la transacción';
			case 'components.dateSelection.selectedDate': return 'Fecha seleccionada';
			case 'components.dateSelection.confirm': return 'Seleccionar';
			case 'components.selection.cancel': return 'Cancelar';
			case 'components.selection.confirm': return 'Confirmar';
			case 'components.selection.select': return 'Seleccionar';
			case 'components.contactSelection.title': return 'Seleccionar contacto';
			case 'components.contactSelection.subtitle': return 'Elige con quién es esta transacción';
			case 'components.contactSelection.searchPlaceholder': return 'Buscar contactos';
			case 'components.contactSelection.noContact': return 'Sin contacto';
			case 'components.contactSelection.noContactDetails': return 'Transacción sin contacto específico';
			case 'components.contactSelection.allContacts': return 'Todos los contactos';
			case 'components.contactSelection.create': return 'Crear nuevo contacto';
			case 'components.categorySelection.title': return 'Seleccionar categoría';
			case 'components.categorySelection.subtitle': return 'Elige una categoría para esta transacción';
			case 'components.categorySelection.searchPlaceholder': return 'Buscar categorías';
			case 'components.currencySelection.title': return 'Seleccionar moneda';
			case 'components.currencySelection.subtitle': return 'Elige la moneda para esta cuenta';
			case 'components.currencySelection.searchPlaceholder': return 'Buscar monedas';
			case 'components.accountSelection.title': return 'Seleccionar cuenta';
			case 'components.accountSelection.subtitle': return 'Elige una cuenta para esta transacción';
			case 'components.accountSelection.searchPlaceholder': return 'Buscar cuentas';
			case 'components.accountSelection.wallets': return 'Billeteras';
			case 'components.accountSelection.creditCards': return 'Tarjetas de Crédito';
			case 'components.accountSelection.selectAccount': return 'Seleccionar cuenta';
			case 'components.accountSelection.confirm': return 'Confirmar';
			case 'components.parentWalletSelection.title': return 'Seleccionar billetera padre';
			case 'components.parentWalletSelection.subtitle': return 'Elige una billetera padre para organizar esta cuenta';
			case 'components.parentWalletSelection.searchPlaceholder': return 'Buscar billeteras';
			case 'components.parentWalletSelection.noParent': return 'Sin billetera padre';
			case 'components.parentWalletSelection.createRoot': return 'Crear como billetera principal';
			case 'components.parentWalletSelection.available': return 'Billeteras disponibles';
			case 'components.walletTypes.checking': return 'Corriente';
			case 'components.walletTypes.savings': return 'Ahorros';
			case 'components.walletTypes.cash': return 'Efectivo';
			case 'components.walletTypes.creditCard': return 'Tarjeta de Crédito';
			case 'navigation.home': return 'Inicio';
			case 'navigation.transactions': return 'Transacciones';
			case 'navigation.contacts': return 'Contactos';
			case 'navigation.settings': return 'Configuración';
			case 'navigation.wallets': return 'Cuentas';
			case 'navigation.categories': return 'Categorías';
			case 'navigation.loans': return 'Préstamos';
			case 'navigation.charts': return 'Plan de Cuentas';
			case 'navigation.backups': return 'Respaldos';
			case 'navigation.creditCards': return 'Tarjetas de Crédito';
			case 'navigation.sections.operations': return 'OPERACIONES';
			case 'navigation.sections.financialTools': return 'HERRAMIENTAS FINANCIERAS';
			case 'navigation.sections.management': return 'GESTIÓN';
			case 'navigation.sections.advanced': return 'AVANZADO';
			case 'transactions.title': return 'Transacciones';
			case 'transactions.types.all': return 'Todas';
			case 'transactions.types.income': return 'Ingreso';
			case 'transactions.types.expense': return 'Gasto';
			case 'transactions.types.transfer': return 'Transferencia';
			case 'transactions.filter.title': return 'Filtrar Transacciones';
			case 'transactions.filter.date': return 'Fecha';
			case 'transactions.filter.categories': return 'Categorías';
			case 'transactions.filter.accounts': return 'Cuentas';
			case 'transactions.filter.contacts': return 'Contactos';
			case 'transactions.filter.amount': return 'Monto';
			case 'transactions.filter.apply': return 'Aplicar filtros';
			case 'transactions.filter.clear': return 'Limpiar filtros';
			case 'transactions.filter.add': return 'Agregar filtro';
			case 'transactions.filter.minAmount': return 'Monto Mínimo';
			case 'transactions.filter.maxAmount': return 'Monto Máximo';
			case 'transactions.filter.selectDate': return 'Seleccionar fecha';
			case 'transactions.filter.selectCategory': return 'Seleccionar categoría';
			case 'transactions.filter.selectAccount': return 'Seleccionar cuenta';
			case 'transactions.filter.selectContact': return 'Seleccionar contacto';
			case 'transactions.filter.quickFilters': return 'Filtros rápidos';
			case 'transactions.filter.ranges.thisMonth': return 'Mes Actual';
			case 'transactions.filter.ranges.lastMonth': return 'Mes Anterior';
			case 'transactions.filter.ranges.thisYear': return 'Año Actual';
			case 'transactions.filter.ranges.lastYear': return 'Año Anterior';
			case 'transactions.filter.customRange': return 'Rango de fechas';
			case 'transactions.filter.startDate': return 'Desde';
			case 'transactions.filter.endDate': return 'Hasta';
			case 'transactions.filter.active': return 'Filtros activos';
			case 'transactions.filter.subtitles.income': return 'Dinero recibido';
			case 'transactions.filter.subtitles.expense': return 'Dinero gastado';
			case 'transactions.filter.subtitles.transfer': return 'Dinero movido';
			case 'transactions.form.newTitle': return 'Nueva Transacción';
			case 'transactions.form.editTitle': return 'Editar Transacción';
			case 'transactions.form.amount': return 'Monto';
			case 'transactions.form.type': return 'Tipo de transacción';
			case 'transactions.form.amountRequired': return 'Monto requerido';
			case 'transactions.form.date': return 'Fecha';
			case 'transactions.form.account': return 'Cuenta';
			case 'transactions.form.toAccount': return 'Cuenta Destino';
			case 'transactions.form.category': return 'Categoría';
			case 'transactions.form.contact': return 'Contacto';
			case 'transactions.form.contactOptional': return 'Contacto (opcional)';
			case 'transactions.form.description': return 'Descripción';
			case 'transactions.form.descriptionOptional': return 'Descripción opcional';
			case 'transactions.form.selectAccount': return 'Seleccionar cuenta';
			case 'transactions.form.selectDestination': return 'Seleccionar destino';
			case 'transactions.form.selectCategory': return 'Seleccionar categoría';
			case 'transactions.form.selectContact': return 'Seleccionar contacto';
			case 'transactions.form.saveSuccess': return 'Transacción guardada exitosamente';
			case 'transactions.form.updateSuccess': return 'Transacción actualizada exitosamente';
			case 'transactions.form.saveError': return 'Error al guardar transacción';
			case 'transactions.form.share': return 'Compartir';
			case 'transactions.form.created': return 'Transacción creada exitosamente';
			case 'transactions.errors.load': return 'Error al cargar las transacciones';
			case 'transactions.empty.title': return 'No hay transacciones';
			case 'transactions.empty.message': return 'No se encontraron transacciones con los filtros aplicados';
			case 'transactions.empty.clearFilters': return 'Limpiar filtros';
			case 'transactions.list.count': return ({required Object n}) => '${n} transacciones';
			case 'transactions.detail.title': return 'Detalle de Transacción';
			case 'transactions.detail.delete': return 'Eliminar Transacción';
			case 'transactions.detail.deleteConfirmation': return '¿Estás seguro? Esta acción no se puede deshacer.';
			case 'transactions.detail.deleted': return 'Transacción eliminada';
			case 'transactions.detail.duplicate': return 'Duplicar';
			case 'transactions.detail.duplicateNotImplemented': return 'Duplicar no implementado';
			case 'transactions.detail.edit': return 'Editar';
			case 'transactions.detail.errorLoad': return 'Error al cargar los detalles de la transacción.';
			case 'transactions.detail.errorPrepareEdit': return ({required Object error}) => 'Error al preparar la edición: ${error}';
			case 'transactions.detail.errorDelete': return ({required Object error}) => 'Error al eliminar: ${error}';
			case 'transactions.detail.category': return 'Categoría';
			case 'transactions.detail.account': return 'Cuenta';
			case 'transactions.detail.contact': return 'Contacto';
			case 'transactions.detail.description': return 'Descripción';
			case 'transactions.detail.transferDetails': return 'Detalles de Transferencia';
			case 'transactions.detail.from': return 'Desde';
			case 'transactions.detail.to': return 'Hacia';
			case 'transactions.detail.unknownAccount': return 'Cuenta desconocida';
			case 'transactions.detail.errorUrl': return ({required Object url}) => 'No se pudo abrir ${url}';
			case 'transactions.detail.date': return 'Fecha';
			case 'transactions.detail.time': return 'Hora';
			case 'transactions.detail.loanLinkedWarning': return 'Esta transacción está vinculada a un préstamo y gestionada automáticamente.';
			case 'transactions.share.title': return 'Compartir Transacción';
			case 'transactions.share.copyText': return 'Copiar Texto';
			case 'transactions.share.shareButton': return 'Compartir';
			case 'transactions.share.shareMessage': return 'Aquí está mi recibo de transacción:';
			case 'transactions.share.copied': return '¡Detalles copiados al portapapeles!';
			case 'transactions.share.errorImage': return ({required Object error}) => 'Error al compartir imagen: ${error}';
			case 'transactions.share.paymentMethod': return 'Método de Pago';
			case 'transactions.share.receiptTitle': return 'Recibo de Transacción';
			case 'transactions.share.poweredBy': return 'Impulsado por MoneyT • moneyt.io';
			case 'transactions.share.generatedOn': return ({required Object date}) => 'Generado el ${date}';
			case 'transactions.share.receipt.title': return '--- Detalle de Transacción ---';
			case 'transactions.share.receipt.amount': return ({required Object amount}) => 'Monto: ${amount}';
			case 'transactions.share.receipt.description': return ({required Object description}) => 'Descripción: ${description}';
			case 'transactions.share.receipt.category': return ({required Object category}) => 'Categoría: ${category}';
			case 'transactions.share.receipt.date': return ({required Object date}) => 'Fecha: ${date}';
			case 'transactions.share.receipt.time': return ({required Object time}) => 'Hora: ${time}';
			case 'transactions.share.receipt.wallet': return ({required Object wallet}) => 'Cuenta: ${wallet}';
			case 'transactions.share.receipt.contact': return ({required Object contact}) => 'Contacto: ${contact}';
			case 'transactions.share.receipt.id': return ({required Object id}) => 'ID Transacción: ${id}';
			case 'transactions.share.receipt.separator': return '--------------------------';
			case 'contacts.title': return 'Contactos';
			case 'contacts.addContact': return 'Agregar Contacto';
			case 'contacts.editContact': return 'Editar Contacto';
			case 'contacts.newContact': return 'Nuevo contacto';
			case 'contacts.noContacts': return 'No hay contactos';
			case 'contacts.noContactsMessage': return 'Agrega tu primer contacto con el botón "+"';
			case 'contacts.searchContacts': return 'Buscar contactos';
			case 'contacts.deleteContact': return 'Eliminar contacto';
			case 'contacts.confirmDelete': return '¿Estás seguro de eliminar';
			case 'contacts.contactDeleted': return 'Contacto eliminado exitosamente';
			case 'contacts.errorDeleting': return 'Error al eliminar contacto';
			case 'contacts.noSearchResults': return 'Sin resultados';
			case 'contacts.noContactsMatch': return ({required Object query}) => 'No hay contactos que coincidan con "${query}". Intenta con otro término.';
			case 'contacts.errorLoading': return 'Error al cargar contactos';
			case 'contacts.contactSaved': return 'Contacto guardado exitosamente';
			case 'contacts.errorSaving': return 'Error al guardar contacto';
			case 'contacts.noContactInfo': return 'Sin información de contacto';
			case 'contacts.importContact': return 'Importar contacto';
			case 'contacts.importContacts': return 'Importar contactos';
			case 'contacts.importContactSoon': return 'Función de importar contacto próximamente';
			case 'contacts.fields.name': return 'Nombre';
			case 'contacts.fields.fullName': return 'Nombre completo';
			case 'contacts.fields.email': return 'Email';
			case 'contacts.fields.phone': return 'Teléfono';
			case 'contacts.fields.address': return 'Dirección';
			case 'contacts.fields.notes': return 'Notas';
			case 'contacts.placeholders.enterFullName': return 'Ingrese el nombre completo';
			case 'contacts.placeholders.enterPhone': return 'Ingrese el número de teléfono';
			case 'contacts.placeholders.enterEmail': return 'Ingrese el email';
			case 'contacts.validation.nameRequired': return 'El nombre es requerido';
			case 'contacts.validation.invalidEmail': return 'Email no válido';
			case 'contacts.validation.invalidPhone': return 'Teléfono no válido';
			case 'errors.loadingAccounts': return ({required Object error}) => 'Error al cargar las cuentas: ${error}';
			case 'errors.unexpected': return 'Error inesperado';
			case 'settings.title': return 'Configuración';
			case 'settings.account.title': return 'Cuenta';
			case 'settings.account.profile': return 'Perfil';
			case 'settings.account.profileSubtitle': return 'Gestiona la información de tu cuenta';
			case 'settings.appearance.title': return 'Apariencia';
			case 'settings.appearance.darkMode': return 'Modo oscuro';
			case 'settings.appearance.darkModeSubtitle': return 'Cambiar a tema oscuro';
			case 'settings.appearance.language': return 'Idioma';
			case 'settings.appearance.darkTheme': return 'Tema oscuro';
			case 'settings.appearance.lightTheme': return 'Tema claro';
			case 'settings.appearance.systemTheme': return 'Tema del sistema';
			case 'settings.data.title': return 'Datos y Almacenamiento';
			case 'settings.data.backup': return 'Copia de seguridad';
			case 'settings.data.backupSubtitle': return 'Gestiona tus copias de seguridad';
			case 'settings.info.title': return 'Información';
			case 'settings.info.contact': return 'Contacto y Redes';
			case 'settings.info.contactSubtitle': return 'Obtén soporte y síguenos en línea';
			case 'settings.info.privacy': return 'Política de privacidad';
			case 'settings.info.privacySubtitle': return 'Lee nuestra política de privacidad';
			case 'settings.info.share': return 'Compartir MoneyT';
			case 'settings.info.shareSubtitle': return 'Cuéntale a tus amigos sobre la app';
			case 'settings.logout.button': return 'Cerrar sesión';
			case 'settings.logout.dialogTitle': return 'Cerrar sesión';
			case 'settings.logout.dialogMessage': return '¿Estás seguro de que quieres cerrar sesión?';
			case 'settings.logout.cancel': return 'Cancelar';
			case 'settings.logout.confirm': return 'Cerrar sesión';
			case 'settings.social.title': return 'Contacto y Redes';
			case 'settings.social.follow': return 'Sigue a MoneyT';
			case 'settings.social.description': return 'Mantente conectado con nosotros en redes sociales para actualizaciones y consejos.';
			case 'settings.social.networks': return 'Redes Sociales';
			case 'settings.social.github': return 'GitHub';
			case 'settings.social.githubSubtitle': return 'Ver código fuente y contribuir';
			case 'settings.social.linkedin': return 'LinkedIn';
			case 'settings.social.linkedinSubtitle': return 'Actualizaciones profesionales';
			case 'settings.social.twitter': return 'X (Twitter)';
			case 'settings.social.twitterSubtitle': return 'Últimas noticias y anuncios';
			case 'settings.social.reddit': return 'Reddit';
			case 'settings.social.redditSubtitle': return 'Únete a las discusiones';
			case 'settings.social.discord': return 'Discord';
			case 'settings.social.discordSubtitle': return 'Chat con la comunidad';
			case 'settings.social.contact': return 'Contacto';
			case 'settings.social.email': return 'Soporte por Email';
			case 'settings.social.website': return 'Sitio Web Oficial';
			case 'settings.language.title': return 'Idioma';
			case 'settings.language.available': return 'IDIOMAS DISPONIBLES';
			case 'settings.language.apply': return 'Aplicar Idioma';
			case 'settings.messages.profileComingSoon': return 'Pantalla de perfil próximamente';
			case 'settings.messages.privacyError': return 'No se pudo abrir la política de privacidad';
			case 'settings.messages.logoutComingSoon': return 'Función de cerrar sesión próximamente';
			case 'onboarding.welcome.title': return 'Bienvenido a MoneyT 👋';
			case 'onboarding.welcome.subtitle': return 'Controla tu dinero en minutos ✨';
			case 'onboarding.problemStatement.title': return '¿Sientes que el dinero se te escapa?';
			case 'onboarding.problemStatement.subtitle': return 'No estás solo. El 70% de las personas no sabe en qué se va su ingreso.';
			case 'onboarding.specificProblem.title': return '¿Qué es lo que más te cuesta?';
			case 'onboarding.specificProblem.options.debts': return 'Deudas y préstamos';
			case 'onboarding.specificProblem.options.savings': return 'No poder ahorrar';
			case 'onboarding.specificProblem.options.unknown': return 'No saber en qué gasté';
			case 'onboarding.specificProblem.options.chaos': return 'Caos financiero';
			case 'onboarding.personalGoal.title': return '¿Cuál es tu meta principal?';
			case 'onboarding.personalGoal.options.debtFree': return 'Salir de deudas';
			case 'onboarding.personalGoal.options.saveTrip': return 'Ahorrar para viaje/auto';
			case 'onboarding.personalGoal.options.invest': return 'Comenzar a invertir';
			case 'onboarding.personalGoal.options.peace': return 'Tranquilidad financiera';
			case 'onboarding.solutionPreview.title': return 'MoneyT te da claridad';
			case 'onboarding.solutionPreview.subtitle': return 'Ve todas tus cuentas, deudas y gastos en un solo lugar. Sin excels, sin estrés.';
			case 'onboarding.solutionPreview.benefits.visualize': return 'Visualiza todos tus gastos en tiempo real';
			case 'onboarding.solutionPreview.benefits.goals': return 'Establece metas y sigue tu progreso';
			case 'onboarding.solutionPreview.benefits.smart': return 'Toma decisiones financieras inteligentes';
			case 'onboarding.currentMethod.title': return '¿Cómo llevas tus cuentas hoy?';
			case 'onboarding.currentMethod.subtitle': return 'Selecciona la opción que mejor te describe.';
			case 'onboarding.currentMethod.options.excel': return 'Excel / Hojas de cálculo';
			case 'onboarding.currentMethod.options.notebook': return 'Cuaderno / Notas';
			case 'onboarding.currentMethod.options.mental': return 'Memoria (Mental)';
			case 'onboarding.currentMethod.options.none': return 'No llevo control';
			case 'onboarding.featuresShowcase.title': return 'Funciones disponibles y en desarrollo ✨';
			case 'onboarding.featuresShowcase.subtitle': return 'Transacciones listas para usar. Más funciones en camino.';
			case 'onboarding.featuresShowcase.available': return 'DISPONIBLE AHORA';
			case 'onboarding.featuresShowcase.comingSoon': return 'PRÓXIMAMENTE';
			case 'onboarding.featuresShowcase.features.income': return 'Ingresos';
			case 'onboarding.featuresShowcase.features.expense': return 'Egresos';
			case 'onboarding.featuresShowcase.features.transfer': return 'Transfer';
			case 'onboarding.featuresShowcase.features.loans': return 'Préstamos';
			case 'onboarding.featuresShowcase.features.goals': return 'Metas';
			case 'onboarding.featuresShowcase.features.budgets': return 'Presupuestos';
			case 'onboarding.featuresShowcase.features.investments': return 'Inversiones';
			case 'onboarding.featuresShowcase.features.cloud': return 'MoneyT Cloud';
			case 'onboarding.featuresShowcase.features.openBanking': return 'Open Banking';
			case 'onboarding.complete.title': return '¡Estás listo para despegar! 🚀';
			case 'onboarding.complete.subtitle': return 'Registra tu primera transacción y mira cómo sube tu probabilidad de éxito 📈';
			case 'onboarding.complete.stats.title': return 'Probabilidad de éxito';
			case 'onboarding.complete.stats.before': return 'Antes de MoneyT';
			case 'onboarding.complete.stats.after': return 'Con MoneyT';
			case 'onboarding.buttons.start': return 'Comenzar ahora 🚀';
			case 'onboarding.buttons.fixIt': return 'Solucionalo hoy ⚡';
			case 'onboarding.buttons.actionContinue': return 'Continuar';
			case 'onboarding.buttons.setGoal': return 'Fijar mi meta 🎯';
			case 'onboarding.buttons.wantControl': return '¡Quiero este control!';
			case 'onboarding.buttons.great': return '¡Genial, vamos a verlo!';
			case 'onboarding.buttons.firstTransaction': return 'Registrar mi primera transacción ➕';
			case 'onboarding.buttons.skip': return 'Saltar';
			case 'dashboard.greeting': return 'Bienvenido a MoneyT';
			case 'dashboard.balance.total': return 'Balance Total';
			case 'dashboard.balance.income': return 'INGRESOS';
			case 'dashboard.balance.expenses': return 'GASTOS';
			case 'dashboard.balance.thisMonth': return 'este mes';
			case 'dashboard.actions.income': return 'Ingreso';
			case 'dashboard.actions.expense': return 'Gasto';
			case 'dashboard.actions.transfer': return 'Transferencia';
			case 'dashboard.actions.all': return 'Ver todos';
			case 'dashboard.wallets.title': return 'Cuentas';
			case 'dashboard.wallets.count': return ({required Object n}) => '${n} cuentas';
			case 'dashboard.wallets.more': return ({required Object n}) => '+${n} cuentas más';
			case 'dashboard.wallets.viewDetails': return ({required Object name}) => 'Ver detalles de ${name}';
			case 'dashboard.transactions.title': return 'Transacciones Recientes';
			case 'dashboard.transactions.subtitle': return 'Últimas 5 transacciones';
			case 'dashboard.transactions.empty': return 'No hay transacciones recientes';
			case 'dashboard.transactions.emptySubtitle': return 'Tus transacciones aparecerán aquí';
			case 'dashboard.transactions.more': return ({required Object n}) => '+${n} transacciones más';
			case 'dashboard.customize': return 'Personalizar';
			case 'dashboard.widgets.balance.title': return 'Balance Total';
			case 'dashboard.widgets.balance.description': return 'Muestra tu estado financiero general';
			case 'dashboard.widgets.quickActions.title': return 'Acciones Rápidas';
			case 'dashboard.widgets.quickActions.description': return 'Acceso rápido a transacciones comunes';
			case 'dashboard.widgets.wallets.title': return 'Cuentas';
			case 'dashboard.widgets.wallets.description': return 'Resumen de tus cuentas';
			case 'dashboard.widgets.loans.title': return 'Préstamos';
			case 'dashboard.widgets.loans.description': return 'Rastrea dinero prestado';
			case 'dashboard.widgets.transactions.title': return 'Transacciones Recientes';
			case 'dashboard.widgets.transactions.description': return 'Última actividad financiera';
			case 'dashboard.widgets.categoryBreakdown.title': return 'Desglose por Categoría';
			case 'dashboard.widgets.categoryBreakdown.description': return 'Desglose mensual';
			case 'dashboard.widgets.categoryBreakdown.empty_message': return 'No hay transacciones registradas este mes.';
			case 'dashboard.widgets.categoryBreakdown.others': return 'Otros';
			case 'dashboard.widgets.categoryBreakdown.back': return 'Atrás';
			case 'dashboard.widgets.categoryBreakdown.monthlyBudget': return 'Presupuesto mensual';
			case 'dashboard.widgets.categoryBreakdown.leftover': return ({required Object amount}) => 'Te quedan ${amount} de ingresos.';
			case 'dashboard.widgets.categoryBreakdown.exceeded': return ({required Object amount}) => 'Has excedido tus ingresos por ${amount}.';
			case 'dashboard.widgets.categoryBreakdown.noIncome': return ({required Object amount}) => 'Gastos registrados: ${amount} (Sin ingresos)';
			case 'dashboard.widgets.chartAccounts.title': return 'Plan de Cuentas';
			case 'dashboard.widgets.chartAccounts.description': return 'Resumen de estructura de cuentas';
			case 'dashboard.widgets.creditCards.title': return 'Tarjetas de Crédito';
			case 'dashboard.widgets.creditCards.description': return 'Balances y límites de tarjetas';
			case 'dashboard.widgets.settings.title': return 'Personalizar Dashboard';
			case 'dashboard.widgets.settings.subtitle': return 'Organiza y gestiona los widgets de tu inicio.';
			case 'dashboard.widgets.settings.reset.button': return 'Restaurar diseño por defecto';
			case 'dashboard.widgets.settings.reset.dialogTitle': return 'Restaurar diseño';
			case 'dashboard.widgets.settings.reset.dialogContent': return '¿Restaurar el dashboard al diseño por defecto? Esto devolverá todos los widgets a su posición original.';
			case 'dashboard.widgets.settings.reset.cancel': return 'Cancelar';
			case 'dashboard.widgets.settings.reset.confirm': return 'Restaurar';
			case 'dashboard.widgets.settings.reset.success': return 'Diseño restaurado por defecto';
			case 'dashboard.widgets.settings.saveSuccess': return '¡Cambios guardados exitosamente!';
			case 'dashboard.widgets.settings.saveError': return ({required Object error}) => 'Error al guardar cambios: ${error}';
			case 'dashboard.widgets.settings.saving': return 'Guardando...';
			case 'dashboard.widgets.settings.save': return 'Guardar Cambios';
			case 'wallets.title': return 'Billeteras';
			case 'wallets.empty.title': return 'No hay billeteras';
			case 'wallets.empty.message': return 'Añade tu primera billetera para comenzar a rastrear tus finanzas.';
			case 'wallets.empty.action': return 'Crear Billetera';
			case 'wallets.emptyArchived.title': return 'No hay billeteras archivadas';
			case 'wallets.emptyArchived.message': return 'Las billeteras archivadas aparecerán aquí.';
			case 'wallets.filter.active': return 'Activas';
			case 'wallets.filter.archived': return 'Archivadas';
			case 'wallets.filter.all': return 'Todas';
			case 'wallets.form.newTitle': return 'Nueva billetera';
			case 'wallets.form.editTitle': return 'Editar billetera';
			case 'wallets.form.name': return 'Nombre de billetera';
			case 'wallets.form.namePlaceholder': return 'Ingresa el nombre de la billetera';
			case 'wallets.form.nameRequired': return 'El nombre es requerido';
			case 'wallets.form.description': return 'Descripción';
			case 'wallets.form.descriptionPlaceholder': return 'Descripción opcional para esta billetera';
			case 'wallets.form.currency': return 'Moneda';
			case 'wallets.form.parent': return 'Billetera padre (opcional)';
			case 'wallets.form.parentEmpty': return 'No hay billeteras disponibles como padre';
			case 'wallets.form.chartAccount': return 'Cuenta contable asociada';
			case 'wallets.form.chartAccountLocked': return 'La cuenta contable no puede ser modificada';
			case 'wallets.form.createSuccess': return 'Billetera creada con éxito';
			case 'wallets.form.updateSuccess': return 'Billetera actualizada con éxito';
			case 'wallets.form.loadParentError': return ({required Object error}) => 'Error al cargar billeteras padre: ${error}';
			case 'wallets.form.loadChartAccountError': return ({required Object error}) => 'Error al cargar cuenta contable: ${error}';
			case 'wallets.delete.dialogTitle': return 'Eliminar billetera';
			case 'wallets.delete.dialogMessage': return ({required Object name}) => '¿Estás seguro de eliminar ${name}?';
			case 'wallets.delete.cancel': return 'Cancelar';
			case 'wallets.delete.confirm': return 'Eliminar';
			case 'wallets.delete.success': return 'Billetera eliminada con éxito';
			case 'wallets.delete.error': return ({required Object error}) => 'Error al eliminar: ${error}';
			case 'wallets.errors.load': return 'Error al cargar las billeteras';
			case 'wallets.errors.retry': return 'Reintentar';
			case 'wallets.errors.comingSoon': return ({required Object name}) => '${name} próximamente';
			case 'wallets.subtitle.mainAccount': return 'Cuenta principal';
			case 'wallets.subtitle.cashDigital': return 'Efectivo y digital';
			case 'wallets.subtitle.count': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: '${n} billetera',
				other: '${n} billeteras',
			);
			case 'wallets.subtitle.account': return 'Cuenta';
			case 'wallets.subtitle.physicalCash': return 'Efectivo físico';
			case 'wallets.subtitle.digitalWallet': return 'Billetera digital';
			case 'wallets.options.viewTransactions': return 'Ver transacciones';
			case 'wallets.options.viewTransactionsSubtitle': return 'Ver todas las transacciones';
			case 'wallets.options.transferFunds': return 'Transferir fondos';
			case 'wallets.options.transferFundsSubtitle': return 'Mover dinero entre billeteras';
			case 'wallets.options.editWallet': return 'Editar billetera';
			case 'wallets.options.editWalletSubtitle': return 'Modificar detalles';
			case 'wallets.options.duplicateWallet': return 'Duplicar billetera';
			case 'wallets.options.duplicateWalletSubtitle': return 'Crear copia de esta billetera';
			case 'wallets.options.archiveWallet': return 'Archivar billetera';
			case 'wallets.options.archiveWalletSubtitle': return 'Ocultar de la vista principal';
			case 'wallets.options.unarchiveWallet': return 'Desarchivar billetera';
			case 'wallets.options.unarchiveWalletSubtitle': return 'Restaurar a la vista principal';
			case 'wallets.options.deleteWallet': return 'Eliminar billetera';
			case 'wallets.options.deleteWalletSubtitle': return 'Eliminar permanentemente';
			case 'wallets.options.defaultTitle': return 'Billetera';
			case 'loans.title': return 'Préstamos';
			case 'loans.filter.active': return 'Préstamos Activos';
			case 'loans.filter.history': return 'Historial';
			case 'loans.filter.all': return 'Todos';
			case 'loans.filter.pending': return 'Pendientes';
			case 'loans.filter.lent': return 'Prestados';
			case 'loans.filter.borrowed': return 'Recibidos';
			case 'loans.summary.netBalance': return 'BALANCE NETO';
			case 'loans.summary.activeLoans': return 'PRÉSTAMOS ACTIVOS';
			case 'loans.summary.noActive': return 'Sin préstamos activos';
			case 'loans.summary.lent': return ({required Object n}) => '${n} prestados';
			case 'loans.summary.borrowed': return ({required Object n}) => '${n} recibidos';
			case 'loans.summary.pending': return ({required Object n}) => '${n} pendientes';
			case 'loans.card.lent': return 'Has prestado';
			case 'loans.card.borrowed': return 'Te han prestado';
			case 'loans.card.active': return ({required Object n}) => '${n} activos';
			case 'loans.card.multiple': return ({required Object n}) => '${n} préstamos';
			case 'loans.card.transactions': return ({required Object n}) => '${n} transacciones';
			case 'loans.card.overdue': return ({required Object n}) => 'Vencido por ${n} días';
			case 'loans.card.due': return ({required Object date}) => 'Vence ${date}';
			case 'loans.form.newTitle': return 'Nuevo Préstamo';
			case 'loans.form.editTitle': return 'Editar Préstamo';
			case 'loans.form.type': return 'Tipo de préstamo';
			case 'loans.form.lend': return 'Yo presto';
			case 'loans.form.borrow': return 'Me prestan';
			case 'loans.form.contact': return 'Contacto';
			case 'loans.form.contactPlaceholder': return 'Seleccionar contacto';
			case 'loans.form.account': return 'Desde cuenta';
			case 'loans.form.accountPlaceholder': return 'Seleccionar cuenta';
			case 'loans.form.amount': return 'Monto';
			case 'loans.form.description': return 'Descripción';
			case 'loans.form.date': return 'Fecha';
			case 'loans.form.dueDate': return 'Fecha límite';
			case 'loans.form.selectDate': return 'Seleccionar fecha';
			case 'loans.form.optional': return '(Opcional)';
			case 'loans.form.createTransaction': return 'Crear registro de transacción';
			case 'loans.form.recordAutomatically': return 'Registrar transacción automáticamente';
			case 'loans.form.transactionCategory': return 'Categoría de transacción';
			case 'loans.form.category': return 'Categoría';
			case 'loans.form.categoryPlaceholder': return 'Seleccionar categoría';
			case 'loans.form.save': return 'Guardar Préstamo';
			case 'loans.form.successCreate': return 'Préstamo creado con éxito';
			case 'loans.form.successUpdate': return 'Préstamo actualizado con éxito';
			case 'loans.form.contactRequired': return 'El contacto es obligatorio';
			case 'loans.form.accountRequired': return 'La cuenta es obligatoria';
			case 'loans.form.amountRequired': return 'El monto es obligatorio';
			case 'loans.detail.title': return 'Detalles del Préstamo';
			case 'loans.detail.deleteTitle': return 'Eliminar Préstamo';
			case 'loans.detail.deleteMessage': return '¿Estás seguro de que deseas eliminar este préstamo?';
			case 'loans.detail.deleteSuccess': return 'Préstamo eliminado exitosamente';
			case 'loans.detail.deleteError': return ({required Object error}) => 'Error al eliminar el préstamo: ${error}';
			case 'loans.detail.notFound': return 'Préstamo no encontrado';
			case 'loans.detail.progress': return 'Progreso del Préstamo';
			case 'loans.detail.info': return 'Información del Préstamo';
			case 'loans.detail.pay': return 'Pagar';
			case 'loans.detail.viewHistory': return 'Ver Historial Completo';
			case 'loans.detail.original': return ({required Object amount}) => 'Original: ${amount}';
			case 'loans.detail.section': return 'Información del Préstamo';
			case 'loans.detail.activeSummary': return 'Resumen Activo';
			case 'loans.detail.activeLent': return 'Prestaste (Activo)';
			case 'loans.detail.activeBorrowed': return 'Te Prestaron (Activo)';
			case 'loans.detail.activeNet': return 'Posición Neta (Activa)';
			case 'loans.detail.activeTotal': return 'Total Préstamos Activos';
			case 'loans.detail.startDate': return 'Inicio del Préstamo';
			case 'loans.detail.dueDate': return 'Fecha de Vencimiento';
			case 'loans.detail.type.label': return 'Tipo de Préstamo';
			case 'loans.detail.type.personal': return 'Préstamo Personal';
			case 'loans.detail.type.borrowed': return 'Préstamo Recibido';
			case 'loans.detail.type.auto': return 'Préstamo Automotriz';
			case 'loans.detail.type.mortgage': return 'Hipoteca';
			case 'loans.detail.type.student': return 'Préstamo Estudiantil';
			case 'loans.detail.payment.history': return 'Historial de Pagos';
			case 'loans.detail.payment.date': return ({required Object date}) => 'Pago el ${date}';
			case 'loans.detail.payment.transactionId': return ({required Object id}) => 'ID Transacción: ${id}';
			case 'loans.detail.payment.paid': return ({required Object amount}) => '${amount} pagado';
			case 'loans.detail.payment.remaining': return ({required Object amount}) => '${amount} restante';
			case 'loans.share.title': return 'Compartir Préstamo';
			case 'loans.share.contactTitle': return 'Compartir Préstamos';
			case 'loans.share.button': return 'Compartir';
			case 'loans.share.copy': return 'Copiar Texto';
			case 'loans.share.message': return 'Aquí está mi estado de cuenta del préstamo:';
			case 'loans.share.contactMessage': return ({required Object name}) => 'Resumen de Préstamos con ${name}:';
			case 'loans.share.error': return ({required Object error}) => 'Error al compartir imagen: ${error}';
			case 'loans.share.contactCopied': return '¡Resumen copiado al portapapeles!';
			case 'loans.share.activeLoans': return ({required Object n}) => 'Préstamos Activos (${n}):';
			case 'loans.share.loanItem': return ({required Object description, required Object amount, required Object date, required Object percent}) => '• ${description}: ${amount} (Fecha: ${date}) - ${percent}% pagado';
			case 'loans.share.loanStatement': return 'MoneyT - Estado de Cuenta';
			case 'loans.share.loanSummary': return 'MoneyT - Resumen de Préstamos';
			case 'loans.share.personalLoan': return 'Préstamo Personal';
			case 'loans.share.remaining': return ({required Object amount}) => 'Saldo Restante: ${amount}';
			case 'loans.share.remainingLabel': return 'Saldo Restante';
			case 'loans.share.original': return ({required Object amount}) => 'de ${amount} original';
			case 'loans.share.progress': return ({required Object percent}) => 'Progreso: ${percent}% Pagado';
			case 'loans.share.progressLabel': return 'Progreso de Pago';
			case 'loans.share.paidSuffix': return 'Pagado';
			case 'loans.share.date': return ({required Object date}) => 'Fecha: ${date}';
			case 'loans.share.dateLabel': return 'Fecha del Préstamo';
			case 'loans.share.contact': return ({required Object name}) => 'Contacto: ${name}';
			case 'loans.share.contactLabel': return 'Contacto';
			case 'loans.share.generated': return ({required Object date}) => 'Generado el ${date}';
			case 'loans.share.generatedLabel': return ({required Object date}) => 'Generado el ${date}';
			case 'loans.share.totalActive': return ({required Object n}) => 'Total Activos: ${n} préstamos';
			case 'loans.share.active': return 'activos';
			case 'loans.share.poweredBy': return 'Desarrollado por MoneyT • moneyt.io';
			case 'loans.share.copied': return '¡Detalles copiados al portapapeles!';
			case 'loans.share.netBalance': return ({required Object amount, required Object status}) => 'Balance Neto: ${amount} (${status})';
			case 'loans.share.netBalanceLabel': return 'Balance Neto';
			case 'loans.share.owed': return 'Te deben';
			case 'loans.share.owe': return 'Debes';
			case 'loans.share.lent': return ({required Object amount}) => 'Prestaste: ${amount}';
			case 'loans.share.lentLabel': return 'Prestaste';
			case 'loans.share.borrowed': return ({required Object amount}) => 'Pediste: ${amount}';
			case 'loans.share.borrowedLabel': return 'Pediste';
			case 'loans.share.contactSummary': return ({required Object name}) => '${name} - Resumen de Préstamos';
			case 'loans.payment.title': return 'Registrar Pago';
			case 'loans.payment.amount': return 'Monto del Pago';
			case 'loans.payment.amountPlaceholder': return '0.00';
			case 'loans.payment.amountRequired': return 'El monto es requerido';
			case 'loans.payment.invalidAmount': return 'Ingresa un monto válido';
			case 'loans.payment.exceedsBalance': return 'El monto no puede exceder el saldo restante';
			case 'loans.payment.date': return 'Fecha de Pago';
			case 'loans.payment.account': return 'Recibido en cuenta';
			case 'loans.payment.selectAccount': return 'Seleccionar cuenta';
			case 'loans.payment.details': return 'Detalles del pago';
			case 'loans.payment.detailsPlaceholder': return 'Agregar notas (opcional)';
			case 'loans.payment.success': return 'Pago registrado con éxito';
			case 'loans.payment.error': return ({required Object error}) => 'Error al registrar pago: ${error}';
			case 'loans.payment.errorAmount': return 'Ingresa un monto de pago válido';
			case 'loans.payment.errorAccount': return 'Por favor selecciona una cuenta';
			case 'loans.payment.errorLoading': return ({required Object error}) => 'Error al cargar datos: ${error}';
			case 'loans.payment.summary.title': return 'Resumen del pago';
			case 'loans.payment.summary.defaultTitle': return 'Préstamo';
			case 'loans.payment.summary.amount': return 'Monto del pago';
			case 'loans.payment.summary.remaining': return 'Saldo restante';
			case 'loans.payment.summary.progress': return 'Nuevo progreso';
			case 'loans.payment.summary.description': return ({required Object loan, required Object contact}) => '${loan} a ${contact}';
			case 'loans.payment.summary.unknownContact': return 'Contacto Desconocido';
			case 'loans.payment.summary.total': return ({required Object amount}) => '${amount} total';
			case 'loans.payment.summary.paid': return ({required Object amount}) => 'Pagado: ${amount}';
			case 'loans.payment.summary.remainingLabel': return ({required Object amount}) => 'Restante: ${amount}';
			case 'loans.payment.quick.full': return ({required Object amount}) => 'Pago Completo (${amount})';
			case 'loans.payment.quick.half': return ({required Object amount}) => 'Mitad (${amount})';
			case 'loans.contactDetail.titleWith': return ({required Object name}) => 'Préstamos con ${name}';
			case 'loans.given': return 'Préstamo otorgado';
			case 'loans.received': return 'Préstamo recibido';
			case 'loans.history.title': return 'Historial de Préstamos';
			case 'loans.history.section': return 'Historial completo';
			case 'loans.history.totalLoaned': return 'Total prestado';
			case 'loans.history.noLoans': return 'No se encontraron préstamos con este filtro.';
			case 'loans.history.filter.all': return 'Todos';
			case 'loans.history.filter.lent': return 'Prestados';
			case 'loans.history.filter.borrowed': return 'Recibidos';
			case 'loans.history.filter.completed': return 'Completados';
			case 'loans.history.filter.title': return 'Filtrar Historial';
			case 'loans.history.filter.reset': return 'Restablecer';
			case 'loans.history.filter.apply': return 'Aplicar Filtros';
			case 'loans.history.filter.dateRange': return 'Rango de Fechas';
			case 'loans.history.filter.amountRange': return 'Rango de Montos';
			case 'loans.history.filter.startDate': return 'Fecha Inicio';
			case 'loans.history.filter.endDate': return 'Fecha Fin';
			case 'loans.history.filter.select': return 'Seleccionar';
			case 'loans.history.headers.lent': return 'Préstamos Otorgados';
			case 'loans.history.headers.borrowed': return 'Préstamos Recibidos';
			case 'loans.history.headers.completed': return 'Préstamos Completados';
			case 'loans.history.headers.active': return 'Préstamos Activos';
			case 'loans.history.headers.cancelled': return 'Préstamos Cancelados';
			case 'loans.history.headers.writtenOff': return 'Préstamos Anulados';
			case 'loans.history.item.defaultTitle': return 'Préstamo';
			case 'loans.history.item.date': return ({required Object date}) => 'Fecha: ${date}';
			case 'loans.history.item.lent': return 'Prestado';
			case 'loans.history.item.borrowed': return 'Recibido';
			case 'loans.history.item.status.completed': return 'Completado';
			case 'loans.history.item.status.active': return 'Activo';
			case 'loans.history.item.status.cancelled': return 'Cancelado';
			case 'loans.history.item.status.writtenOff': return 'Anulado';
			case 'loans.history.summary.title': return 'Resumen Histórico';
			case 'loans.history.summary.viewDetails': return 'Ver Detalles';
			case 'loans.history.summary.hideDetails': return 'Ocultar Detalles';
			case 'loans.history.summary.outstandingLent': return 'Pendiente de Cobro';
			case 'loans.history.summary.outstandingBorrowed': return 'Pendiente de Pago';
			case 'loans.history.summary.netPosition': return 'Posición Neta (Activa)';
			case 'loans.history.summary.totalLent': return 'Total Prestado Histórico';
			case 'loans.history.summary.totalBorrowed': return 'Total Recibido Histórico';
			case 'loans.history.summary.totalRepaidToYou': return 'Total Reembolsado a Ti';
			case 'loans.history.summary.totalYouRepaid': return 'Total que Reembolsaste';
			case 'loans.history.summary.totalLoans': return 'Total de Préstamos';
			case 'loans.history.summary.completedLoans': return 'Préstamos Completados';
			case 'loans.item.due': return ({required Object date}) => 'Vence: ${date}';
			case 'loans.item.paidAmount': return ({required Object amount}) => 'Pagado: ${amount}';
			case 'loans.item.remaining': return ({required Object amount}) => 'Restante: ${amount}';
			case 'loans.item.percentPaid': return ({required Object percent}) => '${percent}% pagado';
			case 'loans.section.activeLoans': return 'Préstamos Activos';
			case 'loans.section.loansCount': return ({required Object n}) => '${n} préstamos';
			case 'loans.empty.title': return 'No hay préstamos activos';
			case 'loans.empty.message': return 'Comienza a llevar el registro de tus préstamos.';
			case 'loans.empty.action': return 'Agregar Préstamo';
			case 'categories.title': return 'Categorías';
			case 'categories.form.newTitle': return 'Nueva Categoría';
			case 'categories.form.editTitle': return 'Editar Categoría';
			case 'categories.form.name': return 'Nombre de categoría';
			case 'categories.form.namePlaceholder': return 'Ingresa el nombre de la categoría';
			case 'categories.form.nameRequired': return 'El nombre es requerido';
			case 'categories.form.parent': return 'Categoría Padre (Opcional)';
			case 'categories.form.noParent': return 'Sin categoría padre';
			case 'categories.form.asSubcategory': return 'Se creará como subcategoría';
			case 'categories.form.asRoot': return 'Se creará como categoría principal';
			case 'categories.form.active': return 'Categoría Activa';
			case 'categories.form.activeDescription': return 'Habilitar esta categoría para nuevas transacciones';
			case 'categories.form.selectIcon': return 'Seleccionar Icono';
			case 'categories.form.selectColor': return 'Seleccionar Color';
			case 'categories.form.saveSuccess': return 'Categoría guardada exitosamente';
			case 'categories.form.saveError': return ({required Object error}) => 'Error al guardar categoría: ${error}';
			case 'categories.parentSelection.title': return 'Seleccionar Categoría Padre';
			case 'categories.parentSelection.subtitle': return 'Toca para seleccionar una categoría padre';
			case 'categories.parentSelection.noParent': return 'Sin categoría padre';
			case 'categories.incomeCategory': return 'Categoría de ingreso';
			case 'categories.expenseCategory': return 'Categoría de gasto';
			case 'categories.report.title': return 'Desglose Avanzado';
			case 'categories.report.timeFilter': return 'Filtro Temporal';
			case 'categories.report.thisMonth': return 'Este Mes';
			case 'categories.report.lastMonth': return 'Mes Pasado';
			case 'categories.report.thisYear': return 'Este Año';
			case 'categories.report.allTime': return 'Todo el Tiempo';
			case 'categories.report.details': return 'Detalle por Categorías';
			case 'categories.report.noTransactions': return 'Sin transacciones';
			case 'categories.report.income': return 'Ingresos';
			case 'categories.report.expense': return 'Gastos';
			case 'backups.title': return 'Copia de Seguridad';
			case 'backups.menu.settings': return 'Configuración de copia de seguridad';
			case 'backups.menu.comingSoon': return 'Configuración de copia de seguridad próximamente';
			case 'backups.filters.all': return 'Todos';
			case 'backups.filters.auto': return 'Auto';
			case 'backups.filters.manual': return 'Manual';
			case 'backups.filters.thisMonth': return 'Este Mes';
			case 'backups.filters.lastMonth': return 'Mes Pasado';
			case 'backups.filters.thisYear': return 'Este Año';
			case 'backups.filters.lastYear': return 'Año Pasado';
			case 'backups.status.loading': return 'Cargando...';
			case 'backups.status.error': return 'Error al cargar copias de seguridad';
			case 'backups.status.empty': return 'No se encontraron copias de seguridad';
			case 'backups.status.emptyAction': return 'Crea tu primera copia de seguridad usando el botón +';
			case 'backups.status.success': return 'Éxito';
			case 'backups.status.created': return 'Copia de seguridad creada con éxito';
			case 'backups.status.createError': return ({required Object error}) => 'Error al crear copia: ${error}';
			case 'backups.status.restoreError': return ({required Object error}) => 'Error al restaurar copia: ${error}';
			case 'backups.status.deleteError': return ({required Object error}) => 'Error al eliminar copia: ${error}';
			case 'backups.actions.create': return 'Crear Copia';
			case 'backups.actions.import': return 'Importar Copia';
			case 'backups.actions.restore': return 'Restaurar';
			case 'backups.actions.delete': return 'Eliminar';
			case 'backups.actions.share': return 'Compartir';
			case 'backups.actions.cancel': return 'Cancelar';
			case 'backups.actions.retry': return 'Reintentar';
			case 'backups.actions.ok': return 'OK';
			case 'backups.dialogs.info.title': return 'Información de Copia';
			case 'backups.dialogs.info.file': return 'Archivo:';
			case 'backups.dialogs.info.size': return 'Tamaño:';
			case 'backups.dialogs.info.created': return 'Creado:';
			case 'backups.dialogs.info.transactions': return 'Transacciones:';
			case 'backups.dialogs.restore.title': return 'Restaurar Copia';
			case 'backups.dialogs.restore.content': return ({required Object file}) => '¿Estás seguro de que deseas restaurar desde "${file}"? La base de datos actual será reemplazada.';
			case 'backups.dialogs.restore.success': return 'Restauración iniciada. La aplicación podría necesitar reiniciarse.';
			case 'backups.dialogs.delete.title': return 'Eliminar Copia';
			case 'backups.dialogs.delete.content': return ({required Object file}) => '¿Estás seguro de que deseas eliminar el archivo "${file}"? Esta acción no se puede deshacer.';
			case 'backups.dialogs.delete.success': return 'Copia de seguridad eliminada.';
			case 'backups.stats.title': return 'Estadísticas de Copias';
			case 'backups.stats.totalBackups': return 'Total de Copias';
			case 'backups.stats.totalSize': return 'Tamaño Total';
			case 'backups.stats.oldest': return 'Copia Más Antigua';
			case 'backups.stats.latest': return 'Copia Más Reciente';
			case 'backups.stats.autoBackupStatus': return 'Estado de Copia Auto';
			case 'backups.stats.active': return 'Activo';
			case 'backups.stats.inactive': return 'Inactivo';
			case 'backups.options.restore.title': return 'Restaurar copia';
			case 'backups.options.restore.subtitle': return 'Reemplazar datos actuales con esta copia';
			case 'backups.options.share.title': return 'Compartir copia';
			case 'backups.options.share.subtitle': return 'Enviar archivo a otro dispositivo';
			case 'backups.options.delete.title': return 'Eliminar copia';
			case 'backups.options.delete.subtitle': return 'Esta acción no se puede deshacer';
			case 'backups.options.latestBadge': return 'Reciente';
			case 'backups.options.latestFile': return 'Copia más reciente';
			case 'backups.options.backupFile': return 'Archivo de copia';
			case 'backups.format.auto': return ({required Object date}) => 'Copia Auto - ${date}';
			case 'backups.format.manual': return ({required Object date}) => 'Copia Manual - ${date}';
			case 'backups.format.initial': return 'Copia Inicial';
			case 'backups.format.generic': return ({required Object date}) => 'Copia - ${date}';
			default: return null;
		}
	}
}

