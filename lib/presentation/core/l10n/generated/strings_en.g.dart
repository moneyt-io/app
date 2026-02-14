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
	late final AppStringsComponentsEn components = AppStringsComponentsEn.internal(_root);
	late final AppStringsNavigationEn navigation = AppStringsNavigationEn.internal(_root);
	late final AppStringsTransactionsEn transactions = AppStringsTransactionsEn.internal(_root);
	late final AppStringsContactsEn contacts = AppStringsContactsEn.internal(_root);
	late final AppStringsErrorsEn errors = AppStringsErrorsEn.internal(_root);
	late final AppStringsSettingsEn settings = AppStringsSettingsEn.internal(_root);
	late final AppStringsOnboardingEn onboarding = AppStringsOnboardingEn.internal(_root);
	late final AppStringsDashboardEn dashboard = AppStringsDashboardEn.internal(_root);
	late final AppStringsWalletsEn wallets = AppStringsWalletsEn.internal(_root);
	late final AppStringsLoansEn loans = AppStringsLoansEn.internal(_root);
	late final AppStringsCategoriesEn categories = AppStringsCategoriesEn.internal(_root);
	late final AppStringsBackupsEn backups = AppStringsBackupsEn.internal(_root);
}

// Path: app
class AppStringsAppEn {
	AppStringsAppEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'MoneyT'
	String get name => 'MoneyT';

	/// en: 'Financial Manager'
	String get description => 'Financial Manager';
}

// Path: common
class AppStringsCommonEn {
	AppStringsCommonEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Save'
	String get save => 'Save';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Delete'
	String get delete => 'Delete';

	/// en: 'Edit'
	String get edit => 'Edit';

	/// en: 'Loading...'
	String get loading => 'Loading...';

	/// en: 'Error'
	String get error => 'Error';

	/// en: 'Success'
	String get success => 'Success';

	/// en: 'Search'
	String get search => 'Search';

	/// en: 'Clear search'
	String get clearSearch => 'Clear search';

	/// en: 'View all'
	String get viewAll => 'View all';

	/// en: 'Retry'
	String get retry => 'Retry';

	/// en: 'Add'
	String get add => 'Add';

	/// en: 'Remove'
	String get remove => 'Remove';

	/// en: 'More options'
	String get moreOptions => 'More options';

	/// en: 'Add to favorites'
	String get addToFavorites => 'Add to favorites';

	/// en: 'Remove from favorites'
	String get removeFromFavorites => 'Remove from favorites';

	/// en: 'Today'
	String get today => 'Today';

	/// en: 'Yesterday'
	String get yesterday => 'Yesterday';
}

// Path: components
class AppStringsComponentsEn {
	AppStringsComponentsEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations
	late final AppStringsComponentsDateSelectionEn dateSelection = AppStringsComponentsDateSelectionEn.internal(_root);
	late final AppStringsComponentsSelectionEn selection = AppStringsComponentsSelectionEn.internal(_root);
	late final AppStringsComponentsContactSelectionEn contactSelection = AppStringsComponentsContactSelectionEn.internal(_root);
	late final AppStringsComponentsCategorySelectionEn categorySelection = AppStringsComponentsCategorySelectionEn.internal(_root);
	late final AppStringsComponentsCurrencySelectionEn currencySelection = AppStringsComponentsCurrencySelectionEn.internal(_root);
	late final AppStringsComponentsAccountSelectionEn accountSelection = AppStringsComponentsAccountSelectionEn.internal(_root);
	late final AppStringsComponentsParentWalletSelectionEn parentWalletSelection = AppStringsComponentsParentWalletSelectionEn.internal(_root);
	late final AppStringsComponentsWalletTypesEn walletTypes = AppStringsComponentsWalletTypesEn.internal(_root);
}

// Path: navigation
class AppStringsNavigationEn {
	AppStringsNavigationEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Home'
	String get home => 'Home';

	/// en: 'Transactions'
	String get transactions => 'Transactions';

	/// en: 'Contacts'
	String get contacts => 'Contacts';

	/// en: 'Settings'
	String get settings => 'Settings';

	/// en: 'Wallets'
	String get wallets => 'Wallets';

	/// en: 'Categories'
	String get categories => 'Categories';

	/// en: 'Loans'
	String get loans => 'Loans';

	/// en: 'Chart of Accounts'
	String get charts => 'Chart of Accounts';

	/// en: 'Backups'
	String get backups => 'Backups';

	/// en: 'Credit Cards'
	String get creditCards => 'Credit Cards';

	late final AppStringsNavigationSectionsEn sections = AppStringsNavigationSectionsEn.internal(_root);
}

// Path: transactions
class AppStringsTransactionsEn {
	AppStringsTransactionsEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Transactions'
	String get title => 'Transactions';

	late final AppStringsTransactionsTypesEn types = AppStringsTransactionsTypesEn.internal(_root);
	late final AppStringsTransactionsFilterEn filter = AppStringsTransactionsFilterEn.internal(_root);
	late final AppStringsTransactionsFormEn form = AppStringsTransactionsFormEn.internal(_root);
	late final AppStringsTransactionsErrorsEn errors = AppStringsTransactionsErrorsEn.internal(_root);
	late final AppStringsTransactionsEmptyEn empty = AppStringsTransactionsEmptyEn.internal(_root);
	late final AppStringsTransactionsListEn list = AppStringsTransactionsListEn.internal(_root);
	late final AppStringsTransactionsDetailEn detail = AppStringsTransactionsDetailEn.internal(_root);
	late final AppStringsTransactionsShareEn share = AppStringsTransactionsShareEn.internal(_root);
}

// Path: contacts
class AppStringsContactsEn {
	AppStringsContactsEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Contacts'
	String get title => 'Contacts';

	/// en: 'Add Contact'
	String get addContact => 'Add Contact';

	/// en: 'Edit Contact'
	String get editContact => 'Edit Contact';

	/// en: 'New contact'
	String get newContact => 'New contact';

	/// en: 'No contacts'
	String get noContacts => 'No contacts';

	/// en: 'Add your first contact with the "+" button'
	String get noContactsMessage => 'Add your first contact with the "+" button';

	/// en: 'Search contacts'
	String get searchContacts => 'Search contacts';

	/// en: 'Delete contact'
	String get deleteContact => 'Delete contact';

	/// en: 'Are you sure you want to delete'
	String get confirmDelete => 'Are you sure you want to delete';

	/// en: 'Contact deleted successfully'
	String get contactDeleted => 'Contact deleted successfully';

	/// en: 'Error deleting contact'
	String get errorDeleting => 'Error deleting contact';

	/// en: 'No search results'
	String get noSearchResults => 'No search results';

	/// en: 'No contacts match "$query". Try a different search term.'
	String noContactsMatch({required Object query}) => 'No contacts match "${query}". Try a different search term.';

	/// en: 'Error loading contacts'
	String get errorLoading => 'Error loading contacts';

	/// en: 'Contact saved successfully'
	String get contactSaved => 'Contact saved successfully';

	/// en: 'Error saving contact'
	String get errorSaving => 'Error saving contact';

	/// en: 'No contact information'
	String get noContactInfo => 'No contact information';

	/// en: 'Import contact'
	String get importContact => 'Import contact';

	/// en: 'Import contacts'
	String get importContacts => 'Import contacts';

	/// en: 'Import contact functionality coming soon'
	String get importContactSoon => 'Import contact functionality coming soon';

	late final AppStringsContactsFieldsEn fields = AppStringsContactsFieldsEn.internal(_root);
	late final AppStringsContactsPlaceholdersEn placeholders = AppStringsContactsPlaceholdersEn.internal(_root);
	late final AppStringsContactsValidationEn validation = AppStringsContactsValidationEn.internal(_root);
}

// Path: errors
class AppStringsErrorsEn {
	AppStringsErrorsEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Error loading accounts: $error'
	String loadingAccounts({required Object error}) => 'Error loading accounts: ${error}';

	/// en: 'Unexpected error'
	String get unexpected => 'Unexpected error';
}

// Path: settings
class AppStringsSettingsEn {
	AppStringsSettingsEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Settings'
	String get title => 'Settings';

	late final AppStringsSettingsAccountEn account = AppStringsSettingsAccountEn.internal(_root);
	late final AppStringsSettingsAppearanceEn appearance = AppStringsSettingsAppearanceEn.internal(_root);
	late final AppStringsSettingsDataEn data = AppStringsSettingsDataEn.internal(_root);
	late final AppStringsSettingsInfoEn info = AppStringsSettingsInfoEn.internal(_root);
	late final AppStringsSettingsLogoutEn logout = AppStringsSettingsLogoutEn.internal(_root);
	late final AppStringsSettingsSocialEn social = AppStringsSettingsSocialEn.internal(_root);
	late final AppStringsSettingsLanguageEn language = AppStringsSettingsLanguageEn.internal(_root);
	late final AppStringsSettingsMessagesEn messages = AppStringsSettingsMessagesEn.internal(_root);
}

// Path: onboarding
class AppStringsOnboardingEn {
	AppStringsOnboardingEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations
	late final AppStringsOnboardingWelcomeEn welcome = AppStringsOnboardingWelcomeEn.internal(_root);
	late final AppStringsOnboardingProblemStatementEn problemStatement = AppStringsOnboardingProblemStatementEn.internal(_root);
	late final AppStringsOnboardingSpecificProblemEn specificProblem = AppStringsOnboardingSpecificProblemEn.internal(_root);
	late final AppStringsOnboardingPersonalGoalEn personalGoal = AppStringsOnboardingPersonalGoalEn.internal(_root);
	late final AppStringsOnboardingSolutionPreviewEn solutionPreview = AppStringsOnboardingSolutionPreviewEn.internal(_root);
	late final AppStringsOnboardingCurrentMethodEn currentMethod = AppStringsOnboardingCurrentMethodEn.internal(_root);
	late final AppStringsOnboardingFeaturesShowcaseEn featuresShowcase = AppStringsOnboardingFeaturesShowcaseEn.internal(_root);
	late final AppStringsOnboardingCompleteEn complete = AppStringsOnboardingCompleteEn.internal(_root);
	late final AppStringsOnboardingButtonsEn buttons = AppStringsOnboardingButtonsEn.internal(_root);
}

// Path: dashboard
class AppStringsDashboardEn {
	AppStringsDashboardEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Welcome to MoneyT'
	String get greeting => 'Welcome to MoneyT';

	late final AppStringsDashboardBalanceEn balance = AppStringsDashboardBalanceEn.internal(_root);
	late final AppStringsDashboardActionsEn actions = AppStringsDashboardActionsEn.internal(_root);
	late final AppStringsDashboardWalletsEn wallets = AppStringsDashboardWalletsEn.internal(_root);
	late final AppStringsDashboardTransactionsEn transactions = AppStringsDashboardTransactionsEn.internal(_root);

	/// en: 'Customize'
	String get customize => 'Customize';

	late final AppStringsDashboardWidgetsEn widgets = AppStringsDashboardWidgetsEn.internal(_root);
}

// Path: wallets
class AppStringsWalletsEn {
	AppStringsWalletsEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Wallets'
	String get title => 'Wallets';

	late final AppStringsWalletsEmptyEn empty = AppStringsWalletsEmptyEn.internal(_root);
	late final AppStringsWalletsEmptyArchivedEn emptyArchived = AppStringsWalletsEmptyArchivedEn.internal(_root);
	late final AppStringsWalletsFilterEn filter = AppStringsWalletsFilterEn.internal(_root);
	late final AppStringsWalletsFormEn form = AppStringsWalletsFormEn.internal(_root);
	late final AppStringsWalletsDeleteEn delete = AppStringsWalletsDeleteEn.internal(_root);
	late final AppStringsWalletsErrorsEn errors = AppStringsWalletsErrorsEn.internal(_root);
	late final AppStringsWalletsSubtitleEn subtitle = AppStringsWalletsSubtitleEn.internal(_root);
	late final AppStringsWalletsOptionsEn options = AppStringsWalletsOptionsEn.internal(_root);
}

// Path: loans
class AppStringsLoansEn {
	AppStringsLoansEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Loans'
	String get title => 'Loans';

	late final AppStringsLoansFilterEn filter = AppStringsLoansFilterEn.internal(_root);
	late final AppStringsLoansSummaryEn summary = AppStringsLoansSummaryEn.internal(_root);
	late final AppStringsLoansCardEn card = AppStringsLoansCardEn.internal(_root);
	late final AppStringsLoansFormEn form = AppStringsLoansFormEn.internal(_root);
	late final AppStringsLoansDetailEn detail = AppStringsLoansDetailEn.internal(_root);
	late final AppStringsLoansHistoryEn history = AppStringsLoansHistoryEn.internal(_root);
	late final AppStringsLoansContactDetailEn contactDetail = AppStringsLoansContactDetailEn.internal(_root);
	late final AppStringsLoansShareEn share = AppStringsLoansShareEn.internal(_root);
	late final AppStringsLoansPaymentEn payment = AppStringsLoansPaymentEn.internal(_root);

	/// en: 'Loan Given'
	String get given => 'Loan Given';

	/// en: 'Loan Received'
	String get received => 'Loan Received';

	late final AppStringsLoansItemEn item = AppStringsLoansItemEn.internal(_root);
	late final AppStringsLoansSectionEn section = AppStringsLoansSectionEn.internal(_root);
	late final AppStringsLoansEmptyEn empty = AppStringsLoansEmptyEn.internal(_root);
}

// Path: categories
class AppStringsCategoriesEn {
	AppStringsCategoriesEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Categories'
	String get title => 'Categories';

	late final AppStringsCategoriesFormEn form = AppStringsCategoriesFormEn.internal(_root);
	late final AppStringsCategoriesParentSelectionEn parentSelection = AppStringsCategoriesParentSelectionEn.internal(_root);

	/// en: 'Income category'
	String get incomeCategory => 'Income category';

	/// en: 'Expense category'
	String get expenseCategory => 'Expense category';
}

// Path: backups
class AppStringsBackupsEn {
	AppStringsBackupsEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Database Backup'
	String get title => 'Database Backup';

	late final AppStringsBackupsMenuEn menu = AppStringsBackupsMenuEn.internal(_root);
	late final AppStringsBackupsFiltersEn filters = AppStringsBackupsFiltersEn.internal(_root);
	late final AppStringsBackupsStatusEn status = AppStringsBackupsStatusEn.internal(_root);
	late final AppStringsBackupsActionsEn actions = AppStringsBackupsActionsEn.internal(_root);
	late final AppStringsBackupsDialogsEn dialogs = AppStringsBackupsDialogsEn.internal(_root);
	late final AppStringsBackupsStatsEn stats = AppStringsBackupsStatsEn.internal(_root);
	late final AppStringsBackupsOptionsEn options = AppStringsBackupsOptionsEn.internal(_root);
	late final AppStringsBackupsFormatEn format = AppStringsBackupsFormatEn.internal(_root);
}

// Path: components.dateSelection
class AppStringsComponentsDateSelectionEn {
	AppStringsComponentsDateSelectionEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Select date'
	String get title => 'Select date';

	/// en: 'Choose transaction date'
	String get subtitle => 'Choose transaction date';

	/// en: 'Selected Date'
	String get selectedDate => 'Selected Date';

	/// en: 'Select'
	String get confirm => 'Select';
}

// Path: components.selection
class AppStringsComponentsSelectionEn {
	AppStringsComponentsSelectionEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Confirm'
	String get confirm => 'Confirm';

	/// en: 'Select'
	String get select => 'Select';
}

// Path: components.contactSelection
class AppStringsComponentsContactSelectionEn {
	AppStringsComponentsContactSelectionEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Select contact'
	String get title => 'Select contact';

	/// en: 'Choose whom this transaction is with'
	String get subtitle => 'Choose whom this transaction is with';

	/// en: 'Search contacts'
	String get searchPlaceholder => 'Search contacts';

	/// en: 'No contact'
	String get noContact => 'No contact';

	/// en: 'Transaction without specific contact'
	String get noContactDetails => 'Transaction without specific contact';

	/// en: 'All Contacts'
	String get allContacts => 'All Contacts';

	/// en: 'Create new contact'
	String get create => 'Create new contact';
}

// Path: components.categorySelection
class AppStringsComponentsCategorySelectionEn {
	AppStringsComponentsCategorySelectionEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Select category'
	String get title => 'Select category';

	/// en: 'Choose a category for this transaction'
	String get subtitle => 'Choose a category for this transaction';

	/// en: 'Search categories'
	String get searchPlaceholder => 'Search categories';
}

// Path: components.currencySelection
class AppStringsComponentsCurrencySelectionEn {
	AppStringsComponentsCurrencySelectionEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Select currency'
	String get title => 'Select currency';

	/// en: 'Choose the currency for this wallet'
	String get subtitle => 'Choose the currency for this wallet';

	/// en: 'Search currencies'
	String get searchPlaceholder => 'Search currencies';
}

// Path: components.accountSelection
class AppStringsComponentsAccountSelectionEn {
	AppStringsComponentsAccountSelectionEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Select account'
	String get title => 'Select account';

	/// en: 'Choose an account for this transaction'
	String get subtitle => 'Choose an account for this transaction';

	/// en: 'Search accounts'
	String get searchPlaceholder => 'Search accounts';

	/// en: 'Wallets'
	String get wallets => 'Wallets';

	/// en: 'Credit Cards'
	String get creditCards => 'Credit Cards';

	/// en: 'Select account'
	String get selectAccount => 'Select account';

	/// en: 'Confirm'
	String get confirm => 'Confirm';
}

// Path: components.parentWalletSelection
class AppStringsComponentsParentWalletSelectionEn {
	AppStringsComponentsParentWalletSelectionEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Select parent wallet'
	String get title => 'Select parent wallet';

	/// en: 'Choose a parent wallet to organize this wallet under another one'
	String get subtitle => 'Choose a parent wallet to organize this wallet under another one';

	/// en: 'Search wallets'
	String get searchPlaceholder => 'Search wallets';

	/// en: 'No parent wallet'
	String get noParent => 'No parent wallet';

	/// en: 'Create as a root wallet'
	String get createRoot => 'Create as a root wallet';

	/// en: 'Available Wallets'
	String get available => 'Available Wallets';
}

// Path: components.walletTypes
class AppStringsComponentsWalletTypesEn {
	AppStringsComponentsWalletTypesEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Checking'
	String get checking => 'Checking';

	/// en: 'Savings'
	String get savings => 'Savings';

	/// en: 'Cash'
	String get cash => 'Cash';

	/// en: 'Credit Card'
	String get creditCard => 'Credit Card';
}

// Path: navigation.sections
class AppStringsNavigationSectionsEn {
	AppStringsNavigationSectionsEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'OPERATIONS'
	String get operations => 'OPERATIONS';

	/// en: 'FINANCIAL TOOLS'
	String get financialTools => 'FINANCIAL TOOLS';

	/// en: 'MANAGEMENT'
	String get management => 'MANAGEMENT';

	/// en: 'ADVANCED'
	String get advanced => 'ADVANCED';
}

// Path: transactions.types
class AppStringsTransactionsTypesEn {
	AppStringsTransactionsTypesEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'All'
	String get all => 'All';

	/// en: 'Income'
	String get income => 'Income';

	/// en: 'Expense'
	String get expense => 'Expense';

	/// en: 'Transfer'
	String get transfer => 'Transfer';
}

// Path: transactions.filter
class AppStringsTransactionsFilterEn {
	AppStringsTransactionsFilterEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Filter Transactions'
	String get title => 'Filter Transactions';

	/// en: 'Date'
	String get date => 'Date';

	/// en: 'Categories'
	String get categories => 'Categories';

	/// en: 'Accounts'
	String get accounts => 'Accounts';

	/// en: 'Contacts'
	String get contacts => 'Contacts';

	/// en: 'Amount'
	String get amount => 'Amount';

	/// en: 'Apply filters'
	String get apply => 'Apply filters';

	/// en: 'Clear filters'
	String get clear => 'Clear filters';

	/// en: 'Add filter'
	String get add => 'Add filter';

	/// en: 'Min Amount'
	String get minAmount => 'Min Amount';

	/// en: 'Max Amount'
	String get maxAmount => 'Max Amount';

	/// en: 'Select date'
	String get selectDate => 'Select date';

	/// en: 'Select category'
	String get selectCategory => 'Select category';

	/// en: 'Select account'
	String get selectAccount => 'Select account';

	/// en: 'Select contact'
	String get selectContact => 'Select contact';

	/// en: 'Quick filters'
	String get quickFilters => 'Quick filters';

	late final AppStringsTransactionsFilterRangesEn ranges = AppStringsTransactionsFilterRangesEn.internal(_root);

	/// en: 'Custom Date Range'
	String get customRange => 'Custom Date Range';

	/// en: 'Start Date'
	String get startDate => 'Start Date';

	/// en: 'End Date'
	String get endDate => 'End Date';

	/// en: 'Active Filters'
	String get active => 'Active Filters';

	late final AppStringsTransactionsFilterSubtitlesEn subtitles = AppStringsTransactionsFilterSubtitlesEn.internal(_root);
}

// Path: transactions.form
class AppStringsTransactionsFormEn {
	AppStringsTransactionsFormEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'New Transaction'
	String get newTitle => 'New Transaction';

	/// en: 'Edit Transaction'
	String get editTitle => 'Edit Transaction';

	/// en: 'Amount'
	String get amount => 'Amount';

	/// en: 'Transaction type'
	String get type => 'Transaction type';

	/// en: 'Amount is required'
	String get amountRequired => 'Amount is required';

	/// en: 'Date'
	String get date => 'Date';

	/// en: 'Account'
	String get account => 'Account';

	/// en: 'To Account'
	String get toAccount => 'To Account';

	/// en: 'Category'
	String get category => 'Category';

	/// en: 'Contact'
	String get contact => 'Contact';

	/// en: 'Contact (optional)'
	String get contactOptional => 'Contact (optional)';

	/// en: 'Description'
	String get description => 'Description';

	/// en: 'Optional description'
	String get descriptionOptional => 'Optional description';

	/// en: 'Select account'
	String get selectAccount => 'Select account';

	/// en: 'Select destination'
	String get selectDestination => 'Select destination';

	/// en: 'Select category'
	String get selectCategory => 'Select category';

	/// en: 'Select contact'
	String get selectContact => 'Select contact';

	/// en: 'Transaction saved successfully'
	String get saveSuccess => 'Transaction saved successfully';

	/// en: 'Transaction updated successfully'
	String get updateSuccess => 'Transaction updated successfully';

	/// en: 'Error saving transaction'
	String get saveError => 'Error saving transaction';

	/// en: 'Share'
	String get share => 'Share';

	/// en: 'Transaction created successfully'
	String get created => 'Transaction created successfully';
}

// Path: transactions.errors
class AppStringsTransactionsErrorsEn {
	AppStringsTransactionsErrorsEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Error loading transactions'
	String get load => 'Error loading transactions';
}

// Path: transactions.empty
class AppStringsTransactionsEmptyEn {
	AppStringsTransactionsEmptyEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'No transactions'
	String get title => 'No transactions';

	/// en: 'No transactions found with applied filters'
	String get message => 'No transactions found with applied filters';

	/// en: 'Clear filters'
	String get clearFilters => 'Clear filters';
}

// Path: transactions.list
class AppStringsTransactionsListEn {
	AppStringsTransactionsListEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: '$n transactions'
	String count({required Object n}) => '${n} transactions';
}

// Path: transactions.detail
class AppStringsTransactionsDetailEn {
	AppStringsTransactionsDetailEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Transaction Details'
	String get title => 'Transaction Details';

	/// en: 'Delete Transaction'
	String get delete => 'Delete Transaction';

	/// en: 'Are you sure? This action cannot be undone.'
	String get deleteConfirmation => 'Are you sure? This action cannot be undone.';

	/// en: 'Transaction deleted'
	String get deleted => 'Transaction deleted';

	/// en: 'Duplicate'
	String get duplicate => 'Duplicate';

	/// en: 'Duplicate not implemented yet'
	String get duplicateNotImplemented => 'Duplicate not implemented yet';

	/// en: 'Edit'
	String get edit => 'Edit';

	/// en: 'Error loading transaction details'
	String get errorLoad => 'Error loading transaction details';

	/// en: 'Error preparing edit: $error'
	String errorPrepareEdit({required Object error}) => 'Error preparing edit: ${error}';

	/// en: 'Error deleting: $error'
	String errorDelete({required Object error}) => 'Error deleting: ${error}';

	/// en: 'Category'
	String get category => 'Category';

	/// en: 'Account'
	String get account => 'Account';

	/// en: 'Contact'
	String get contact => 'Contact';

	/// en: 'Description'
	String get description => 'Description';

	/// en: 'Transfer Details'
	String get transferDetails => 'Transfer Details';

	/// en: 'From'
	String get from => 'From';

	/// en: 'To'
	String get to => 'To';

	/// en: 'Unknown Account'
	String get unknownAccount => 'Unknown Account';

	/// en: 'Could not open $url'
	String errorUrl({required Object url}) => 'Could not open ${url}';

	/// en: 'Date'
	String get date => 'Date';

	/// en: 'Time'
	String get time => 'Time';

	/// en: 'This transaction is linked to a loan and managed automatically.'
	String get loanLinkedWarning => 'This transaction is linked to a loan and managed automatically.';
}

// Path: transactions.share
class AppStringsTransactionsShareEn {
	AppStringsTransactionsShareEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Share Transaction'
	String get title => 'Share Transaction';

	/// en: 'Copy Text'
	String get copyText => 'Copy Text';

	/// en: 'Share'
	String get shareButton => 'Share';

	/// en: 'Here is my transaction receipt:'
	String get shareMessage => 'Here is my transaction receipt:';

	/// en: 'Transaction details copied to clipboard!'
	String get copied => 'Transaction details copied to clipboard!';

	/// en: 'Payment Method'
	String get paymentMethod => 'Payment Method';

	/// en: 'Transaction Receipt'
	String get receiptTitle => 'Transaction Receipt';

	/// en: 'Powered by MoneyT • moneyt.io'
	String get poweredBy => 'Powered by MoneyT • moneyt.io';

	/// en: 'Error sharing image: $error'
	String errorImage({required Object error}) => 'Error sharing image: ${error}';

	late final AppStringsTransactionsShareReceiptEn receipt = AppStringsTransactionsShareReceiptEn.internal(_root);

	/// en: 'Generated on $date'
	String generatedOn({required Object date}) => 'Generated on ${date}';
}

// Path: contacts.fields
class AppStringsContactsFieldsEn {
	AppStringsContactsFieldsEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Name'
	String get name => 'Name';

	/// en: 'Full name'
	String get fullName => 'Full name';

	/// en: 'Email'
	String get email => 'Email';

	/// en: 'Phone'
	String get phone => 'Phone';

	/// en: 'Address'
	String get address => 'Address';

	/// en: 'Notes'
	String get notes => 'Notes';
}

// Path: contacts.placeholders
class AppStringsContactsPlaceholdersEn {
	AppStringsContactsPlaceholdersEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Enter full name'
	String get enterFullName => 'Enter full name';

	/// en: 'Enter phone number'
	String get enterPhone => 'Enter phone number';

	/// en: 'Enter email address'
	String get enterEmail => 'Enter email address';
}

// Path: contacts.validation
class AppStringsContactsValidationEn {
	AppStringsContactsValidationEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Name is required'
	String get nameRequired => 'Name is required';

	/// en: 'Invalid email'
	String get invalidEmail => 'Invalid email';

	/// en: 'Invalid phone number'
	String get invalidPhone => 'Invalid phone number';
}

// Path: settings.account
class AppStringsSettingsAccountEn {
	AppStringsSettingsAccountEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Account'
	String get title => 'Account';

	/// en: 'Profile'
	String get profile => 'Profile';

	/// en: 'Manage your account information'
	String get profileSubtitle => 'Manage your account information';
}

// Path: settings.appearance
class AppStringsSettingsAppearanceEn {
	AppStringsSettingsAppearanceEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Appearance'
	String get title => 'Appearance';

	/// en: 'Dark mode'
	String get darkMode => 'Dark mode';

	/// en: 'Switch to dark theme'
	String get darkModeSubtitle => 'Switch to dark theme';

	/// en: 'Language'
	String get language => 'Language';

	/// en: 'Dark theme'
	String get darkTheme => 'Dark theme';

	/// en: 'Light theme'
	String get lightTheme => 'Light theme';

	/// en: 'System theme'
	String get systemTheme => 'System theme';
}

// Path: settings.data
class AppStringsSettingsDataEn {
	AppStringsSettingsDataEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Data & Storage'
	String get title => 'Data & Storage';

	/// en: 'Database backup'
	String get backup => 'Database backup';

	/// en: 'Manage your data backups'
	String get backupSubtitle => 'Manage your data backups';
}

// Path: settings.info
class AppStringsSettingsInfoEn {
	AppStringsSettingsInfoEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Information'
	String get title => 'Information';

	/// en: 'Contact & Social'
	String get contact => 'Contact & Social';

	/// en: 'Get support and follow us online'
	String get contactSubtitle => 'Get support and follow us online';

	/// en: 'Privacy policy'
	String get privacy => 'Privacy policy';

	/// en: 'Read our privacy policy'
	String get privacySubtitle => 'Read our privacy policy';

	/// en: 'Share MoneyT'
	String get share => 'Share MoneyT';

	/// en: 'Tell your friends about the app'
	String get shareSubtitle => 'Tell your friends about the app';
}

// Path: settings.logout
class AppStringsSettingsLogoutEn {
	AppStringsSettingsLogoutEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Sign out'
	String get button => 'Sign out';

	/// en: 'Sign out'
	String get dialogTitle => 'Sign out';

	/// en: 'Are you sure you want to sign out of your account?'
	String get dialogMessage => 'Are you sure you want to sign out of your account?';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Sign out'
	String get confirm => 'Sign out';
}

// Path: settings.social
class AppStringsSettingsSocialEn {
	AppStringsSettingsSocialEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Contact & Social'
	String get title => 'Contact & Social';

	/// en: 'Follow MoneyT'
	String get follow => 'Follow MoneyT';

	/// en: 'Stay connected with us on social media for updates, tips, and community discussions.'
	String get description => 'Stay connected with us on social media for updates, tips, and community discussions.';

	/// en: 'Social Networks'
	String get networks => 'Social Networks';

	/// en: 'GitHub'
	String get github => 'GitHub';

	/// en: 'View source code and contribute'
	String get githubSubtitle => 'View source code and contribute';

	/// en: 'LinkedIn'
	String get linkedin => 'LinkedIn';

	/// en: 'Professional updates and insights'
	String get linkedinSubtitle => 'Professional updates and insights';

	/// en: 'X (Twitter)'
	String get twitter => 'X (Twitter)';

	/// en: 'Latest news and announcements'
	String get twitterSubtitle => 'Latest news and announcements';

	/// en: 'Reddit'
	String get reddit => 'Reddit';

	/// en: 'Join the community discussions'
	String get redditSubtitle => 'Join the community discussions';

	/// en: 'Discord'
	String get discord => 'Discord';

	/// en: 'Join the community discussions'
	String get discordSubtitle => 'Join the community discussions';

	/// en: 'Contact'
	String get contact => 'Contact';

	/// en: 'Email Support'
	String get email => 'Email Support';

	/// en: 'Official Website'
	String get website => 'Official Website';
}

// Path: settings.language
class AppStringsSettingsLanguageEn {
	AppStringsSettingsLanguageEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Language'
	String get title => 'Language';

	/// en: 'AVAILABLE LANGUAGES'
	String get available => 'AVAILABLE LANGUAGES';

	/// en: 'Apply Language'
	String get apply => 'Apply Language';
}

// Path: settings.messages
class AppStringsSettingsMessagesEn {
	AppStringsSettingsMessagesEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Profile screen coming soon'
	String get profileComingSoon => 'Profile screen coming soon';

	/// en: 'Could not open privacy policy'
	String get privacyError => 'Could not open privacy policy';

	/// en: 'Sign out functionality coming soon'
	String get logoutComingSoon => 'Sign out functionality coming soon';
}

// Path: onboarding.welcome
class AppStringsOnboardingWelcomeEn {
	AppStringsOnboardingWelcomeEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Welcome to MoneyT 👋'
	String get title => 'Welcome to MoneyT 👋';

	/// en: 'Control your money in minutes ✨'
	String get subtitle => 'Control your money in minutes ✨';
}

// Path: onboarding.problemStatement
class AppStringsOnboardingProblemStatementEn {
	AppStringsOnboardingProblemStatementEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Do you feel like money slips through your fingers?'
	String get title => 'Do you feel like money slips through your fingers?';

	/// en: 'You're not alone. 70% of people don't know where their income goes.'
	String get subtitle => 'You\'re not alone. 70% of people don\'t know where their income goes.';
}

// Path: onboarding.specificProblem
class AppStringsOnboardingSpecificProblemEn {
	AppStringsOnboardingSpecificProblemEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'What's harder for you?'
	String get title => 'What\'s harder for you?';

	late final AppStringsOnboardingSpecificProblemOptionsEn options = AppStringsOnboardingSpecificProblemOptionsEn.internal(_root);
}

// Path: onboarding.personalGoal
class AppStringsOnboardingPersonalGoalEn {
	AppStringsOnboardingPersonalGoalEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'What's your main goal?'
	String get title => 'What\'s your main goal?';

	late final AppStringsOnboardingPersonalGoalOptionsEn options = AppStringsOnboardingPersonalGoalOptionsEn.internal(_root);
}

// Path: onboarding.solutionPreview
class AppStringsOnboardingSolutionPreviewEn {
	AppStringsOnboardingSolutionPreviewEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'MoneyT gives you clarity'
	String get title => 'MoneyT gives you clarity';

	/// en: 'See all your accounts, debts, and expenses in one place. No spreadsheets, no stress.'
	String get subtitle => 'See all your accounts, debts, and expenses in one place. No spreadsheets, no stress.';

	late final AppStringsOnboardingSolutionPreviewBenefitsEn benefits = AppStringsOnboardingSolutionPreviewBenefitsEn.internal(_root);
}

// Path: onboarding.currentMethod
class AppStringsOnboardingCurrentMethodEn {
	AppStringsOnboardingCurrentMethodEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'How do you manage your money today?'
	String get title => 'How do you manage your money today?';

	/// en: 'Select the option that best describes you.'
	String get subtitle => 'Select the option that best describes you.';

	late final AppStringsOnboardingCurrentMethodOptionsEn options = AppStringsOnboardingCurrentMethodOptionsEn.internal(_root);
}

// Path: onboarding.featuresShowcase
class AppStringsOnboardingFeaturesShowcaseEn {
	AppStringsOnboardingFeaturesShowcaseEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Available and coming soon features ✨'
	String get title => 'Available and coming soon features ✨';

	/// en: 'Transactions ready to use. More features on the way.'
	String get subtitle => 'Transactions ready to use. More features on the way.';

	/// en: 'AVAILABLE NOW'
	String get available => 'AVAILABLE NOW';

	/// en: 'COMING SOON'
	String get comingSoon => 'COMING SOON';

	late final AppStringsOnboardingFeaturesShowcaseFeaturesEn features = AppStringsOnboardingFeaturesShowcaseFeaturesEn.internal(_root);
}

// Path: onboarding.complete
class AppStringsOnboardingCompleteEn {
	AppStringsOnboardingCompleteEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'You're ready for takeoff! 🚀'
	String get title => 'You\'re ready for takeoff! 🚀';

	/// en: 'Record your first transaction and watch your success probability soar 📈'
	String get subtitle => 'Record your first transaction and watch your success probability soar 📈';

	late final AppStringsOnboardingCompleteStatsEn stats = AppStringsOnboardingCompleteStatsEn.internal(_root);
}

// Path: onboarding.buttons
class AppStringsOnboardingButtonsEn {
	AppStringsOnboardingButtonsEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Start now 🚀'
	String get start => 'Start now 🚀';

	/// en: 'Fix it today ⚡'
	String get fixIt => 'Fix it today ⚡';

	/// en: 'Continue'
	String get actionContinue => 'Continue';

	/// en: 'Set my goal 🎯'
	String get setGoal => 'Set my goal 🎯';

	/// en: 'I want this control!'
	String get wantControl => 'I want this control!';

	/// en: 'Great, let's see it!'
	String get great => 'Great, let\'s see it!';

	/// en: 'Record my first transaction ➕'
	String get firstTransaction => 'Record my first transaction ➕';

	/// en: 'Skip'
	String get skip => 'Skip';
}

// Path: dashboard.balance
class AppStringsDashboardBalanceEn {
	AppStringsDashboardBalanceEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Total Balance'
	String get total => 'Total Balance';

	/// en: 'INCOME'
	String get income => 'INCOME';

	/// en: 'EXPENSES'
	String get expenses => 'EXPENSES';

	/// en: 'this month'
	String get thisMonth => 'this month';
}

// Path: dashboard.actions
class AppStringsDashboardActionsEn {
	AppStringsDashboardActionsEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Income'
	String get income => 'Income';

	/// en: 'Expense'
	String get expense => 'Expense';

	/// en: 'Transfer'
	String get transfer => 'Transfer';

	/// en: 'All'
	String get all => 'All';
}

// Path: dashboard.wallets
class AppStringsDashboardWalletsEn {
	AppStringsDashboardWalletsEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Wallets'
	String get title => 'Wallets';

	/// en: '$n accounts'
	String count({required Object n}) => '${n} accounts';

	/// en: '+$n more accounts'
	String more({required Object n}) => '+${n} more accounts';

	/// en: 'View $name details'
	String viewDetails({required Object name}) => 'View ${name} details';
}

// Path: dashboard.transactions
class AppStringsDashboardTransactionsEn {
	AppStringsDashboardTransactionsEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Recent Transactions'
	String get title => 'Recent Transactions';

	/// en: 'Last 5 transactions'
	String get subtitle => 'Last 5 transactions';

	/// en: 'No recent transactions'
	String get empty => 'No recent transactions';

	/// en: 'Your transactions will appear here'
	String get emptySubtitle => 'Your transactions will appear here';

	/// en: '+$n more transactions'
	String more({required Object n}) => '+${n} more transactions';
}

// Path: dashboard.widgets
class AppStringsDashboardWidgetsEn {
	AppStringsDashboardWidgetsEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations
	late final AppStringsDashboardWidgetsBalanceEn balance = AppStringsDashboardWidgetsBalanceEn.internal(_root);
	late final AppStringsDashboardWidgetsQuickActionsEn quickActions = AppStringsDashboardWidgetsQuickActionsEn.internal(_root);
	late final AppStringsDashboardWidgetsWalletsEn wallets = AppStringsDashboardWidgetsWalletsEn.internal(_root);
	late final AppStringsDashboardWidgetsLoansEn loans = AppStringsDashboardWidgetsLoansEn.internal(_root);
	late final AppStringsDashboardWidgetsTransactionsEn transactions = AppStringsDashboardWidgetsTransactionsEn.internal(_root);
	late final AppStringsDashboardWidgetsChartAccountsEn chartAccounts = AppStringsDashboardWidgetsChartAccountsEn.internal(_root);
	late final AppStringsDashboardWidgetsCreditCardsEn creditCards = AppStringsDashboardWidgetsCreditCardsEn.internal(_root);
	late final AppStringsDashboardWidgetsSettingsEn settings = AppStringsDashboardWidgetsSettingsEn.internal(_root);
}

// Path: wallets.empty
class AppStringsWalletsEmptyEn {
	AppStringsWalletsEmptyEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'No wallets found'
	String get title => 'No wallets found';

	/// en: 'Add your first wallet to start tracking your finances.'
	String get message => 'Add your first wallet to start tracking your finances.';

	/// en: 'Create Wallet'
	String get action => 'Create Wallet';
}

// Path: wallets.emptyArchived
class AppStringsWalletsEmptyArchivedEn {
	AppStringsWalletsEmptyArchivedEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'No archived wallets'
	String get title => 'No archived wallets';

	/// en: 'Archived wallets will appear here.'
	String get message => 'Archived wallets will appear here.';
}

// Path: wallets.filter
class AppStringsWalletsFilterEn {
	AppStringsWalletsFilterEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Active'
	String get active => 'Active';

	/// en: 'Archived'
	String get archived => 'Archived';

	/// en: 'All'
	String get all => 'All';
}

// Path: wallets.form
class AppStringsWalletsFormEn {
	AppStringsWalletsFormEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'New wallet'
	String get newTitle => 'New wallet';

	/// en: 'Edit wallet'
	String get editTitle => 'Edit wallet';

	/// en: 'Wallet name'
	String get name => 'Wallet name';

	/// en: 'Enter wallet name'
	String get namePlaceholder => 'Enter wallet name';

	/// en: 'Name is required'
	String get nameRequired => 'Name is required';

	/// en: 'Description'
	String get description => 'Description';

	/// en: 'Optional description for this wallet'
	String get descriptionPlaceholder => 'Optional description for this wallet';

	/// en: 'Currency'
	String get currency => 'Currency';

	/// en: 'Parent wallet (optional)'
	String get parent => 'Parent wallet (optional)';

	/// en: 'No wallets available as parent'
	String get parentEmpty => 'No wallets available as parent';

	/// en: 'Associated chart account'
	String get chartAccount => 'Associated chart account';

	/// en: 'Chart account cannot be changed'
	String get chartAccountLocked => 'Chart account cannot be changed';

	/// en: 'Wallet created successfully'
	String get createSuccess => 'Wallet created successfully';

	/// en: 'Wallet updated successfully'
	String get updateSuccess => 'Wallet updated successfully';

	/// en: 'Error loading parent wallets: $error'
	String loadParentError({required Object error}) => 'Error loading parent wallets: ${error}';

	/// en: 'Error loading chart account: $error'
	String loadChartAccountError({required Object error}) => 'Error loading chart account: ${error}';
}

// Path: wallets.delete
class AppStringsWalletsDeleteEn {
	AppStringsWalletsDeleteEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Delete wallet'
	String get dialogTitle => 'Delete wallet';

	/// en: 'Are you sure you want to delete $name?'
	String dialogMessage({required Object name}) => 'Are you sure you want to delete ${name}?';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Delete'
	String get confirm => 'Delete';

	/// en: 'Wallet deleted successfully'
	String get success => 'Wallet deleted successfully';

	/// en: 'Error deleting wallet: $error'
	String error({required Object error}) => 'Error deleting wallet: ${error}';
}

// Path: wallets.errors
class AppStringsWalletsErrorsEn {
	AppStringsWalletsErrorsEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Error loading wallets'
	String get load => 'Error loading wallets';

	/// en: 'Retry'
	String get retry => 'Retry';

	/// en: '$name coming soon'
	String comingSoon({required Object name}) => '${name} coming soon';
}

// Path: wallets.subtitle
class AppStringsWalletsSubtitleEn {
	AppStringsWalletsSubtitleEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Main account'
	String get mainAccount => 'Main account';

	/// en: 'Cash & digital'
	String get cashDigital => 'Cash & digital';

	/// en: '(one) {$n wallet} (other) {$n wallets}'
	String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} wallet',
		other: '${n} wallets',
	);

	/// en: 'Account'
	String get account => 'Account';

	/// en: 'Physical cash'
	String get physicalCash => 'Physical cash';

	/// en: 'Digital wallet'
	String get digitalWallet => 'Digital wallet';
}

// Path: wallets.options
class AppStringsWalletsOptionsEn {
	AppStringsWalletsOptionsEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'View transactions'
	String get viewTransactions => 'View transactions';

	/// en: 'See all transactions for this wallet'
	String get viewTransactionsSubtitle => 'See all transactions for this wallet';

	/// en: 'Transfer funds'
	String get transferFunds => 'Transfer funds';

	/// en: 'Move money between wallets'
	String get transferFundsSubtitle => 'Move money between wallets';

	/// en: 'Edit wallet'
	String get editWallet => 'Edit wallet';

	/// en: 'Modify wallet details'
	String get editWalletSubtitle => 'Modify wallet details';

	/// en: 'Duplicate wallet'
	String get duplicateWallet => 'Duplicate wallet';

	/// en: 'Create a copy of this wallet'
	String get duplicateWalletSubtitle => 'Create a copy of this wallet';

	/// en: 'Archive wallet'
	String get archiveWallet => 'Archive wallet';

	/// en: 'Hide wallet from main view'
	String get archiveWalletSubtitle => 'Hide wallet from main view';

	/// en: 'Unarchive wallet'
	String get unarchiveWallet => 'Unarchive wallet';

	/// en: 'Restore to main view'
	String get unarchiveWalletSubtitle => 'Restore to main view';

	/// en: 'Delete wallet'
	String get deleteWallet => 'Delete wallet';

	/// en: 'Permanently remove this wallet'
	String get deleteWalletSubtitle => 'Permanently remove this wallet';

	/// en: 'Wallet'
	String get defaultTitle => 'Wallet';
}

// Path: loans.filter
class AppStringsLoansFilterEn {
	AppStringsLoansFilterEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Active Loans'
	String get active => 'Active Loans';

	/// en: 'History'
	String get history => 'History';

	/// en: 'All'
	String get all => 'All';

	/// en: 'Pending'
	String get pending => 'Pending';

	/// en: 'Lent'
	String get lent => 'Lent';

	/// en: 'Borrowed'
	String get borrowed => 'Borrowed';
}

// Path: loans.summary
class AppStringsLoansSummaryEn {
	AppStringsLoansSummaryEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'NET BALANCE'
	String get netBalance => 'NET BALANCE';

	/// en: 'ACTIVE LOANS'
	String get activeLoans => 'ACTIVE LOANS';

	/// en: 'No active loans'
	String get noActive => 'No active loans';

	/// en: '$n lent'
	String lent({required Object n}) => '${n} lent';

	/// en: '$n borrowed'
	String borrowed({required Object n}) => '${n} borrowed';

	/// en: '$n pending'
	String pending({required Object n}) => '${n} pending';
}

// Path: loans.card
class AppStringsLoansCardEn {
	AppStringsLoansCardEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'You Lent'
	String get lent => 'You Lent';

	/// en: 'You Borrowed'
	String get borrowed => 'You Borrowed';

	/// en: '$n active'
	String active({required Object n}) => '${n} active';

	/// en: '$n loans'
	String multiple({required Object n}) => '${n} loans';

	/// en: '$n transactions'
	String transactions({required Object n}) => '${n} transactions';

	/// en: 'Overdue by $n days'
	String overdue({required Object n}) => 'Overdue by ${n} days';

	/// en: 'Due $date'
	String due({required Object date}) => 'Due ${date}';
}

// Path: loans.form
class AppStringsLoansFormEn {
	AppStringsLoansFormEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'New Loan'
	String get newTitle => 'New Loan';

	/// en: 'Edit Loan'
	String get editTitle => 'Edit Loan';

	/// en: 'Loan type'
	String get type => 'Loan type';

	/// en: 'I Lend'
	String get lend => 'I Lend';

	/// en: 'I Borrow'
	String get borrow => 'I Borrow';

	/// en: 'Contact'
	String get contact => 'Contact';

	/// en: 'Select a contact'
	String get contactPlaceholder => 'Select a contact';

	/// en: 'From Account'
	String get account => 'From Account';

	/// en: 'Select an account'
	String get accountPlaceholder => 'Select an account';

	/// en: 'Amount'
	String get amount => 'Amount';

	/// en: 'Description'
	String get description => 'Description';

	/// en: 'Loan date'
	String get date => 'Loan date';

	/// en: 'Due date'
	String get dueDate => 'Due date';

	/// en: 'Select date'
	String get selectDate => 'Select date';

	/// en: '(Optional)'
	String get optional => '(Optional)';

	/// en: 'Create transaction record'
	String get createTransaction => 'Create transaction record';

	/// en: 'Record transaction automatically'
	String get recordAutomatically => 'Record transaction automatically';

	/// en: 'Transaction category'
	String get transactionCategory => 'Transaction category';

	/// en: 'Category'
	String get category => 'Category';

	/// en: 'Select a category'
	String get categoryPlaceholder => 'Select a category';

	/// en: 'Save Loan'
	String get save => 'Save Loan';

	/// en: 'Loan created successfully'
	String get successCreate => 'Loan created successfully';

	/// en: 'Loan updated successfully'
	String get successUpdate => 'Loan updated successfully';

	/// en: 'Contact is required'
	String get contactRequired => 'Contact is required';

	/// en: 'Account is required'
	String get accountRequired => 'Account is required';

	/// en: 'Amount is required'
	String get amountRequired => 'Amount is required';
}

// Path: loans.detail
class AppStringsLoansDetailEn {
	AppStringsLoansDetailEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Loan Details'
	String get title => 'Loan Details';

	/// en: 'Delete Loan'
	String get deleteTitle => 'Delete Loan';

	/// en: 'Are you sure you want to delete this loan?'
	String get deleteMessage => 'Are you sure you want to delete this loan?';

	/// en: 'Loan deleted successfully'
	String get deleteSuccess => 'Loan deleted successfully';

	/// en: 'Error deleting loan: $error'
	String deleteError({required Object error}) => 'Error deleting loan: ${error}';

	/// en: 'Loan not found'
	String get notFound => 'Loan not found';

	/// en: 'Loan Progress'
	String get progress => 'Loan Progress';

	/// en: 'Loan Information'
	String get info => 'Loan Information';

	/// en: 'Pay'
	String get pay => 'Pay';

	/// en: 'View Complete History'
	String get viewHistory => 'View Complete History';

	/// en: 'Original: $amount'
	String original({required Object amount}) => 'Original: ${amount}';

	/// en: 'Loan Details'
	String get section => 'Loan Details';

	/// en: 'Active Summary'
	String get activeSummary => 'Active Summary';

	/// en: 'You Lent (Active)'
	String get activeLent => 'You Lent (Active)';

	/// en: 'You Borrowed (Active)'
	String get activeBorrowed => 'You Borrowed (Active)';

	/// en: 'Net Position (Active)'
	String get activeNet => 'Net Position (Active)';

	/// en: 'Total Active Loans'
	String get activeTotal => 'Total Active Loans';

	/// en: 'Loan Start'
	String get startDate => 'Loan Start';

	/// en: 'Due Date'
	String get dueDate => 'Due Date';

	late final AppStringsLoansDetailTypeEn type = AppStringsLoansDetailTypeEn.internal(_root);
	late final AppStringsLoansDetailPaymentEn payment = AppStringsLoansDetailPaymentEn.internal(_root);
}

// Path: loans.history
class AppStringsLoansHistoryEn {
	AppStringsLoansHistoryEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Loan History'
	String get title => 'Loan History';

	/// en: 'Complete loan history'
	String get section => 'Complete loan history';

	/// en: 'Total loaned'
	String get totalLoaned => 'Total loaned';

	/// en: 'No loans found for this filter.'
	String get noLoans => 'No loans found for this filter.';

	late final AppStringsLoansHistoryFilterEn filter = AppStringsLoansHistoryFilterEn.internal(_root);
	late final AppStringsLoansHistoryHeadersEn headers = AppStringsLoansHistoryHeadersEn.internal(_root);
	late final AppStringsLoansHistoryItemEn item = AppStringsLoansHistoryItemEn.internal(_root);
	late final AppStringsLoansHistorySummaryEn summary = AppStringsLoansHistorySummaryEn.internal(_root);
}

// Path: loans.contactDetail
class AppStringsLoansContactDetailEn {
	AppStringsLoansContactDetailEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Loans with $name'
	String titleWith({required Object name}) => 'Loans with ${name}';
}

// Path: loans.share
class AppStringsLoansShareEn {
	AppStringsLoansShareEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Share Loan'
	String get title => 'Share Loan';

	/// en: 'Share Contact Loans'
	String get contactTitle => 'Share Contact Loans';

	/// en: 'Share'
	String get button => 'Share';

	/// en: 'Copy Text'
	String get copy => 'Copy Text';

	/// en: 'Here is my loan statement:'
	String get message => 'Here is my loan statement:';

	/// en: 'Loan Summary with $name:'
	String contactMessage({required Object name}) => 'Loan Summary with ${name}:';

	/// en: 'Error sharing image: $error'
	String error({required Object error}) => 'Error sharing image: ${error}';

	/// en: 'Loan summary copied to clipboard!'
	String get contactCopied => 'Loan summary copied to clipboard!';

	/// en: 'Active Loans ($n):'
	String activeLoans({required Object n}) => 'Active Loans (${n}):';

	/// en: '• $description: $amount (Date: $date) - $percent% paid'
	String loanItem({required Object description, required Object amount, required Object date, required Object percent}) => '• ${description}: ${amount} (Date: ${date}) - ${percent}% paid';

	/// en: 'MoneyT - Loan Statement'
	String get loanStatement => 'MoneyT - Loan Statement';

	/// en: 'MoneyT - Loan Summary'
	String get loanSummary => 'MoneyT - Loan Summary';

	/// en: 'Personal Loan'
	String get personalLoan => 'Personal Loan';

	/// en: 'Remaining Balance: $amount'
	String remaining({required Object amount}) => 'Remaining Balance: ${amount}';

	/// en: 'Remaining Balance'
	String get remainingLabel => 'Remaining Balance';

	/// en: 'of $amount original'
	String original({required Object amount}) => 'of ${amount} original';

	/// en: 'Payment Progress: $percent% Paid'
	String progress({required Object percent}) => 'Payment Progress: ${percent}% Paid';

	/// en: 'Payment Progress'
	String get progressLabel => 'Payment Progress';

	/// en: 'Paid'
	String get paidSuffix => 'Paid';

	/// en: 'Loan Date: $date'
	String date({required Object date}) => 'Loan Date: ${date}';

	/// en: 'Loan Date'
	String get dateLabel => 'Loan Date';

	/// en: 'Contact: $name'
	String contact({required Object name}) => 'Contact: ${name}';

	/// en: 'Contact'
	String get contactLabel => 'Contact';

	/// en: 'Generated on $date'
	String generated({required Object date}) => 'Generated on ${date}';

	/// en: 'Generated on $date'
	String generatedLabel({required Object date}) => 'Generated on ${date}';

	/// en: 'Total Active: $n loans'
	String totalActive({required Object n}) => 'Total Active: ${n} loans';

	/// en: 'active'
	String get active => 'active';

	/// en: 'Powered by MoneyT • moneyt.io'
	String get poweredBy => 'Powered by MoneyT • moneyt.io';

	/// en: 'Loan details copied to clipboard!'
	String get copied => 'Loan details copied to clipboard!';

	/// en: 'Net Balance: $amount ($status)'
	String netBalance({required Object amount, required Object status}) => 'Net Balance: ${amount} (${status})';

	/// en: 'Net Balance'
	String get netBalanceLabel => 'Net Balance';

	/// en: 'You are owed'
	String get owed => 'You are owed';

	/// en: 'You owe'
	String get owe => 'You owe';

	/// en: 'You Lent: $amount'
	String lent({required Object amount}) => 'You Lent: ${amount}';

	/// en: 'You Lent'
	String get lentLabel => 'You Lent';

	/// en: 'You Borrowed: $amount'
	String borrowed({required Object amount}) => 'You Borrowed: ${amount}';

	/// en: 'You Borrowed'
	String get borrowedLabel => 'You Borrowed';

	/// en: '$name - Loan Summary'
	String contactSummary({required Object name}) => '${name} - Loan Summary';
}

// Path: loans.payment
class AppStringsLoansPaymentEn {
	AppStringsLoansPaymentEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Record Payment'
	String get title => 'Record Payment';

	/// en: 'Payment amount'
	String get amount => 'Payment amount';

	/// en: '0.00'
	String get amountPlaceholder => '0.00';

	/// en: 'Payment amount is required'
	String get amountRequired => 'Payment amount is required';

	/// en: 'Please enter a valid amount'
	String get invalidAmount => 'Please enter a valid amount';

	/// en: 'Amount cannot exceed remaining balance'
	String get exceedsBalance => 'Amount cannot exceed remaining balance';

	/// en: 'Payment date'
	String get date => 'Payment date';

	/// en: 'Received in account'
	String get account => 'Received in account';

	/// en: 'Select account'
	String get selectAccount => 'Select account';

	/// en: 'Payment details'
	String get details => 'Payment details';

	/// en: 'Add notes about this payment (optional)'
	String get detailsPlaceholder => 'Add notes about this payment (optional)';

	/// en: 'Payment recorded successfully'
	String get success => 'Payment recorded successfully';

	/// en: 'Error recording payment: $error'
	String error({required Object error}) => 'Error recording payment: ${error}';

	/// en: 'Please enter a valid payment amount'
	String get errorAmount => 'Please enter a valid payment amount';

	/// en: 'Please select an account'
	String get errorAccount => 'Please select an account';

	/// en: 'Error loading data: $error'
	String errorLoading({required Object error}) => 'Error loading data: ${error}';

	late final AppStringsLoansPaymentSummaryEn summary = AppStringsLoansPaymentSummaryEn.internal(_root);
	late final AppStringsLoansPaymentQuickEn quick = AppStringsLoansPaymentQuickEn.internal(_root);
}

// Path: loans.item
class AppStringsLoansItemEn {
	AppStringsLoansItemEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Due: $date'
	String due({required Object date}) => 'Due: ${date}';

	/// en: 'Paid: $amount'
	String paidAmount({required Object amount}) => 'Paid: ${amount}';

	/// en: 'Remaining: $amount'
	String remaining({required Object amount}) => 'Remaining: ${amount}';

	/// en: '$percent% paid'
	String percentPaid({required Object percent}) => '${percent}% paid';
}

// Path: loans.section
class AppStringsLoansSectionEn {
	AppStringsLoansSectionEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Active Loans'
	String get activeLoans => 'Active Loans';

	/// en: '$n loans'
	String loansCount({required Object n}) => '${n} loans';
}

// Path: loans.empty
class AppStringsLoansEmptyEn {
	AppStringsLoansEmptyEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'No loans active'
	String get title => 'No loans active';

	/// en: 'Start tracking money you lent or borrowed.'
	String get message => 'Start tracking money you lent or borrowed.';

	/// en: 'Add Loan'
	String get action => 'Add Loan';
}

// Path: categories.form
class AppStringsCategoriesFormEn {
	AppStringsCategoriesFormEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'New Category'
	String get newTitle => 'New Category';

	/// en: 'Edit Category'
	String get editTitle => 'Edit Category';

	/// en: 'Category Name'
	String get name => 'Category Name';

	/// en: 'Enter category name'
	String get namePlaceholder => 'Enter category name';

	/// en: 'Category name is required'
	String get nameRequired => 'Category name is required';

	/// en: 'Parent Category (Optional)'
	String get parent => 'Parent Category (Optional)';

	/// en: 'No parent category'
	String get noParent => 'No parent category';

	/// en: 'Will be created as subcategory'
	String get asSubcategory => 'Will be created as subcategory';

	/// en: 'Will be created as root category'
	String get asRoot => 'Will be created as root category';

	/// en: 'Active Category'
	String get active => 'Active Category';

	/// en: 'Enable this category for new transactions'
	String get activeDescription => 'Enable this category for new transactions';

	/// en: 'Select Icon'
	String get selectIcon => 'Select Icon';

	/// en: 'Select Color'
	String get selectColor => 'Select Color';

	/// en: 'Category saved successfully'
	String get saveSuccess => 'Category saved successfully';

	/// en: 'Error saving category: $error'
	String saveError({required Object error}) => 'Error saving category: ${error}';
}

// Path: categories.parentSelection
class AppStringsCategoriesParentSelectionEn {
	AppStringsCategoriesParentSelectionEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Select Parent Category'
	String get title => 'Select Parent Category';

	/// en: 'Tap to select a parent category'
	String get subtitle => 'Tap to select a parent category';

	/// en: 'No parent category'
	String get noParent => 'No parent category';
}

// Path: backups.menu
class AppStringsBackupsMenuEn {
	AppStringsBackupsMenuEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Backup settings'
	String get settings => 'Backup settings';

	/// en: 'Backup settings coming soon'
	String get comingSoon => 'Backup settings coming soon';
}

// Path: backups.filters
class AppStringsBackupsFiltersEn {
	AppStringsBackupsFiltersEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'All'
	String get all => 'All';

	/// en: 'Auto'
	String get auto => 'Auto';

	/// en: 'Manual'
	String get manual => 'Manual';

	/// en: 'This Month'
	String get thisMonth => 'This Month';

	/// en: 'Last Month'
	String get lastMonth => 'Last Month';

	/// en: 'This Year'
	String get thisYear => 'This Year';

	/// en: 'Last Year'
	String get lastYear => 'Last Year';
}

// Path: backups.status
class AppStringsBackupsStatusEn {
	AppStringsBackupsStatusEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Loading...'
	String get loading => 'Loading...';

	/// en: 'Error loading backups'
	String get error => 'Error loading backups';

	/// en: 'No backups found'
	String get empty => 'No backups found';

	/// en: 'Create your first backup using the + button'
	String get emptyAction => 'Create your first backup using the + button';

	/// en: 'Success'
	String get success => 'Success';

	/// en: 'Backup created successfully'
	String get created => 'Backup created successfully';

	/// en: 'Error creating backup: $error'
	String createError({required Object error}) => 'Error creating backup: ${error}';

	/// en: 'Error restoring backup: $error'
	String restoreError({required Object error}) => 'Error restoring backup: ${error}';

	/// en: 'Error deleting backup: $error'
	String deleteError({required Object error}) => 'Error deleting backup: ${error}';
}

// Path: backups.actions
class AppStringsBackupsActionsEn {
	AppStringsBackupsActionsEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Create Backup'
	String get create => 'Create Backup';

	/// en: 'Import Backup'
	String get import => 'Import Backup';

	/// en: 'Restore'
	String get restore => 'Restore';

	/// en: 'Delete'
	String get delete => 'Delete';

	/// en: 'Share'
	String get share => 'Share';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Retry'
	String get retry => 'Retry';

	/// en: 'OK'
	String get ok => 'OK';
}

// Path: backups.dialogs
class AppStringsBackupsDialogsEn {
	AppStringsBackupsDialogsEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations
	late final AppStringsBackupsDialogsInfoEn info = AppStringsBackupsDialogsInfoEn.internal(_root);
	late final AppStringsBackupsDialogsRestoreEn restore = AppStringsBackupsDialogsRestoreEn.internal(_root);
	late final AppStringsBackupsDialogsDeleteEn delete = AppStringsBackupsDialogsDeleteEn.internal(_root);
}

// Path: backups.stats
class AppStringsBackupsStatsEn {
	AppStringsBackupsStatsEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Backup Statistics'
	String get title => 'Backup Statistics';

	/// en: 'Total Backups'
	String get totalBackups => 'Total Backups';

	/// en: 'Total Size'
	String get totalSize => 'Total Size';

	/// en: 'Oldest Backup'
	String get oldest => 'Oldest Backup';

	/// en: 'Latest Backup'
	String get latest => 'Latest Backup';

	/// en: 'Auto Backup Status'
	String get autoBackupStatus => 'Auto Backup Status';

	/// en: 'Active'
	String get active => 'Active';

	/// en: 'Inactive'
	String get inactive => 'Inactive';
}

// Path: backups.options
class AppStringsBackupsOptionsEn {
	AppStringsBackupsOptionsEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations
	late final AppStringsBackupsOptionsRestoreEn restore = AppStringsBackupsOptionsRestoreEn.internal(_root);
	late final AppStringsBackupsOptionsShareEn share = AppStringsBackupsOptionsShareEn.internal(_root);
	late final AppStringsBackupsOptionsDeleteEn delete = AppStringsBackupsOptionsDeleteEn.internal(_root);

	/// en: 'Latest'
	String get latestBadge => 'Latest';

	/// en: 'Latest backup'
	String get latestFile => 'Latest backup';

	/// en: 'Backup file'
	String get backupFile => 'Backup file';
}

// Path: backups.format
class AppStringsBackupsFormatEn {
	AppStringsBackupsFormatEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Auto Backup - $date'
	String auto({required Object date}) => 'Auto Backup - ${date}';

	/// en: 'Manual Backup - $date'
	String manual({required Object date}) => 'Manual Backup - ${date}';

	/// en: 'Initial Backup'
	String get initial => 'Initial Backup';

	/// en: 'Backup - $date'
	String generic({required Object date}) => 'Backup - ${date}';
}

// Path: transactions.filter.ranges
class AppStringsTransactionsFilterRangesEn {
	AppStringsTransactionsFilterRangesEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'This Month'
	String get thisMonth => 'This Month';

	/// en: 'Last Month'
	String get lastMonth => 'Last Month';

	/// en: 'This Year'
	String get thisYear => 'This Year';

	/// en: 'Last Year'
	String get lastYear => 'Last Year';
}

// Path: transactions.filter.subtitles
class AppStringsTransactionsFilterSubtitlesEn {
	AppStringsTransactionsFilterSubtitlesEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Money received'
	String get income => 'Money received';

	/// en: 'Money spent'
	String get expense => 'Money spent';

	/// en: 'Money moved'
	String get transfer => 'Money moved';
}

// Path: transactions.share.receipt
class AppStringsTransactionsShareReceiptEn {
	AppStringsTransactionsShareReceiptEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: '--- Transaction Details ---'
	String get title => '--- Transaction Details ---';

	/// en: 'Amount: $amount'
	String amount({required Object amount}) => 'Amount: ${amount}';

	/// en: 'Description: $description'
	String description({required Object description}) => 'Description: ${description}';

	/// en: 'Category: $category'
	String category({required Object category}) => 'Category: ${category}';

	/// en: 'Date: $date'
	String date({required Object date}) => 'Date: ${date}';

	/// en: 'Time: $time'
	String time({required Object time}) => 'Time: ${time}';

	/// en: 'Wallet: $wallet'
	String wallet({required Object wallet}) => 'Wallet: ${wallet}';

	/// en: 'Contact: $contact'
	String contact({required Object contact}) => 'Contact: ${contact}';

	/// en: 'Transaction ID: $id'
	String id({required Object id}) => 'Transaction ID: ${id}';

	/// en: '--------------------------'
	String get separator => '--------------------------';
}

// Path: onboarding.specificProblem.options
class AppStringsOnboardingSpecificProblemOptionsEn {
	AppStringsOnboardingSpecificProblemOptionsEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Debts and loans'
	String get debts => 'Debts and loans';

	/// en: 'Not being able to save'
	String get savings => 'Not being able to save';

	/// en: 'Not knowing where I spent it'
	String get unknown => 'Not knowing where I spent it';

	/// en: 'Financial chaos'
	String get chaos => 'Financial chaos';
}

// Path: onboarding.personalGoal.options
class AppStringsOnboardingPersonalGoalOptionsEn {
	AppStringsOnboardingPersonalGoalOptionsEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Be debt free'
	String get debtFree => 'Be debt free';

	/// en: 'Save for a trip/car'
	String get saveTrip => 'Save for a trip/car';

	/// en: 'Start investing'
	String get invest => 'Start investing';

	/// en: 'Financial peace of mind'
	String get peace => 'Financial peace of mind';
}

// Path: onboarding.solutionPreview.benefits
class AppStringsOnboardingSolutionPreviewBenefitsEn {
	AppStringsOnboardingSolutionPreviewBenefitsEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Visualize all your expenses in real time'
	String get visualize => 'Visualize all your expenses in real time';

	/// en: 'Set goals and track your progress'
	String get goals => 'Set goals and track your progress';

	/// en: 'Make smart financial decisions'
	String get smart => 'Make smart financial decisions';
}

// Path: onboarding.currentMethod.options
class AppStringsOnboardingCurrentMethodOptionsEn {
	AppStringsOnboardingCurrentMethodOptionsEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Excel / Spreadsheets'
	String get excel => 'Excel / Spreadsheets';

	/// en: 'Notebook'
	String get notebook => 'Notebook';

	/// en: 'Mental notes'
	String get mental => 'Mental notes';

	/// en: 'I don't track anything'
	String get none => 'I don\'t track anything';
}

// Path: onboarding.featuresShowcase.features
class AppStringsOnboardingFeaturesShowcaseFeaturesEn {
	AppStringsOnboardingFeaturesShowcaseFeaturesEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Income'
	String get income => 'Income';

	/// en: 'Expense'
	String get expense => 'Expense';

	/// en: 'Transfer'
	String get transfer => 'Transfer';

	/// en: 'Loans'
	String get loans => 'Loans';

	/// en: 'Goals'
	String get goals => 'Goals';

	/// en: 'Budgets'
	String get budgets => 'Budgets';

	/// en: 'Investments'
	String get investments => 'Investments';

	/// en: 'MoneyT Cloud'
	String get cloud => 'MoneyT Cloud';

	/// en: 'Open Banking'
	String get openBanking => 'Open Banking';
}

// Path: onboarding.complete.stats
class AppStringsOnboardingCompleteStatsEn {
	AppStringsOnboardingCompleteStatsEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Success Probability'
	String get title => 'Success Probability';

	/// en: 'Before MoneyT'
	String get before => 'Before MoneyT';

	/// en: 'With MoneyT'
	String get after => 'With MoneyT';
}

// Path: dashboard.widgets.balance
class AppStringsDashboardWidgetsBalanceEn {
	AppStringsDashboardWidgetsBalanceEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Total Balance'
	String get title => 'Total Balance';

	/// en: 'Shows your overall financial status'
	String get description => 'Shows your overall financial status';
}

// Path: dashboard.widgets.quickActions
class AppStringsDashboardWidgetsQuickActionsEn {
	AppStringsDashboardWidgetsQuickActionsEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Quick Actions'
	String get title => 'Quick Actions';

	/// en: 'Fast access to common transactions'
	String get description => 'Fast access to common transactions';
}

// Path: dashboard.widgets.wallets
class AppStringsDashboardWidgetsWalletsEn {
	AppStringsDashboardWidgetsWalletsEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Wallets'
	String get title => 'Wallets';

	/// en: 'Overview of your accounts'
	String get description => 'Overview of your accounts';
}

// Path: dashboard.widgets.loans
class AppStringsDashboardWidgetsLoansEn {
	AppStringsDashboardWidgetsLoansEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Loans'
	String get title => 'Loans';

	/// en: 'Track borrowed and lent money'
	String get description => 'Track borrowed and lent money';
}

// Path: dashboard.widgets.transactions
class AppStringsDashboardWidgetsTransactionsEn {
	AppStringsDashboardWidgetsTransactionsEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Recent Transactions'
	String get title => 'Recent Transactions';

	/// en: 'Latest financial activity'
	String get description => 'Latest financial activity';
}

// Path: dashboard.widgets.chartAccounts
class AppStringsDashboardWidgetsChartAccountsEn {
	AppStringsDashboardWidgetsChartAccountsEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Chart of Accounts'
	String get title => 'Chart of Accounts';

	/// en: 'Account structure overview'
	String get description => 'Account structure overview';
}

// Path: dashboard.widgets.creditCards
class AppStringsDashboardWidgetsCreditCardsEn {
	AppStringsDashboardWidgetsCreditCardsEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Credit Cards'
	String get title => 'Credit Cards';

	/// en: 'Credit card balances and limits'
	String get description => 'Credit card balances and limits';
}

// Path: dashboard.widgets.settings
class AppStringsDashboardWidgetsSettingsEn {
	AppStringsDashboardWidgetsSettingsEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Customize Dashboard'
	String get title => 'Customize Dashboard';

	/// en: 'Organize and manage your home screen widgets.'
	String get subtitle => 'Organize and manage your home screen widgets.';

	late final AppStringsDashboardWidgetsSettingsResetEn reset = AppStringsDashboardWidgetsSettingsResetEn.internal(_root);

	/// en: 'Changes saved successfully!'
	String get saveSuccess => 'Changes saved successfully!';

	/// en: 'Error saving changes: $error'
	String saveError({required Object error}) => 'Error saving changes: ${error}';

	/// en: 'Saving...'
	String get saving => 'Saving...';

	/// en: 'Save Changes'
	String get save => 'Save Changes';
}

// Path: loans.detail.type
class AppStringsLoansDetailTypeEn {
	AppStringsLoansDetailTypeEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Loan Type'
	String get label => 'Loan Type';

	/// en: 'Personal Loan'
	String get personal => 'Personal Loan';

	/// en: 'Borrowed Loan'
	String get borrowed => 'Borrowed Loan';

	/// en: 'Auto Loan'
	String get auto => 'Auto Loan';

	/// en: 'Mortgage'
	String get mortgage => 'Mortgage';

	/// en: 'Student Loan'
	String get student => 'Student Loan';
}

// Path: loans.detail.payment
class AppStringsLoansDetailPaymentEn {
	AppStringsLoansDetailPaymentEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Payment History'
	String get history => 'Payment History';

	/// en: 'Payment on $date'
	String date({required Object date}) => 'Payment on ${date}';

	/// en: 'Transaction ID: $id'
	String transactionId({required Object id}) => 'Transaction ID: ${id}';

	/// en: '$amount paid'
	String paid({required Object amount}) => '${amount} paid';

	/// en: '$amount remaining'
	String remaining({required Object amount}) => '${amount} remaining';
}

// Path: loans.history.filter
class AppStringsLoansHistoryFilterEn {
	AppStringsLoansHistoryFilterEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'All'
	String get all => 'All';

	/// en: 'Lent'
	String get lent => 'Lent';

	/// en: 'Borrowed'
	String get borrowed => 'Borrowed';

	/// en: 'Completed'
	String get completed => 'Completed';

	/// en: 'Filter Loan History'
	String get title => 'Filter Loan History';

	/// en: 'Reset'
	String get reset => 'Reset';

	/// en: 'Apply Filters'
	String get apply => 'Apply Filters';

	/// en: 'Date Range'
	String get dateRange => 'Date Range';

	/// en: 'Amount Range'
	String get amountRange => 'Amount Range';

	/// en: 'Start Date'
	String get startDate => 'Start Date';

	/// en: 'End Date'
	String get endDate => 'End Date';

	/// en: 'Select'
	String get select => 'Select';
}

// Path: loans.history.headers
class AppStringsLoansHistoryHeadersEn {
	AppStringsLoansHistoryHeadersEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Lent Loans'
	String get lent => 'Lent Loans';

	/// en: 'Borrowed Loans'
	String get borrowed => 'Borrowed Loans';

	/// en: 'Completed Loans'
	String get completed => 'Completed Loans';

	/// en: 'Active Loans'
	String get active => 'Active Loans';

	/// en: 'Cancelled Loans'
	String get cancelled => 'Cancelled Loans';

	/// en: 'Written Off Loans'
	String get writtenOff => 'Written Off Loans';
}

// Path: loans.history.item
class AppStringsLoansHistoryItemEn {
	AppStringsLoansHistoryItemEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Loan'
	String get defaultTitle => 'Loan';

	/// en: 'Date: $date'
	String date({required Object date}) => 'Date: ${date}';

	/// en: 'Lent'
	String get lent => 'Lent';

	/// en: 'Borrowed'
	String get borrowed => 'Borrowed';

	late final AppStringsLoansHistoryItemStatusEn status = AppStringsLoansHistoryItemStatusEn.internal(_root);
}

// Path: loans.history.summary
class AppStringsLoansHistorySummaryEn {
	AppStringsLoansHistorySummaryEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'History Summary'
	String get title => 'History Summary';

	/// en: 'View Details'
	String get viewDetails => 'View Details';

	/// en: 'Hide Details'
	String get hideDetails => 'Hide Details';

	/// en: 'Currently Outstanding'
	String get outstandingLent => 'Currently Outstanding';

	/// en: 'You Currently Owe'
	String get outstandingBorrowed => 'You Currently Owe';

	/// en: 'Net Position (Active)'
	String get netPosition => 'Net Position (Active)';

	/// en: 'Total Ever Lent'
	String get totalLent => 'Total Ever Lent';

	/// en: 'Total Ever Borrowed'
	String get totalBorrowed => 'Total Ever Borrowed';

	/// en: 'Total Repaid to You'
	String get totalRepaidToYou => 'Total Repaid to You';

	/// en: 'Total You Repaid'
	String get totalYouRepaid => 'Total You Repaid';

	/// en: 'Total Loans'
	String get totalLoans => 'Total Loans';

	/// en: 'Completed Loans'
	String get completedLoans => 'Completed Loans';
}

// Path: loans.payment.summary
class AppStringsLoansPaymentSummaryEn {
	AppStringsLoansPaymentSummaryEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Payment summary'
	String get title => 'Payment summary';

	/// en: 'Loan'
	String get defaultTitle => 'Loan';

	/// en: 'Payment amount'
	String get amount => 'Payment amount';

	/// en: 'Remaining balance'
	String get remaining => 'Remaining balance';

	/// en: 'New progress'
	String get progress => 'New progress';

	/// en: '$loan to $contact'
	String description({required Object loan, required Object contact}) => '${loan} to ${contact}';

	/// en: 'Unknown Contact'
	String get unknownContact => 'Unknown Contact';

	/// en: '$amount total'
	String total({required Object amount}) => '${amount} total';

	/// en: 'Paid: $amount'
	String paid({required Object amount}) => 'Paid: ${amount}';

	/// en: 'Remaining: $amount'
	String remainingLabel({required Object amount}) => 'Remaining: ${amount}';
}

// Path: loans.payment.quick
class AppStringsLoansPaymentQuickEn {
	AppStringsLoansPaymentQuickEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Full Payment ($amount)'
	String full({required Object amount}) => 'Full Payment (${amount})';

	/// en: 'Half ($amount)'
	String half({required Object amount}) => 'Half (${amount})';
}

// Path: backups.dialogs.info
class AppStringsBackupsDialogsInfoEn {
	AppStringsBackupsDialogsInfoEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Backup Information'
	String get title => 'Backup Information';

	/// en: 'File:'
	String get file => 'File:';

	/// en: 'Size:'
	String get size => 'Size:';

	/// en: 'Created:'
	String get created => 'Created:';

	/// en: 'Transactions:'
	String get transactions => 'Transactions:';
}

// Path: backups.dialogs.restore
class AppStringsBackupsDialogsRestoreEn {
	AppStringsBackupsDialogsRestoreEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Restore Backup'
	String get title => 'Restore Backup';

	/// en: 'Are you sure you want to restore from "$file"? The current database will be replaced.'
	String content({required Object file}) => 'Are you sure you want to restore from "${file}"? The current database will be replaced.';

	/// en: 'Restore initiated. The application might need to restart.'
	String get success => 'Restore initiated. The application might need to restart.';
}

// Path: backups.dialogs.delete
class AppStringsBackupsDialogsDeleteEn {
	AppStringsBackupsDialogsDeleteEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Delete Backup'
	String get title => 'Delete Backup';

	/// en: 'Are you sure you want to delete file "$file"? This action cannot be undone.'
	String content({required Object file}) => 'Are you sure you want to delete file "${file}"? This action cannot be undone.';

	/// en: 'Backup deleted.'
	String get success => 'Backup deleted.';
}

// Path: backups.options.restore
class AppStringsBackupsOptionsRestoreEn {
	AppStringsBackupsOptionsRestoreEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Restore backup'
	String get title => 'Restore backup';

	/// en: 'Replace current data with this backup'
	String get subtitle => 'Replace current data with this backup';
}

// Path: backups.options.share
class AppStringsBackupsOptionsShareEn {
	AppStringsBackupsOptionsShareEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Share backup'
	String get title => 'Share backup';

	/// en: 'Send this backup file to another device'
	String get subtitle => 'Send this backup file to another device';
}

// Path: backups.options.delete
class AppStringsBackupsOptionsDeleteEn {
	AppStringsBackupsOptionsDeleteEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Delete backup'
	String get title => 'Delete backup';

	/// en: 'This action cannot be undone'
	String get subtitle => 'This action cannot be undone';
}

// Path: dashboard.widgets.settings.reset
class AppStringsDashboardWidgetsSettingsResetEn {
	AppStringsDashboardWidgetsSettingsResetEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Reset to Default Layout'
	String get button => 'Reset to Default Layout';

	/// en: 'Reset to Default Layout'
	String get dialogTitle => 'Reset to Default Layout';

	/// en: 'Reset dashboard to default layout? This will restore all widgets to their original positions.'
	String get dialogContent => 'Reset dashboard to default layout? This will restore all widgets to their original positions.';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Reset'
	String get confirm => 'Reset';

	/// en: 'Layout reset to default'
	String get success => 'Layout reset to default';
}

// Path: loans.history.item.status
class AppStringsLoansHistoryItemStatusEn {
	AppStringsLoansHistoryItemStatusEn.internal(this._root);

	final AppStrings _root; // ignore: unused_field

	// Translations

	/// en: 'Completed'
	String get completed => 'Completed';

	/// en: 'Active'
	String get active => 'Active';

	/// en: 'Cancelled'
	String get cancelled => 'Cancelled';

	/// en: 'Written Off'
	String get writtenOff => 'Written Off';
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
			case 'common.today': return 'Today';
			case 'common.yesterday': return 'Yesterday';
			case 'components.dateSelection.title': return 'Select date';
			case 'components.dateSelection.subtitle': return 'Choose transaction date';
			case 'components.dateSelection.selectedDate': return 'Selected Date';
			case 'components.dateSelection.confirm': return 'Select';
			case 'components.selection.cancel': return 'Cancel';
			case 'components.selection.confirm': return 'Confirm';
			case 'components.selection.select': return 'Select';
			case 'components.contactSelection.title': return 'Select contact';
			case 'components.contactSelection.subtitle': return 'Choose whom this transaction is with';
			case 'components.contactSelection.searchPlaceholder': return 'Search contacts';
			case 'components.contactSelection.noContact': return 'No contact';
			case 'components.contactSelection.noContactDetails': return 'Transaction without specific contact';
			case 'components.contactSelection.allContacts': return 'All Contacts';
			case 'components.contactSelection.create': return 'Create new contact';
			case 'components.categorySelection.title': return 'Select category';
			case 'components.categorySelection.subtitle': return 'Choose a category for this transaction';
			case 'components.categorySelection.searchPlaceholder': return 'Search categories';
			case 'components.currencySelection.title': return 'Select currency';
			case 'components.currencySelection.subtitle': return 'Choose the currency for this wallet';
			case 'components.currencySelection.searchPlaceholder': return 'Search currencies';
			case 'components.accountSelection.title': return 'Select account';
			case 'components.accountSelection.subtitle': return 'Choose an account for this transaction';
			case 'components.accountSelection.searchPlaceholder': return 'Search accounts';
			case 'components.accountSelection.wallets': return 'Wallets';
			case 'components.accountSelection.creditCards': return 'Credit Cards';
			case 'components.accountSelection.selectAccount': return 'Select account';
			case 'components.accountSelection.confirm': return 'Confirm';
			case 'components.parentWalletSelection.title': return 'Select parent wallet';
			case 'components.parentWalletSelection.subtitle': return 'Choose a parent wallet to organize this wallet under another one';
			case 'components.parentWalletSelection.searchPlaceholder': return 'Search wallets';
			case 'components.parentWalletSelection.noParent': return 'No parent wallet';
			case 'components.parentWalletSelection.createRoot': return 'Create as a root wallet';
			case 'components.parentWalletSelection.available': return 'Available Wallets';
			case 'components.walletTypes.checking': return 'Checking';
			case 'components.walletTypes.savings': return 'Savings';
			case 'components.walletTypes.cash': return 'Cash';
			case 'components.walletTypes.creditCard': return 'Credit Card';
			case 'navigation.home': return 'Home';
			case 'navigation.transactions': return 'Transactions';
			case 'navigation.contacts': return 'Contacts';
			case 'navigation.settings': return 'Settings';
			case 'navigation.wallets': return 'Wallets';
			case 'navigation.categories': return 'Categories';
			case 'navigation.loans': return 'Loans';
			case 'navigation.charts': return 'Chart of Accounts';
			case 'navigation.backups': return 'Backups';
			case 'navigation.creditCards': return 'Credit Cards';
			case 'navigation.sections.operations': return 'OPERATIONS';
			case 'navigation.sections.financialTools': return 'FINANCIAL TOOLS';
			case 'navigation.sections.management': return 'MANAGEMENT';
			case 'navigation.sections.advanced': return 'ADVANCED';
			case 'transactions.title': return 'Transactions';
			case 'transactions.types.all': return 'All';
			case 'transactions.types.income': return 'Income';
			case 'transactions.types.expense': return 'Expense';
			case 'transactions.types.transfer': return 'Transfer';
			case 'transactions.filter.title': return 'Filter Transactions';
			case 'transactions.filter.date': return 'Date';
			case 'transactions.filter.categories': return 'Categories';
			case 'transactions.filter.accounts': return 'Accounts';
			case 'transactions.filter.contacts': return 'Contacts';
			case 'transactions.filter.amount': return 'Amount';
			case 'transactions.filter.apply': return 'Apply filters';
			case 'transactions.filter.clear': return 'Clear filters';
			case 'transactions.filter.add': return 'Add filter';
			case 'transactions.filter.minAmount': return 'Min Amount';
			case 'transactions.filter.maxAmount': return 'Max Amount';
			case 'transactions.filter.selectDate': return 'Select date';
			case 'transactions.filter.selectCategory': return 'Select category';
			case 'transactions.filter.selectAccount': return 'Select account';
			case 'transactions.filter.selectContact': return 'Select contact';
			case 'transactions.filter.quickFilters': return 'Quick filters';
			case 'transactions.filter.ranges.thisMonth': return 'This Month';
			case 'transactions.filter.ranges.lastMonth': return 'Last Month';
			case 'transactions.filter.ranges.thisYear': return 'This Year';
			case 'transactions.filter.ranges.lastYear': return 'Last Year';
			case 'transactions.filter.customRange': return 'Custom Date Range';
			case 'transactions.filter.startDate': return 'Start Date';
			case 'transactions.filter.endDate': return 'End Date';
			case 'transactions.filter.active': return 'Active Filters';
			case 'transactions.filter.subtitles.income': return 'Money received';
			case 'transactions.filter.subtitles.expense': return 'Money spent';
			case 'transactions.filter.subtitles.transfer': return 'Money moved';
			case 'transactions.form.newTitle': return 'New Transaction';
			case 'transactions.form.editTitle': return 'Edit Transaction';
			case 'transactions.form.amount': return 'Amount';
			case 'transactions.form.type': return 'Transaction type';
			case 'transactions.form.amountRequired': return 'Amount is required';
			case 'transactions.form.date': return 'Date';
			case 'transactions.form.account': return 'Account';
			case 'transactions.form.toAccount': return 'To Account';
			case 'transactions.form.category': return 'Category';
			case 'transactions.form.contact': return 'Contact';
			case 'transactions.form.contactOptional': return 'Contact (optional)';
			case 'transactions.form.description': return 'Description';
			case 'transactions.form.descriptionOptional': return 'Optional description';
			case 'transactions.form.selectAccount': return 'Select account';
			case 'transactions.form.selectDestination': return 'Select destination';
			case 'transactions.form.selectCategory': return 'Select category';
			case 'transactions.form.selectContact': return 'Select contact';
			case 'transactions.form.saveSuccess': return 'Transaction saved successfully';
			case 'transactions.form.updateSuccess': return 'Transaction updated successfully';
			case 'transactions.form.saveError': return 'Error saving transaction';
			case 'transactions.form.share': return 'Share';
			case 'transactions.form.created': return 'Transaction created successfully';
			case 'transactions.errors.load': return 'Error loading transactions';
			case 'transactions.empty.title': return 'No transactions';
			case 'transactions.empty.message': return 'No transactions found with applied filters';
			case 'transactions.empty.clearFilters': return 'Clear filters';
			case 'transactions.list.count': return ({required Object n}) => '${n} transactions';
			case 'transactions.detail.title': return 'Transaction Details';
			case 'transactions.detail.delete': return 'Delete Transaction';
			case 'transactions.detail.deleteConfirmation': return 'Are you sure? This action cannot be undone.';
			case 'transactions.detail.deleted': return 'Transaction deleted';
			case 'transactions.detail.duplicate': return 'Duplicate';
			case 'transactions.detail.duplicateNotImplemented': return 'Duplicate not implemented yet';
			case 'transactions.detail.edit': return 'Edit';
			case 'transactions.detail.errorLoad': return 'Error loading transaction details';
			case 'transactions.detail.errorPrepareEdit': return ({required Object error}) => 'Error preparing edit: ${error}';
			case 'transactions.detail.errorDelete': return ({required Object error}) => 'Error deleting: ${error}';
			case 'transactions.detail.category': return 'Category';
			case 'transactions.detail.account': return 'Account';
			case 'transactions.detail.contact': return 'Contact';
			case 'transactions.detail.description': return 'Description';
			case 'transactions.detail.transferDetails': return 'Transfer Details';
			case 'transactions.detail.from': return 'From';
			case 'transactions.detail.to': return 'To';
			case 'transactions.detail.unknownAccount': return 'Unknown Account';
			case 'transactions.detail.errorUrl': return ({required Object url}) => 'Could not open ${url}';
			case 'transactions.detail.date': return 'Date';
			case 'transactions.detail.time': return 'Time';
			case 'transactions.detail.loanLinkedWarning': return 'This transaction is linked to a loan and managed automatically.';
			case 'transactions.share.title': return 'Share Transaction';
			case 'transactions.share.copyText': return 'Copy Text';
			case 'transactions.share.shareButton': return 'Share';
			case 'transactions.share.shareMessage': return 'Here is my transaction receipt:';
			case 'transactions.share.copied': return 'Transaction details copied to clipboard!';
			case 'transactions.share.paymentMethod': return 'Payment Method';
			case 'transactions.share.receiptTitle': return 'Transaction Receipt';
			case 'transactions.share.poweredBy': return 'Powered by MoneyT • moneyt.io';
			case 'transactions.share.errorImage': return ({required Object error}) => 'Error sharing image: ${error}';
			case 'transactions.share.receipt.title': return '--- Transaction Details ---';
			case 'transactions.share.receipt.amount': return ({required Object amount}) => 'Amount: ${amount}';
			case 'transactions.share.receipt.description': return ({required Object description}) => 'Description: ${description}';
			case 'transactions.share.receipt.category': return ({required Object category}) => 'Category: ${category}';
			case 'transactions.share.receipt.date': return ({required Object date}) => 'Date: ${date}';
			case 'transactions.share.receipt.time': return ({required Object time}) => 'Time: ${time}';
			case 'transactions.share.receipt.wallet': return ({required Object wallet}) => 'Wallet: ${wallet}';
			case 'transactions.share.receipt.contact': return ({required Object contact}) => 'Contact: ${contact}';
			case 'transactions.share.receipt.id': return ({required Object id}) => 'Transaction ID: ${id}';
			case 'transactions.share.receipt.separator': return '--------------------------';
			case 'transactions.share.generatedOn': return ({required Object date}) => 'Generated on ${date}';
			case 'contacts.title': return 'Contacts';
			case 'contacts.addContact': return 'Add Contact';
			case 'contacts.editContact': return 'Edit Contact';
			case 'contacts.newContact': return 'New contact';
			case 'contacts.noContacts': return 'No contacts';
			case 'contacts.noContactsMessage': return 'Add your first contact with the "+" button';
			case 'contacts.searchContacts': return 'Search contacts';
			case 'contacts.deleteContact': return 'Delete contact';
			case 'contacts.confirmDelete': return 'Are you sure you want to delete';
			case 'contacts.contactDeleted': return 'Contact deleted successfully';
			case 'contacts.errorDeleting': return 'Error deleting contact';
			case 'contacts.noSearchResults': return 'No search results';
			case 'contacts.noContactsMatch': return ({required Object query}) => 'No contacts match "${query}". Try a different search term.';
			case 'contacts.errorLoading': return 'Error loading contacts';
			case 'contacts.contactSaved': return 'Contact saved successfully';
			case 'contacts.errorSaving': return 'Error saving contact';
			case 'contacts.noContactInfo': return 'No contact information';
			case 'contacts.importContact': return 'Import contact';
			case 'contacts.importContacts': return 'Import contacts';
			case 'contacts.importContactSoon': return 'Import contact functionality coming soon';
			case 'contacts.fields.name': return 'Name';
			case 'contacts.fields.fullName': return 'Full name';
			case 'contacts.fields.email': return 'Email';
			case 'contacts.fields.phone': return 'Phone';
			case 'contacts.fields.address': return 'Address';
			case 'contacts.fields.notes': return 'Notes';
			case 'contacts.placeholders.enterFullName': return 'Enter full name';
			case 'contacts.placeholders.enterPhone': return 'Enter phone number';
			case 'contacts.placeholders.enterEmail': return 'Enter email address';
			case 'contacts.validation.nameRequired': return 'Name is required';
			case 'contacts.validation.invalidEmail': return 'Invalid email';
			case 'contacts.validation.invalidPhone': return 'Invalid phone number';
			case 'errors.loadingAccounts': return ({required Object error}) => 'Error loading accounts: ${error}';
			case 'errors.unexpected': return 'Unexpected error';
			case 'settings.title': return 'Settings';
			case 'settings.account.title': return 'Account';
			case 'settings.account.profile': return 'Profile';
			case 'settings.account.profileSubtitle': return 'Manage your account information';
			case 'settings.appearance.title': return 'Appearance';
			case 'settings.appearance.darkMode': return 'Dark mode';
			case 'settings.appearance.darkModeSubtitle': return 'Switch to dark theme';
			case 'settings.appearance.language': return 'Language';
			case 'settings.appearance.darkTheme': return 'Dark theme';
			case 'settings.appearance.lightTheme': return 'Light theme';
			case 'settings.appearance.systemTheme': return 'System theme';
			case 'settings.data.title': return 'Data & Storage';
			case 'settings.data.backup': return 'Database backup';
			case 'settings.data.backupSubtitle': return 'Manage your data backups';
			case 'settings.info.title': return 'Information';
			case 'settings.info.contact': return 'Contact & Social';
			case 'settings.info.contactSubtitle': return 'Get support and follow us online';
			case 'settings.info.privacy': return 'Privacy policy';
			case 'settings.info.privacySubtitle': return 'Read our privacy policy';
			case 'settings.info.share': return 'Share MoneyT';
			case 'settings.info.shareSubtitle': return 'Tell your friends about the app';
			case 'settings.logout.button': return 'Sign out';
			case 'settings.logout.dialogTitle': return 'Sign out';
			case 'settings.logout.dialogMessage': return 'Are you sure you want to sign out of your account?';
			case 'settings.logout.cancel': return 'Cancel';
			case 'settings.logout.confirm': return 'Sign out';
			case 'settings.social.title': return 'Contact & Social';
			case 'settings.social.follow': return 'Follow MoneyT';
			case 'settings.social.description': return 'Stay connected with us on social media for updates, tips, and community discussions.';
			case 'settings.social.networks': return 'Social Networks';
			case 'settings.social.github': return 'GitHub';
			case 'settings.social.githubSubtitle': return 'View source code and contribute';
			case 'settings.social.linkedin': return 'LinkedIn';
			case 'settings.social.linkedinSubtitle': return 'Professional updates and insights';
			case 'settings.social.twitter': return 'X (Twitter)';
			case 'settings.social.twitterSubtitle': return 'Latest news and announcements';
			case 'settings.social.reddit': return 'Reddit';
			case 'settings.social.redditSubtitle': return 'Join the community discussions';
			case 'settings.social.discord': return 'Discord';
			case 'settings.social.discordSubtitle': return 'Join the community discussions';
			case 'settings.social.contact': return 'Contact';
			case 'settings.social.email': return 'Email Support';
			case 'settings.social.website': return 'Official Website';
			case 'settings.language.title': return 'Language';
			case 'settings.language.available': return 'AVAILABLE LANGUAGES';
			case 'settings.language.apply': return 'Apply Language';
			case 'settings.messages.profileComingSoon': return 'Profile screen coming soon';
			case 'settings.messages.privacyError': return 'Could not open privacy policy';
			case 'settings.messages.logoutComingSoon': return 'Sign out functionality coming soon';
			case 'onboarding.welcome.title': return 'Welcome to MoneyT 👋';
			case 'onboarding.welcome.subtitle': return 'Control your money in minutes ✨';
			case 'onboarding.problemStatement.title': return 'Do you feel like money slips through your fingers?';
			case 'onboarding.problemStatement.subtitle': return 'You\'re not alone. 70% of people don\'t know where their income goes.';
			case 'onboarding.specificProblem.title': return 'What\'s harder for you?';
			case 'onboarding.specificProblem.options.debts': return 'Debts and loans';
			case 'onboarding.specificProblem.options.savings': return 'Not being able to save';
			case 'onboarding.specificProblem.options.unknown': return 'Not knowing where I spent it';
			case 'onboarding.specificProblem.options.chaos': return 'Financial chaos';
			case 'onboarding.personalGoal.title': return 'What\'s your main goal?';
			case 'onboarding.personalGoal.options.debtFree': return 'Be debt free';
			case 'onboarding.personalGoal.options.saveTrip': return 'Save for a trip/car';
			case 'onboarding.personalGoal.options.invest': return 'Start investing';
			case 'onboarding.personalGoal.options.peace': return 'Financial peace of mind';
			case 'onboarding.solutionPreview.title': return 'MoneyT gives you clarity';
			case 'onboarding.solutionPreview.subtitle': return 'See all your accounts, debts, and expenses in one place. No spreadsheets, no stress.';
			case 'onboarding.solutionPreview.benefits.visualize': return 'Visualize all your expenses in real time';
			case 'onboarding.solutionPreview.benefits.goals': return 'Set goals and track your progress';
			case 'onboarding.solutionPreview.benefits.smart': return 'Make smart financial decisions';
			case 'onboarding.currentMethod.title': return 'How do you manage your money today?';
			case 'onboarding.currentMethod.subtitle': return 'Select the option that best describes you.';
			case 'onboarding.currentMethod.options.excel': return 'Excel / Spreadsheets';
			case 'onboarding.currentMethod.options.notebook': return 'Notebook';
			case 'onboarding.currentMethod.options.mental': return 'Mental notes';
			case 'onboarding.currentMethod.options.none': return 'I don\'t track anything';
			case 'onboarding.featuresShowcase.title': return 'Available and coming soon features ✨';
			case 'onboarding.featuresShowcase.subtitle': return 'Transactions ready to use. More features on the way.';
			case 'onboarding.featuresShowcase.available': return 'AVAILABLE NOW';
			case 'onboarding.featuresShowcase.comingSoon': return 'COMING SOON';
			case 'onboarding.featuresShowcase.features.income': return 'Income';
			case 'onboarding.featuresShowcase.features.expense': return 'Expense';
			case 'onboarding.featuresShowcase.features.transfer': return 'Transfer';
			case 'onboarding.featuresShowcase.features.loans': return 'Loans';
			case 'onboarding.featuresShowcase.features.goals': return 'Goals';
			case 'onboarding.featuresShowcase.features.budgets': return 'Budgets';
			case 'onboarding.featuresShowcase.features.investments': return 'Investments';
			case 'onboarding.featuresShowcase.features.cloud': return 'MoneyT Cloud';
			case 'onboarding.featuresShowcase.features.openBanking': return 'Open Banking';
			case 'onboarding.complete.title': return 'You\'re ready for takeoff! 🚀';
			case 'onboarding.complete.subtitle': return 'Record your first transaction and watch your success probability soar 📈';
			case 'onboarding.complete.stats.title': return 'Success Probability';
			case 'onboarding.complete.stats.before': return 'Before MoneyT';
			case 'onboarding.complete.stats.after': return 'With MoneyT';
			case 'onboarding.buttons.start': return 'Start now 🚀';
			case 'onboarding.buttons.fixIt': return 'Fix it today ⚡';
			case 'onboarding.buttons.actionContinue': return 'Continue';
			case 'onboarding.buttons.setGoal': return 'Set my goal 🎯';
			case 'onboarding.buttons.wantControl': return 'I want this control!';
			case 'onboarding.buttons.great': return 'Great, let\'s see it!';
			case 'onboarding.buttons.firstTransaction': return 'Record my first transaction ➕';
			case 'onboarding.buttons.skip': return 'Skip';
			case 'dashboard.greeting': return 'Welcome to MoneyT';
			case 'dashboard.balance.total': return 'Total Balance';
			case 'dashboard.balance.income': return 'INCOME';
			case 'dashboard.balance.expenses': return 'EXPENSES';
			case 'dashboard.balance.thisMonth': return 'this month';
			case 'dashboard.actions.income': return 'Income';
			case 'dashboard.actions.expense': return 'Expense';
			case 'dashboard.actions.transfer': return 'Transfer';
			case 'dashboard.actions.all': return 'All';
			case 'dashboard.wallets.title': return 'Wallets';
			case 'dashboard.wallets.count': return ({required Object n}) => '${n} accounts';
			case 'dashboard.wallets.more': return ({required Object n}) => '+${n} more accounts';
			case 'dashboard.wallets.viewDetails': return ({required Object name}) => 'View ${name} details';
			case 'dashboard.transactions.title': return 'Recent Transactions';
			case 'dashboard.transactions.subtitle': return 'Last 5 transactions';
			case 'dashboard.transactions.empty': return 'No recent transactions';
			case 'dashboard.transactions.emptySubtitle': return 'Your transactions will appear here';
			case 'dashboard.transactions.more': return ({required Object n}) => '+${n} more transactions';
			case 'dashboard.customize': return 'Customize';
			case 'dashboard.widgets.balance.title': return 'Total Balance';
			case 'dashboard.widgets.balance.description': return 'Shows your overall financial status';
			case 'dashboard.widgets.quickActions.title': return 'Quick Actions';
			case 'dashboard.widgets.quickActions.description': return 'Fast access to common transactions';
			case 'dashboard.widgets.wallets.title': return 'Wallets';
			case 'dashboard.widgets.wallets.description': return 'Overview of your accounts';
			case 'dashboard.widgets.loans.title': return 'Loans';
			case 'dashboard.widgets.loans.description': return 'Track borrowed and lent money';
			case 'dashboard.widgets.transactions.title': return 'Recent Transactions';
			case 'dashboard.widgets.transactions.description': return 'Latest financial activity';
			case 'dashboard.widgets.chartAccounts.title': return 'Chart of Accounts';
			case 'dashboard.widgets.chartAccounts.description': return 'Account structure overview';
			case 'dashboard.widgets.creditCards.title': return 'Credit Cards';
			case 'dashboard.widgets.creditCards.description': return 'Credit card balances and limits';
			case 'dashboard.widgets.settings.title': return 'Customize Dashboard';
			case 'dashboard.widgets.settings.subtitle': return 'Organize and manage your home screen widgets.';
			case 'dashboard.widgets.settings.reset.button': return 'Reset to Default Layout';
			case 'dashboard.widgets.settings.reset.dialogTitle': return 'Reset to Default Layout';
			case 'dashboard.widgets.settings.reset.dialogContent': return 'Reset dashboard to default layout? This will restore all widgets to their original positions.';
			case 'dashboard.widgets.settings.reset.cancel': return 'Cancel';
			case 'dashboard.widgets.settings.reset.confirm': return 'Reset';
			case 'dashboard.widgets.settings.reset.success': return 'Layout reset to default';
			case 'dashboard.widgets.settings.saveSuccess': return 'Changes saved successfully!';
			case 'dashboard.widgets.settings.saveError': return ({required Object error}) => 'Error saving changes: ${error}';
			case 'dashboard.widgets.settings.saving': return 'Saving...';
			case 'dashboard.widgets.settings.save': return 'Save Changes';
			case 'wallets.title': return 'Wallets';
			case 'wallets.empty.title': return 'No wallets found';
			case 'wallets.empty.message': return 'Add your first wallet to start tracking your finances.';
			case 'wallets.empty.action': return 'Create Wallet';
			case 'wallets.emptyArchived.title': return 'No archived wallets';
			case 'wallets.emptyArchived.message': return 'Archived wallets will appear here.';
			case 'wallets.filter.active': return 'Active';
			case 'wallets.filter.archived': return 'Archived';
			case 'wallets.filter.all': return 'All';
			case 'wallets.form.newTitle': return 'New wallet';
			case 'wallets.form.editTitle': return 'Edit wallet';
			case 'wallets.form.name': return 'Wallet name';
			case 'wallets.form.namePlaceholder': return 'Enter wallet name';
			case 'wallets.form.nameRequired': return 'Name is required';
			case 'wallets.form.description': return 'Description';
			case 'wallets.form.descriptionPlaceholder': return 'Optional description for this wallet';
			case 'wallets.form.currency': return 'Currency';
			case 'wallets.form.parent': return 'Parent wallet (optional)';
			case 'wallets.form.parentEmpty': return 'No wallets available as parent';
			case 'wallets.form.chartAccount': return 'Associated chart account';
			case 'wallets.form.chartAccountLocked': return 'Chart account cannot be changed';
			case 'wallets.form.createSuccess': return 'Wallet created successfully';
			case 'wallets.form.updateSuccess': return 'Wallet updated successfully';
			case 'wallets.form.loadParentError': return ({required Object error}) => 'Error loading parent wallets: ${error}';
			case 'wallets.form.loadChartAccountError': return ({required Object error}) => 'Error loading chart account: ${error}';
			case 'wallets.delete.dialogTitle': return 'Delete wallet';
			case 'wallets.delete.dialogMessage': return ({required Object name}) => 'Are you sure you want to delete ${name}?';
			case 'wallets.delete.cancel': return 'Cancel';
			case 'wallets.delete.confirm': return 'Delete';
			case 'wallets.delete.success': return 'Wallet deleted successfully';
			case 'wallets.delete.error': return ({required Object error}) => 'Error deleting wallet: ${error}';
			case 'wallets.errors.load': return 'Error loading wallets';
			case 'wallets.errors.retry': return 'Retry';
			case 'wallets.errors.comingSoon': return ({required Object name}) => '${name} coming soon';
			case 'wallets.subtitle.mainAccount': return 'Main account';
			case 'wallets.subtitle.cashDigital': return 'Cash & digital';
			case 'wallets.subtitle.count': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: '${n} wallet',
				other: '${n} wallets',
			);
			case 'wallets.subtitle.account': return 'Account';
			case 'wallets.subtitle.physicalCash': return 'Physical cash';
			case 'wallets.subtitle.digitalWallet': return 'Digital wallet';
			case 'wallets.options.viewTransactions': return 'View transactions';
			case 'wallets.options.viewTransactionsSubtitle': return 'See all transactions for this wallet';
			case 'wallets.options.transferFunds': return 'Transfer funds';
			case 'wallets.options.transferFundsSubtitle': return 'Move money between wallets';
			case 'wallets.options.editWallet': return 'Edit wallet';
			case 'wallets.options.editWalletSubtitle': return 'Modify wallet details';
			case 'wallets.options.duplicateWallet': return 'Duplicate wallet';
			case 'wallets.options.duplicateWalletSubtitle': return 'Create a copy of this wallet';
			case 'wallets.options.archiveWallet': return 'Archive wallet';
			case 'wallets.options.archiveWalletSubtitle': return 'Hide wallet from main view';
			case 'wallets.options.unarchiveWallet': return 'Unarchive wallet';
			case 'wallets.options.unarchiveWalletSubtitle': return 'Restore to main view';
			case 'wallets.options.deleteWallet': return 'Delete wallet';
			case 'wallets.options.deleteWalletSubtitle': return 'Permanently remove this wallet';
			case 'wallets.options.defaultTitle': return 'Wallet';
			case 'loans.title': return 'Loans';
			case 'loans.filter.active': return 'Active Loans';
			case 'loans.filter.history': return 'History';
			case 'loans.filter.all': return 'All';
			case 'loans.filter.pending': return 'Pending';
			case 'loans.filter.lent': return 'Lent';
			case 'loans.filter.borrowed': return 'Borrowed';
			case 'loans.summary.netBalance': return 'NET BALANCE';
			case 'loans.summary.activeLoans': return 'ACTIVE LOANS';
			case 'loans.summary.noActive': return 'No active loans';
			case 'loans.summary.lent': return ({required Object n}) => '${n} lent';
			case 'loans.summary.borrowed': return ({required Object n}) => '${n} borrowed';
			case 'loans.summary.pending': return ({required Object n}) => '${n} pending';
			case 'loans.card.lent': return 'You Lent';
			case 'loans.card.borrowed': return 'You Borrowed';
			case 'loans.card.active': return ({required Object n}) => '${n} active';
			case 'loans.card.multiple': return ({required Object n}) => '${n} loans';
			case 'loans.card.transactions': return ({required Object n}) => '${n} transactions';
			case 'loans.card.overdue': return ({required Object n}) => 'Overdue by ${n} days';
			case 'loans.card.due': return ({required Object date}) => 'Due ${date}';
			case 'loans.form.newTitle': return 'New Loan';
			case 'loans.form.editTitle': return 'Edit Loan';
			case 'loans.form.type': return 'Loan type';
			case 'loans.form.lend': return 'I Lend';
			case 'loans.form.borrow': return 'I Borrow';
			case 'loans.form.contact': return 'Contact';
			case 'loans.form.contactPlaceholder': return 'Select a contact';
			case 'loans.form.account': return 'From Account';
			case 'loans.form.accountPlaceholder': return 'Select an account';
			case 'loans.form.amount': return 'Amount';
			case 'loans.form.description': return 'Description';
			case 'loans.form.date': return 'Loan date';
			case 'loans.form.dueDate': return 'Due date';
			case 'loans.form.selectDate': return 'Select date';
			case 'loans.form.optional': return '(Optional)';
			case 'loans.form.createTransaction': return 'Create transaction record';
			case 'loans.form.recordAutomatically': return 'Record transaction automatically';
			case 'loans.form.transactionCategory': return 'Transaction category';
			case 'loans.form.category': return 'Category';
			case 'loans.form.categoryPlaceholder': return 'Select a category';
			case 'loans.form.save': return 'Save Loan';
			case 'loans.form.successCreate': return 'Loan created successfully';
			case 'loans.form.successUpdate': return 'Loan updated successfully';
			case 'loans.form.contactRequired': return 'Contact is required';
			case 'loans.form.accountRequired': return 'Account is required';
			case 'loans.form.amountRequired': return 'Amount is required';
			case 'loans.detail.title': return 'Loan Details';
			case 'loans.detail.deleteTitle': return 'Delete Loan';
			case 'loans.detail.deleteMessage': return 'Are you sure you want to delete this loan?';
			case 'loans.detail.deleteSuccess': return 'Loan deleted successfully';
			case 'loans.detail.deleteError': return ({required Object error}) => 'Error deleting loan: ${error}';
			case 'loans.detail.notFound': return 'Loan not found';
			case 'loans.detail.progress': return 'Loan Progress';
			case 'loans.detail.info': return 'Loan Information';
			case 'loans.detail.pay': return 'Pay';
			case 'loans.detail.viewHistory': return 'View Complete History';
			case 'loans.detail.original': return ({required Object amount}) => 'Original: ${amount}';
			case 'loans.detail.section': return 'Loan Details';
			case 'loans.detail.activeSummary': return 'Active Summary';
			case 'loans.detail.activeLent': return 'You Lent (Active)';
			case 'loans.detail.activeBorrowed': return 'You Borrowed (Active)';
			case 'loans.detail.activeNet': return 'Net Position (Active)';
			case 'loans.detail.activeTotal': return 'Total Active Loans';
			case 'loans.detail.startDate': return 'Loan Start';
			case 'loans.detail.dueDate': return 'Due Date';
			case 'loans.detail.type.label': return 'Loan Type';
			case 'loans.detail.type.personal': return 'Personal Loan';
			case 'loans.detail.type.borrowed': return 'Borrowed Loan';
			case 'loans.detail.type.auto': return 'Auto Loan';
			case 'loans.detail.type.mortgage': return 'Mortgage';
			case 'loans.detail.type.student': return 'Student Loan';
			case 'loans.detail.payment.history': return 'Payment History';
			case 'loans.detail.payment.date': return ({required Object date}) => 'Payment on ${date}';
			case 'loans.detail.payment.transactionId': return ({required Object id}) => 'Transaction ID: ${id}';
			case 'loans.detail.payment.paid': return ({required Object amount}) => '${amount} paid';
			case 'loans.detail.payment.remaining': return ({required Object amount}) => '${amount} remaining';
			case 'loans.history.title': return 'Loan History';
			case 'loans.history.section': return 'Complete loan history';
			case 'loans.history.totalLoaned': return 'Total loaned';
			case 'loans.history.noLoans': return 'No loans found for this filter.';
			case 'loans.history.filter.all': return 'All';
			case 'loans.history.filter.lent': return 'Lent';
			case 'loans.history.filter.borrowed': return 'Borrowed';
			case 'loans.history.filter.completed': return 'Completed';
			case 'loans.history.filter.title': return 'Filter Loan History';
			case 'loans.history.filter.reset': return 'Reset';
			case 'loans.history.filter.apply': return 'Apply Filters';
			case 'loans.history.filter.dateRange': return 'Date Range';
			case 'loans.history.filter.amountRange': return 'Amount Range';
			case 'loans.history.filter.startDate': return 'Start Date';
			case 'loans.history.filter.endDate': return 'End Date';
			case 'loans.history.filter.select': return 'Select';
			case 'loans.history.headers.lent': return 'Lent Loans';
			case 'loans.history.headers.borrowed': return 'Borrowed Loans';
			case 'loans.history.headers.completed': return 'Completed Loans';
			case 'loans.history.headers.active': return 'Active Loans';
			case 'loans.history.headers.cancelled': return 'Cancelled Loans';
			case 'loans.history.headers.writtenOff': return 'Written Off Loans';
			case 'loans.history.item.defaultTitle': return 'Loan';
			case 'loans.history.item.date': return ({required Object date}) => 'Date: ${date}';
			case 'loans.history.item.lent': return 'Lent';
			case 'loans.history.item.borrowed': return 'Borrowed';
			case 'loans.history.item.status.completed': return 'Completed';
			case 'loans.history.item.status.active': return 'Active';
			case 'loans.history.item.status.cancelled': return 'Cancelled';
			case 'loans.history.item.status.writtenOff': return 'Written Off';
			case 'loans.history.summary.title': return 'History Summary';
			case 'loans.history.summary.viewDetails': return 'View Details';
			case 'loans.history.summary.hideDetails': return 'Hide Details';
			case 'loans.history.summary.outstandingLent': return 'Currently Outstanding';
			case 'loans.history.summary.outstandingBorrowed': return 'You Currently Owe';
			case 'loans.history.summary.netPosition': return 'Net Position (Active)';
			case 'loans.history.summary.totalLent': return 'Total Ever Lent';
			case 'loans.history.summary.totalBorrowed': return 'Total Ever Borrowed';
			case 'loans.history.summary.totalRepaidToYou': return 'Total Repaid to You';
			case 'loans.history.summary.totalYouRepaid': return 'Total You Repaid';
			case 'loans.history.summary.totalLoans': return 'Total Loans';
			case 'loans.history.summary.completedLoans': return 'Completed Loans';
			case 'loans.contactDetail.titleWith': return ({required Object name}) => 'Loans with ${name}';
			case 'loans.share.title': return 'Share Loan';
			case 'loans.share.contactTitle': return 'Share Contact Loans';
			case 'loans.share.button': return 'Share';
			case 'loans.share.copy': return 'Copy Text';
			case 'loans.share.message': return 'Here is my loan statement:';
			case 'loans.share.contactMessage': return ({required Object name}) => 'Loan Summary with ${name}:';
			case 'loans.share.error': return ({required Object error}) => 'Error sharing image: ${error}';
			case 'loans.share.contactCopied': return 'Loan summary copied to clipboard!';
			case 'loans.share.activeLoans': return ({required Object n}) => 'Active Loans (${n}):';
			case 'loans.share.loanItem': return ({required Object description, required Object amount, required Object date, required Object percent}) => '• ${description}: ${amount} (Date: ${date}) - ${percent}% paid';
			case 'loans.share.loanStatement': return 'MoneyT - Loan Statement';
			case 'loans.share.loanSummary': return 'MoneyT - Loan Summary';
			case 'loans.share.personalLoan': return 'Personal Loan';
			case 'loans.share.remaining': return ({required Object amount}) => 'Remaining Balance: ${amount}';
			case 'loans.share.remainingLabel': return 'Remaining Balance';
			case 'loans.share.original': return ({required Object amount}) => 'of ${amount} original';
			case 'loans.share.progress': return ({required Object percent}) => 'Payment Progress: ${percent}% Paid';
			case 'loans.share.progressLabel': return 'Payment Progress';
			case 'loans.share.paidSuffix': return 'Paid';
			case 'loans.share.date': return ({required Object date}) => 'Loan Date: ${date}';
			case 'loans.share.dateLabel': return 'Loan Date';
			case 'loans.share.contact': return ({required Object name}) => 'Contact: ${name}';
			case 'loans.share.contactLabel': return 'Contact';
			case 'loans.share.generated': return ({required Object date}) => 'Generated on ${date}';
			case 'loans.share.generatedLabel': return ({required Object date}) => 'Generated on ${date}';
			case 'loans.share.totalActive': return ({required Object n}) => 'Total Active: ${n} loans';
			case 'loans.share.active': return 'active';
			case 'loans.share.poweredBy': return 'Powered by MoneyT • moneyt.io';
			case 'loans.share.copied': return 'Loan details copied to clipboard!';
			case 'loans.share.netBalance': return ({required Object amount, required Object status}) => 'Net Balance: ${amount} (${status})';
			case 'loans.share.netBalanceLabel': return 'Net Balance';
			case 'loans.share.owed': return 'You are owed';
			case 'loans.share.owe': return 'You owe';
			case 'loans.share.lent': return ({required Object amount}) => 'You Lent: ${amount}';
			case 'loans.share.lentLabel': return 'You Lent';
			case 'loans.share.borrowed': return ({required Object amount}) => 'You Borrowed: ${amount}';
			case 'loans.share.borrowedLabel': return 'You Borrowed';
			case 'loans.share.contactSummary': return ({required Object name}) => '${name} - Loan Summary';
			case 'loans.payment.title': return 'Record Payment';
			case 'loans.payment.amount': return 'Payment amount';
			case 'loans.payment.amountPlaceholder': return '0.00';
			case 'loans.payment.amountRequired': return 'Payment amount is required';
			case 'loans.payment.invalidAmount': return 'Please enter a valid amount';
			case 'loans.payment.exceedsBalance': return 'Amount cannot exceed remaining balance';
			case 'loans.payment.date': return 'Payment date';
			case 'loans.payment.account': return 'Received in account';
			case 'loans.payment.selectAccount': return 'Select account';
			case 'loans.payment.details': return 'Payment details';
			case 'loans.payment.detailsPlaceholder': return 'Add notes about this payment (optional)';
			case 'loans.payment.success': return 'Payment recorded successfully';
			case 'loans.payment.error': return ({required Object error}) => 'Error recording payment: ${error}';
			case 'loans.payment.errorAmount': return 'Please enter a valid payment amount';
			case 'loans.payment.errorAccount': return 'Please select an account';
			case 'loans.payment.errorLoading': return ({required Object error}) => 'Error loading data: ${error}';
			case 'loans.payment.summary.title': return 'Payment summary';
			case 'loans.payment.summary.defaultTitle': return 'Loan';
			case 'loans.payment.summary.amount': return 'Payment amount';
			case 'loans.payment.summary.remaining': return 'Remaining balance';
			case 'loans.payment.summary.progress': return 'New progress';
			case 'loans.payment.summary.description': return ({required Object loan, required Object contact}) => '${loan} to ${contact}';
			case 'loans.payment.summary.unknownContact': return 'Unknown Contact';
			case 'loans.payment.summary.total': return ({required Object amount}) => '${amount} total';
			case 'loans.payment.summary.paid': return ({required Object amount}) => 'Paid: ${amount}';
			case 'loans.payment.summary.remainingLabel': return ({required Object amount}) => 'Remaining: ${amount}';
			case 'loans.payment.quick.full': return ({required Object amount}) => 'Full Payment (${amount})';
			case 'loans.payment.quick.half': return ({required Object amount}) => 'Half (${amount})';
			case 'loans.given': return 'Loan Given';
			case 'loans.received': return 'Loan Received';
			case 'loans.item.due': return ({required Object date}) => 'Due: ${date}';
			case 'loans.item.paidAmount': return ({required Object amount}) => 'Paid: ${amount}';
			case 'loans.item.remaining': return ({required Object amount}) => 'Remaining: ${amount}';
			case 'loans.item.percentPaid': return ({required Object percent}) => '${percent}% paid';
			case 'loans.section.activeLoans': return 'Active Loans';
			case 'loans.section.loansCount': return ({required Object n}) => '${n} loans';
			case 'loans.empty.title': return 'No loans active';
			case 'loans.empty.message': return 'Start tracking money you lent or borrowed.';
			case 'loans.empty.action': return 'Add Loan';
			case 'categories.title': return 'Categories';
			case 'categories.form.newTitle': return 'New Category';
			case 'categories.form.editTitle': return 'Edit Category';
			case 'categories.form.name': return 'Category Name';
			case 'categories.form.namePlaceholder': return 'Enter category name';
			case 'categories.form.nameRequired': return 'Category name is required';
			case 'categories.form.parent': return 'Parent Category (Optional)';
			case 'categories.form.noParent': return 'No parent category';
			case 'categories.form.asSubcategory': return 'Will be created as subcategory';
			case 'categories.form.asRoot': return 'Will be created as root category';
			case 'categories.form.active': return 'Active Category';
			case 'categories.form.activeDescription': return 'Enable this category for new transactions';
			case 'categories.form.selectIcon': return 'Select Icon';
			case 'categories.form.selectColor': return 'Select Color';
			case 'categories.form.saveSuccess': return 'Category saved successfully';
			case 'categories.form.saveError': return ({required Object error}) => 'Error saving category: ${error}';
			case 'categories.parentSelection.title': return 'Select Parent Category';
			case 'categories.parentSelection.subtitle': return 'Tap to select a parent category';
			case 'categories.parentSelection.noParent': return 'No parent category';
			case 'categories.incomeCategory': return 'Income category';
			case 'categories.expenseCategory': return 'Expense category';
			case 'backups.title': return 'Database Backup';
			case 'backups.menu.settings': return 'Backup settings';
			case 'backups.menu.comingSoon': return 'Backup settings coming soon';
			case 'backups.filters.all': return 'All';
			case 'backups.filters.auto': return 'Auto';
			case 'backups.filters.manual': return 'Manual';
			case 'backups.filters.thisMonth': return 'This Month';
			case 'backups.filters.lastMonth': return 'Last Month';
			case 'backups.filters.thisYear': return 'This Year';
			case 'backups.filters.lastYear': return 'Last Year';
			case 'backups.status.loading': return 'Loading...';
			case 'backups.status.error': return 'Error loading backups';
			case 'backups.status.empty': return 'No backups found';
			case 'backups.status.emptyAction': return 'Create your first backup using the + button';
			case 'backups.status.success': return 'Success';
			case 'backups.status.created': return 'Backup created successfully';
			case 'backups.status.createError': return ({required Object error}) => 'Error creating backup: ${error}';
			case 'backups.status.restoreError': return ({required Object error}) => 'Error restoring backup: ${error}';
			case 'backups.status.deleteError': return ({required Object error}) => 'Error deleting backup: ${error}';
			case 'backups.actions.create': return 'Create Backup';
			case 'backups.actions.import': return 'Import Backup';
			case 'backups.actions.restore': return 'Restore';
			case 'backups.actions.delete': return 'Delete';
			case 'backups.actions.share': return 'Share';
			case 'backups.actions.cancel': return 'Cancel';
			case 'backups.actions.retry': return 'Retry';
			case 'backups.actions.ok': return 'OK';
			case 'backups.dialogs.info.title': return 'Backup Information';
			case 'backups.dialogs.info.file': return 'File:';
			case 'backups.dialogs.info.size': return 'Size:';
			case 'backups.dialogs.info.created': return 'Created:';
			case 'backups.dialogs.info.transactions': return 'Transactions:';
			case 'backups.dialogs.restore.title': return 'Restore Backup';
			case 'backups.dialogs.restore.content': return ({required Object file}) => 'Are you sure you want to restore from "${file}"? The current database will be replaced.';
			case 'backups.dialogs.restore.success': return 'Restore initiated. The application might need to restart.';
			case 'backups.dialogs.delete.title': return 'Delete Backup';
			case 'backups.dialogs.delete.content': return ({required Object file}) => 'Are you sure you want to delete file "${file}"? This action cannot be undone.';
			case 'backups.dialogs.delete.success': return 'Backup deleted.';
			case 'backups.stats.title': return 'Backup Statistics';
			case 'backups.stats.totalBackups': return 'Total Backups';
			case 'backups.stats.totalSize': return 'Total Size';
			case 'backups.stats.oldest': return 'Oldest Backup';
			case 'backups.stats.latest': return 'Latest Backup';
			case 'backups.stats.autoBackupStatus': return 'Auto Backup Status';
			case 'backups.stats.active': return 'Active';
			case 'backups.stats.inactive': return 'Inactive';
			case 'backups.options.restore.title': return 'Restore backup';
			case 'backups.options.restore.subtitle': return 'Replace current data with this backup';
			case 'backups.options.share.title': return 'Share backup';
			case 'backups.options.share.subtitle': return 'Send this backup file to another device';
			case 'backups.options.delete.title': return 'Delete backup';
			case 'backups.options.delete.subtitle': return 'This action cannot be undone';
			case 'backups.options.latestBadge': return 'Latest';
			case 'backups.options.latestFile': return 'Latest backup';
			case 'backups.options.backupFile': return 'Backup file';
			case 'backups.format.auto': return ({required Object date}) => 'Auto Backup - ${date}';
			case 'backups.format.manual': return ({required Object date}) => 'Manual Backup - ${date}';
			case 'backups.format.initial': return 'Initial Backup';
			case 'backups.format.generic': return ({required Object date}) => 'Backup - ${date}';
			default: return null;
		}
	}
}

