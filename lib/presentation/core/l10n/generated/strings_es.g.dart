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
	@override late final _AppStringsNavigationEs navigation = _AppStringsNavigationEs._(_root);
	@override late final _AppStringsTransactionsEs transactions = _AppStringsTransactionsEs._(_root);
	@override late final _AppStringsContactsEs contacts = _AppStringsContactsEs._(_root);
	@override late final _AppStringsErrorsEs errors = _AppStringsErrorsEs._(_root);
	@override late final _AppStringsSettingsEs settings = _AppStringsSettingsEs._(_root);
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
	@override String get removeFromFavorites => 'Quitar de favoritos';
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
}

// Path: transactions
class _AppStringsTransactionsEs extends AppStringsTransactionsEn {
	_AppStringsTransactionsEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override late final _AppStringsTransactionsTypesEs types = _AppStringsTransactionsTypesEs._(_root);
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
	@override String get errorLoading => 'Error al cargar contactos';
	@override String get contactSaved => 'Contacto guardado exitosamente';
	@override String get errorSaving => 'Error al guardar contacto';
	@override String get noContactInfo => 'Sin información de contacto';
	@override String get importContact => 'Importar contacto';
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
	@override String get loadingAccounts => 'Error al cargar las cuentas: {error}';
	@override String get unexpected => 'Error inesperado';
}

// Path: settings
class _AppStringsSettingsEs extends AppStringsSettingsEn {
	_AppStringsSettingsEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get appearance => 'Apariencia';
	@override String get darkTheme => 'Tema oscuro';
	@override String get lightTheme => 'Tema claro';
	@override String get systemTheme => 'Tema del sistema';
}

// Path: transactions.types
class _AppStringsTransactionsTypesEs extends AppStringsTransactionsTypesEn {
	_AppStringsTransactionsTypesEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get income => 'Ingreso';
	@override String get expense => 'Gasto';
	@override String get transfer => 'Transferencia';
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
			case 'common.removeFromFavorites': return 'Quitar de favoritos';
			case 'navigation.home': return 'Inicio';
			case 'navigation.transactions': return 'Transacciones';
			case 'navigation.contacts': return 'Contactos';
			case 'navigation.settings': return 'Configuración';
			case 'navigation.wallets': return 'Cuentas';
			case 'navigation.categories': return 'Categorías';
			case 'navigation.loans': return 'Préstamos';
			case 'navigation.charts': return 'Plan de Cuentas';
			case 'navigation.backups': return 'Respaldos';
			case 'transactions.types.income': return 'Ingreso';
			case 'transactions.types.expense': return 'Gasto';
			case 'transactions.types.transfer': return 'Transferencia';
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
			case 'contacts.errorLoading': return 'Error al cargar contactos';
			case 'contacts.contactSaved': return 'Contacto guardado exitosamente';
			case 'contacts.errorSaving': return 'Error al guardar contacto';
			case 'contacts.noContactInfo': return 'Sin información de contacto';
			case 'contacts.importContact': return 'Importar contacto';
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
			case 'errors.loadingAccounts': return 'Error al cargar las cuentas: {error}';
			case 'errors.unexpected': return 'Error inesperado';
			case 'settings.appearance': return 'Apariencia';
			case 'settings.darkTheme': return 'Tema oscuro';
			case 'settings.lightTheme': return 'Tema claro';
			case 'settings.systemTheme': return 'Tema del sistema';
			default: return null;
		}
	}
}

