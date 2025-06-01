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

// Path: errors
class _AppStringsErrorsEs extends AppStringsErrorsEn {
	_AppStringsErrorsEs._(AppStringsEs root) : this._root = root, super.internal(root);

	final AppStringsEs _root; // ignore: unused_field

	// Translations
	@override String get loadingAccounts => 'Error al cargar las cuentas: {error}';
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
			case 'errors.loadingAccounts': return 'Error al cargar las cuentas: {error}';
			case 'settings.appearance': return 'Apariencia';
			case 'settings.darkTheme': return 'Tema oscuro';
			case 'settings.lightTheme': return 'Tema claro';
			case 'settings.systemTheme': return 'Tema del sistema';
			default: return null;
		}
	}
}

