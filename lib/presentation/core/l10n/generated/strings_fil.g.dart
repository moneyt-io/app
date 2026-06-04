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
class AppStringsFil extends AppStrings {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	AppStringsFil({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, AppStrings>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.fil,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <fil>.
	@override final TranslationMetadata<AppLocale, AppStrings> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final AppStringsFil _root = this; // ignore: unused_field

	@override 
	AppStringsFil $copyWith({TranslationMetadata<AppLocale, AppStrings>? meta}) => AppStringsFil(meta: meta ?? this.$meta);

	// Translations
	@override late final _AppStringsAppFil app = _AppStringsAppFil._(_root);
	@override late final _AppStringsCommonFil common = _AppStringsCommonFil._(_root);
	@override late final _AppStringsComponentsFil components = _AppStringsComponentsFil._(_root);
	@override late final _AppStringsNavigationFil navigation = _AppStringsNavigationFil._(_root);
	@override late final _AppStringsTransactionsFil transactions = _AppStringsTransactionsFil._(_root);
	@override late final _AppStringsContactsFil contacts = _AppStringsContactsFil._(_root);
	@override late final _AppStringsErrorsFil errors = _AppStringsErrorsFil._(_root);
	@override late final _AppStringsSettingsFil settings = _AppStringsSettingsFil._(_root);
	@override late final _AppStringsOnboardingFil onboarding = _AppStringsOnboardingFil._(_root);
	@override late final _AppStringsDashboardFil dashboard = _AppStringsDashboardFil._(_root);
	@override late final _AppStringsWalletsFil wallets = _AppStringsWalletsFil._(_root);
	@override late final _AppStringsLoansFil loans = _AppStringsLoansFil._(_root);
	@override late final _AppStringsCategoriesFil categories = _AppStringsCategoriesFil._(_root);
	@override late final _AppStringsBackupsFil backups = _AppStringsBackupsFil._(_root);
	@override late final _AppStringsV2Fil v2 = _AppStringsV2Fil._(_root);
	@override late final _AppStringsIntentsFil intents = _AppStringsIntentsFil._(_root);
}

// Path: app
class _AppStringsAppFil extends AppStringsAppEn {
	_AppStringsAppFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get name => 'MoneyT';
	@override String get description => 'Tagapamahala ng Pera';
}

// Path: common
class _AppStringsCommonFil extends AppStringsCommonEn {
	_AppStringsCommonFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get save => 'I-save';
	@override String get cancel => 'Kanselahin';
	@override String get delete => 'Burahin';
	@override String get edit => 'I-edit';
	@override String get loading => 'Naglo-load...';
	@override String get error => 'Error';
	@override String get success => 'Tagumpay';
	@override String get search => 'Maghanap';
	@override String get clearSearch => 'I-clear ang paghahanap';
	@override String get viewAll => 'Tingnan lahat';
	@override String get retry => 'Subukang muli';
	@override String get add => 'Magdagdag';
	@override String get remove => 'Alisin';
	@override String get moreOptions => 'Iba pang opsyon';
	@override String get addToFavorites => 'Idagdag sa paborito';
	@override String get removeFromFavorites => 'Alisin sa paborito';
	@override String get today => 'Ngayon';
	@override String get yesterday => 'Kahapon';
}

// Path: components
class _AppStringsComponentsFil extends AppStringsComponentsEn {
	_AppStringsComponentsFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override late final _AppStringsComponentsDateSelectionFil dateSelection = _AppStringsComponentsDateSelectionFil._(_root);
	@override late final _AppStringsComponentsSelectionFil selection = _AppStringsComponentsSelectionFil._(_root);
	@override late final _AppStringsComponentsContactSelectionFil contactSelection = _AppStringsComponentsContactSelectionFil._(_root);
	@override late final _AppStringsComponentsCategorySelectionFil categorySelection = _AppStringsComponentsCategorySelectionFil._(_root);
	@override late final _AppStringsComponentsCurrencySelectionFil currencySelection = _AppStringsComponentsCurrencySelectionFil._(_root);
	@override late final _AppStringsComponentsAccountSelectionFil accountSelection = _AppStringsComponentsAccountSelectionFil._(_root);
	@override late final _AppStringsComponentsParentWalletSelectionFil parentWalletSelection = _AppStringsComponentsParentWalletSelectionFil._(_root);
	@override late final _AppStringsComponentsWalletTypesFil walletTypes = _AppStringsComponentsWalletTypesFil._(_root);
}

// Path: navigation
class _AppStringsNavigationFil extends AppStringsNavigationEn {
	_AppStringsNavigationFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get home => 'Home';
	@override String get transactions => 'Transaksyon';
	@override String get contacts => 'Mga Contact';
	@override String get settings => 'Mga Setting';
	@override String get wallets => 'Mga Wallet';
	@override String get categories => 'Mga Kategorya';
	@override String get loans => 'Mga Utang';
	@override String get charts => 'Chart of Accounts';
	@override String get backups => 'Mga Backup';
	@override String get creditCards => 'Credit Cards';
	@override late final _AppStringsNavigationSectionsFil sections = _AppStringsNavigationSectionsFil._(_root);
}

// Path: transactions
class _AppStringsTransactionsFil extends AppStringsTransactionsEn {
	_AppStringsTransactionsFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Mga Transaksyon';
	@override late final _AppStringsTransactionsTypesFil types = _AppStringsTransactionsTypesFil._(_root);
	@override late final _AppStringsTransactionsFilterFil filter = _AppStringsTransactionsFilterFil._(_root);
	@override late final _AppStringsTransactionsFormFil form = _AppStringsTransactionsFormFil._(_root);
	@override late final _AppStringsTransactionsErrorsFil errors = _AppStringsTransactionsErrorsFil._(_root);
	@override late final _AppStringsTransactionsEmptyFil empty = _AppStringsTransactionsEmptyFil._(_root);
	@override late final _AppStringsTransactionsListFil list = _AppStringsTransactionsListFil._(_root);
	@override late final _AppStringsTransactionsDetailFil detail = _AppStringsTransactionsDetailFil._(_root);
	@override late final _AppStringsTransactionsShareFil share = _AppStringsTransactionsShareFil._(_root);
}

// Path: contacts
class _AppStringsContactsFil extends AppStringsContactsEn {
	_AppStringsContactsFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Mga Contact';
	@override String get addContact => 'Magdagdag';
	@override String get editContact => 'I-edit';
	@override String get newContact => 'Bagong contact';
	@override String get noContacts => 'Walang contact';
	@override String get noContactsMessage => 'Magdagdag ng iyong unang contact gamit ang "+"';
	@override String get searchContacts => 'Maghanap';
	@override String get deleteContact => 'Burahin';
	@override String get confirmDelete => 'Gusto mo bang burahin ang';
	@override String get contactDeleted => 'Nabura na';
	@override String get errorDeleting => 'Error sa pagbura';
	@override String get noSearchResults => 'Walang nahanap';
	@override String noContactsMatch({required Object query}) => 'Walang tumutugma sa "${query}".';
	@override String get errorLoading => 'Error sa pag-load';
	@override String get contactSaved => 'Nai-save na';
	@override String get errorSaving => 'Error sa pag-save';
	@override String get noContactInfo => 'Walang impormasyon';
	@override String get importContact => 'Mag-import';
	@override String get importContacts => 'Mag-import ng mga contact';
	@override String get importContactSoon => 'Malapit nang dumating';
	@override late final _AppStringsContactsFieldsFil fields = _AppStringsContactsFieldsFil._(_root);
	@override late final _AppStringsContactsPlaceholdersFil placeholders = _AppStringsContactsPlaceholdersFil._(_root);
	@override late final _AppStringsContactsValidationFil validation = _AppStringsContactsValidationFil._(_root);
}

// Path: errors
class _AppStringsErrorsFil extends AppStringsErrorsEn {
	_AppStringsErrorsFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String loadingAccounts({required Object error}) => 'Error: ${error}';
	@override String get unexpected => 'Hindi inaasahang error';
}

// Path: settings
class _AppStringsSettingsFil extends AppStringsSettingsEn {
	_AppStringsSettingsFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Mga Setting';
	@override late final _AppStringsSettingsAccountFil account = _AppStringsSettingsAccountFil._(_root);
	@override late final _AppStringsSettingsAppearanceFil appearance = _AppStringsSettingsAppearanceFil._(_root);
	@override late final _AppStringsSettingsDataFil data = _AppStringsSettingsDataFil._(_root);
	@override late final _AppStringsSettingsInfoFil info = _AppStringsSettingsInfoFil._(_root);
	@override late final _AppStringsSettingsLogoutFil logout = _AppStringsSettingsLogoutFil._(_root);
	@override late final _AppStringsSettingsSocialFil social = _AppStringsSettingsSocialFil._(_root);
	@override late final _AppStringsSettingsLanguageFil language = _AppStringsSettingsLanguageFil._(_root);
	@override late final _AppStringsSettingsCurrencyFil currency = _AppStringsSettingsCurrencyFil._(_root);
	@override late final _AppStringsSettingsMessagesFil messages = _AppStringsSettingsMessagesFil._(_root);
}

// Path: onboarding
class _AppStringsOnboardingFil extends AppStringsOnboardingEn {
	_AppStringsOnboardingFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override late final _AppStringsOnboardingWelcomeFil welcome = _AppStringsOnboardingWelcomeFil._(_root);
	@override late final _AppStringsOnboardingProblemStatementFil problemStatement = _AppStringsOnboardingProblemStatementFil._(_root);
	@override late final _AppStringsOnboardingSpecificProblemFil specificProblem = _AppStringsOnboardingSpecificProblemFil._(_root);
	@override late final _AppStringsOnboardingPersonalGoalFil personalGoal = _AppStringsOnboardingPersonalGoalFil._(_root);
	@override late final _AppStringsOnboardingSolutionPreviewFil solutionPreview = _AppStringsOnboardingSolutionPreviewFil._(_root);
	@override late final _AppStringsOnboardingCurrentMethodFil currentMethod = _AppStringsOnboardingCurrentMethodFil._(_root);
	@override late final _AppStringsOnboardingFeaturesShowcaseFil featuresShowcase = _AppStringsOnboardingFeaturesShowcaseFil._(_root);
	@override late final _AppStringsOnboardingCompleteFil complete = _AppStringsOnboardingCompleteFil._(_root);
	@override late final _AppStringsOnboardingButtonsFil buttons = _AppStringsOnboardingButtonsFil._(_root);
}

// Path: dashboard
class _AppStringsDashboardFil extends AppStringsDashboardEn {
	_AppStringsDashboardFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get greeting => 'Mabuhay!';
	@override late final _AppStringsDashboardBalanceFil balance = _AppStringsDashboardBalanceFil._(_root);
	@override late final _AppStringsDashboardActionsFil actions = _AppStringsDashboardActionsFil._(_root);
	@override late final _AppStringsDashboardWalletsFil wallets = _AppStringsDashboardWalletsFil._(_root);
	@override late final _AppStringsDashboardTransactionsFil transactions = _AppStringsDashboardTransactionsFil._(_root);
	@override String get customize => 'I-customize';
	@override late final _AppStringsDashboardWidgetsFil widgets = _AppStringsDashboardWidgetsFil._(_root);
}

// Path: wallets
class _AppStringsWalletsFil extends AppStringsWalletsEn {
	_AppStringsWalletsFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Mga Wallet';
	@override late final _AppStringsWalletsEmptyFil empty = _AppStringsWalletsEmptyFil._(_root);
	@override late final _AppStringsWalletsEmptyArchivedFil emptyArchived = _AppStringsWalletsEmptyArchivedFil._(_root);
	@override late final _AppStringsWalletsFilterFil filter = _AppStringsWalletsFilterFil._(_root);
	@override late final _AppStringsWalletsFormFil form = _AppStringsWalletsFormFil._(_root);
	@override late final _AppStringsWalletsDeleteFil delete = _AppStringsWalletsDeleteFil._(_root);
	@override late final _AppStringsWalletsErrorsFil errors = _AppStringsWalletsErrorsFil._(_root);
	@override late final _AppStringsWalletsSubtitleFil subtitle = _AppStringsWalletsSubtitleFil._(_root);
	@override late final _AppStringsWalletsOptionsFil options = _AppStringsWalletsOptionsFil._(_root);
}

// Path: loans
class _AppStringsLoansFil extends AppStringsLoansEn {
	_AppStringsLoansFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Mga Utang';
	@override late final _AppStringsLoansFilterFil filter = _AppStringsLoansFilterFil._(_root);
	@override late final _AppStringsLoansSummaryFil summary = _AppStringsLoansSummaryFil._(_root);
	@override late final _AppStringsLoansCardFil card = _AppStringsLoansCardFil._(_root);
	@override late final _AppStringsLoansFormFil form = _AppStringsLoansFormFil._(_root);
	@override late final _AppStringsLoansDetailFil detail = _AppStringsLoansDetailFil._(_root);
	@override late final _AppStringsLoansHistoryFil history = _AppStringsLoansHistoryFil._(_root);
	@override late final _AppStringsLoansContactDetailFil contactDetail = _AppStringsLoansContactDetailFil._(_root);
	@override late final _AppStringsLoansShareFil share = _AppStringsLoansShareFil._(_root);
	@override late final _AppStringsLoansPaymentFil payment = _AppStringsLoansPaymentFil._(_root);
	@override String get given => 'Pinahiram';
	@override String get received => 'Hiniram';
	@override late final _AppStringsLoansItemFil item = _AppStringsLoansItemFil._(_root);
	@override late final _AppStringsLoansSectionFil section = _AppStringsLoansSectionFil._(_root);
	@override late final _AppStringsLoansEmptyFil empty = _AppStringsLoansEmptyFil._(_root);
}

// Path: categories
class _AppStringsCategoriesFil extends AppStringsCategoriesEn {
	_AppStringsCategoriesFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Mga Kategorya';
	@override late final _AppStringsCategoriesFormFil form = _AppStringsCategoriesFormFil._(_root);
	@override late final _AppStringsCategoriesParentSelectionFil parentSelection = _AppStringsCategoriesParentSelectionFil._(_root);
	@override String get incomeCategory => 'Kategorya ng Kita';
	@override String get expenseCategory => 'Kategorya ng Gastos';
	@override late final _AppStringsCategoriesReportFil report = _AppStringsCategoriesReportFil._(_root);
}

// Path: backups
class _AppStringsBackupsFil extends AppStringsBackupsEn {
	_AppStringsBackupsFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Mga Backup';
	@override late final _AppStringsBackupsMenuFil menu = _AppStringsBackupsMenuFil._(_root);
	@override late final _AppStringsBackupsFiltersFil filters = _AppStringsBackupsFiltersFil._(_root);
	@override late final _AppStringsBackupsStatusFil status = _AppStringsBackupsStatusFil._(_root);
	@override late final _AppStringsBackupsActionsFil actions = _AppStringsBackupsActionsFil._(_root);
	@override late final _AppStringsBackupsDialogsFil dialogs = _AppStringsBackupsDialogsFil._(_root);
	@override late final _AppStringsBackupsStatsFil stats = _AppStringsBackupsStatsFil._(_root);
	@override late final _AppStringsBackupsOptionsFil options = _AppStringsBackupsOptionsFil._(_root);
	@override late final _AppStringsBackupsFormatFil format = _AppStringsBackupsFormatFil._(_root);
}

// Path: v2
class _AppStringsV2Fil extends AppStringsV2En {
	_AppStringsV2Fil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override late final _AppStringsV2VoiceFil voice = _AppStringsV2VoiceFil._(_root);
	@override late final _AppStringsV2TransactionsFil transactions = _AppStringsV2TransactionsFil._(_root);
	@override late final _AppStringsV2SettingsFil settings = _AppStringsV2SettingsFil._(_root);
	@override late final _AppStringsV2DashboardFil dashboard = _AppStringsV2DashboardFil._(_root);
	@override late final _AppStringsV2CategoriesFil categories = _AppStringsV2CategoriesFil._(_root);
	@override late final _AppStringsV2OnboardingFil onboarding = _AppStringsV2OnboardingFil._(_root);
}

// Path: intents
class _AppStringsIntentsFil extends AppStringsIntentsEn {
	_AppStringsIntentsFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get transactionSavedTitle => '✅ Nai-save ang Transaksyon';
	@override String get emptyText => 'Walang teksto';
	@override String get emptyData => 'Walang data';
	@override String get cannotUnderstand => 'Hindi maintindihan ang transaksyon';
	@override String get errorSaving => 'May error sa pag-save';
	@override String get noCategories => 'Walang kategoryang magagamit';
	@override String get loadingError => 'Error sa pag-load';
}

// Path: components.dateSelection
class _AppStringsComponentsDateSelectionFil extends AppStringsComponentsDateSelectionEn {
	_AppStringsComponentsDateSelectionFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Pumili ng petsa';
	@override String get subtitle => 'Piliin ang petsa ng transaksyon';
	@override String get selectedDate => 'Napiling petsa';
	@override String get confirm => 'Kumpirmahin';
}

// Path: components.selection
class _AppStringsComponentsSelectionFil extends AppStringsComponentsSelectionEn {
	_AppStringsComponentsSelectionFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Kanselahin';
	@override String get confirm => 'Kumpirmahin';
	@override String get select => 'Piliin';
}

// Path: components.contactSelection
class _AppStringsComponentsContactSelectionFil extends AppStringsComponentsContactSelectionEn {
	_AppStringsComponentsContactSelectionFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Pumili ng contact';
	@override String get subtitle => 'Kanino ang transaksyon';
	@override String get searchPlaceholder => 'Maghanap ng contact';
	@override String get noContact => 'Walang contact';
	@override String get noContactDetails => 'Transaksyon na walang contact';
	@override String get allContacts => 'Lahat ng contact';
	@override String get create => 'Lumikha ng bago';
}

// Path: components.categorySelection
class _AppStringsComponentsCategorySelectionFil extends AppStringsComponentsCategorySelectionEn {
	_AppStringsComponentsCategorySelectionFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Pumili ng kategorya';
	@override String get subtitle => 'Piliin ang kategorya para sa transaksyong ito';
	@override String get searchPlaceholder => 'Maghanap ng kategorya';
}

// Path: components.currencySelection
class _AppStringsComponentsCurrencySelectionFil extends AppStringsComponentsCurrencySelectionEn {
	_AppStringsComponentsCurrencySelectionFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Pumili ng pera';
	@override String get subtitle => 'Piliin ang pera (currency)';
	@override String get searchPlaceholder => 'Maghanap ng pera';
}

// Path: components.accountSelection
class _AppStringsComponentsAccountSelectionFil extends AppStringsComponentsAccountSelectionEn {
	_AppStringsComponentsAccountSelectionFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Pumili ng account';
	@override String get subtitle => 'Piliin ang account para dito';
	@override String get searchPlaceholder => 'Maghanap ng account';
	@override String get wallets => 'Mga Wallet';
	@override String get creditCards => 'Credit Cards';
	@override String get selectAccount => 'Pumili ng account';
	@override String get confirm => 'Kumpirmahin';
}

// Path: components.parentWalletSelection
class _AppStringsComponentsParentWalletSelectionFil extends AppStringsComponentsParentWalletSelectionEn {
	_AppStringsComponentsParentWalletSelectionFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Pangunahing wallet';
	@override String get subtitle => 'Piliin ang parent wallet';
	@override String get searchPlaceholder => 'Maghanap ng wallet';
	@override String get noParent => 'Walang parent wallet';
	@override String get createRoot => 'Gawing pangunahin';
	@override String get available => 'Available na Wallet';
}

// Path: components.walletTypes
class _AppStringsComponentsWalletTypesFil extends AppStringsComponentsWalletTypesEn {
	_AppStringsComponentsWalletTypesFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get checking => 'Checking Account';
	@override String get savings => 'Savings';
	@override String get cash => 'Cash';
	@override String get creditCard => 'Credit Card';
}

// Path: navigation.sections
class _AppStringsNavigationSectionsFil extends AppStringsNavigationSectionsEn {
	_AppStringsNavigationSectionsFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get operations => 'MGA OPERASYON';
	@override String get financialTools => 'MGA TOOLS';
	@override String get management => 'PAMAMAHALA';
	@override String get advanced => 'ADVANCED';
}

// Path: transactions.types
class _AppStringsTransactionsTypesFil extends AppStringsTransactionsTypesEn {
	_AppStringsTransactionsTypesFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get all => 'Lahat';
	@override String get income => 'Kita';
	@override String get expense => 'Gastos';
	@override String get transfer => 'Paglipat';
}

// Path: transactions.filter
class _AppStringsTransactionsFilterFil extends AppStringsTransactionsFilterEn {
	_AppStringsTransactionsFilterFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'I-filter ang Transaksyon';
	@override String get date => 'Petsa';
	@override String get categories => 'Kategorya';
	@override String get accounts => 'Mga Account';
	@override String get contacts => 'Mga Contact';
	@override String get amount => 'Halaga';
	@override String get apply => 'I-apply';
	@override String get clear => 'I-clear';
	@override String get add => 'Magdagdag ng filter';
	@override String get minAmount => 'Min Halaga';
	@override String get maxAmount => 'Max Halaga';
	@override String get selectDate => 'Piliin ang petsa';
	@override String get selectCategory => 'Piliin ang kategorya';
	@override String get selectAccount => 'Piliin ang account';
	@override String get selectContact => 'Piliin ang contact';
	@override String get quickFilters => 'Mabilisang Filter';
	@override late final _AppStringsTransactionsFilterRangesFil ranges = _AppStringsTransactionsFilterRangesFil._(_root);
	@override String get customRange => 'Pasadyang Petsa';
	@override String get startDate => 'Petsa ng Simula';
	@override String get endDate => 'Petsa ng Pagtatapos';
	@override String get active => 'Mga Aktibong Filter';
	@override late final _AppStringsTransactionsFilterSubtitlesFil subtitles = _AppStringsTransactionsFilterSubtitlesFil._(_root);
}

// Path: transactions.form
class _AppStringsTransactionsFormFil extends AppStringsTransactionsFormEn {
	_AppStringsTransactionsFormFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get newTitle => 'Bagong Transaksyon';
	@override String get editTitle => 'I-edit ang Transaksyon';
	@override String get amount => 'Halaga';
	@override String get type => 'Uri ng transaksyon';
	@override String get amountRequired => 'Kailangan ng halaga';
	@override String get date => 'Petsa';
	@override String get account => 'Account';
	@override String get toAccount => 'Papunta sa Account';
	@override String get category => 'Kategorya';
	@override String get contact => 'Contact';
	@override String get contactOptional => 'Contact (Opsyonal)';
	@override String get description => 'Paglalarawan';
	@override String get descriptionOptional => 'Paglalarawan (Opsyonal)';
	@override String get selectAccount => 'Pumili ng account';
	@override String get selectDestination => 'Pumili ng destinasyon';
	@override String get selectCategory => 'Pumili ng kategorya';
	@override String get selectContact => 'Pumili ng contact';
	@override String get saveSuccess => 'Nai-save ang transaksyon';
	@override String get updateSuccess => 'Na-update ang transaksyon';
	@override String get saveError => 'May error sa pag-save';
	@override String get share => 'I-share';
	@override String get created => 'Nagawa ang transaksyon';
	@override String get crossCurrencyConversion => 'Palitan ng Pera';
	@override String get receivedAmount => 'Halagang natanggap';
	@override String get exchangeRate => 'Exchange rate';
	@override String get receivedAmountRequired => 'Ilagay ang natanggap';
	@override String exchangeRateLabel({required Object from, required Object rate, required Object to}) => '1 ${from} = ${rate} ${to}';
}

// Path: transactions.errors
class _AppStringsTransactionsErrorsFil extends AppStringsTransactionsErrorsEn {
	_AppStringsTransactionsErrorsFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get load => 'May error sa pag-load';
}

// Path: transactions.empty
class _AppStringsTransactionsEmptyFil extends AppStringsTransactionsEmptyEn {
	_AppStringsTransactionsEmptyFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Walang transaksyon';
	@override String get message => 'Walang nakitang transaksyon';
	@override String get clearFilters => 'I-clear ang filter';
}

// Path: transactions.list
class _AppStringsTransactionsListFil extends AppStringsTransactionsListEn {
	_AppStringsTransactionsListFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String count({required Object n}) => '${n} transaksyon';
}

// Path: transactions.detail
class _AppStringsTransactionsDetailFil extends AppStringsTransactionsDetailEn {
	_AppStringsTransactionsDetailFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Detalye ng Transaksyon';
	@override String get delete => 'Burahin';
	@override String get deleteConfirmation => 'Sigurado ka ba? Hindi na ito mababawi.';
	@override String get deleted => 'Nabura na';
	@override String get duplicate => 'Doblehin';
	@override String get duplicateNotImplemented => 'Hindi pa available ang duplicate';
	@override String get edit => 'I-edit';
	@override String get errorLoad => 'Error sa pag-load';
	@override String errorPrepareEdit({required Object error}) => 'Error: ${error}';
	@override String errorDelete({required Object error}) => 'Error: ${error}';
	@override String get category => 'Kategorya';
	@override String get account => 'Account';
	@override String get contact => 'Contact';
	@override String get description => 'Paglalarawan';
	@override String get transferDetails => 'Detalye ng Paglipat';
	@override String get from => 'Mula';
	@override String get to => 'Papunta';
	@override String get unknownAccount => 'Hindi kilalang Account';
	@override String errorUrl({required Object url}) => 'Hindi mabuksan ang ${url}';
	@override String get date => 'Petsa';
	@override String get time => 'Oras';
	@override String get loanLinkedWarning => 'Ang transaksyong ito ay nakaugnay sa isang utang.';
}

// Path: transactions.share
class _AppStringsTransactionsShareFil extends AppStringsTransactionsShareEn {
	_AppStringsTransactionsShareFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'I-share';
	@override String get copyText => 'Kopyahin';
	@override String get shareButton => 'I-share';
	@override String get shareMessage => 'Ito ang aking resibo:';
	@override String get copied => 'Nakopya na sa clipboard!';
	@override String get paymentMethod => 'Paraan ng pagbabayad';
	@override String get receiptTitle => 'Resibo';
	@override String get poweredBy => 'Pinapagana ng MoneyT • moneyt.io';
	@override String errorImage({required Object error}) => 'Error sa larawan: ${error}';
	@override late final _AppStringsTransactionsShareReceiptFil receipt = _AppStringsTransactionsShareReceiptFil._(_root);
	@override String generatedOn({required Object date}) => 'Nagawa noong ${date}';
}

// Path: contacts.fields
class _AppStringsContactsFieldsFil extends AppStringsContactsFieldsEn {
	_AppStringsContactsFieldsFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get name => 'Pangalan';
	@override String get fullName => 'Buong pangalan';
	@override String get email => 'Email';
	@override String get phone => 'Telepono';
	@override String get address => 'Address';
	@override String get notes => 'Mga Tala';
}

// Path: contacts.placeholders
class _AppStringsContactsPlaceholdersFil extends AppStringsContactsPlaceholdersEn {
	_AppStringsContactsPlaceholdersFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get enterFullName => 'Ilagay ang buong pangalan';
	@override String get enterPhone => 'Ilagay ang numero';
	@override String get enterEmail => 'Ilagay ang email';
}

// Path: contacts.validation
class _AppStringsContactsValidationFil extends AppStringsContactsValidationEn {
	_AppStringsContactsValidationFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get nameRequired => 'Kailangan ang pangalan';
	@override String get invalidEmail => 'Maling email';
	@override String get invalidPhone => 'Maling numero';
}

// Path: settings.account
class _AppStringsSettingsAccountFil extends AppStringsSettingsAccountEn {
	_AppStringsSettingsAccountFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Account';
	@override String get profile => 'Profile';
	@override String get profileSubtitle => 'Pamahalaan ang impormasyon';
}

// Path: settings.appearance
class _AppStringsSettingsAppearanceFil extends AppStringsSettingsAppearanceEn {
	_AppStringsSettingsAppearanceFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Itsura';
	@override String get darkMode => 'Dark Mode';
	@override String get darkModeSubtitle => 'Gamitin ang dark theme';
	@override String get language => 'Wika';
	@override String get currency => 'Pangunahing Pera';
	@override String get currencySubtitle => 'Default na pera para sa bagong accounts';
	@override String get darkTheme => 'Dark Theme';
	@override String get lightTheme => 'Light Theme';
	@override String get systemTheme => 'Tema ng system';
}

// Path: settings.data
class _AppStringsSettingsDataFil extends AppStringsSettingsDataEn {
	_AppStringsSettingsDataFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Data at Storage';
	@override String get backup => 'Mga Backup';
	@override String get backupSubtitle => 'Pamahalaan ang backups';
}

// Path: settings.info
class _AppStringsSettingsInfoFil extends AppStringsSettingsInfoEn {
	_AppStringsSettingsInfoFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Impormasyon';
	@override String get contact => 'Contact & Social Media';
	@override String get contactSubtitle => 'Para sa suporta';
	@override String get privacy => 'Privacy Policy';
	@override String get privacySubtitle => 'Basahin ang aming polisiya';
	@override String get share => 'I-share ang MoneyT';
	@override String get shareSubtitle => 'Irekumenda sa kaibigan';
}

// Path: settings.logout
class _AppStringsSettingsLogoutFil extends AppStringsSettingsLogoutEn {
	_AppStringsSettingsLogoutFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get button => 'Mag-logout';
	@override String get dialogTitle => 'Mag-logout';
	@override String get dialogMessage => 'Sigurado ka bang gusto mong mag-logout?';
	@override String get cancel => 'Kanselahin';
	@override String get confirm => 'Mag-logout';
}

// Path: settings.social
class _AppStringsSettingsSocialFil extends AppStringsSettingsSocialEn {
	_AppStringsSettingsSocialFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Contact at Social';
	@override String get follow => 'I-follow ang MoneyT';
	@override String get description => 'Manatiling konektado sa komunidad.';
	@override String get networks => 'Social Media';
	@override String get github => 'GitHub';
	@override String get githubSubtitle => 'Tingnan ang code';
	@override String get linkedin => 'LinkedIn';
	@override String get linkedinSubtitle => 'Balitang propesyonal';
	@override String get twitter => 'X (Twitter)';
	@override String get twitterSubtitle => 'Balita at updates';
	@override String get reddit => 'Reddit';
	@override String get redditSubtitle => 'Komunidad';
	@override String get discord => 'Discord';
	@override String get discordSubtitle => 'Live chat';
	@override String get contact => 'Support';
	@override String get email => 'Email Support';
	@override String get website => 'Opisyal na Website';
}

// Path: settings.language
class _AppStringsSettingsLanguageFil extends AppStringsSettingsLanguageEn {
	_AppStringsSettingsLanguageFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Wika';
	@override String get available => 'MGA WIKA';
	@override String get apply => 'I-apply ang Wika';
}

// Path: settings.currency
class _AppStringsSettingsCurrencyFil extends AppStringsSettingsCurrencyEn {
	_AppStringsSettingsCurrencyFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Pangunahing Pera';
	@override String get available => 'MGA PERA';
	@override String get apply => 'I-apply ang Pera';
}

// Path: settings.messages
class _AppStringsSettingsMessagesFil extends AppStringsSettingsMessagesEn {
	_AppStringsSettingsMessagesFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get profileComingSoon => 'Malapit na ang profile';
	@override String get privacyError => 'Hindi mabuksan ang privacy policy';
	@override String get logoutComingSoon => 'Malapit na ang logout';
}

// Path: onboarding.welcome
class _AppStringsOnboardingWelcomeFil extends AppStringsOnboardingWelcomeEn {
	_AppStringsOnboardingWelcomeFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Welcome sa MoneyT 👋';
	@override String get subtitle => 'Hawak mo na ang pera mo ✨';
}

// Path: onboarding.problemStatement
class _AppStringsOnboardingProblemStatementFil extends AppStringsOnboardingProblemStatementEn {
	_AppStringsOnboardingProblemStatementFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Parang naglalaho lang ang pera mo?';
	@override String get subtitle => 'Hindi ka nag-iisa. 70% ng mga tao hindi alam kung saan napupunta ang pera nila.';
}

// Path: onboarding.specificProblem
class _AppStringsOnboardingSpecificProblemFil extends AppStringsOnboardingSpecificProblemEn {
	_AppStringsOnboardingSpecificProblemFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ano ang pinakamalaking problema mo?';
	@override late final _AppStringsOnboardingSpecificProblemOptionsFil options = _AppStringsOnboardingSpecificProblemOptionsFil._(_root);
}

// Path: onboarding.personalGoal
class _AppStringsOnboardingPersonalGoalFil extends AppStringsOnboardingPersonalGoalEn {
	_AppStringsOnboardingPersonalGoalFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ano ang focus mo ngayon?';
	@override late final _AppStringsOnboardingPersonalGoalOptionsFil options = _AppStringsOnboardingPersonalGoalOptionsFil._(_root);
}

// Path: onboarding.solutionPreview
class _AppStringsOnboardingSolutionPreviewFil extends AppStringsOnboardingSolutionPreviewEn {
	_AppStringsOnboardingSolutionPreviewFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Bibigyan ka ng linaw ng MoneyT';
	@override String get subtitle => 'Tingnan lahat ng accounts at utang sa isang lugar. Wala nang nakakahilong excel.';
	@override late final _AppStringsOnboardingSolutionPreviewBenefitsFil benefits = _AppStringsOnboardingSolutionPreviewBenefitsFil._(_root);
}

// Path: onboarding.currentMethod
class _AppStringsOnboardingCurrentMethodFil extends AppStringsOnboardingCurrentMethodEn {
	_AppStringsOnboardingCurrentMethodFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Paano mo tina-track ang pera mo ngayon?';
	@override String get subtitle => 'Piliin ang pinakakatulad mo.';
	@override late final _AppStringsOnboardingCurrentMethodOptionsFil options = _AppStringsOnboardingCurrentMethodOptionsFil._(_root);
}

// Path: onboarding.featuresShowcase
class _AppStringsOnboardingFeaturesShowcaseFil extends AppStringsOnboardingFeaturesShowcaseEn {
	_AppStringsOnboardingFeaturesShowcaseFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Mga features at mga susunod pa ✨';
	@override String get subtitle => 'Ready to use na, pero marami pang paparating.';
	@override String get available => 'AVAILABLE NA';
	@override String get comingSoon => 'MALAPIT NA';
	@override late final _AppStringsOnboardingFeaturesShowcaseFeaturesFil features = _AppStringsOnboardingFeaturesShowcaseFeaturesFil._(_root);
}

// Path: onboarding.complete
class _AppStringsOnboardingCompleteFil extends AppStringsOnboardingCompleteEn {
	_AppStringsOnboardingCompleteFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ready to go! 🚀';
	@override String get subtitle => 'Ilagay ang unang gastos mo at tingnan ang magic 📈';
	@override late final _AppStringsOnboardingCompleteStatsFil stats = _AppStringsOnboardingCompleteStatsFil._(_root);
}

// Path: onboarding.buttons
class _AppStringsOnboardingButtonsFil extends AppStringsOnboardingButtonsEn {
	_AppStringsOnboardingButtonsFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get start => 'Tara, simulan na 🚀';
	@override String get fixIt => 'Ayusin natin \'to ⚡';
	@override String get actionContinue => 'Tuloy';
	@override String get setGoal => 'I-set ang Goal 🎯';
	@override String get wantControl => 'Gusto ko \'yan!';
	@override String get great => 'Ayos, patingin!';
	@override String get firstTransaction => 'I-record ang una ➕';
	@override String get skip => 'Skip muna';
}

// Path: dashboard.balance
class _AppStringsDashboardBalanceFil extends AppStringsDashboardBalanceEn {
	_AppStringsDashboardBalanceFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get total => 'KABUUANG BALANSE';
	@override String get income => 'KITA';
	@override String get expenses => 'GASTOS';
	@override String get thisMonth => 'ngayong buwan';
}

// Path: dashboard.actions
class _AppStringsDashboardActionsFil extends AppStringsDashboardActionsEn {
	_AppStringsDashboardActionsFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get income => 'Kita';
	@override String get expense => 'Gastos';
	@override String get transfer => 'Lipat';
	@override String get all => 'Lahat';
}

// Path: dashboard.wallets
class _AppStringsDashboardWalletsFil extends AppStringsDashboardWalletsEn {
	_AppStringsDashboardWalletsFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Mga Wallet';
	@override String count({required Object n}) => '${n} account';
	@override String more({required Object n}) => '+${n} pa';
	@override String viewDetails({required Object name}) => 'Tingnan ang detalye ni ${name}';
}

// Path: dashboard.transactions
class _AppStringsDashboardTransactionsFil extends AppStringsDashboardTransactionsEn {
	_AppStringsDashboardTransactionsFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Kamakailang Transaksyon';
	@override String get subtitle => '5 pinakabago';
	@override String get empty => 'Walang bago';
	@override String get emptySubtitle => 'Lalabas dito ang transaksyon mo';
	@override String more({required Object n}) => '+${n} pa';
}

// Path: dashboard.widgets
class _AppStringsDashboardWidgetsFil extends AppStringsDashboardWidgetsEn {
	_AppStringsDashboardWidgetsFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override late final _AppStringsDashboardWidgetsBalanceFil balance = _AppStringsDashboardWidgetsBalanceFil._(_root);
	@override late final _AppStringsDashboardWidgetsQuickActionsFil quickActions = _AppStringsDashboardWidgetsQuickActionsFil._(_root);
	@override late final _AppStringsDashboardWidgetsWalletsFil wallets = _AppStringsDashboardWidgetsWalletsFil._(_root);
	@override late final _AppStringsDashboardWidgetsLoansFil loans = _AppStringsDashboardWidgetsLoansFil._(_root);
	@override late final _AppStringsDashboardWidgetsTransactionsFil transactions = _AppStringsDashboardWidgetsTransactionsFil._(_root);
	@override late final _AppStringsDashboardWidgetsCategoryBreakdownFil categoryBreakdown = _AppStringsDashboardWidgetsCategoryBreakdownFil._(_root);
	@override late final _AppStringsDashboardWidgetsChartAccountsFil chartAccounts = _AppStringsDashboardWidgetsChartAccountsFil._(_root);
	@override late final _AppStringsDashboardWidgetsCreditCardsFil creditCards = _AppStringsDashboardWidgetsCreditCardsFil._(_root);
	@override late final _AppStringsDashboardWidgetsSettingsFil settings = _AppStringsDashboardWidgetsSettingsFil._(_root);
}

// Path: wallets.empty
class _AppStringsWalletsEmptyFil extends AppStringsWalletsEmptyEn {
	_AppStringsWalletsEmptyFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Walang wallet na nakita';
	@override String get message => 'Gumawa ng wallet para makapagsimula.';
	@override String get action => 'Gumawa ng Wallet';
}

// Path: wallets.emptyArchived
class _AppStringsWalletsEmptyArchivedFil extends AppStringsWalletsEmptyArchivedEn {
	_AppStringsWalletsEmptyArchivedFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Walang naka-archive';
	@override String get message => 'Dito mapupunta ang archived wallets.';
}

// Path: wallets.filter
class _AppStringsWalletsFilterFil extends AppStringsWalletsFilterEn {
	_AppStringsWalletsFilterFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get active => 'Aktibo';
	@override String get archived => 'Naka-archive';
	@override String get all => 'Lahat';
}

// Path: wallets.form
class _AppStringsWalletsFormFil extends AppStringsWalletsFormEn {
	_AppStringsWalletsFormFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get newTitle => 'Bagong Wallet';
	@override String get editTitle => 'I-edit ang Wallet';
	@override String get name => 'Pangalan ng Wallet';
	@override String get namePlaceholder => 'Hal: BDO, GCash, Cash sa wallet';
	@override String get nameRequired => 'Kailangan ng pangalan';
	@override String get description => 'Paglalarawan';
	@override String get descriptionPlaceholder => 'Para saan ito? (Opsyonal)';
	@override String get currency => 'Pera (Currency)';
	@override String get currencyLockedByParent => 'Naka-lock sa parent wallet';
	@override String get parent => 'Parent Wallet (Opsyonal)';
	@override String get parentEmpty => 'Walang parent wallet';
	@override String get chartAccount => 'Chart of Account';
	@override String get chartAccountLocked => 'Hindi mapalitan ang account';
	@override String get createSuccess => 'Nagawa ang wallet';
	@override String get updateSuccess => 'Na-update ang wallet';
	@override String loadParentError({required Object error}) => 'Error: ${error}';
	@override String loadChartAccountError({required Object error}) => 'Error: ${error}';
}

// Path: wallets.delete
class _AppStringsWalletsDeleteFil extends AppStringsWalletsDeleteEn {
	_AppStringsWalletsDeleteFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get dialogTitle => 'Burahin ang Wallet';
	@override String dialogMessage({required Object name}) => 'Sigurado ka ba? Mabubura ang ${name} at lahat ng nasa loob nito.';
	@override String get cancel => 'Kanselahin';
	@override String get confirm => 'Burahin';
	@override String get success => 'Nabura na';
	@override String error({required Object error}) => 'May error: ${error}';
}

// Path: wallets.errors
class _AppStringsWalletsErrorsFil extends AppStringsWalletsErrorsEn {
	_AppStringsWalletsErrorsFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get load => 'Error sa pag-load';
	@override String get retry => 'Subukang muli';
	@override String comingSoon({required Object name}) => '${name} ay malapit na';
}

// Path: wallets.subtitle
class _AppStringsWalletsSubtitleFil extends AppStringsWalletsSubtitleEn {
	_AppStringsWalletsSubtitleFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get mainAccount => 'Main Account';
	@override String get cashDigital => 'Cash at Digital';
	@override String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fil'))(n,
		one: '${n} wallet',
		other: '${n} wallets',
	);
	@override String get account => 'Account';
	@override String get physicalCash => 'Pisikal na Pera';
	@override String get digitalWallet => 'Digital Wallet';
}

// Path: wallets.options
class _AppStringsWalletsOptionsFil extends AppStringsWalletsOptionsEn {
	_AppStringsWalletsOptionsFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get viewTransactions => 'Tingnan ang transaksyon';
	@override String get viewTransactionsSubtitle => 'Tingnan ang history';
	@override String get transferFunds => 'Maglipat ng pondo';
	@override String get transferFundsSubtitle => 'Ilipat sa ibang wallet';
	@override String get editWallet => 'I-edit';
	@override String get editWalletSubtitle => 'Palitan ang pangalan at kulay';
	@override String get duplicateWallet => 'Doblehin';
	@override String get duplicateWalletSubtitle => 'Kopyahin ito';
	@override String get archiveWallet => 'I-archive';
	@override String get archiveWalletSubtitle => 'Itago muna ang wallet';
	@override String get unarchiveWallet => 'I-unarchive';
	@override String get unarchiveWalletSubtitle => 'Ibalik sa listahan';
	@override String get deleteWallet => 'Burahin';
	@override String get deleteWalletSubtitle => 'Permanente itong burahin';
	@override String get defaultTitle => 'Wallet';
}

// Path: loans.filter
class _AppStringsLoansFilterFil extends AppStringsLoansFilterEn {
	_AppStringsLoansFilterFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get active => 'Aktibo';
	@override String get history => 'History';
	@override String get all => 'Lahat';
	@override String get pending => 'Pending';
	@override String get lent => 'Pinahiram';
	@override String get borrowed => 'Hiniram';
}

// Path: loans.summary
class _AppStringsLoansSummaryFil extends AppStringsLoansSummaryEn {
	_AppStringsLoansSummaryFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get netBalance => 'NET BALANCE';
	@override String get activeLoans => 'AKTIBONG UTANG';
	@override String get noActive => 'Walang utang, yay!';
	@override String lent({required Object n}) => '${n} pinahiram';
	@override String borrowed({required Object n}) => '${n} hiniram';
	@override String pending({required Object n}) => '${n} pending';
}

// Path: loans.card
class _AppStringsLoansCardFil extends AppStringsLoansCardEn {
	_AppStringsLoansCardFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get lent => 'May Utang Sayo';
	@override String get borrowed => 'Utang Mo';
	@override String active({required Object n}) => '${n} aktibo';
	@override String multiple({required Object n}) => '${n} utang';
	@override String transactions({required Object n}) => '${n} transaksyon';
	@override String overdue({required Object n}) => 'Late ng ${n} araw';
	@override String due({required Object date}) => 'Due sa ${date}';
}

// Path: loans.form
class _AppStringsLoansFormFil extends AppStringsLoansFormEn {
	_AppStringsLoansFormFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get newTitle => 'Bagong Utang';
	@override String get editTitle => 'I-edit ang Utang';
	@override String get type => 'Uri ng utang';
	@override String get lend => 'Nagpautang Ako';
	@override String get borrow => 'Nangutang Ako';
	@override String get contact => 'Contact';
	@override String get contactPlaceholder => 'Kanino?';
	@override String get account => 'Mula sa Account';
	@override String get accountPlaceholder => 'Piliin ang account';
	@override String get amount => 'Halaga';
	@override String get description => 'Paglalarawan';
	@override String get date => 'Petsa';
	@override String get dueDate => 'Kelan babayaran';
	@override String get selectDate => 'Pumili ng petsa';
	@override String get optional => '(Opsyonal)';
	@override String get createTransaction => 'Gawan ng record sa wallet';
	@override String get recordAutomatically => 'Awtomatikong i-record';
	@override String get transactionCategory => 'Kategorya ng transaksyon';
	@override String get category => 'Kategorya';
	@override String get categoryPlaceholder => 'Pumili ng kategorya';
	@override String get save => 'I-save';
	@override String get successCreate => 'Na-record na ang utang!';
	@override String get successUpdate => 'Na-update ang utang';
	@override String get contactRequired => 'Kailangan ng contact';
	@override String get accountRequired => 'Kailangan ng account';
	@override String get amountRequired => 'Magkano?';
}

// Path: loans.detail
class _AppStringsLoansDetailFil extends AppStringsLoansDetailEn {
	_AppStringsLoansDetailFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Detalye';
	@override String get deleteTitle => 'Burahin ang Utang';
	@override String get deleteMessage => 'Sigurado ka? Gusto mong burahin \'to?';
	@override String get deleteSuccess => 'Nabura na.';
	@override String deleteError({required Object error}) => 'May error: ${error}';
	@override String get notFound => 'Hindi nahanap';
	@override String get progress => 'Progress ng Pagbabayad';
	@override String get info => 'Impormasyon';
	@override String get pay => 'Magbayad / Tumanggap';
	@override String get viewHistory => 'Buong History';
	@override String original({required Object amount}) => 'Orihinal na halaga: ${amount}';
	@override String get section => 'Detalye';
	@override String get activeSummary => 'Buod';
	@override String get activeLent => 'Pinahiram';
	@override String get activeBorrowed => 'Inutang';
	@override String get activeNet => 'Net Balance';
	@override String get activeTotal => 'Kabuuan';
	@override String get startDate => 'Nagsimula';
	@override String get dueDate => 'Due Date';
	@override late final _AppStringsLoansDetailTypeFil type = _AppStringsLoansDetailTypeFil._(_root);
	@override late final _AppStringsLoansDetailPaymentFil payment = _AppStringsLoansDetailPaymentFil._(_root);
}

// Path: loans.history
class _AppStringsLoansHistoryFil extends AppStringsLoansHistoryEn {
	_AppStringsLoansHistoryFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'History ng Utang';
	@override String get section => 'Lahat ng Utang';
	@override String get totalLoaned => 'Kabuuang halaga';
	@override String get noLoans => 'Walang utang na nakita.';
	@override late final _AppStringsLoansHistoryFilterFil filter = _AppStringsLoansHistoryFilterFil._(_root);
	@override late final _AppStringsLoansHistoryHeadersFil headers = _AppStringsLoansHistoryHeadersFil._(_root);
	@override late final _AppStringsLoansHistoryItemFil item = _AppStringsLoansHistoryItemFil._(_root);
	@override late final _AppStringsLoansHistorySummaryFil summary = _AppStringsLoansHistorySummaryFil._(_root);
}

// Path: loans.contactDetail
class _AppStringsLoansContactDetailFil extends AppStringsLoansContactDetailEn {
	_AppStringsLoansContactDetailFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String titleWith({required Object name}) => 'Mga utang kay ${name}';
}

// Path: loans.share
class _AppStringsLoansShareFil extends AppStringsLoansShareEn {
	_AppStringsLoansShareFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'I-share';
	@override String get contactTitle => 'I-share ang buod';
	@override String get button => 'Ipadala';
	@override String get copy => 'Kopyahin';
	@override String get message => 'Pre/Sis, ito ang buod ng utang:';
	@override String contactMessage({required Object name}) => 'Buod ng utang kay ${name}:';
	@override String error({required Object error}) => 'Error: ${error}';
	@override String get contactCopied => 'Nakopya na!';
	@override String activeLoans({required Object n}) => 'Mga Aktibo (${n}):';
	@override String loanItem({required Object description, required Object amount, required Object date, required Object percent}) => '• ${description}: ${amount} (${date}) - ${percent}% bayad';
	@override String get loanStatement => 'MoneyT - Statement ng Utang';
	@override String get loanSummary => 'MoneyT - Buod';
	@override String get personalLoan => 'Personal Loan';
	@override String remaining({required Object amount}) => 'Balanse: ${amount}';
	@override String get remainingLabel => 'Natitirang balanse';
	@override String original({required Object amount}) => 'mula sa ${amount}';
	@override String progress({required Object percent}) => '${percent}% na ang bayad';
	@override String get progressLabel => 'Progress';
	@override String get paidSuffix => 'Bayad Na';
	@override String date({required Object date}) => 'Petsa: ${date}';
	@override String get dateLabel => 'Petsa';
	@override String contact({required Object name}) => 'Contact: ${name}';
	@override String get contactLabel => 'Pangalan';
	@override String generated({required Object date}) => 'Ginawa noong ${date}';
	@override String generatedLabel({required Object date}) => 'Ginawa noong ${date}';
	@override String totalActive({required Object n}) => 'Kabuuan: ${n}';
	@override String get active => 'aktibo';
	@override String get poweredBy => 'Powered by MoneyT • moneyt.io';
	@override String get copied => 'Nakopya na!';
	@override String netBalance({required Object amount, required Object status}) => 'Net Balance: ${amount} (${status})';
	@override String get netBalanceLabel => 'Net Balance';
	@override String get owed => 'Babayaran ka';
	@override String get owe => 'Magbabayad ka';
	@override String lent({required Object amount}) => 'Pinahiram mo: ${amount}';
	@override String get lentLabel => 'Pinahiram mo';
	@override String borrowed({required Object amount}) => 'Hiniram mo: ${amount}';
	@override String get borrowedLabel => 'Hiniram mo';
	@override String contactSummary({required Object name}) => 'Buod ni ${name}';
}

// Path: loans.payment
class _AppStringsLoansPaymentFil extends AppStringsLoansPaymentEn {
	_AppStringsLoansPaymentFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'I-record ang Bayad';
	@override String get amount => 'Magkano?';
	@override String get amountPlaceholder => '0.00';
	@override String get amountRequired => 'Ilagay ang halaga';
	@override String get invalidAmount => 'Maling halaga';
	@override String get exceedsBalance => 'Sobra sa balanse yung binayad mo boss';
	@override String get date => 'Petsa ng bayad';
	@override String get account => 'Saang account papasok/lalabas?';
	@override String get selectAccount => 'Piliin ang account';
	@override String get details => 'Karagdagang detalye';
	@override String get detailsPlaceholder => 'Mga tala... (Opsyonal)';
	@override String get success => 'Nice, na-record ang bayad!';
	@override String error({required Object error}) => 'Error: ${error}';
	@override String get errorAmount => 'Maling halaga';
	@override String get errorAccount => 'Pumili ng account';
	@override String errorLoading({required Object error}) => 'Error: ${error}';
	@override late final _AppStringsLoansPaymentSummaryFil summary = _AppStringsLoansPaymentSummaryFil._(_root);
	@override late final _AppStringsLoansPaymentQuickFil quick = _AppStringsLoansPaymentQuickFil._(_root);
}

// Path: loans.item
class _AppStringsLoansItemFil extends AppStringsLoansItemEn {
	_AppStringsLoansItemFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String due({required Object date}) => 'Due: ${date}';
	@override String paidAmount({required Object amount}) => 'Bayad: ${amount}';
	@override String remaining({required Object amount}) => 'Balanse: ${amount}';
	@override String percentPaid({required Object percent}) => '${percent}%';
}

// Path: loans.section
class _AppStringsLoansSectionFil extends AppStringsLoansSectionEn {
	_AppStringsLoansSectionFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get activeLoans => 'Mga Aktibong Utang';
	@override String loansCount({required Object n}) => '${n} loans';
}

// Path: loans.empty
class _AppStringsLoansEmptyFil extends AppStringsLoansEmptyEn {
	_AppStringsLoansEmptyFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Walang mga utang';
	@override String get message => 'Masarap ang tulog kapag walang utang.';
	@override String get action => 'Gumawa ng Utang';
}

// Path: categories.form
class _AppStringsCategoriesFormFil extends AppStringsCategoriesFormEn {
	_AppStringsCategoriesFormFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get newTitle => 'Bagong Kategorya';
	@override String get editTitle => 'I-edit ang Kategorya';
	@override String get name => 'Pangalan';
	@override String get namePlaceholder => 'Hal: Pagkain, Pamasahe, Shopee';
	@override String get nameRequired => 'Kailangan ang pangalan';
	@override String get parent => 'Parent Category (Opsyonal)';
	@override String get noParent => 'Gawing pangunahin';
	@override String get asSubcategory => 'Ito ay magiging subcategory';
	@override String get asRoot => 'Ito ay magiging main category';
	@override String get active => 'Aktibo';
	@override String get activeDescription => 'Ipapakita sa paggawa ng transaksyon';
	@override String get selectIcon => 'Pumili ng Icon';
	@override String get selectColor => 'Pumili ng Kulay';
	@override String get saveSuccess => 'Nai-save na!';
	@override String saveError({required Object error}) => 'May error sa pag-save: ${error}';
}

// Path: categories.parentSelection
class _AppStringsCategoriesParentSelectionFil extends AppStringsCategoriesParentSelectionEn {
	_AppStringsCategoriesParentSelectionFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Pumili ng parent category';
	@override String get subtitle => 'Saan ito kabilang?';
	@override String get noParent => 'Walang parent (Main)';
}

// Path: categories.report
class _AppStringsCategoriesReportFil extends AppStringsCategoriesReportEn {
	_AppStringsCategoriesReportFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Advanced Report';
	@override String get timeFilter => 'Panahon';
	@override String get thisMonth => 'Ngayong Buwan';
	@override String get lastMonth => 'Nakaraang Buwan';
	@override String get thisYear => 'Ngayong Taon';
	@override String get allTime => 'Lahat ng Panahon';
	@override String get details => 'Mga Detalye';
	@override String get noTransactions => 'Walang transaksyon';
	@override String get income => 'Kita';
	@override String get expense => 'Gastos';
}

// Path: backups.menu
class _AppStringsBackupsMenuFil extends AppStringsBackupsMenuEn {
	_AppStringsBackupsMenuFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get settings => 'Backup Settings';
	@override String get comingSoon => 'Malapit na';
}

// Path: backups.filters
class _AppStringsBackupsFiltersFil extends AppStringsBackupsFiltersEn {
	_AppStringsBackupsFiltersFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get all => 'Lahat';
	@override String get auto => 'Automatic';
	@override String get manual => 'Manual';
	@override String get thisMonth => 'Ngayong Buwan';
	@override String get lastMonth => 'Nakaraang Buwan';
	@override String get thisYear => 'Ngayong Taon';
	@override String get lastYear => 'Nakaraang Taon';
}

// Path: backups.status
class _AppStringsBackupsStatusFil extends AppStringsBackupsStatusEn {
	_AppStringsBackupsStatusFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get loading => 'Naglo-load...';
	@override String get error => 'May error';
	@override String get empty => 'Walang backup';
	@override String get emptyAction => 'Pindutin ang + para gumawa';
	@override String get success => 'Tagumpay!';
	@override String get created => 'Gawa na ang backup.';
	@override String createError({required Object error}) => 'Error sa paggawa: ${error}';
	@override String restoreError({required Object error}) => 'Error sa pag-restore: ${error}';
	@override String deleteError({required Object error}) => 'Error sa pagbura: ${error}';
}

// Path: backups.actions
class _AppStringsBackupsActionsFil extends AppStringsBackupsActionsEn {
	_AppStringsBackupsActionsFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get create => 'Gumawa ng Backup';
	@override String get import => 'Mag-import';
	@override String get restore => 'I-restore';
	@override String get delete => 'Burahin';
	@override String get share => 'I-share';
	@override String get cancel => 'Kanselahin';
	@override String get retry => 'Subukan Ulit';
	@override String get ok => 'OK';
}

// Path: backups.dialogs
class _AppStringsBackupsDialogsFil extends AppStringsBackupsDialogsEn {
	_AppStringsBackupsDialogsFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override late final _AppStringsBackupsDialogsInfoFil info = _AppStringsBackupsDialogsInfoFil._(_root);
	@override late final _AppStringsBackupsDialogsRestoreFil restore = _AppStringsBackupsDialogsRestoreFil._(_root);
	@override late final _AppStringsBackupsDialogsDeleteFil delete = _AppStringsBackupsDialogsDeleteFil._(_root);
}

// Path: backups.stats
class _AppStringsBackupsStatsFil extends AppStringsBackupsStatsEn {
	_AppStringsBackupsStatsFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Backup Stats';
	@override String get totalBackups => 'Kabuuan';
	@override String get totalSize => 'Kabuuang Laki';
	@override String get oldest => 'Pinakaluma';
	@override String get latest => 'Pinakabago';
	@override String get autoBackupStatus => 'Auto Backup';
	@override String get active => 'Bukas';
	@override String get inactive => 'Patay';
}

// Path: backups.options
class _AppStringsBackupsOptionsFil extends AppStringsBackupsOptionsEn {
	_AppStringsBackupsOptionsFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override late final _AppStringsBackupsOptionsRestoreFil restore = _AppStringsBackupsOptionsRestoreFil._(_root);
	@override late final _AppStringsBackupsOptionsShareFil share = _AppStringsBackupsOptionsShareFil._(_root);
	@override late final _AppStringsBackupsOptionsDeleteFil delete = _AppStringsBackupsOptionsDeleteFil._(_root);
	@override String get latestBadge => 'Latest';
	@override String get latestFile => 'Pinakabago';
	@override String get backupFile => 'Backup na file';
}

// Path: backups.format
class _AppStringsBackupsFormatFil extends AppStringsBackupsFormatEn {
	_AppStringsBackupsFormatFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String auto({required Object date}) => 'Auto - ${date}';
	@override String manual({required Object date}) => 'Manual - ${date}';
	@override String get initial => 'Initial Backup';
	@override String generic({required Object date}) => 'Backup - ${date}';
}

// Path: v2.voice
class _AppStringsV2VoiceFil extends AppStringsV2VoiceEn {
	_AppStringsV2VoiceFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get errorProcessing => 'Hindi ko na-gets. Paki-ulit nga?';
	@override String get tapMicrophone => 'Pindutin ang mic para magsalita';
	@override String get listening => 'Nakikinig...';
	@override String get missingApiKey => 'Wala kasing GEMINI_API_KEY sa .env file mo.';
	@override String aiError({required Object error}) => 'AI Error: ${error}';
	@override String get cancel => 'Kanselahin';
	@override String get scan => 'I-scan';
}

// Path: v2.transactions
class _AppStringsV2TransactionsFil extends AppStringsV2TransactionsEn {
	_AppStringsV2TransactionsFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get invalidAmount => 'Maling halaga. Paki-ayos.';
	@override String get selectAccount => 'Saan nanggaling ang pera?';
	@override String get selectCategory => 'Anong klaseng gastos \'to?';
	@override String errorCreatingCategory({required Object error}) => 'Error sa kategorya: ${error}';
	@override String error({required Object error}) => 'May error: ${error}';
	@override String get more => 'More';
	@override String get expense => 'Gastos';
	@override String get income => 'Pumasok';
	@override String get deleteTransaction => 'Burahin \'tong transaksyon?';
	@override String get cancel => 'Cancel';
	@override String get delete => 'Burahin';
	@override String get yesterday => 'Kahapon';
	@override String get usedCategories => 'MADALAS GAMITIN';
	@override String get noTransactions => 'Walang nangyari ngayon';
	@override String get recentActivity => 'Kamakailan';
	@override String get searchTransaction => 'Hanapin ang gastos...';
	@override String get date => 'Kailan';
	@override String get wallet => 'Mula saan';
	@override String get transactionDeleted => 'Nabura na.';
	@override String get selectCategoryTitle => 'Saan \'to papasok?';
	@override String get searchCategory => 'Maghanap ng kategorya...';
	@override String get noCategoriesAvailable => 'Walang kategorya';
	@override String get createNewCategory => 'Gumawa ng bago';
	@override String get amount => 'HALAGA';
	@override String get description => 'PARA SAAN';
	@override String get category => 'KATEGORYA';
	@override String get addNote => 'Magdagdag ng note (optional)...';
	@override String get today => 'Ngayon';
	@override String get editTransaction => 'Ayusin \'to';
	@override String get newTransaction => 'Bagong Record';
	@override String get selectWallet => 'Pumili ng Wallet';
	@override String get save => 'I-save';
	@override String get transactionUpdated => 'Ayos, na-update na.';
	@override String get transactionSaved => 'Na-save na, boss.';
}

// Path: v2.settings
class _AppStringsV2SettingsFil extends AppStringsV2SettingsEn {
	_AppStringsV2SettingsFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'I-customize';
	@override String get categories => 'Mga Kategorya ng Gastos';
	@override String get wallets => 'Mga Pera at Account Mo';
	@override String get language => 'Wika';
	@override String get currency => 'Pera';
	@override String get contact => 'Kausapin Kami';
	@override String get legacyView => 'Bumalik sa Lumang Hitsura';
	@override String get deleteCategory => 'Burahin \'tong kategorya?';
	@override String get deleteWallet => 'Burahin ang wallet na \'to?';
	@override String get cannotUndo => 'Sigurado ka ba? Hindi mo na \'to maibabalik.';
	@override String get deleteWalletWarning => 'Mabubura rin ang lahat ng gastos na nakalista sa wallet na \'to.';
	@override String deleteError({required Object error}) => 'May mali: ${error}';
	@override String get noCategoriesCreated => 'Wala pang kategorya.\nGumawa ka muna.';
	@override String get noWalletsCreated => 'Wala ka pang nilalagay na account.\nAdd mo na.';
	@override String get walletDeleted => 'Boom, nabura na.';
	@override String get cancel => 'Wag muna';
	@override String get delete => 'Sige, burahin';
	@override String get expenses => 'Gastos';
	@override String get income => 'Kita';
	@override String get newWallet => 'Bagong Wallet';
	@override String get editWallet => 'Ayusin ang Wallet';
	@override String get walletName => 'Pangalan ng Wallet';
	@override String get saveWallet => 'I-save ang Wallet';
	@override String get deleteWalletHasTransactions => 'Hindi maaaring tanggalin ang wallet na ito dahil mayroon itong mga transaksyon.';
}

// Path: v2.dashboard
class _AppStringsV2DashboardFil extends AppStringsV2DashboardEn {
	_AppStringsV2DashboardFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get greetingMorning => 'Magandang umaga!';
	@override String get totalBalance => 'KABUUANG PERA';
	@override late final _AppStringsV2DashboardDateFiltersFil dateFilters = _AppStringsV2DashboardDateFiltersFil._(_root);
	@override late final _AppStringsV2DashboardWalletFiltersFil walletFilters = _AppStringsV2DashboardWalletFiltersFil._(_root);
	@override late final _AppStringsV2DashboardBackgroundFil background = _AppStringsV2DashboardBackgroundFil._(_root);
	@override late final _AppStringsV2DashboardIncomeExpenseFil incomeExpense = _AppStringsV2DashboardIncomeExpenseFil._(_root);
	@override late final _AppStringsV2DashboardGaugeFil gauge = _AppStringsV2DashboardGaugeFil._(_root);
	@override late final _AppStringsV2DashboardActivityListFil activityList = _AppStringsV2DashboardActivityListFil._(_root);
}

// Path: v2.categories
class _AppStringsV2CategoriesFil extends AppStringsV2CategoriesEn {
	_AppStringsV2CategoriesFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Mga Kategorya';
	@override String get searchPlaceholder => 'Maghanap...';
	@override String get newCategory => 'Gumawa';
	@override String get editCategory => 'I-edit';
	@override String get noCategories => 'Wala pang laman';
	@override late final _AppStringsV2CategoriesFormFil form = _AppStringsV2CategoriesFormFil._(_root);
}

// Path: v2.onboarding
class _AppStringsV2OnboardingFil extends AppStringsV2OnboardingEn {
	_AppStringsV2OnboardingFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override late final _AppStringsV2OnboardingButtonsFil buttons = _AppStringsV2OnboardingButtonsFil._(_root);
	@override late final _AppStringsV2OnboardingSplashFil splash = _AppStringsV2OnboardingSplashFil._(_root);
	@override late final _AppStringsV2OnboardingExpenseCategoriesFil expenseCategories = _AppStringsV2OnboardingExpenseCategoriesFil._(_root);
	@override late final _AppStringsV2OnboardingFinancialGoalsFil financialGoals = _AppStringsV2OnboardingFinancialGoalsFil._(_root);
	@override late final _AppStringsV2OnboardingRegistrationMethodFil registrationMethod = _AppStringsV2OnboardingRegistrationMethodFil._(_root);
	@override late final _AppStringsV2OnboardingAiAnalysisFil aiAnalysis = _AppStringsV2OnboardingAiAnalysisFil._(_root);
	@override late final _AppStringsV2OnboardingMainPriorityFil mainPriority = _AppStringsV2OnboardingMainPriorityFil._(_root);
	@override late final _AppStringsV2OnboardingAiVoiceFil aiVoice = _AppStringsV2OnboardingAiVoiceFil._(_root);
}

// Path: transactions.filter.ranges
class _AppStringsTransactionsFilterRangesFil extends AppStringsTransactionsFilterRangesEn {
	_AppStringsTransactionsFilterRangesFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get thisMonth => 'Ngayong buwan';
	@override String get lastMonth => 'Nakaraang buwan';
	@override String get thisYear => 'Ngayong taon';
	@override String get lastYear => 'Nakaraang taon';
}

// Path: transactions.filter.subtitles
class _AppStringsTransactionsFilterSubtitlesFil extends AppStringsTransactionsFilterSubtitlesEn {
	_AppStringsTransactionsFilterSubtitlesFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get income => 'Pera na pumasok';
	@override String get expense => 'Pera na lumabas';
	@override String get transfer => 'Pera na inilipat';
}

// Path: transactions.share.receipt
class _AppStringsTransactionsShareReceiptFil extends AppStringsTransactionsShareReceiptEn {
	_AppStringsTransactionsShareReceiptFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => '--- Detalye ---';
	@override String amount({required Object amount}) => 'Halaga: ${amount}';
	@override String description({required Object description}) => 'Deskripsyon: ${description}';
	@override String category({required Object category}) => 'Kategorya: ${category}';
	@override String date({required Object date}) => 'Petsa: ${date}';
	@override String time({required Object time}) => 'Oras: ${time}';
	@override String wallet({required Object wallet}) => 'Account: ${wallet}';
	@override String contact({required Object contact}) => 'Contact: ${contact}';
	@override String id({required Object id}) => 'ID: ${id}';
	@override String get separator => '--------------------------';
}

// Path: onboarding.specificProblem.options
class _AppStringsOnboardingSpecificProblemOptionsFil extends AppStringsOnboardingSpecificProblemOptionsEn {
	_AppStringsOnboardingSpecificProblemOptionsFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get debts => 'Mga utang';
	@override String get savings => 'Hindi makapag-ipon';
	@override String get unknown => 'Hindi ko alam kung saan nauubos';
	@override String get chaos => 'Magulo talaga ang pera ko';
}

// Path: onboarding.personalGoal.options
class _AppStringsOnboardingPersonalGoalOptionsFil extends AppStringsOnboardingPersonalGoalOptionsEn {
	_AppStringsOnboardingPersonalGoalOptionsFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get debtFree => 'Makawala sa utang';
	@override String get saveTrip => 'Mag-ipon para sa travel';
	@override String get invest => 'Magsimulang mag-invest';
	@override String get peace => 'Peace of mind';
}

// Path: onboarding.solutionPreview.benefits
class _AppStringsOnboardingSolutionPreviewBenefitsFil extends AppStringsOnboardingSolutionPreviewBenefitsEn {
	_AppStringsOnboardingSolutionPreviewBenefitsFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get visualize => 'Tingnan ang gastos in real-time';
	@override String get goals => 'Abutin ang goals';
	@override String get smart => 'Maging matalino sa desisyon';
}

// Path: onboarding.currentMethod.options
class _AppStringsOnboardingCurrentMethodOptionsFil extends AppStringsOnboardingCurrentMethodOptionsEn {
	_AppStringsOnboardingCurrentMethodOptionsFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get excel => 'Excel / Spreadsheets';
	@override String get notebook => 'Notebook at Ballpen';
	@override String get mental => 'Sa isip lang';
	@override String get none => 'Wala, bahala na';
}

// Path: onboarding.featuresShowcase.features
class _AppStringsOnboardingFeaturesShowcaseFeaturesFil extends AppStringsOnboardingFeaturesShowcaseFeaturesEn {
	_AppStringsOnboardingFeaturesShowcaseFeaturesFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get income => 'Pera Pumasok';
	@override String get expense => 'Pera Lumabas';
	@override String get transfer => 'Lipat Pera';
	@override String get loans => 'Mga Utang';
	@override String get goals => 'Mga Target';
	@override String get budgets => 'Badget';
	@override String get investments => 'Investments';
	@override String get cloud => 'Cloud Sync';
	@override String get openBanking => 'Bank Sync';
}

// Path: onboarding.complete.stats
class _AppStringsOnboardingCompleteStatsFil extends AppStringsOnboardingCompleteStatsEn {
	_AppStringsOnboardingCompleteStatsFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Pag-asang Magtagumpay';
	@override String get before => 'Bago ang MoneyT';
	@override String get after => 'Gamit ang MoneyT';
}

// Path: dashboard.widgets.balance
class _AppStringsDashboardWidgetsBalanceFil extends AppStringsDashboardWidgetsBalanceEn {
	_AppStringsDashboardWidgetsBalanceFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Kabuuang Balanse';
	@override String get description => 'General status ng pera mo';
}

// Path: dashboard.widgets.quickActions
class _AppStringsDashboardWidgetsQuickActionsFil extends AppStringsDashboardWidgetsQuickActionsEn {
	_AppStringsDashboardWidgetsQuickActionsFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Quick Actions';
	@override String get description => 'Shortcuts';
}

// Path: dashboard.widgets.wallets
class _AppStringsDashboardWidgetsWalletsFil extends AppStringsDashboardWidgetsWalletsEn {
	_AppStringsDashboardWidgetsWalletsFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Wallets';
	@override String get description => 'Kung magkano pera mo';
}

// Path: dashboard.widgets.loans
class _AppStringsDashboardWidgetsLoansFil extends AppStringsDashboardWidgetsLoansEn {
	_AppStringsDashboardWidgetsLoansFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Mga Utang';
	@override String get description => 'Pautang at inutang';
}

// Path: dashboard.widgets.transactions
class _AppStringsDashboardWidgetsTransactionsFil extends AppStringsDashboardWidgetsTransactionsEn {
	_AppStringsDashboardWidgetsTransactionsFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Mga Transaksyon';
	@override String get description => 'Mga huling galaw ng pera';
}

// Path: dashboard.widgets.categoryBreakdown
class _AppStringsDashboardWidgetsCategoryBreakdownFil extends AppStringsDashboardWidgetsCategoryBreakdownEn {
	_AppStringsDashboardWidgetsCategoryBreakdownFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Gastos kada Kategorya';
	@override String get description => 'Gastos mo ngayong buwan';
	@override String get empty_message => 'Walang gastos. Tipid ah!';
	@override String get others => 'Iba pa';
	@override String get back => 'Bumalik';
	@override String get monthlyBudget => 'Budget sa buwan';
	@override String leftover({required Object amount}) => 'May natitira kang ${amount}.';
	@override String exceeded({required Object amount}) => 'Sobra ka ng ${amount} sa budget.';
	@override String noIncome({required Object amount}) => 'Gastos mo: ${amount} (Walang kita)';
}

// Path: dashboard.widgets.chartAccounts
class _AppStringsDashboardWidgetsChartAccountsFil extends AppStringsDashboardWidgetsChartAccountsEn {
	_AppStringsDashboardWidgetsChartAccountsFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Chart of Accounts';
	@override String get description => 'Struktura ng accounts';
}

// Path: dashboard.widgets.creditCards
class _AppStringsDashboardWidgetsCreditCardsFil extends AppStringsDashboardWidgetsCreditCardsEn {
	_AppStringsDashboardWidgetsCreditCardsFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Credit Cards';
	@override String get description => 'Mga Limit at Utang';
}

// Path: dashboard.widgets.settings
class _AppStringsDashboardWidgetsSettingsFil extends AppStringsDashboardWidgetsSettingsEn {
	_AppStringsDashboardWidgetsSettingsFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'I-ayos ang Dashboard';
	@override String get subtitle => 'I-drag and drop para ayusin ang itsura.';
	@override late final _AppStringsDashboardWidgetsSettingsResetFil reset = _AppStringsDashboardWidgetsSettingsResetFil._(_root);
	@override String get saveSuccess => 'Nai-save ang layout!';
	@override String saveError({required Object error}) => 'Error sa pag-save: ${error}';
	@override String get saving => 'Sini-save...';
	@override String get save => 'I-save ang Layout';
}

// Path: loans.detail.type
class _AppStringsLoansDetailTypeFil extends AppStringsLoansDetailTypeEn {
	_AppStringsLoansDetailTypeFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get label => 'Uri';
	@override String get personal => 'Personal na Utang';
	@override String get borrowed => 'Hiniram na Pera';
	@override String get auto => 'Utang sa Sasakyan';
	@override String get mortgage => 'Utang sa Bahay';
	@override String get student => 'Student Loan';
}

// Path: loans.detail.payment
class _AppStringsLoansDetailPaymentFil extends AppStringsLoansDetailPaymentEn {
	_AppStringsLoansDetailPaymentFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get history => 'History ng Bayad';
	@override String date({required Object date}) => 'Nagbayad noong ${date}';
	@override String transactionId({required Object id}) => 'ID: ${id}';
	@override String paid({required Object amount}) => 'Bayad: ${amount}';
	@override String remaining({required Object amount}) => 'Balanse: ${amount}';
}

// Path: loans.history.filter
class _AppStringsLoansHistoryFilterFil extends AppStringsLoansHistoryFilterEn {
	_AppStringsLoansHistoryFilterFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get all => 'Lahat';
	@override String get lent => 'Pinahiram';
	@override String get borrowed => 'Hiniram';
	@override String get completed => 'Bayad Na';
	@override String get title => 'Mga Filter';
	@override String get reset => 'I-reset';
	@override String get apply => 'I-apply';
	@override String get dateRange => 'Petsa';
	@override String get amountRange => 'Halaga';
	@override String get startDate => 'Simula';
	@override String get endDate => 'Katapusan';
	@override String get select => 'Piliin';
}

// Path: loans.history.headers
class _AppStringsLoansHistoryHeadersFil extends AppStringsLoansHistoryHeadersEn {
	_AppStringsLoansHistoryHeadersFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get lent => 'Pera Mo na Pinahiram';
	@override String get borrowed => 'Perang Hiniram Mo';
	@override String get completed => 'Mga Bayad Na';
	@override String get active => 'Mga Aktibo Pa';
	@override String get cancelled => 'Kinansela';
	@override String get writtenOff => 'Hindi na babayaran / TY';
}

// Path: loans.history.item
class _AppStringsLoansHistoryItemFil extends AppStringsLoansHistoryItemEn {
	_AppStringsLoansHistoryItemFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get defaultTitle => 'Utang';
	@override String date({required Object date}) => 'Petsa: ${date}';
	@override String get lent => 'Pinahiram';
	@override String get borrowed => 'Hiniram';
	@override late final _AppStringsLoansHistoryItemStatusFil status = _AppStringsLoansHistoryItemStatusFil._(_root);
}

// Path: loans.history.summary
class _AppStringsLoansHistorySummaryFil extends AppStringsLoansHistorySummaryEn {
	_AppStringsLoansHistorySummaryFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Buod ng Pautang';
	@override String get viewDetails => 'Tingnan ang detalye';
	@override String get hideDetails => 'Itago';
	@override String get outstandingLent => 'Pera mo sa kanila';
	@override String get outstandingBorrowed => 'Pera nila sayo';
	@override String get netPosition => 'Net Balance';
	@override String get totalLent => 'Total na Pinahiram';
	@override String get totalBorrowed => 'Total na Hiniram';
	@override String get totalRepaidToYou => 'Ibinayad Sayo';
	@override String get totalYouRepaid => 'Ibinayad Mo';
	@override String get totalLoans => 'Total Loans';
	@override String get completedLoans => 'Mga Bayad Na';
}

// Path: loans.payment.summary
class _AppStringsLoansPaymentSummaryFil extends AppStringsLoansPaymentSummaryEn {
	_AppStringsLoansPaymentSummaryFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Buod ng pagbabayad';
	@override String get defaultTitle => 'Utang';
	@override String get amount => 'Halagang babayaran';
	@override String get remaining => 'Matitirang balanse';
	@override String get progress => 'Bagong progress';
	@override String description({required Object loan, required Object contact}) => '${loan} kay ${contact}';
	@override String get unknownContact => 'Di Kilala';
	@override String total({required Object amount}) => 'Total: ${amount}';
	@override String paid({required Object amount}) => 'Bayad na: ${amount}';
	@override String remainingLabel({required Object amount}) => 'Balanse: ${amount}';
}

// Path: loans.payment.quick
class _AppStringsLoansPaymentQuickFil extends AppStringsLoansPaymentQuickEn {
	_AppStringsLoansPaymentQuickFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String full({required Object amount}) => 'Bayaran Lahat (${amount})';
	@override String half({required Object amount}) => 'Kalahati (${amount})';
}

// Path: backups.dialogs.info
class _AppStringsBackupsDialogsInfoFil extends AppStringsBackupsDialogsInfoEn {
	_AppStringsBackupsDialogsInfoFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Impormasyon';
	@override String get file => 'File:';
	@override String get size => 'Laki:';
	@override String get created => 'Petsa:';
	@override String get transactions => 'Transaksyon:';
}

// Path: backups.dialogs.restore
class _AppStringsBackupsDialogsRestoreFil extends AppStringsBackupsDialogsRestoreEn {
	_AppStringsBackupsDialogsRestoreFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'I-restore ang Data';
	@override String content({required Object file}) => 'Sigurado ka bang gusto mong i-restore ang "${file}"? Mapapalitan ang kasalukuyang data mo.';
	@override String get success => 'Nire-restore na... Mag-rereset ang app.';
}

// Path: backups.dialogs.delete
class _AppStringsBackupsDialogsDeleteFil extends AppStringsBackupsDialogsDeleteEn {
	_AppStringsBackupsDialogsDeleteFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Burahin ang Backup';
	@override String content({required Object file}) => 'Gusto mo ba talagang burahin ang "${file}"?';
	@override String get success => 'Nabura na ang backup.';
}

// Path: backups.options.restore
class _AppStringsBackupsOptionsRestoreFil extends AppStringsBackupsOptionsRestoreEn {
	_AppStringsBackupsOptionsRestoreFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'I-restore';
	@override String get subtitle => 'Palitan ang kasalukuyang data';
}

// Path: backups.options.share
class _AppStringsBackupsOptionsShareFil extends AppStringsBackupsOptionsShareEn {
	_AppStringsBackupsOptionsShareFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'I-share';
	@override String get subtitle => 'I-export ang file';
}

// Path: backups.options.delete
class _AppStringsBackupsOptionsDeleteFil extends AppStringsBackupsOptionsDeleteEn {
	_AppStringsBackupsOptionsDeleteFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Burahin';
	@override String get subtitle => 'Hindi na ito mababawi';
}

// Path: v2.dashboard.dateFilters
class _AppStringsV2DashboardDateFiltersFil extends AppStringsV2DashboardDateFiltersEn {
	_AppStringsV2DashboardDateFiltersFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get thisMonth => 'Ngayong buwan';
	@override String get lastMonth => 'Nakaraang buwan';
	@override String get customRange => 'Pumili ng petsa...';
}

// Path: v2.dashboard.walletFilters
class _AppStringsV2DashboardWalletFiltersFil extends AppStringsV2DashboardWalletFiltersEn {
	_AppStringsV2DashboardWalletFiltersFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get all => 'Lahat';
	@override String get allWallets => 'Lahat ng Accounts';
}

// Path: v2.dashboard.background
class _AppStringsV2DashboardBackgroundFil extends AppStringsV2DashboardBackgroundEn {
	_AppStringsV2DashboardBackgroundFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Palitan ang Background';
	@override String get chooseFromGallery => 'Pumili sa Gallery';
	@override String get restoreDefault => 'Ibalik sa Dati';
}

// Path: v2.dashboard.incomeExpense
class _AppStringsV2DashboardIncomeExpenseFil extends AppStringsV2DashboardIncomeExpenseEn {
	_AppStringsV2DashboardIncomeExpenseFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get income => 'KITA';
	@override String get expenses => 'GASTOS';
}

// Path: v2.dashboard.gauge
class _AppStringsV2DashboardGaugeFil extends AppStringsV2DashboardGaugeEn {
	_AppStringsV2DashboardGaugeFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get exceeded => 'SUMOBRA NA';
	@override String get spent => 'NAGASTOS NA';
	@override String get available => 'NATITIRA';
	@override String get overdrawn => 'UBOS NA UBOS';
}

// Path: v2.dashboard.activityList
class _AppStringsV2DashboardActivityListFil extends AppStringsV2DashboardActivityListEn {
	_AppStringsV2DashboardActivityListFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get seeAll => 'Tingnan lahat';
	@override String get newUi => 'Bagong Itsura';
	@override String get expensesByCategory => 'Kung Saan Napupunta ang Pera Mo';
	@override String get noRecentExpenses => 'Wow, walang gastos!';
	@override String percentOfTotal({required Object percent}) => '${percent}% ng kabuuan';
	@override String topExpenses({required Object count}) => 'Top ${count} mong gastos';
	@override String get others => 'Iba pa';
}

// Path: v2.categories.form
class _AppStringsV2CategoriesFormFil extends AppStringsV2CategoriesFormEn {
	_AppStringsV2CategoriesFormFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get nameLabel => 'Pangalan';
	@override String get save => 'I-save';
}

// Path: v2.onboarding.buttons
class _AppStringsV2OnboardingButtonsFil extends AppStringsV2OnboardingButtonsEn {
	_AppStringsV2OnboardingButtonsFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get start => 'Tara, simulan na! 🚀';
	@override String get actionContinue => 'Tuloy';
	@override String get great => 'Astig!';
	@override String get setGoal => 'I-set ang Goal';
	@override String get skip => 'Skip muna';
}

// Path: v2.onboarding.splash
class _AppStringsV2OnboardingSplashFil extends AppStringsV2OnboardingSplashEn {
	_AppStringsV2OnboardingSplashFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title1 => 'Paano kung ang AI na ';
	@override String get title2 => 'ang bahala mag-ayos\nng pera mo?';
	@override String get benefit1 => 'Walang kahirap-hirap.';
	@override String get benefit2 => 'Mas malinaw ang lahat.';
	@override String get benefit3 => 'Matalinong desisyon.';
}

// Path: v2.onboarding.expenseCategories
class _AppStringsV2OnboardingExpenseCategoriesFil extends AppStringsV2OnboardingExpenseCategoriesEn {
	_AppStringsV2OnboardingExpenseCategoriesFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title1 => 'Saan nauubos ang pera mo tuwing buwan?';
	@override String get subtitle => 'Pumili ng hanggang 3';
	@override String get diningOut => 'Kakakain sa labas';
	@override String get cravings => 'Mga milktea at snacks';
	@override String get subscriptions => 'Mga app at Netflix';
	@override String get outings => 'Gimik at inuman';
	@override String get shopping => 'Online shopping (Shopee/Lazada)';
	@override String get delivery => 'Puro GrabFood/FoodPanda';
}

// Path: v2.onboarding.financialGoals
class _AppStringsV2OnboardingFinancialGoalsFil extends AppStringsV2OnboardingFinancialGoalsEn {
	_AppStringsV2OnboardingFinancialGoalsFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ano ang magpapabago ng\nbuhay mo ngayon?';
	@override String get subtitle => 'Pumili ng isa';
	@override String get trackMoney => 'Malaman lang talaga kung saan napupunta pera ko';
	@override String get spendLess => 'Tigilan ang pagbili ng mga walang kwentang bagay';
	@override String get lessStress => 'Tumigil ma-stress tuwing petsa de peligro';
	@override String get saveMoney => 'Makapag-ipon man lang kahit papaano';
}

// Path: v2.onboarding.registrationMethod
class _AppStringsV2OnboardingRegistrationMethodFil extends AppStringsV2OnboardingRegistrationMethodEn {
	_AppStringsV2OnboardingRegistrationMethodFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Paano mo gustong ilista\nang mga gastos mo?';
	@override String get subtitle => 'Piliin yung pinakamadali';
	@override String get voice => 'Pagsalita na lang sa phone ko';
	@override String get auto => 'Auto-sync sa bank account';
	@override String get write => 'Ita-type ko isa-isa';
	@override String get easy => 'Basta kung ano yung hindi nakakatamad';
}

// Path: v2.onboarding.aiAnalysis
class _AppStringsV2OnboardingAiAnalysisFil extends AppStringsV2OnboardingAiAnalysisEn {
	_AppStringsV2OnboardingAiAnalysisFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override late final _AppStringsV2OnboardingAiAnalysisLoadingFil loading = _AppStringsV2OnboardingAiAnalysisLoadingFil._(_root);
	@override late final _AppStringsV2OnboardingAiAnalysisShowcaseFil showcase = _AppStringsV2OnboardingAiAnalysisShowcaseFil._(_root);
}

// Path: v2.onboarding.mainPriority
class _AppStringsV2OnboardingMainPriorityFil extends AppStringsV2OnboardingMainPriorityEn {
	_AppStringsV2OnboardingMainPriorityFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ano yung pinaka-priority\nmo ngayon?';
	@override String get subtitle => 'Pumili ng isa na gusto mong tulungan ka ng MoneyT';
	@override String get breakHabits => 'Mawala yung mga bad habits ko sa pera';
	@override String get stopStress => 'Mawala na ang kaba pag malapit na katapusan';
	@override String get buildFuture => 'Magsimulang yumaman pakonti-konti';
	@override String get feelControl => 'Ako ang may kontrol sa pera, hindi yung pera sakin';
	@override String get saveGoal => 'Maka-ipon para sa isang bibilhin';
}

// Path: v2.onboarding.aiVoice
class _AppStringsV2OnboardingAiVoiceFil extends AppStringsV2OnboardingAiVoiceEn {
	_AppStringsV2OnboardingAiVoiceFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override late final _AppStringsV2OnboardingAiVoiceTitleFil title = _AppStringsV2OnboardingAiVoiceTitleFil._(_root);
	@override String get subtitle => 'Wag mo nang i-type isa-isa, kausapin mo na lang yung AI, siya na bahala.';
	@override String get listening => 'Magsalita ka lang, nakikinig ako...';
	@override List<String> get examples => [
		'Kape ₱150',
		'Grab ₱250',
		'Sine ₱350',
		'Grocery ₱1,200',
		'Gas ₱1,000',
		'Netflix ₱549',
		'Dinner ₱800',
		'Gamot ₱450',
	];
}

// Path: dashboard.widgets.settings.reset
class _AppStringsDashboardWidgetsSettingsResetFil extends AppStringsDashboardWidgetsSettingsResetEn {
	_AppStringsDashboardWidgetsSettingsResetFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get button => 'I-reset sa default';
	@override String get dialogTitle => 'I-reset ang Layout';
	@override String get dialogContent => 'Gusto mo bang ibalik sa original na layout?';
	@override String get cancel => 'Cancel';
	@override String get confirm => 'I-reset';
	@override String get success => 'Na-reset na ang layout';
}

// Path: loans.history.item.status
class _AppStringsLoansHistoryItemStatusFil extends AppStringsLoansHistoryItemStatusEn {
	_AppStringsLoansHistoryItemStatusFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get completed => 'Bayad Na';
	@override String get active => 'Aktibo Pa';
	@override String get cancelled => 'Cancel';
	@override String get writtenOff => 'TY na';
}

// Path: v2.onboarding.aiAnalysis.loading
class _AppStringsV2OnboardingAiAnalysisLoadingFil extends AppStringsV2OnboardingAiAnalysisLoadingEn {
	_AppStringsV2OnboardingAiAnalysisLoadingFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'SINI-SETUP NA NAMIN\nANG APP PARA SAYO';
	@override String get subtitle => 'Pinoproseso...';
	@override List<String> get messages => [
		'Tinitingnan kung pano ka gumastos...',
		'Sini-setup yung mga kategorya mo...',
		'Hinahanap kung saan ka laging nabubutas...',
		'Gumagawa ng magandang plano...',
	];
}

// Path: v2.onboarding.aiAnalysis.showcase
class _AppStringsV2OnboardingAiAnalysisShowcaseFil extends AppStringsV2OnboardingAiAnalysisShowcaseEn {
	_AppStringsV2OnboardingAiAnalysisShowcaseFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ayan na, tapos na!';
	@override late final _AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextFil dynamicText = _AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextFil._(_root);
	@override late final _AppStringsV2OnboardingAiAnalysisShowcaseResultFil result = _AppStringsV2OnboardingAiAnalysisShowcaseResultFil._(_root);
}

// Path: v2.onboarding.aiVoice.title
class _AppStringsV2OnboardingAiVoiceTitleFil extends AppStringsV2OnboardingAiVoiceTitleEn {
	_AppStringsV2OnboardingAiVoiceTitleFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get kDefault => 'Ang abutin ang goal mo';
	@override String get breakHabits => 'Ang alisin ang bad habits';
	@override String get stopStress => 'Ang tanggalin ang stress sa pera';
	@override String get buildFuture => 'Ang yumaman balang araw';
	@override String get feelControl => 'Ang hawakan nang maayos ang pera';
	@override String get saveGoal => 'Ang maipon yung target mong pera';
	@override String get suffix => ' ay mas madali na ngayon dahil may AI Assistant ka na.';
}

// Path: v2.onboarding.aiAnalysis.showcase.dynamicText
class _AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextFil extends AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextEn {
	_AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get kDefault => 'Sobrang bilis maubos ng pera mo. Parang hindi na nagwo-work yung ginagawa mo ngayon.';
	@override String get part2 => ' ang umuubos ng malaking parte ng budget mo, at dahil gusto mong ';
	@override String get part3 => ' ibig sabihin kailangan mo nang magbago ng diskarte.';
	@override late final _AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextCategoriesFil categories = _AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextCategoriesFil._(_root);
	@override late final _AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextIntentionsFil intentions = _AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextIntentionsFil._(_root);
}

// Path: v2.onboarding.aiAnalysis.showcase.result
class _AppStringsV2OnboardingAiAnalysisShowcaseResultFil extends AppStringsV2OnboardingAiAnalysisShowcaseResultEn {
	_AppStringsV2OnboardingAiAnalysisShowcaseResultFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get yourResult => 'Resulta mo';
	@override String get average => 'Normal na Tao';
	@override String get messagePart1 => 'Mas malaki ng 68% ';
	@override String get messagePart2 => 'ang ginagastos mo dyan kumpara sa iba, ';
	@override String get messagePart3 => 'at ito ang unti-unting sumisira\n';
	@override String get messagePart4 => 'sa mga pangarap mo';
}

// Path: v2.onboarding.aiAnalysis.showcase.dynamicText.categories
class _AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextCategoriesFil extends AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextCategoriesEn {
	_AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextCategoriesFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get diningOut => 'Puro kain sa labas';
	@override String get cravings => 'Mga snacks at cravings';
	@override String get subscriptions => 'Mga subscriptions';
	@override String get outings => 'Pag-gimik lagi';
	@override String get shopping => 'Kakacheck-out online';
	@override String get delivery => 'Puro padeliver ng pagkain';
}

// Path: v2.onboarding.aiAnalysis.showcase.dynamicText.intentions
class _AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextIntentionsFil extends AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextIntentionsEn {
	_AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextIntentionsFil._(AppStringsFil root) : this._root = root, super.internal(root);

	final AppStringsFil _root; // ignore: unused_field

	// Translations
	@override String get trackMoney => 'ma-track kung saan napupunta pera mo';
	@override String get spendLess => 'mabawasan mga gastos';
	@override String get lessStress => 'mabawasan stress mo';
	@override String get saveMoney => 'makapag-ipon na talaga';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on AppStringsFil {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'app.name': return 'MoneyT';
			case 'app.description': return 'Tagapamahala ng Pera';
			case 'common.save': return 'I-save';
			case 'common.cancel': return 'Kanselahin';
			case 'common.delete': return 'Burahin';
			case 'common.edit': return 'I-edit';
			case 'common.loading': return 'Naglo-load...';
			case 'common.error': return 'Error';
			case 'common.success': return 'Tagumpay';
			case 'common.search': return 'Maghanap';
			case 'common.clearSearch': return 'I-clear ang paghahanap';
			case 'common.viewAll': return 'Tingnan lahat';
			case 'common.retry': return 'Subukang muli';
			case 'common.add': return 'Magdagdag';
			case 'common.remove': return 'Alisin';
			case 'common.moreOptions': return 'Iba pang opsyon';
			case 'common.addToFavorites': return 'Idagdag sa paborito';
			case 'common.removeFromFavorites': return 'Alisin sa paborito';
			case 'common.today': return 'Ngayon';
			case 'common.yesterday': return 'Kahapon';
			case 'components.dateSelection.title': return 'Pumili ng petsa';
			case 'components.dateSelection.subtitle': return 'Piliin ang petsa ng transaksyon';
			case 'components.dateSelection.selectedDate': return 'Napiling petsa';
			case 'components.dateSelection.confirm': return 'Kumpirmahin';
			case 'components.selection.cancel': return 'Kanselahin';
			case 'components.selection.confirm': return 'Kumpirmahin';
			case 'components.selection.select': return 'Piliin';
			case 'components.contactSelection.title': return 'Pumili ng contact';
			case 'components.contactSelection.subtitle': return 'Kanino ang transaksyon';
			case 'components.contactSelection.searchPlaceholder': return 'Maghanap ng contact';
			case 'components.contactSelection.noContact': return 'Walang contact';
			case 'components.contactSelection.noContactDetails': return 'Transaksyon na walang contact';
			case 'components.contactSelection.allContacts': return 'Lahat ng contact';
			case 'components.contactSelection.create': return 'Lumikha ng bago';
			case 'components.categorySelection.title': return 'Pumili ng kategorya';
			case 'components.categorySelection.subtitle': return 'Piliin ang kategorya para sa transaksyong ito';
			case 'components.categorySelection.searchPlaceholder': return 'Maghanap ng kategorya';
			case 'components.currencySelection.title': return 'Pumili ng pera';
			case 'components.currencySelection.subtitle': return 'Piliin ang pera (currency)';
			case 'components.currencySelection.searchPlaceholder': return 'Maghanap ng pera';
			case 'components.accountSelection.title': return 'Pumili ng account';
			case 'components.accountSelection.subtitle': return 'Piliin ang account para dito';
			case 'components.accountSelection.searchPlaceholder': return 'Maghanap ng account';
			case 'components.accountSelection.wallets': return 'Mga Wallet';
			case 'components.accountSelection.creditCards': return 'Credit Cards';
			case 'components.accountSelection.selectAccount': return 'Pumili ng account';
			case 'components.accountSelection.confirm': return 'Kumpirmahin';
			case 'components.parentWalletSelection.title': return 'Pangunahing wallet';
			case 'components.parentWalletSelection.subtitle': return 'Piliin ang parent wallet';
			case 'components.parentWalletSelection.searchPlaceholder': return 'Maghanap ng wallet';
			case 'components.parentWalletSelection.noParent': return 'Walang parent wallet';
			case 'components.parentWalletSelection.createRoot': return 'Gawing pangunahin';
			case 'components.parentWalletSelection.available': return 'Available na Wallet';
			case 'components.walletTypes.checking': return 'Checking Account';
			case 'components.walletTypes.savings': return 'Savings';
			case 'components.walletTypes.cash': return 'Cash';
			case 'components.walletTypes.creditCard': return 'Credit Card';
			case 'navigation.home': return 'Home';
			case 'navigation.transactions': return 'Transaksyon';
			case 'navigation.contacts': return 'Mga Contact';
			case 'navigation.settings': return 'Mga Setting';
			case 'navigation.wallets': return 'Mga Wallet';
			case 'navigation.categories': return 'Mga Kategorya';
			case 'navigation.loans': return 'Mga Utang';
			case 'navigation.charts': return 'Chart of Accounts';
			case 'navigation.backups': return 'Mga Backup';
			case 'navigation.creditCards': return 'Credit Cards';
			case 'navigation.sections.operations': return 'MGA OPERASYON';
			case 'navigation.sections.financialTools': return 'MGA TOOLS';
			case 'navigation.sections.management': return 'PAMAMAHALA';
			case 'navigation.sections.advanced': return 'ADVANCED';
			case 'transactions.title': return 'Mga Transaksyon';
			case 'transactions.types.all': return 'Lahat';
			case 'transactions.types.income': return 'Kita';
			case 'transactions.types.expense': return 'Gastos';
			case 'transactions.types.transfer': return 'Paglipat';
			case 'transactions.filter.title': return 'I-filter ang Transaksyon';
			case 'transactions.filter.date': return 'Petsa';
			case 'transactions.filter.categories': return 'Kategorya';
			case 'transactions.filter.accounts': return 'Mga Account';
			case 'transactions.filter.contacts': return 'Mga Contact';
			case 'transactions.filter.amount': return 'Halaga';
			case 'transactions.filter.apply': return 'I-apply';
			case 'transactions.filter.clear': return 'I-clear';
			case 'transactions.filter.add': return 'Magdagdag ng filter';
			case 'transactions.filter.minAmount': return 'Min Halaga';
			case 'transactions.filter.maxAmount': return 'Max Halaga';
			case 'transactions.filter.selectDate': return 'Piliin ang petsa';
			case 'transactions.filter.selectCategory': return 'Piliin ang kategorya';
			case 'transactions.filter.selectAccount': return 'Piliin ang account';
			case 'transactions.filter.selectContact': return 'Piliin ang contact';
			case 'transactions.filter.quickFilters': return 'Mabilisang Filter';
			case 'transactions.filter.ranges.thisMonth': return 'Ngayong buwan';
			case 'transactions.filter.ranges.lastMonth': return 'Nakaraang buwan';
			case 'transactions.filter.ranges.thisYear': return 'Ngayong taon';
			case 'transactions.filter.ranges.lastYear': return 'Nakaraang taon';
			case 'transactions.filter.customRange': return 'Pasadyang Petsa';
			case 'transactions.filter.startDate': return 'Petsa ng Simula';
			case 'transactions.filter.endDate': return 'Petsa ng Pagtatapos';
			case 'transactions.filter.active': return 'Mga Aktibong Filter';
			case 'transactions.filter.subtitles.income': return 'Pera na pumasok';
			case 'transactions.filter.subtitles.expense': return 'Pera na lumabas';
			case 'transactions.filter.subtitles.transfer': return 'Pera na inilipat';
			case 'transactions.form.newTitle': return 'Bagong Transaksyon';
			case 'transactions.form.editTitle': return 'I-edit ang Transaksyon';
			case 'transactions.form.amount': return 'Halaga';
			case 'transactions.form.type': return 'Uri ng transaksyon';
			case 'transactions.form.amountRequired': return 'Kailangan ng halaga';
			case 'transactions.form.date': return 'Petsa';
			case 'transactions.form.account': return 'Account';
			case 'transactions.form.toAccount': return 'Papunta sa Account';
			case 'transactions.form.category': return 'Kategorya';
			case 'transactions.form.contact': return 'Contact';
			case 'transactions.form.contactOptional': return 'Contact (Opsyonal)';
			case 'transactions.form.description': return 'Paglalarawan';
			case 'transactions.form.descriptionOptional': return 'Paglalarawan (Opsyonal)';
			case 'transactions.form.selectAccount': return 'Pumili ng account';
			case 'transactions.form.selectDestination': return 'Pumili ng destinasyon';
			case 'transactions.form.selectCategory': return 'Pumili ng kategorya';
			case 'transactions.form.selectContact': return 'Pumili ng contact';
			case 'transactions.form.saveSuccess': return 'Nai-save ang transaksyon';
			case 'transactions.form.updateSuccess': return 'Na-update ang transaksyon';
			case 'transactions.form.saveError': return 'May error sa pag-save';
			case 'transactions.form.share': return 'I-share';
			case 'transactions.form.created': return 'Nagawa ang transaksyon';
			case 'transactions.form.crossCurrencyConversion': return 'Palitan ng Pera';
			case 'transactions.form.receivedAmount': return 'Halagang natanggap';
			case 'transactions.form.exchangeRate': return 'Exchange rate';
			case 'transactions.form.receivedAmountRequired': return 'Ilagay ang natanggap';
			case 'transactions.form.exchangeRateLabel': return ({required Object from, required Object rate, required Object to}) => '1 ${from} = ${rate} ${to}';
			case 'transactions.errors.load': return 'May error sa pag-load';
			case 'transactions.empty.title': return 'Walang transaksyon';
			case 'transactions.empty.message': return 'Walang nakitang transaksyon';
			case 'transactions.empty.clearFilters': return 'I-clear ang filter';
			case 'transactions.list.count': return ({required Object n}) => '${n} transaksyon';
			case 'transactions.detail.title': return 'Detalye ng Transaksyon';
			case 'transactions.detail.delete': return 'Burahin';
			case 'transactions.detail.deleteConfirmation': return 'Sigurado ka ba? Hindi na ito mababawi.';
			case 'transactions.detail.deleted': return 'Nabura na';
			case 'transactions.detail.duplicate': return 'Doblehin';
			case 'transactions.detail.duplicateNotImplemented': return 'Hindi pa available ang duplicate';
			case 'transactions.detail.edit': return 'I-edit';
			case 'transactions.detail.errorLoad': return 'Error sa pag-load';
			case 'transactions.detail.errorPrepareEdit': return ({required Object error}) => 'Error: ${error}';
			case 'transactions.detail.errorDelete': return ({required Object error}) => 'Error: ${error}';
			case 'transactions.detail.category': return 'Kategorya';
			case 'transactions.detail.account': return 'Account';
			case 'transactions.detail.contact': return 'Contact';
			case 'transactions.detail.description': return 'Paglalarawan';
			case 'transactions.detail.transferDetails': return 'Detalye ng Paglipat';
			case 'transactions.detail.from': return 'Mula';
			case 'transactions.detail.to': return 'Papunta';
			case 'transactions.detail.unknownAccount': return 'Hindi kilalang Account';
			case 'transactions.detail.errorUrl': return ({required Object url}) => 'Hindi mabuksan ang ${url}';
			case 'transactions.detail.date': return 'Petsa';
			case 'transactions.detail.time': return 'Oras';
			case 'transactions.detail.loanLinkedWarning': return 'Ang transaksyong ito ay nakaugnay sa isang utang.';
			case 'transactions.share.title': return 'I-share';
			case 'transactions.share.copyText': return 'Kopyahin';
			case 'transactions.share.shareButton': return 'I-share';
			case 'transactions.share.shareMessage': return 'Ito ang aking resibo:';
			case 'transactions.share.copied': return 'Nakopya na sa clipboard!';
			case 'transactions.share.paymentMethod': return 'Paraan ng pagbabayad';
			case 'transactions.share.receiptTitle': return 'Resibo';
			case 'transactions.share.poweredBy': return 'Pinapagana ng MoneyT • moneyt.io';
			case 'transactions.share.errorImage': return ({required Object error}) => 'Error sa larawan: ${error}';
			case 'transactions.share.receipt.title': return '--- Detalye ---';
			case 'transactions.share.receipt.amount': return ({required Object amount}) => 'Halaga: ${amount}';
			case 'transactions.share.receipt.description': return ({required Object description}) => 'Deskripsyon: ${description}';
			case 'transactions.share.receipt.category': return ({required Object category}) => 'Kategorya: ${category}';
			case 'transactions.share.receipt.date': return ({required Object date}) => 'Petsa: ${date}';
			case 'transactions.share.receipt.time': return ({required Object time}) => 'Oras: ${time}';
			case 'transactions.share.receipt.wallet': return ({required Object wallet}) => 'Account: ${wallet}';
			case 'transactions.share.receipt.contact': return ({required Object contact}) => 'Contact: ${contact}';
			case 'transactions.share.receipt.id': return ({required Object id}) => 'ID: ${id}';
			case 'transactions.share.receipt.separator': return '--------------------------';
			case 'transactions.share.generatedOn': return ({required Object date}) => 'Nagawa noong ${date}';
			case 'contacts.title': return 'Mga Contact';
			case 'contacts.addContact': return 'Magdagdag';
			case 'contacts.editContact': return 'I-edit';
			case 'contacts.newContact': return 'Bagong contact';
			case 'contacts.noContacts': return 'Walang contact';
			case 'contacts.noContactsMessage': return 'Magdagdag ng iyong unang contact gamit ang "+"';
			case 'contacts.searchContacts': return 'Maghanap';
			case 'contacts.deleteContact': return 'Burahin';
			case 'contacts.confirmDelete': return 'Gusto mo bang burahin ang';
			case 'contacts.contactDeleted': return 'Nabura na';
			case 'contacts.errorDeleting': return 'Error sa pagbura';
			case 'contacts.noSearchResults': return 'Walang nahanap';
			case 'contacts.noContactsMatch': return ({required Object query}) => 'Walang tumutugma sa "${query}".';
			case 'contacts.errorLoading': return 'Error sa pag-load';
			case 'contacts.contactSaved': return 'Nai-save na';
			case 'contacts.errorSaving': return 'Error sa pag-save';
			case 'contacts.noContactInfo': return 'Walang impormasyon';
			case 'contacts.importContact': return 'Mag-import';
			case 'contacts.importContacts': return 'Mag-import ng mga contact';
			case 'contacts.importContactSoon': return 'Malapit nang dumating';
			case 'contacts.fields.name': return 'Pangalan';
			case 'contacts.fields.fullName': return 'Buong pangalan';
			case 'contacts.fields.email': return 'Email';
			case 'contacts.fields.phone': return 'Telepono';
			case 'contacts.fields.address': return 'Address';
			case 'contacts.fields.notes': return 'Mga Tala';
			case 'contacts.placeholders.enterFullName': return 'Ilagay ang buong pangalan';
			case 'contacts.placeholders.enterPhone': return 'Ilagay ang numero';
			case 'contacts.placeholders.enterEmail': return 'Ilagay ang email';
			case 'contacts.validation.nameRequired': return 'Kailangan ang pangalan';
			case 'contacts.validation.invalidEmail': return 'Maling email';
			case 'contacts.validation.invalidPhone': return 'Maling numero';
			case 'errors.loadingAccounts': return ({required Object error}) => 'Error: ${error}';
			case 'errors.unexpected': return 'Hindi inaasahang error';
			case 'settings.title': return 'Mga Setting';
			case 'settings.account.title': return 'Account';
			case 'settings.account.profile': return 'Profile';
			case 'settings.account.profileSubtitle': return 'Pamahalaan ang impormasyon';
			case 'settings.appearance.title': return 'Itsura';
			case 'settings.appearance.darkMode': return 'Dark Mode';
			case 'settings.appearance.darkModeSubtitle': return 'Gamitin ang dark theme';
			case 'settings.appearance.language': return 'Wika';
			case 'settings.appearance.currency': return 'Pangunahing Pera';
			case 'settings.appearance.currencySubtitle': return 'Default na pera para sa bagong accounts';
			case 'settings.appearance.darkTheme': return 'Dark Theme';
			case 'settings.appearance.lightTheme': return 'Light Theme';
			case 'settings.appearance.systemTheme': return 'Tema ng system';
			case 'settings.data.title': return 'Data at Storage';
			case 'settings.data.backup': return 'Mga Backup';
			case 'settings.data.backupSubtitle': return 'Pamahalaan ang backups';
			case 'settings.info.title': return 'Impormasyon';
			case 'settings.info.contact': return 'Contact & Social Media';
			case 'settings.info.contactSubtitle': return 'Para sa suporta';
			case 'settings.info.privacy': return 'Privacy Policy';
			case 'settings.info.privacySubtitle': return 'Basahin ang aming polisiya';
			case 'settings.info.share': return 'I-share ang MoneyT';
			case 'settings.info.shareSubtitle': return 'Irekumenda sa kaibigan';
			case 'settings.logout.button': return 'Mag-logout';
			case 'settings.logout.dialogTitle': return 'Mag-logout';
			case 'settings.logout.dialogMessage': return 'Sigurado ka bang gusto mong mag-logout?';
			case 'settings.logout.cancel': return 'Kanselahin';
			case 'settings.logout.confirm': return 'Mag-logout';
			case 'settings.social.title': return 'Contact at Social';
			case 'settings.social.follow': return 'I-follow ang MoneyT';
			case 'settings.social.description': return 'Manatiling konektado sa komunidad.';
			case 'settings.social.networks': return 'Social Media';
			case 'settings.social.github': return 'GitHub';
			case 'settings.social.githubSubtitle': return 'Tingnan ang code';
			case 'settings.social.linkedin': return 'LinkedIn';
			case 'settings.social.linkedinSubtitle': return 'Balitang propesyonal';
			case 'settings.social.twitter': return 'X (Twitter)';
			case 'settings.social.twitterSubtitle': return 'Balita at updates';
			case 'settings.social.reddit': return 'Reddit';
			case 'settings.social.redditSubtitle': return 'Komunidad';
			case 'settings.social.discord': return 'Discord';
			case 'settings.social.discordSubtitle': return 'Live chat';
			case 'settings.social.contact': return 'Support';
			case 'settings.social.email': return 'Email Support';
			case 'settings.social.website': return 'Opisyal na Website';
			case 'settings.language.title': return 'Wika';
			case 'settings.language.available': return 'MGA WIKA';
			case 'settings.language.apply': return 'I-apply ang Wika';
			case 'settings.currency.title': return 'Pangunahing Pera';
			case 'settings.currency.available': return 'MGA PERA';
			case 'settings.currency.apply': return 'I-apply ang Pera';
			case 'settings.messages.profileComingSoon': return 'Malapit na ang profile';
			case 'settings.messages.privacyError': return 'Hindi mabuksan ang privacy policy';
			case 'settings.messages.logoutComingSoon': return 'Malapit na ang logout';
			case 'onboarding.welcome.title': return 'Welcome sa MoneyT 👋';
			case 'onboarding.welcome.subtitle': return 'Hawak mo na ang pera mo ✨';
			case 'onboarding.problemStatement.title': return 'Parang naglalaho lang ang pera mo?';
			case 'onboarding.problemStatement.subtitle': return 'Hindi ka nag-iisa. 70% ng mga tao hindi alam kung saan napupunta ang pera nila.';
			case 'onboarding.specificProblem.title': return 'Ano ang pinakamalaking problema mo?';
			case 'onboarding.specificProblem.options.debts': return 'Mga utang';
			case 'onboarding.specificProblem.options.savings': return 'Hindi makapag-ipon';
			case 'onboarding.specificProblem.options.unknown': return 'Hindi ko alam kung saan nauubos';
			case 'onboarding.specificProblem.options.chaos': return 'Magulo talaga ang pera ko';
			case 'onboarding.personalGoal.title': return 'Ano ang focus mo ngayon?';
			case 'onboarding.personalGoal.options.debtFree': return 'Makawala sa utang';
			case 'onboarding.personalGoal.options.saveTrip': return 'Mag-ipon para sa travel';
			case 'onboarding.personalGoal.options.invest': return 'Magsimulang mag-invest';
			case 'onboarding.personalGoal.options.peace': return 'Peace of mind';
			case 'onboarding.solutionPreview.title': return 'Bibigyan ka ng linaw ng MoneyT';
			case 'onboarding.solutionPreview.subtitle': return 'Tingnan lahat ng accounts at utang sa isang lugar. Wala nang nakakahilong excel.';
			case 'onboarding.solutionPreview.benefits.visualize': return 'Tingnan ang gastos in real-time';
			case 'onboarding.solutionPreview.benefits.goals': return 'Abutin ang goals';
			case 'onboarding.solutionPreview.benefits.smart': return 'Maging matalino sa desisyon';
			case 'onboarding.currentMethod.title': return 'Paano mo tina-track ang pera mo ngayon?';
			case 'onboarding.currentMethod.subtitle': return 'Piliin ang pinakakatulad mo.';
			case 'onboarding.currentMethod.options.excel': return 'Excel / Spreadsheets';
			case 'onboarding.currentMethod.options.notebook': return 'Notebook at Ballpen';
			case 'onboarding.currentMethod.options.mental': return 'Sa isip lang';
			case 'onboarding.currentMethod.options.none': return 'Wala, bahala na';
			case 'onboarding.featuresShowcase.title': return 'Mga features at mga susunod pa ✨';
			case 'onboarding.featuresShowcase.subtitle': return 'Ready to use na, pero marami pang paparating.';
			case 'onboarding.featuresShowcase.available': return 'AVAILABLE NA';
			case 'onboarding.featuresShowcase.comingSoon': return 'MALAPIT NA';
			case 'onboarding.featuresShowcase.features.income': return 'Pera Pumasok';
			case 'onboarding.featuresShowcase.features.expense': return 'Pera Lumabas';
			case 'onboarding.featuresShowcase.features.transfer': return 'Lipat Pera';
			case 'onboarding.featuresShowcase.features.loans': return 'Mga Utang';
			case 'onboarding.featuresShowcase.features.goals': return 'Mga Target';
			case 'onboarding.featuresShowcase.features.budgets': return 'Badget';
			case 'onboarding.featuresShowcase.features.investments': return 'Investments';
			case 'onboarding.featuresShowcase.features.cloud': return 'Cloud Sync';
			case 'onboarding.featuresShowcase.features.openBanking': return 'Bank Sync';
			case 'onboarding.complete.title': return 'Ready to go! 🚀';
			case 'onboarding.complete.subtitle': return 'Ilagay ang unang gastos mo at tingnan ang magic 📈';
			case 'onboarding.complete.stats.title': return 'Pag-asang Magtagumpay';
			case 'onboarding.complete.stats.before': return 'Bago ang MoneyT';
			case 'onboarding.complete.stats.after': return 'Gamit ang MoneyT';
			case 'onboarding.buttons.start': return 'Tara, simulan na 🚀';
			case 'onboarding.buttons.fixIt': return 'Ayusin natin \'to ⚡';
			case 'onboarding.buttons.actionContinue': return 'Tuloy';
			case 'onboarding.buttons.setGoal': return 'I-set ang Goal 🎯';
			case 'onboarding.buttons.wantControl': return 'Gusto ko \'yan!';
			case 'onboarding.buttons.great': return 'Ayos, patingin!';
			case 'onboarding.buttons.firstTransaction': return 'I-record ang una ➕';
			case 'onboarding.buttons.skip': return 'Skip muna';
			case 'dashboard.greeting': return 'Mabuhay!';
			case 'dashboard.balance.total': return 'KABUUANG BALANSE';
			case 'dashboard.balance.income': return 'KITA';
			case 'dashboard.balance.expenses': return 'GASTOS';
			case 'dashboard.balance.thisMonth': return 'ngayong buwan';
			case 'dashboard.actions.income': return 'Kita';
			case 'dashboard.actions.expense': return 'Gastos';
			case 'dashboard.actions.transfer': return 'Lipat';
			case 'dashboard.actions.all': return 'Lahat';
			case 'dashboard.wallets.title': return 'Mga Wallet';
			case 'dashboard.wallets.count': return ({required Object n}) => '${n} account';
			case 'dashboard.wallets.more': return ({required Object n}) => '+${n} pa';
			case 'dashboard.wallets.viewDetails': return ({required Object name}) => 'Tingnan ang detalye ni ${name}';
			case 'dashboard.transactions.title': return 'Kamakailang Transaksyon';
			case 'dashboard.transactions.subtitle': return '5 pinakabago';
			case 'dashboard.transactions.empty': return 'Walang bago';
			case 'dashboard.transactions.emptySubtitle': return 'Lalabas dito ang transaksyon mo';
			case 'dashboard.transactions.more': return ({required Object n}) => '+${n} pa';
			case 'dashboard.customize': return 'I-customize';
			case 'dashboard.widgets.balance.title': return 'Kabuuang Balanse';
			case 'dashboard.widgets.balance.description': return 'General status ng pera mo';
			case 'dashboard.widgets.quickActions.title': return 'Quick Actions';
			case 'dashboard.widgets.quickActions.description': return 'Shortcuts';
			case 'dashboard.widgets.wallets.title': return 'Wallets';
			case 'dashboard.widgets.wallets.description': return 'Kung magkano pera mo';
			case 'dashboard.widgets.loans.title': return 'Mga Utang';
			case 'dashboard.widgets.loans.description': return 'Pautang at inutang';
			case 'dashboard.widgets.transactions.title': return 'Mga Transaksyon';
			case 'dashboard.widgets.transactions.description': return 'Mga huling galaw ng pera';
			case 'dashboard.widgets.categoryBreakdown.title': return 'Gastos kada Kategorya';
			case 'dashboard.widgets.categoryBreakdown.description': return 'Gastos mo ngayong buwan';
			case 'dashboard.widgets.categoryBreakdown.empty_message': return 'Walang gastos. Tipid ah!';
			case 'dashboard.widgets.categoryBreakdown.others': return 'Iba pa';
			case 'dashboard.widgets.categoryBreakdown.back': return 'Bumalik';
			case 'dashboard.widgets.categoryBreakdown.monthlyBudget': return 'Budget sa buwan';
			case 'dashboard.widgets.categoryBreakdown.leftover': return ({required Object amount}) => 'May natitira kang ${amount}.';
			case 'dashboard.widgets.categoryBreakdown.exceeded': return ({required Object amount}) => 'Sobra ka ng ${amount} sa budget.';
			case 'dashboard.widgets.categoryBreakdown.noIncome': return ({required Object amount}) => 'Gastos mo: ${amount} (Walang kita)';
			case 'dashboard.widgets.chartAccounts.title': return 'Chart of Accounts';
			case 'dashboard.widgets.chartAccounts.description': return 'Struktura ng accounts';
			case 'dashboard.widgets.creditCards.title': return 'Credit Cards';
			case 'dashboard.widgets.creditCards.description': return 'Mga Limit at Utang';
			case 'dashboard.widgets.settings.title': return 'I-ayos ang Dashboard';
			case 'dashboard.widgets.settings.subtitle': return 'I-drag and drop para ayusin ang itsura.';
			case 'dashboard.widgets.settings.reset.button': return 'I-reset sa default';
			case 'dashboard.widgets.settings.reset.dialogTitle': return 'I-reset ang Layout';
			case 'dashboard.widgets.settings.reset.dialogContent': return 'Gusto mo bang ibalik sa original na layout?';
			case 'dashboard.widgets.settings.reset.cancel': return 'Cancel';
			case 'dashboard.widgets.settings.reset.confirm': return 'I-reset';
			case 'dashboard.widgets.settings.reset.success': return 'Na-reset na ang layout';
			case 'dashboard.widgets.settings.saveSuccess': return 'Nai-save ang layout!';
			case 'dashboard.widgets.settings.saveError': return ({required Object error}) => 'Error sa pag-save: ${error}';
			case 'dashboard.widgets.settings.saving': return 'Sini-save...';
			case 'dashboard.widgets.settings.save': return 'I-save ang Layout';
			case 'wallets.title': return 'Mga Wallet';
			case 'wallets.empty.title': return 'Walang wallet na nakita';
			case 'wallets.empty.message': return 'Gumawa ng wallet para makapagsimula.';
			case 'wallets.empty.action': return 'Gumawa ng Wallet';
			case 'wallets.emptyArchived.title': return 'Walang naka-archive';
			case 'wallets.emptyArchived.message': return 'Dito mapupunta ang archived wallets.';
			case 'wallets.filter.active': return 'Aktibo';
			case 'wallets.filter.archived': return 'Naka-archive';
			case 'wallets.filter.all': return 'Lahat';
			case 'wallets.form.newTitle': return 'Bagong Wallet';
			case 'wallets.form.editTitle': return 'I-edit ang Wallet';
			case 'wallets.form.name': return 'Pangalan ng Wallet';
			case 'wallets.form.namePlaceholder': return 'Hal: BDO, GCash, Cash sa wallet';
			case 'wallets.form.nameRequired': return 'Kailangan ng pangalan';
			case 'wallets.form.description': return 'Paglalarawan';
			case 'wallets.form.descriptionPlaceholder': return 'Para saan ito? (Opsyonal)';
			case 'wallets.form.currency': return 'Pera (Currency)';
			case 'wallets.form.currencyLockedByParent': return 'Naka-lock sa parent wallet';
			case 'wallets.form.parent': return 'Parent Wallet (Opsyonal)';
			case 'wallets.form.parentEmpty': return 'Walang parent wallet';
			case 'wallets.form.chartAccount': return 'Chart of Account';
			case 'wallets.form.chartAccountLocked': return 'Hindi mapalitan ang account';
			case 'wallets.form.createSuccess': return 'Nagawa ang wallet';
			case 'wallets.form.updateSuccess': return 'Na-update ang wallet';
			case 'wallets.form.loadParentError': return ({required Object error}) => 'Error: ${error}';
			case 'wallets.form.loadChartAccountError': return ({required Object error}) => 'Error: ${error}';
			case 'wallets.delete.dialogTitle': return 'Burahin ang Wallet';
			case 'wallets.delete.dialogMessage': return ({required Object name}) => 'Sigurado ka ba? Mabubura ang ${name} at lahat ng nasa loob nito.';
			case 'wallets.delete.cancel': return 'Kanselahin';
			case 'wallets.delete.confirm': return 'Burahin';
			case 'wallets.delete.success': return 'Nabura na';
			case 'wallets.delete.error': return ({required Object error}) => 'May error: ${error}';
			case 'wallets.errors.load': return 'Error sa pag-load';
			case 'wallets.errors.retry': return 'Subukang muli';
			case 'wallets.errors.comingSoon': return ({required Object name}) => '${name} ay malapit na';
			case 'wallets.subtitle.mainAccount': return 'Main Account';
			case 'wallets.subtitle.cashDigital': return 'Cash at Digital';
			case 'wallets.subtitle.count': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fil'))(n,
				one: '${n} wallet',
				other: '${n} wallets',
			);
			case 'wallets.subtitle.account': return 'Account';
			case 'wallets.subtitle.physicalCash': return 'Pisikal na Pera';
			case 'wallets.subtitle.digitalWallet': return 'Digital Wallet';
			case 'wallets.options.viewTransactions': return 'Tingnan ang transaksyon';
			case 'wallets.options.viewTransactionsSubtitle': return 'Tingnan ang history';
			case 'wallets.options.transferFunds': return 'Maglipat ng pondo';
			case 'wallets.options.transferFundsSubtitle': return 'Ilipat sa ibang wallet';
			case 'wallets.options.editWallet': return 'I-edit';
			case 'wallets.options.editWalletSubtitle': return 'Palitan ang pangalan at kulay';
			case 'wallets.options.duplicateWallet': return 'Doblehin';
			case 'wallets.options.duplicateWalletSubtitle': return 'Kopyahin ito';
			case 'wallets.options.archiveWallet': return 'I-archive';
			case 'wallets.options.archiveWalletSubtitle': return 'Itago muna ang wallet';
			case 'wallets.options.unarchiveWallet': return 'I-unarchive';
			case 'wallets.options.unarchiveWalletSubtitle': return 'Ibalik sa listahan';
			case 'wallets.options.deleteWallet': return 'Burahin';
			case 'wallets.options.deleteWalletSubtitle': return 'Permanente itong burahin';
			case 'wallets.options.defaultTitle': return 'Wallet';
			case 'loans.title': return 'Mga Utang';
			case 'loans.filter.active': return 'Aktibo';
			case 'loans.filter.history': return 'History';
			case 'loans.filter.all': return 'Lahat';
			case 'loans.filter.pending': return 'Pending';
			case 'loans.filter.lent': return 'Pinahiram';
			case 'loans.filter.borrowed': return 'Hiniram';
			case 'loans.summary.netBalance': return 'NET BALANCE';
			case 'loans.summary.activeLoans': return 'AKTIBONG UTANG';
			case 'loans.summary.noActive': return 'Walang utang, yay!';
			case 'loans.summary.lent': return ({required Object n}) => '${n} pinahiram';
			case 'loans.summary.borrowed': return ({required Object n}) => '${n} hiniram';
			case 'loans.summary.pending': return ({required Object n}) => '${n} pending';
			case 'loans.card.lent': return 'May Utang Sayo';
			case 'loans.card.borrowed': return 'Utang Mo';
			case 'loans.card.active': return ({required Object n}) => '${n} aktibo';
			case 'loans.card.multiple': return ({required Object n}) => '${n} utang';
			case 'loans.card.transactions': return ({required Object n}) => '${n} transaksyon';
			case 'loans.card.overdue': return ({required Object n}) => 'Late ng ${n} araw';
			case 'loans.card.due': return ({required Object date}) => 'Due sa ${date}';
			case 'loans.form.newTitle': return 'Bagong Utang';
			case 'loans.form.editTitle': return 'I-edit ang Utang';
			case 'loans.form.type': return 'Uri ng utang';
			case 'loans.form.lend': return 'Nagpautang Ako';
			case 'loans.form.borrow': return 'Nangutang Ako';
			case 'loans.form.contact': return 'Contact';
			case 'loans.form.contactPlaceholder': return 'Kanino?';
			case 'loans.form.account': return 'Mula sa Account';
			case 'loans.form.accountPlaceholder': return 'Piliin ang account';
			case 'loans.form.amount': return 'Halaga';
			case 'loans.form.description': return 'Paglalarawan';
			case 'loans.form.date': return 'Petsa';
			case 'loans.form.dueDate': return 'Kelan babayaran';
			case 'loans.form.selectDate': return 'Pumili ng petsa';
			case 'loans.form.optional': return '(Opsyonal)';
			case 'loans.form.createTransaction': return 'Gawan ng record sa wallet';
			case 'loans.form.recordAutomatically': return 'Awtomatikong i-record';
			case 'loans.form.transactionCategory': return 'Kategorya ng transaksyon';
			case 'loans.form.category': return 'Kategorya';
			case 'loans.form.categoryPlaceholder': return 'Pumili ng kategorya';
			case 'loans.form.save': return 'I-save';
			case 'loans.form.successCreate': return 'Na-record na ang utang!';
			case 'loans.form.successUpdate': return 'Na-update ang utang';
			case 'loans.form.contactRequired': return 'Kailangan ng contact';
			case 'loans.form.accountRequired': return 'Kailangan ng account';
			case 'loans.form.amountRequired': return 'Magkano?';
			case 'loans.detail.title': return 'Detalye';
			case 'loans.detail.deleteTitle': return 'Burahin ang Utang';
			case 'loans.detail.deleteMessage': return 'Sigurado ka? Gusto mong burahin \'to?';
			case 'loans.detail.deleteSuccess': return 'Nabura na.';
			case 'loans.detail.deleteError': return ({required Object error}) => 'May error: ${error}';
			case 'loans.detail.notFound': return 'Hindi nahanap';
			case 'loans.detail.progress': return 'Progress ng Pagbabayad';
			case 'loans.detail.info': return 'Impormasyon';
			case 'loans.detail.pay': return 'Magbayad / Tumanggap';
			case 'loans.detail.viewHistory': return 'Buong History';
			case 'loans.detail.original': return ({required Object amount}) => 'Orihinal na halaga: ${amount}';
			case 'loans.detail.section': return 'Detalye';
			case 'loans.detail.activeSummary': return 'Buod';
			case 'loans.detail.activeLent': return 'Pinahiram';
			case 'loans.detail.activeBorrowed': return 'Inutang';
			case 'loans.detail.activeNet': return 'Net Balance';
			case 'loans.detail.activeTotal': return 'Kabuuan';
			case 'loans.detail.startDate': return 'Nagsimula';
			case 'loans.detail.dueDate': return 'Due Date';
			case 'loans.detail.type.label': return 'Uri';
			case 'loans.detail.type.personal': return 'Personal na Utang';
			case 'loans.detail.type.borrowed': return 'Hiniram na Pera';
			case 'loans.detail.type.auto': return 'Utang sa Sasakyan';
			case 'loans.detail.type.mortgage': return 'Utang sa Bahay';
			case 'loans.detail.type.student': return 'Student Loan';
			case 'loans.detail.payment.history': return 'History ng Bayad';
			case 'loans.detail.payment.date': return ({required Object date}) => 'Nagbayad noong ${date}';
			case 'loans.detail.payment.transactionId': return ({required Object id}) => 'ID: ${id}';
			case 'loans.detail.payment.paid': return ({required Object amount}) => 'Bayad: ${amount}';
			case 'loans.detail.payment.remaining': return ({required Object amount}) => 'Balanse: ${amount}';
			case 'loans.history.title': return 'History ng Utang';
			case 'loans.history.section': return 'Lahat ng Utang';
			case 'loans.history.totalLoaned': return 'Kabuuang halaga';
			case 'loans.history.noLoans': return 'Walang utang na nakita.';
			case 'loans.history.filter.all': return 'Lahat';
			case 'loans.history.filter.lent': return 'Pinahiram';
			case 'loans.history.filter.borrowed': return 'Hiniram';
			case 'loans.history.filter.completed': return 'Bayad Na';
			case 'loans.history.filter.title': return 'Mga Filter';
			case 'loans.history.filter.reset': return 'I-reset';
			case 'loans.history.filter.apply': return 'I-apply';
			case 'loans.history.filter.dateRange': return 'Petsa';
			case 'loans.history.filter.amountRange': return 'Halaga';
			case 'loans.history.filter.startDate': return 'Simula';
			case 'loans.history.filter.endDate': return 'Katapusan';
			case 'loans.history.filter.select': return 'Piliin';
			case 'loans.history.headers.lent': return 'Pera Mo na Pinahiram';
			case 'loans.history.headers.borrowed': return 'Perang Hiniram Mo';
			case 'loans.history.headers.completed': return 'Mga Bayad Na';
			case 'loans.history.headers.active': return 'Mga Aktibo Pa';
			case 'loans.history.headers.cancelled': return 'Kinansela';
			case 'loans.history.headers.writtenOff': return 'Hindi na babayaran / TY';
			case 'loans.history.item.defaultTitle': return 'Utang';
			case 'loans.history.item.date': return ({required Object date}) => 'Petsa: ${date}';
			case 'loans.history.item.lent': return 'Pinahiram';
			case 'loans.history.item.borrowed': return 'Hiniram';
			case 'loans.history.item.status.completed': return 'Bayad Na';
			case 'loans.history.item.status.active': return 'Aktibo Pa';
			case 'loans.history.item.status.cancelled': return 'Cancel';
			case 'loans.history.item.status.writtenOff': return 'TY na';
			case 'loans.history.summary.title': return 'Buod ng Pautang';
			case 'loans.history.summary.viewDetails': return 'Tingnan ang detalye';
			case 'loans.history.summary.hideDetails': return 'Itago';
			case 'loans.history.summary.outstandingLent': return 'Pera mo sa kanila';
			case 'loans.history.summary.outstandingBorrowed': return 'Pera nila sayo';
			case 'loans.history.summary.netPosition': return 'Net Balance';
			case 'loans.history.summary.totalLent': return 'Total na Pinahiram';
			case 'loans.history.summary.totalBorrowed': return 'Total na Hiniram';
			case 'loans.history.summary.totalRepaidToYou': return 'Ibinayad Sayo';
			case 'loans.history.summary.totalYouRepaid': return 'Ibinayad Mo';
			case 'loans.history.summary.totalLoans': return 'Total Loans';
			case 'loans.history.summary.completedLoans': return 'Mga Bayad Na';
			case 'loans.contactDetail.titleWith': return ({required Object name}) => 'Mga utang kay ${name}';
			case 'loans.share.title': return 'I-share';
			case 'loans.share.contactTitle': return 'I-share ang buod';
			case 'loans.share.button': return 'Ipadala';
			case 'loans.share.copy': return 'Kopyahin';
			case 'loans.share.message': return 'Pre/Sis, ito ang buod ng utang:';
			case 'loans.share.contactMessage': return ({required Object name}) => 'Buod ng utang kay ${name}:';
			case 'loans.share.error': return ({required Object error}) => 'Error: ${error}';
			case 'loans.share.contactCopied': return 'Nakopya na!';
			case 'loans.share.activeLoans': return ({required Object n}) => 'Mga Aktibo (${n}):';
			case 'loans.share.loanItem': return ({required Object description, required Object amount, required Object date, required Object percent}) => '• ${description}: ${amount} (${date}) - ${percent}% bayad';
			case 'loans.share.loanStatement': return 'MoneyT - Statement ng Utang';
			case 'loans.share.loanSummary': return 'MoneyT - Buod';
			case 'loans.share.personalLoan': return 'Personal Loan';
			case 'loans.share.remaining': return ({required Object amount}) => 'Balanse: ${amount}';
			case 'loans.share.remainingLabel': return 'Natitirang balanse';
			case 'loans.share.original': return ({required Object amount}) => 'mula sa ${amount}';
			case 'loans.share.progress': return ({required Object percent}) => '${percent}% na ang bayad';
			case 'loans.share.progressLabel': return 'Progress';
			case 'loans.share.paidSuffix': return 'Bayad Na';
			case 'loans.share.date': return ({required Object date}) => 'Petsa: ${date}';
			case 'loans.share.dateLabel': return 'Petsa';
			case 'loans.share.contact': return ({required Object name}) => 'Contact: ${name}';
			case 'loans.share.contactLabel': return 'Pangalan';
			case 'loans.share.generated': return ({required Object date}) => 'Ginawa noong ${date}';
			case 'loans.share.generatedLabel': return ({required Object date}) => 'Ginawa noong ${date}';
			case 'loans.share.totalActive': return ({required Object n}) => 'Kabuuan: ${n}';
			case 'loans.share.active': return 'aktibo';
			case 'loans.share.poweredBy': return 'Powered by MoneyT • moneyt.io';
			case 'loans.share.copied': return 'Nakopya na!';
			case 'loans.share.netBalance': return ({required Object amount, required Object status}) => 'Net Balance: ${amount} (${status})';
			case 'loans.share.netBalanceLabel': return 'Net Balance';
			case 'loans.share.owed': return 'Babayaran ka';
			case 'loans.share.owe': return 'Magbabayad ka';
			case 'loans.share.lent': return ({required Object amount}) => 'Pinahiram mo: ${amount}';
			case 'loans.share.lentLabel': return 'Pinahiram mo';
			case 'loans.share.borrowed': return ({required Object amount}) => 'Hiniram mo: ${amount}';
			case 'loans.share.borrowedLabel': return 'Hiniram mo';
			case 'loans.share.contactSummary': return ({required Object name}) => 'Buod ni ${name}';
			case 'loans.payment.title': return 'I-record ang Bayad';
			case 'loans.payment.amount': return 'Magkano?';
			case 'loans.payment.amountPlaceholder': return '0.00';
			case 'loans.payment.amountRequired': return 'Ilagay ang halaga';
			case 'loans.payment.invalidAmount': return 'Maling halaga';
			case 'loans.payment.exceedsBalance': return 'Sobra sa balanse yung binayad mo boss';
			case 'loans.payment.date': return 'Petsa ng bayad';
			case 'loans.payment.account': return 'Saang account papasok/lalabas?';
			case 'loans.payment.selectAccount': return 'Piliin ang account';
			case 'loans.payment.details': return 'Karagdagang detalye';
			case 'loans.payment.detailsPlaceholder': return 'Mga tala... (Opsyonal)';
			case 'loans.payment.success': return 'Nice, na-record ang bayad!';
			case 'loans.payment.error': return ({required Object error}) => 'Error: ${error}';
			case 'loans.payment.errorAmount': return 'Maling halaga';
			case 'loans.payment.errorAccount': return 'Pumili ng account';
			case 'loans.payment.errorLoading': return ({required Object error}) => 'Error: ${error}';
			case 'loans.payment.summary.title': return 'Buod ng pagbabayad';
			case 'loans.payment.summary.defaultTitle': return 'Utang';
			case 'loans.payment.summary.amount': return 'Halagang babayaran';
			case 'loans.payment.summary.remaining': return 'Matitirang balanse';
			case 'loans.payment.summary.progress': return 'Bagong progress';
			case 'loans.payment.summary.description': return ({required Object loan, required Object contact}) => '${loan} kay ${contact}';
			case 'loans.payment.summary.unknownContact': return 'Di Kilala';
			case 'loans.payment.summary.total': return ({required Object amount}) => 'Total: ${amount}';
			case 'loans.payment.summary.paid': return ({required Object amount}) => 'Bayad na: ${amount}';
			case 'loans.payment.summary.remainingLabel': return ({required Object amount}) => 'Balanse: ${amount}';
			case 'loans.payment.quick.full': return ({required Object amount}) => 'Bayaran Lahat (${amount})';
			case 'loans.payment.quick.half': return ({required Object amount}) => 'Kalahati (${amount})';
			case 'loans.given': return 'Pinahiram';
			case 'loans.received': return 'Hiniram';
			case 'loans.item.due': return ({required Object date}) => 'Due: ${date}';
			case 'loans.item.paidAmount': return ({required Object amount}) => 'Bayad: ${amount}';
			case 'loans.item.remaining': return ({required Object amount}) => 'Balanse: ${amount}';
			case 'loans.item.percentPaid': return ({required Object percent}) => '${percent}%';
			case 'loans.section.activeLoans': return 'Mga Aktibong Utang';
			case 'loans.section.loansCount': return ({required Object n}) => '${n} loans';
			case 'loans.empty.title': return 'Walang mga utang';
			case 'loans.empty.message': return 'Masarap ang tulog kapag walang utang.';
			case 'loans.empty.action': return 'Gumawa ng Utang';
			case 'categories.title': return 'Mga Kategorya';
			case 'categories.form.newTitle': return 'Bagong Kategorya';
			case 'categories.form.editTitle': return 'I-edit ang Kategorya';
			case 'categories.form.name': return 'Pangalan';
			case 'categories.form.namePlaceholder': return 'Hal: Pagkain, Pamasahe, Shopee';
			case 'categories.form.nameRequired': return 'Kailangan ang pangalan';
			case 'categories.form.parent': return 'Parent Category (Opsyonal)';
			case 'categories.form.noParent': return 'Gawing pangunahin';
			case 'categories.form.asSubcategory': return 'Ito ay magiging subcategory';
			case 'categories.form.asRoot': return 'Ito ay magiging main category';
			case 'categories.form.active': return 'Aktibo';
			case 'categories.form.activeDescription': return 'Ipapakita sa paggawa ng transaksyon';
			case 'categories.form.selectIcon': return 'Pumili ng Icon';
			case 'categories.form.selectColor': return 'Pumili ng Kulay';
			case 'categories.form.saveSuccess': return 'Nai-save na!';
			case 'categories.form.saveError': return ({required Object error}) => 'May error sa pag-save: ${error}';
			case 'categories.parentSelection.title': return 'Pumili ng parent category';
			case 'categories.parentSelection.subtitle': return 'Saan ito kabilang?';
			case 'categories.parentSelection.noParent': return 'Walang parent (Main)';
			case 'categories.incomeCategory': return 'Kategorya ng Kita';
			case 'categories.expenseCategory': return 'Kategorya ng Gastos';
			case 'categories.report.title': return 'Advanced Report';
			case 'categories.report.timeFilter': return 'Panahon';
			case 'categories.report.thisMonth': return 'Ngayong Buwan';
			case 'categories.report.lastMonth': return 'Nakaraang Buwan';
			case 'categories.report.thisYear': return 'Ngayong Taon';
			case 'categories.report.allTime': return 'Lahat ng Panahon';
			case 'categories.report.details': return 'Mga Detalye';
			case 'categories.report.noTransactions': return 'Walang transaksyon';
			case 'categories.report.income': return 'Kita';
			case 'categories.report.expense': return 'Gastos';
			case 'backups.title': return 'Mga Backup';
			case 'backups.menu.settings': return 'Backup Settings';
			case 'backups.menu.comingSoon': return 'Malapit na';
			case 'backups.filters.all': return 'Lahat';
			case 'backups.filters.auto': return 'Automatic';
			case 'backups.filters.manual': return 'Manual';
			case 'backups.filters.thisMonth': return 'Ngayong Buwan';
			case 'backups.filters.lastMonth': return 'Nakaraang Buwan';
			case 'backups.filters.thisYear': return 'Ngayong Taon';
			case 'backups.filters.lastYear': return 'Nakaraang Taon';
			case 'backups.status.loading': return 'Naglo-load...';
			case 'backups.status.error': return 'May error';
			case 'backups.status.empty': return 'Walang backup';
			case 'backups.status.emptyAction': return 'Pindutin ang + para gumawa';
			case 'backups.status.success': return 'Tagumpay!';
			case 'backups.status.created': return 'Gawa na ang backup.';
			case 'backups.status.createError': return ({required Object error}) => 'Error sa paggawa: ${error}';
			case 'backups.status.restoreError': return ({required Object error}) => 'Error sa pag-restore: ${error}';
			case 'backups.status.deleteError': return ({required Object error}) => 'Error sa pagbura: ${error}';
			case 'backups.actions.create': return 'Gumawa ng Backup';
			case 'backups.actions.import': return 'Mag-import';
			case 'backups.actions.restore': return 'I-restore';
			case 'backups.actions.delete': return 'Burahin';
			case 'backups.actions.share': return 'I-share';
			case 'backups.actions.cancel': return 'Kanselahin';
			case 'backups.actions.retry': return 'Subukan Ulit';
			case 'backups.actions.ok': return 'OK';
			case 'backups.dialogs.info.title': return 'Impormasyon';
			case 'backups.dialogs.info.file': return 'File:';
			case 'backups.dialogs.info.size': return 'Laki:';
			case 'backups.dialogs.info.created': return 'Petsa:';
			case 'backups.dialogs.info.transactions': return 'Transaksyon:';
			case 'backups.dialogs.restore.title': return 'I-restore ang Data';
			case 'backups.dialogs.restore.content': return ({required Object file}) => 'Sigurado ka bang gusto mong i-restore ang "${file}"? Mapapalitan ang kasalukuyang data mo.';
			case 'backups.dialogs.restore.success': return 'Nire-restore na... Mag-rereset ang app.';
			case 'backups.dialogs.delete.title': return 'Burahin ang Backup';
			case 'backups.dialogs.delete.content': return ({required Object file}) => 'Gusto mo ba talagang burahin ang "${file}"?';
			case 'backups.dialogs.delete.success': return 'Nabura na ang backup.';
			case 'backups.stats.title': return 'Backup Stats';
			case 'backups.stats.totalBackups': return 'Kabuuan';
			case 'backups.stats.totalSize': return 'Kabuuang Laki';
			case 'backups.stats.oldest': return 'Pinakaluma';
			case 'backups.stats.latest': return 'Pinakabago';
			case 'backups.stats.autoBackupStatus': return 'Auto Backup';
			case 'backups.stats.active': return 'Bukas';
			case 'backups.stats.inactive': return 'Patay';
			case 'backups.options.restore.title': return 'I-restore';
			case 'backups.options.restore.subtitle': return 'Palitan ang kasalukuyang data';
			case 'backups.options.share.title': return 'I-share';
			case 'backups.options.share.subtitle': return 'I-export ang file';
			case 'backups.options.delete.title': return 'Burahin';
			case 'backups.options.delete.subtitle': return 'Hindi na ito mababawi';
			case 'backups.options.latestBadge': return 'Latest';
			case 'backups.options.latestFile': return 'Pinakabago';
			case 'backups.options.backupFile': return 'Backup na file';
			case 'backups.format.auto': return ({required Object date}) => 'Auto - ${date}';
			case 'backups.format.manual': return ({required Object date}) => 'Manual - ${date}';
			case 'backups.format.initial': return 'Initial Backup';
			case 'backups.format.generic': return ({required Object date}) => 'Backup - ${date}';
			case 'v2.voice.errorProcessing': return 'Hindi ko na-gets. Paki-ulit nga?';
			case 'v2.voice.tapMicrophone': return 'Pindutin ang mic para magsalita';
			case 'v2.voice.listening': return 'Nakikinig...';
			case 'v2.voice.missingApiKey': return 'Wala kasing GEMINI_API_KEY sa .env file mo.';
			case 'v2.voice.aiError': return ({required Object error}) => 'AI Error: ${error}';
			case 'v2.voice.cancel': return 'Kanselahin';
			case 'v2.voice.scan': return 'I-scan';
			case 'v2.transactions.invalidAmount': return 'Maling halaga. Paki-ayos.';
			case 'v2.transactions.selectAccount': return 'Saan nanggaling ang pera?';
			case 'v2.transactions.selectCategory': return 'Anong klaseng gastos \'to?';
			case 'v2.transactions.errorCreatingCategory': return ({required Object error}) => 'Error sa kategorya: ${error}';
			case 'v2.transactions.error': return ({required Object error}) => 'May error: ${error}';
			case 'v2.transactions.more': return 'More';
			case 'v2.transactions.expense': return 'Gastos';
			case 'v2.transactions.income': return 'Pumasok';
			case 'v2.transactions.deleteTransaction': return 'Burahin \'tong transaksyon?';
			case 'v2.transactions.cancel': return 'Cancel';
			case 'v2.transactions.delete': return 'Burahin';
			case 'v2.transactions.yesterday': return 'Kahapon';
			case 'v2.transactions.usedCategories': return 'MADALAS GAMITIN';
			case 'v2.transactions.noTransactions': return 'Walang nangyari ngayon';
			case 'v2.transactions.recentActivity': return 'Kamakailan';
			case 'v2.transactions.searchTransaction': return 'Hanapin ang gastos...';
			case 'v2.transactions.date': return 'Kailan';
			case 'v2.transactions.wallet': return 'Mula saan';
			case 'v2.transactions.transactionDeleted': return 'Nabura na.';
			case 'v2.transactions.selectCategoryTitle': return 'Saan \'to papasok?';
			case 'v2.transactions.searchCategory': return 'Maghanap ng kategorya...';
			case 'v2.transactions.noCategoriesAvailable': return 'Walang kategorya';
			case 'v2.transactions.createNewCategory': return 'Gumawa ng bago';
			case 'v2.transactions.amount': return 'HALAGA';
			case 'v2.transactions.description': return 'PARA SAAN';
			case 'v2.transactions.category': return 'KATEGORYA';
			case 'v2.transactions.addNote': return 'Magdagdag ng note (optional)...';
			case 'v2.transactions.today': return 'Ngayon';
			case 'v2.transactions.editTransaction': return 'Ayusin \'to';
			case 'v2.transactions.newTransaction': return 'Bagong Record';
			case 'v2.transactions.selectWallet': return 'Pumili ng Wallet';
			case 'v2.transactions.save': return 'I-save';
			case 'v2.transactions.transactionUpdated': return 'Ayos, na-update na.';
			case 'v2.transactions.transactionSaved': return 'Na-save na, boss.';
			case 'v2.settings.title': return 'I-customize';
			case 'v2.settings.categories': return 'Mga Kategorya ng Gastos';
			case 'v2.settings.wallets': return 'Mga Pera at Account Mo';
			case 'v2.settings.language': return 'Wika';
			case 'v2.settings.currency': return 'Pera';
			case 'v2.settings.contact': return 'Kausapin Kami';
			case 'v2.settings.legacyView': return 'Bumalik sa Lumang Hitsura';
			case 'v2.settings.deleteCategory': return 'Burahin \'tong kategorya?';
			case 'v2.settings.deleteWallet': return 'Burahin ang wallet na \'to?';
			case 'v2.settings.cannotUndo': return 'Sigurado ka ba? Hindi mo na \'to maibabalik.';
			case 'v2.settings.deleteWalletWarning': return 'Mabubura rin ang lahat ng gastos na nakalista sa wallet na \'to.';
			case 'v2.settings.deleteError': return ({required Object error}) => 'May mali: ${error}';
			case 'v2.settings.noCategoriesCreated': return 'Wala pang kategorya.\nGumawa ka muna.';
			case 'v2.settings.noWalletsCreated': return 'Wala ka pang nilalagay na account.\nAdd mo na.';
			case 'v2.settings.walletDeleted': return 'Boom, nabura na.';
			case 'v2.settings.cancel': return 'Wag muna';
			case 'v2.settings.delete': return 'Sige, burahin';
			case 'v2.settings.expenses': return 'Gastos';
			case 'v2.settings.income': return 'Kita';
			case 'v2.settings.newWallet': return 'Bagong Wallet';
			case 'v2.settings.editWallet': return 'Ayusin ang Wallet';
			case 'v2.settings.walletName': return 'Pangalan ng Wallet';
			case 'v2.settings.saveWallet': return 'I-save ang Wallet';
			case 'v2.settings.deleteWalletHasTransactions': return 'Hindi maaaring tanggalin ang wallet na ito dahil mayroon itong mga transaksyon.';
			case 'v2.dashboard.greetingMorning': return 'Magandang umaga!';
			case 'v2.dashboard.totalBalance': return 'KABUUANG PERA';
			case 'v2.dashboard.dateFilters.thisMonth': return 'Ngayong buwan';
			case 'v2.dashboard.dateFilters.lastMonth': return 'Nakaraang buwan';
			case 'v2.dashboard.dateFilters.customRange': return 'Pumili ng petsa...';
			case 'v2.dashboard.walletFilters.all': return 'Lahat';
			case 'v2.dashboard.walletFilters.allWallets': return 'Lahat ng Accounts';
			case 'v2.dashboard.background.title': return 'Palitan ang Background';
			case 'v2.dashboard.background.chooseFromGallery': return 'Pumili sa Gallery';
			case 'v2.dashboard.background.restoreDefault': return 'Ibalik sa Dati';
			case 'v2.dashboard.incomeExpense.income': return 'KITA';
			case 'v2.dashboard.incomeExpense.expenses': return 'GASTOS';
			case 'v2.dashboard.gauge.exceeded': return 'SUMOBRA NA';
			case 'v2.dashboard.gauge.spent': return 'NAGASTOS NA';
			case 'v2.dashboard.gauge.available': return 'NATITIRA';
			case 'v2.dashboard.gauge.overdrawn': return 'UBOS NA UBOS';
			case 'v2.dashboard.activityList.seeAll': return 'Tingnan lahat';
			case 'v2.dashboard.activityList.newUi': return 'Bagong Itsura';
			case 'v2.dashboard.activityList.expensesByCategory': return 'Kung Saan Napupunta ang Pera Mo';
			case 'v2.dashboard.activityList.noRecentExpenses': return 'Wow, walang gastos!';
			case 'v2.dashboard.activityList.percentOfTotal': return ({required Object percent}) => '${percent}% ng kabuuan';
			case 'v2.dashboard.activityList.topExpenses': return ({required Object count}) => 'Top ${count} mong gastos';
			case 'v2.dashboard.activityList.others': return 'Iba pa';
			case 'v2.categories.title': return 'Mga Kategorya';
			case 'v2.categories.searchPlaceholder': return 'Maghanap...';
			case 'v2.categories.newCategory': return 'Gumawa';
			case 'v2.categories.editCategory': return 'I-edit';
			case 'v2.categories.noCategories': return 'Wala pang laman';
			case 'v2.categories.form.nameLabel': return 'Pangalan';
			case 'v2.categories.form.save': return 'I-save';
			case 'v2.onboarding.buttons.start': return 'Tara, simulan na! 🚀';
			case 'v2.onboarding.buttons.actionContinue': return 'Tuloy';
			case 'v2.onboarding.buttons.great': return 'Astig!';
			case 'v2.onboarding.buttons.setGoal': return 'I-set ang Goal';
			case 'v2.onboarding.buttons.skip': return 'Skip muna';
			case 'v2.onboarding.splash.title1': return 'Paano kung ang AI na ';
			case 'v2.onboarding.splash.title2': return 'ang bahala mag-ayos\nng pera mo?';
			case 'v2.onboarding.splash.benefit1': return 'Walang kahirap-hirap.';
			case 'v2.onboarding.splash.benefit2': return 'Mas malinaw ang lahat.';
			case 'v2.onboarding.splash.benefit3': return 'Matalinong desisyon.';
			case 'v2.onboarding.expenseCategories.title1': return 'Saan nauubos ang pera mo tuwing buwan?';
			case 'v2.onboarding.expenseCategories.subtitle': return 'Pumili ng hanggang 3';
			case 'v2.onboarding.expenseCategories.diningOut': return 'Kakakain sa labas';
			case 'v2.onboarding.expenseCategories.cravings': return 'Mga milktea at snacks';
			case 'v2.onboarding.expenseCategories.subscriptions': return 'Mga app at Netflix';
			case 'v2.onboarding.expenseCategories.outings': return 'Gimik at inuman';
			case 'v2.onboarding.expenseCategories.shopping': return 'Online shopping (Shopee/Lazada)';
			case 'v2.onboarding.expenseCategories.delivery': return 'Puro GrabFood/FoodPanda';
			case 'v2.onboarding.financialGoals.title': return 'Ano ang magpapabago ng\nbuhay mo ngayon?';
			case 'v2.onboarding.financialGoals.subtitle': return 'Pumili ng isa';
			case 'v2.onboarding.financialGoals.trackMoney': return 'Malaman lang talaga kung saan napupunta pera ko';
			case 'v2.onboarding.financialGoals.spendLess': return 'Tigilan ang pagbili ng mga walang kwentang bagay';
			case 'v2.onboarding.financialGoals.lessStress': return 'Tumigil ma-stress tuwing petsa de peligro';
			case 'v2.onboarding.financialGoals.saveMoney': return 'Makapag-ipon man lang kahit papaano';
			case 'v2.onboarding.registrationMethod.title': return 'Paano mo gustong ilista\nang mga gastos mo?';
			case 'v2.onboarding.registrationMethod.subtitle': return 'Piliin yung pinakamadali';
			case 'v2.onboarding.registrationMethod.voice': return 'Pagsalita na lang sa phone ko';
			case 'v2.onboarding.registrationMethod.auto': return 'Auto-sync sa bank account';
			case 'v2.onboarding.registrationMethod.write': return 'Ita-type ko isa-isa';
			case 'v2.onboarding.registrationMethod.easy': return 'Basta kung ano yung hindi nakakatamad';
			case 'v2.onboarding.aiAnalysis.loading.title': return 'SINI-SETUP NA NAMIN\nANG APP PARA SAYO';
			case 'v2.onboarding.aiAnalysis.loading.subtitle': return 'Pinoproseso...';
			case 'v2.onboarding.aiAnalysis.loading.messages.0': return 'Tinitingnan kung pano ka gumastos...';
			case 'v2.onboarding.aiAnalysis.loading.messages.1': return 'Sini-setup yung mga kategorya mo...';
			case 'v2.onboarding.aiAnalysis.loading.messages.2': return 'Hinahanap kung saan ka laging nabubutas...';
			case 'v2.onboarding.aiAnalysis.loading.messages.3': return 'Gumagawa ng magandang plano...';
			case 'v2.onboarding.aiAnalysis.showcase.title': return 'Ayan na, tapos na!';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.kDefault': return 'Sobrang bilis maubos ng pera mo. Parang hindi na nagwo-work yung ginagawa mo ngayon.';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.part2': return ' ang umuubos ng malaking parte ng budget mo, at dahil gusto mong ';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.part3': return ' ibig sabihin kailangan mo nang magbago ng diskarte.';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.categories.diningOut': return 'Puro kain sa labas';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.categories.cravings': return 'Mga snacks at cravings';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.categories.subscriptions': return 'Mga subscriptions';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.categories.outings': return 'Pag-gimik lagi';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.categories.shopping': return 'Kakacheck-out online';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.categories.delivery': return 'Puro padeliver ng pagkain';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.intentions.trackMoney': return 'ma-track kung saan napupunta pera mo';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.intentions.spendLess': return 'mabawasan mga gastos';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.intentions.lessStress': return 'mabawasan stress mo';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.intentions.saveMoney': return 'makapag-ipon na talaga';
			case 'v2.onboarding.aiAnalysis.showcase.result.yourResult': return 'Resulta mo';
			case 'v2.onboarding.aiAnalysis.showcase.result.average': return 'Normal na Tao';
			case 'v2.onboarding.aiAnalysis.showcase.result.messagePart1': return 'Mas malaki ng 68% ';
			case 'v2.onboarding.aiAnalysis.showcase.result.messagePart2': return 'ang ginagastos mo dyan kumpara sa iba, ';
			case 'v2.onboarding.aiAnalysis.showcase.result.messagePart3': return 'at ito ang unti-unting sumisira\n';
			case 'v2.onboarding.aiAnalysis.showcase.result.messagePart4': return 'sa mga pangarap mo';
			case 'v2.onboarding.mainPriority.title': return 'Ano yung pinaka-priority\nmo ngayon?';
			case 'v2.onboarding.mainPriority.subtitle': return 'Pumili ng isa na gusto mong tulungan ka ng MoneyT';
			case 'v2.onboarding.mainPriority.breakHabits': return 'Mawala yung mga bad habits ko sa pera';
			case 'v2.onboarding.mainPriority.stopStress': return 'Mawala na ang kaba pag malapit na katapusan';
			case 'v2.onboarding.mainPriority.buildFuture': return 'Magsimulang yumaman pakonti-konti';
			case 'v2.onboarding.mainPriority.feelControl': return 'Ako ang may kontrol sa pera, hindi yung pera sakin';
			case 'v2.onboarding.mainPriority.saveGoal': return 'Maka-ipon para sa isang bibilhin';
			case 'v2.onboarding.aiVoice.title.kDefault': return 'Ang abutin ang goal mo';
			case 'v2.onboarding.aiVoice.title.breakHabits': return 'Ang alisin ang bad habits';
			case 'v2.onboarding.aiVoice.title.stopStress': return 'Ang tanggalin ang stress sa pera';
			case 'v2.onboarding.aiVoice.title.buildFuture': return 'Ang yumaman balang araw';
			case 'v2.onboarding.aiVoice.title.feelControl': return 'Ang hawakan nang maayos ang pera';
			case 'v2.onboarding.aiVoice.title.saveGoal': return 'Ang maipon yung target mong pera';
			case 'v2.onboarding.aiVoice.title.suffix': return ' ay mas madali na ngayon dahil may AI Assistant ka na.';
			case 'v2.onboarding.aiVoice.subtitle': return 'Wag mo nang i-type isa-isa, kausapin mo na lang yung AI, siya na bahala.';
			case 'v2.onboarding.aiVoice.listening': return 'Magsalita ka lang, nakikinig ako...';
			case 'v2.onboarding.aiVoice.examples.0': return 'Kape ₱150';
			case 'v2.onboarding.aiVoice.examples.1': return 'Grab ₱250';
			case 'v2.onboarding.aiVoice.examples.2': return 'Sine ₱350';
			case 'v2.onboarding.aiVoice.examples.3': return 'Grocery ₱1,200';
			case 'v2.onboarding.aiVoice.examples.4': return 'Gas ₱1,000';
			case 'v2.onboarding.aiVoice.examples.5': return 'Netflix ₱549';
			case 'v2.onboarding.aiVoice.examples.6': return 'Dinner ₱800';
			case 'v2.onboarding.aiVoice.examples.7': return 'Gamot ₱450';
			case 'intents.transactionSavedTitle': return '✅ Nai-save ang Transaksyon';
			case 'intents.emptyText': return 'Walang teksto';
			case 'intents.emptyData': return 'Walang data';
			case 'intents.cannotUnderstand': return 'Hindi maintindihan ang transaksyon';
			case 'intents.errorSaving': return 'May error sa pag-save';
			case 'intents.noCategories': return 'Walang kategoryang magagamit';
			case 'intents.loadingError': return 'Error sa pag-load';
			default: return null;
		}
	}
}

