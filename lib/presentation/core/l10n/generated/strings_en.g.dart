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
	late final AppStringsContactsEn contacts = AppStringsContactsEn.internal(_root);
	late final AppStringsErrorsEn errors = AppStringsErrorsEn.internal(_root);
	late final AppStringsSettingsEn settings = AppStringsSettingsEn.internal(_root);
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
	String get search => 'Search';
	String get clearSearch => 'Clear search';
	String get viewAll => 'View all';
	String get retry => 'Retry';
	String get add => 'Add';
	String get remove => 'Remove';
	String get moreOptions => 'More options';
	String get addToFavorites => 'Add to favorites';
	String get removeFromFavorites => 'Remove from favorites';
}

// Path: navigation
class AppStringsNavigationEn {
	AppStringsNavigationEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations
	String get home => 'Home';
	String get transactions => 'Transactions';
	String get contacts => 'Contacts';
	String get settings => 'Settings';
	String get wallets => 'Wallets';
	String get categories => 'Categories';
	String get loans => 'Loans';
	String get charts => 'Chart of Accounts';
	String get backups => 'Backups';
}

// Path: transactions
class AppStringsTransactionsEn {
	AppStringsTransactionsEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations
	late final AppStringsTransactionsTypesEn types = AppStringsTransactionsTypesEn.internal(_root);
}

// Path: contacts
class AppStringsContactsEn {
	AppStringsContactsEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations
	String get title => 'Contacts';
	String get addContact => 'Add Contact';
	String get editContact => 'Edit Contact';
	String get noContacts => 'No contacts';
	String get noContactsMessage => 'Add your first contact with the "+" button';
	String get searchContacts => 'Search contacts';
	String get deleteContact => 'Delete contact';
	String get confirmDelete => 'Are you sure you want to delete';
	String get contactDeleted => 'Contact deleted successfully';
	String get errorDeleting => 'Error deleting contact';
	String get errorLoading => 'Error loading contacts';
	String get contactSaved => 'Contact saved successfully';
	String get errorSaving => 'Error saving contact';
	String get noContactInfo => 'No contact information';
	late final AppStringsContactsFieldsEn fields = AppStringsContactsFieldsEn.internal(_root);
	late final AppStringsContactsValidationEn validation = AppStringsContactsValidationEn.internal(_root);
}

// Path: errors
class AppStringsErrorsEn {
	AppStringsErrorsEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations
	String get loadingAccounts => 'Error loading accounts: {error}';
	String get unexpected => 'Unexpected error';
}

// Path: settings
class AppStringsSettingsEn {
	AppStringsSettingsEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations
	String get appearance => 'Appearance';
	String get darkTheme => 'Dark theme';
	String get lightTheme => 'Light theme';
	String get systemTheme => 'System theme';
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

// Path: contacts.fields
class AppStringsContactsFieldsEn {
	AppStringsContactsFieldsEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations
	String get name => 'Name';
	String get email => 'Email';
	String get phone => 'Phone';
	String get address => 'Address';
	String get notes => 'Notes';
}

// Path: contacts.validation
class AppStringsContactsValidationEn {
	AppStringsContactsValidationEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations
	String get nameRequired => 'Name is required';
	String get invalidEmail => 'Invalid email';
	String get invalidPhone => 'Invalid phone';
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
			case 'common.search': return 'Search';
			case 'common.clearSearch': return 'Clear search';
			case 'common.viewAll': return 'View all';
			case 'common.retry': return 'Retry';
			case 'common.add': return 'Add';
			case 'common.remove': return 'Remove';
			case 'common.moreOptions': return 'More options';
			case 'common.addToFavorites': return 'Add to favorites';
			case 'common.removeFromFavorites': return 'Remove from favorites';
			case 'navigation.home': return 'Home';
			case 'navigation.transactions': return 'Transactions';
			case 'navigation.contacts': return 'Contacts';
			case 'navigation.settings': return 'Settings';
			case 'navigation.wallets': return 'Wallets';
			case 'navigation.categories': return 'Categories';
			case 'navigation.loans': return 'Loans';
			case 'navigation.charts': return 'Chart of Accounts';
			case 'navigation.backups': return 'Backups';
			case 'transactions.types.income': return 'Income';
			case 'transactions.types.expense': return 'Expense';
			case 'transactions.types.transfer': return 'Transfer';
			case 'contacts.title': return 'Contacts';
			case 'contacts.addContact': return 'Add Contact';
			case 'contacts.editContact': return 'Edit Contact';
			case 'contacts.noContacts': return 'No contacts';
			case 'contacts.noContactsMessage': return 'Add your first contact with the "+" button';
			case 'contacts.searchContacts': return 'Search contacts';
			case 'contacts.deleteContact': return 'Delete contact';
			case 'contacts.confirmDelete': return 'Are you sure you want to delete';
			case 'contacts.contactDeleted': return 'Contact deleted successfully';
			case 'contacts.errorDeleting': return 'Error deleting contact';
			case 'contacts.errorLoading': return 'Error loading contacts';
			case 'contacts.contactSaved': return 'Contact saved successfully';
			case 'contacts.errorSaving': return 'Error saving contact';
			case 'contacts.noContactInfo': return 'No contact information';
			case 'contacts.fields.name': return 'Name';
			case 'contacts.fields.email': return 'Email';
			case 'contacts.fields.phone': return 'Phone';
			case 'contacts.fields.address': return 'Address';
			case 'contacts.fields.notes': return 'Notes';
			case 'contacts.validation.nameRequired': return 'Name is required';
			case 'contacts.validation.invalidEmail': return 'Invalid email';
			case 'contacts.validation.invalidPhone': return 'Invalid phone';
			case 'errors.loadingAccounts': return 'Error loading accounts: {error}';
			case 'errors.unexpected': return 'Unexpected error';
			case 'settings.appearance': return 'Appearance';
			case 'settings.darkTheme': return 'Dark theme';
			case 'settings.lightTheme': return 'Light theme';
			case 'settings.systemTheme': return 'System theme';
			default: return null;
		}
	}
}

