///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'strings.g.dart';

// Path: <root>
typedef AppStringsEn = AppStrings; // ignore: unused_element
class AppStrings implements BaseTranslations<AppLocale, AppStrings> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = AppStrings.of(context);
	static AppStrings of(BuildContext context) => InheritedLocaleData.of<AppLocale, AppStrings>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	AppStrings({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, AppStrings>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, AppStrings> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final AppStrings _root = this; // ignore: unused_field

	AppStrings $copyWith({TranslationMetadata<AppLocale, AppStrings>? meta}) => AppStrings(meta: meta ?? this.$meta);

	// Translations
	late final AppStringsAppEn app = AppStringsAppEn.internal(_root);
	late final AppStringsCommonEn common = AppStringsCommonEn.internal(_root);
	late final AppStringsNavigationEn navigation = AppStringsNavigationEn.internal(_root);
	late final AppStringsTransactionsEn transactions = AppStringsTransactionsEn.internal(_root);
	late final AppStringsErrorsEn errors = AppStringsErrorsEn.internal(_root);
}

// Path: app
class AppStringsAppEn {
	AppStringsAppEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations
	String get name => 'MoneyT';
	String get description => 'Financial Manager';
}

// Path: common
class AppStringsCommonEn {
	AppStringsCommonEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations
	String get save => 'Save';
	String get cancel => 'Cancel';
	String get delete => 'Delete';
	String get edit => 'Edit';
	String get loading => 'Loading...';
	String get error => 'Error';
	String get success => 'Success';
}

// Path: navigation
class AppStringsNavigationEn {
	AppStringsNavigationEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations
	String get dashboard => 'Dashboard';
	String get transactions => 'Transactions';
	String get loans => 'Loans';
	String get wallets => 'Wallets';
	String get categories => 'Categories';
	String get settings => 'Settings';
	String get contacts => 'Contacts';
}

// Path: transactions
class AppStringsTransactionsEn {
	AppStringsTransactionsEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations
	late final AppStringsTransactionsTypesEn types = AppStringsTransactionsTypesEn.internal(_root);
}

// Path: errors
class AppStringsErrorsEn {
	AppStringsErrorsEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations
	String get loadingAccounts => 'Error loading accounts: {error}';
}

// Path: transactions.types
class AppStringsTransactionsTypesEn {
	AppStringsTransactionsTypesEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations
	String get income => 'Income';
	String get expense => 'Expense';
	String get transfer => 'Transfer';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on AppStrings {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'app.name': return 'MoneyT';
			case 'app.description': return 'Financial Manager';
			case 'common.save': return 'Save';
			case 'common.cancel': return 'Cancel';
			case 'common.delete': return 'Delete';
			case 'common.edit': return 'Edit';
			case 'common.loading': return 'Loading...';
			case 'common.error': return 'Error';
			case 'common.success': return 'Success';
			case 'navigation.dashboard': return 'Dashboard';
			case 'navigation.transactions': return 'Transactions';
			case 'navigation.loans': return 'Loans';
			case 'navigation.wallets': return 'Wallets';
			case 'navigation.categories': return 'Categories';
			case 'navigation.settings': return 'Settings';
			case 'navigation.contacts': return 'Contacts';
			case 'transactions.types.income': return 'Income';
			case 'transactions.types.expense': return 'Expense';
			case 'transactions.types.transfer': return 'Transfer';
			case 'errors.loadingAccounts': return 'Error loading accounts: {error}';
			default: return null;
		}
	}
}

