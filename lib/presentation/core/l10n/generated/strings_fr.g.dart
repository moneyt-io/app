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
class AppStringsFr extends AppStrings {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	AppStringsFr({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, AppStrings>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.fr,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <fr>.
	@override final TranslationMetadata<AppLocale, AppStrings> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final AppStringsFr _root = this; // ignore: unused_field

	@override 
	AppStringsFr $copyWith({TranslationMetadata<AppLocale, AppStrings>? meta}) => AppStringsFr(meta: meta ?? this.$meta);

	// Translations
	@override late final _AppStringsAppFr app = _AppStringsAppFr._(_root);
	@override late final _AppStringsCommonFr common = _AppStringsCommonFr._(_root);
	@override late final _AppStringsComponentsFr components = _AppStringsComponentsFr._(_root);
	@override late final _AppStringsNavigationFr navigation = _AppStringsNavigationFr._(_root);
	@override late final _AppStringsTransactionsFr transactions = _AppStringsTransactionsFr._(_root);
	@override late final _AppStringsContactsFr contacts = _AppStringsContactsFr._(_root);
	@override late final _AppStringsErrorsFr errors = _AppStringsErrorsFr._(_root);
	@override late final _AppStringsSettingsFr settings = _AppStringsSettingsFr._(_root);
	@override late final _AppStringsOnboardingFr onboarding = _AppStringsOnboardingFr._(_root);
	@override late final _AppStringsDashboardFr dashboard = _AppStringsDashboardFr._(_root);
	@override late final _AppStringsWalletsFr wallets = _AppStringsWalletsFr._(_root);
	@override late final _AppStringsLoansFr loans = _AppStringsLoansFr._(_root);
	@override late final _AppStringsCategoriesFr categories = _AppStringsCategoriesFr._(_root);
	@override late final _AppStringsBackupsFr backups = _AppStringsBackupsFr._(_root);
	@override late final _AppStringsV2Fr v2 = _AppStringsV2Fr._(_root);
	@override late final _AppStringsIntentsFr intents = _AppStringsIntentsFr._(_root);
}

// Path: app
class _AppStringsAppFr extends AppStringsAppEn {
	_AppStringsAppFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get name => 'MoneyT';
	@override String get description => 'Gestionnaire Financier';
}

// Path: common
class _AppStringsCommonFr extends AppStringsCommonEn {
	_AppStringsCommonFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get save => 'Enregistrer';
	@override String get cancel => 'Annuler';
	@override String get delete => 'Supprimer';
	@override String get edit => 'Modifier';
	@override String get loading => 'Chargement...';
	@override String get error => 'Erreur';
	@override String get success => 'Succès';
	@override String get search => 'Rechercher';
	@override String get clearSearch => 'Effacer la recherche';
	@override String get viewAll => 'Voir tout';
	@override String get retry => 'Réessayer';
	@override String get add => 'Ajouter';
	@override String get remove => 'Retirer';
	@override String get moreOptions => 'Plus d\'options';
	@override String get addToFavorites => 'Ajouter aux favoris';
	@override String get removeFromFavorites => 'Retirer des favoris';
	@override String get today => 'Aujourd\'hui';
	@override String get yesterday => 'Hier';
}

// Path: components
class _AppStringsComponentsFr extends AppStringsComponentsEn {
	_AppStringsComponentsFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override late final _AppStringsComponentsDateSelectionFr dateSelection = _AppStringsComponentsDateSelectionFr._(_root);
	@override late final _AppStringsComponentsSelectionFr selection = _AppStringsComponentsSelectionFr._(_root);
	@override late final _AppStringsComponentsContactSelectionFr contactSelection = _AppStringsComponentsContactSelectionFr._(_root);
	@override late final _AppStringsComponentsCategorySelectionFr categorySelection = _AppStringsComponentsCategorySelectionFr._(_root);
	@override late final _AppStringsComponentsCurrencySelectionFr currencySelection = _AppStringsComponentsCurrencySelectionFr._(_root);
	@override late final _AppStringsComponentsAccountSelectionFr accountSelection = _AppStringsComponentsAccountSelectionFr._(_root);
	@override late final _AppStringsComponentsParentWalletSelectionFr parentWalletSelection = _AppStringsComponentsParentWalletSelectionFr._(_root);
	@override late final _AppStringsComponentsWalletTypesFr walletTypes = _AppStringsComponentsWalletTypesFr._(_root);
}

// Path: navigation
class _AppStringsNavigationFr extends AppStringsNavigationEn {
	_AppStringsNavigationFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get home => 'Accueil';
	@override String get transactions => 'Transactions';
	@override String get contacts => 'Contacts';
	@override String get settings => 'Paramètres';
	@override String get wallets => 'Comptes';
	@override String get categories => 'Catégories';
	@override String get loans => 'Prêts';
	@override String get charts => 'Plan comptable';
	@override String get backups => 'Sauvegardes';
	@override String get creditCards => 'Cartes';
	@override late final _AppStringsNavigationSectionsFr sections = _AppStringsNavigationSectionsFr._(_root);
}

// Path: transactions
class _AppStringsTransactionsFr extends AppStringsTransactionsEn {
	_AppStringsTransactionsFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Transactions';
	@override late final _AppStringsTransactionsTypesFr types = _AppStringsTransactionsTypesFr._(_root);
	@override late final _AppStringsTransactionsFilterFr filter = _AppStringsTransactionsFilterFr._(_root);
	@override late final _AppStringsTransactionsFormFr form = _AppStringsTransactionsFormFr._(_root);
	@override late final _AppStringsTransactionsErrorsFr errors = _AppStringsTransactionsErrorsFr._(_root);
	@override late final _AppStringsTransactionsEmptyFr empty = _AppStringsTransactionsEmptyFr._(_root);
	@override late final _AppStringsTransactionsListFr list = _AppStringsTransactionsListFr._(_root);
	@override late final _AppStringsTransactionsDetailFr detail = _AppStringsTransactionsDetailFr._(_root);
	@override late final _AppStringsTransactionsShareFr share = _AppStringsTransactionsShareFr._(_root);
}

// Path: contacts
class _AppStringsContactsFr extends AppStringsContactsEn {
	_AppStringsContactsFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Contacts';
	@override String get addContact => 'Nouveau';
	@override String get editContact => 'Modifier';
	@override String get newContact => 'Nouveau contact';
	@override String get noContacts => 'Aucun contact';
	@override String get noContactsMessage => 'Ajoute ton premier contact';
	@override String get searchContacts => 'Chercher';
	@override String get deleteContact => 'Supprimer';
	@override String get confirmDelete => 'Tu veux vraiment supprimer';
	@override String get contactDeleted => 'Contact supprimé';
	@override String get errorDeleting => 'Erreur';
	@override String get noSearchResults => 'Aucun résultat';
	@override String noContactsMatch({required Object query}) => 'Personne avec "${query}".';
	@override String get errorLoading => 'Erreur de chargement';
	@override String get contactSaved => 'Contact enregistré';
	@override String get errorSaving => 'Erreur';
	@override String get noContactInfo => 'Aucune info';
	@override String get importContact => 'Importer';
	@override String get importContacts => 'Importer contacts';
	@override String get importContactSoon => 'Bientôt disponible';
	@override late final _AppStringsContactsFieldsFr fields = _AppStringsContactsFieldsFr._(_root);
	@override late final _AppStringsContactsPlaceholdersFr placeholders = _AppStringsContactsPlaceholdersFr._(_root);
	@override late final _AppStringsContactsValidationFr validation = _AppStringsContactsValidationFr._(_root);
}

// Path: errors
class _AppStringsErrorsFr extends AppStringsErrorsEn {
	_AppStringsErrorsFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String loadingAccounts({required Object error}) => 'Erreur chargement : ${error}';
	@override String get unexpected => 'Oups, erreur inattendue';
}

// Path: settings
class _AppStringsSettingsFr extends AppStringsSettingsEn {
	_AppStringsSettingsFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Paramètres';
	@override late final _AppStringsSettingsAccountFr account = _AppStringsSettingsAccountFr._(_root);
	@override late final _AppStringsSettingsAppearanceFr appearance = _AppStringsSettingsAppearanceFr._(_root);
	@override late final _AppStringsSettingsDataFr data = _AppStringsSettingsDataFr._(_root);
	@override late final _AppStringsSettingsInfoFr info = _AppStringsSettingsInfoFr._(_root);
	@override late final _AppStringsSettingsLogoutFr logout = _AppStringsSettingsLogoutFr._(_root);
	@override late final _AppStringsSettingsSocialFr social = _AppStringsSettingsSocialFr._(_root);
	@override late final _AppStringsSettingsLanguageFr language = _AppStringsSettingsLanguageFr._(_root);
	@override late final _AppStringsSettingsCurrencyFr currency = _AppStringsSettingsCurrencyFr._(_root);
	@override late final _AppStringsSettingsMessagesFr messages = _AppStringsSettingsMessagesFr._(_root);
}

// Path: onboarding
class _AppStringsOnboardingFr extends AppStringsOnboardingEn {
	_AppStringsOnboardingFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override late final _AppStringsOnboardingWelcomeFr welcome = _AppStringsOnboardingWelcomeFr._(_root);
	@override late final _AppStringsOnboardingProblemStatementFr problemStatement = _AppStringsOnboardingProblemStatementFr._(_root);
	@override late final _AppStringsOnboardingSpecificProblemFr specificProblem = _AppStringsOnboardingSpecificProblemFr._(_root);
	@override late final _AppStringsOnboardingPersonalGoalFr personalGoal = _AppStringsOnboardingPersonalGoalFr._(_root);
	@override late final _AppStringsOnboardingSolutionPreviewFr solutionPreview = _AppStringsOnboardingSolutionPreviewFr._(_root);
	@override late final _AppStringsOnboardingCurrentMethodFr currentMethod = _AppStringsOnboardingCurrentMethodFr._(_root);
	@override late final _AppStringsOnboardingFeaturesShowcaseFr featuresShowcase = _AppStringsOnboardingFeaturesShowcaseFr._(_root);
	@override late final _AppStringsOnboardingCompleteFr complete = _AppStringsOnboardingCompleteFr._(_root);
	@override late final _AppStringsOnboardingButtonsFr buttons = _AppStringsOnboardingButtonsFr._(_root);
}

// Path: dashboard
class _AppStringsDashboardFr extends AppStringsDashboardEn {
	_AppStringsDashboardFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get greeting => 'Bienvenue';
	@override late final _AppStringsDashboardBalanceFr balance = _AppStringsDashboardBalanceFr._(_root);
	@override late final _AppStringsDashboardActionsFr actions = _AppStringsDashboardActionsFr._(_root);
	@override late final _AppStringsDashboardWalletsFr wallets = _AppStringsDashboardWalletsFr._(_root);
	@override late final _AppStringsDashboardTransactionsFr transactions = _AppStringsDashboardTransactionsFr._(_root);
	@override String get customize => 'Personnaliser';
	@override late final _AppStringsDashboardWidgetsFr widgets = _AppStringsDashboardWidgetsFr._(_root);
}

// Path: wallets
class _AppStringsWalletsFr extends AppStringsWalletsEn {
	_AppStringsWalletsFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Comptes';
	@override late final _AppStringsWalletsEmptyFr empty = _AppStringsWalletsEmptyFr._(_root);
	@override late final _AppStringsWalletsEmptyArchivedFr emptyArchived = _AppStringsWalletsEmptyArchivedFr._(_root);
	@override late final _AppStringsWalletsFilterFr filter = _AppStringsWalletsFilterFr._(_root);
	@override late final _AppStringsWalletsFormFr form = _AppStringsWalletsFormFr._(_root);
	@override late final _AppStringsWalletsDeleteFr delete = _AppStringsWalletsDeleteFr._(_root);
	@override late final _AppStringsWalletsErrorsFr errors = _AppStringsWalletsErrorsFr._(_root);
	@override late final _AppStringsWalletsSubtitleFr subtitle = _AppStringsWalletsSubtitleFr._(_root);
	@override late final _AppStringsWalletsOptionsFr options = _AppStringsWalletsOptionsFr._(_root);
}

// Path: loans
class _AppStringsLoansFr extends AppStringsLoansEn {
	_AppStringsLoansFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Prêts';
	@override late final _AppStringsLoansFilterFr filter = _AppStringsLoansFilterFr._(_root);
	@override late final _AppStringsLoansSummaryFr summary = _AppStringsLoansSummaryFr._(_root);
	@override late final _AppStringsLoansCardFr card = _AppStringsLoansCardFr._(_root);
	@override late final _AppStringsLoansFormFr form = _AppStringsLoansFormFr._(_root);
	@override late final _AppStringsLoansDetailFr detail = _AppStringsLoansDetailFr._(_root);
	@override late final _AppStringsLoansHistoryFr history = _AppStringsLoansHistoryFr._(_root);
	@override late final _AppStringsLoansContactDetailFr contactDetail = _AppStringsLoansContactDetailFr._(_root);
	@override late final _AppStringsLoansShareFr share = _AppStringsLoansShareFr._(_root);
	@override late final _AppStringsLoansPaymentFr payment = _AppStringsLoansPaymentFr._(_root);
	@override String get given => 'J\'ai Prêté';
	@override String get received => 'J\'ai Emprunté';
	@override late final _AppStringsLoansItemFr item = _AppStringsLoansItemFr._(_root);
	@override late final _AppStringsLoansSectionFr section = _AppStringsLoansSectionFr._(_root);
	@override late final _AppStringsLoansEmptyFr empty = _AppStringsLoansEmptyFr._(_root);
}

// Path: categories
class _AppStringsCategoriesFr extends AppStringsCategoriesEn {
	_AppStringsCategoriesFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Catégories';
	@override late final _AppStringsCategoriesFormFr form = _AppStringsCategoriesFormFr._(_root);
	@override late final _AppStringsCategoriesParentSelectionFr parentSelection = _AppStringsCategoriesParentSelectionFr._(_root);
	@override String get incomeCategory => 'Catégorie Revenu';
	@override String get expenseCategory => 'Catégorie Dépense';
	@override late final _AppStringsCategoriesReportFr report = _AppStringsCategoriesReportFr._(_root);
}

// Path: backups
class _AppStringsBackupsFr extends AppStringsBackupsEn {
	_AppStringsBackupsFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sauvegardes';
	@override late final _AppStringsBackupsMenuFr menu = _AppStringsBackupsMenuFr._(_root);
	@override late final _AppStringsBackupsFiltersFr filters = _AppStringsBackupsFiltersFr._(_root);
	@override late final _AppStringsBackupsStatusFr status = _AppStringsBackupsStatusFr._(_root);
	@override late final _AppStringsBackupsActionsFr actions = _AppStringsBackupsActionsFr._(_root);
	@override late final _AppStringsBackupsDialogsFr dialogs = _AppStringsBackupsDialogsFr._(_root);
	@override late final _AppStringsBackupsStatsFr stats = _AppStringsBackupsStatsFr._(_root);
	@override late final _AppStringsBackupsOptionsFr options = _AppStringsBackupsOptionsFr._(_root);
	@override late final _AppStringsBackupsFormatFr format = _AppStringsBackupsFormatFr._(_root);
}

// Path: v2
class _AppStringsV2Fr extends AppStringsV2En {
	_AppStringsV2Fr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override late final _AppStringsV2VoiceFr voice = _AppStringsV2VoiceFr._(_root);
	@override late final _AppStringsV2TransactionsFr transactions = _AppStringsV2TransactionsFr._(_root);
	@override late final _AppStringsV2SettingsFr settings = _AppStringsV2SettingsFr._(_root);
	@override late final _AppStringsV2DashboardFr dashboard = _AppStringsV2DashboardFr._(_root);
	@override late final _AppStringsV2CategoriesFr categories = _AppStringsV2CategoriesFr._(_root);
	@override late final _AppStringsV2OnboardingFr onboarding = _AppStringsV2OnboardingFr._(_root);
	@override late final _AppStringsV2DateSelectionFr dateSelection = _AppStringsV2DateSelectionFr._(_root);
}

// Path: intents
class _AppStringsIntentsFr extends AppStringsIntentsEn {
	_AppStringsIntentsFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get transactionSavedTitle => '✅ Transaction Enregistrée';
	@override String get emptyText => 'Texte vide';
	@override String get emptyData => 'Données vides';
	@override String get cannotUnderstand => 'Impossible de comprendre la transaction';
	@override String get errorSaving => 'Erreur de sauvegarde';
	@override String get noCategories => 'Aucune catégorie';
	@override String get loadingError => 'Erreur de chargement';
}

// Path: components.dateSelection
class _AppStringsComponentsDateSelectionFr extends AppStringsComponentsDateSelectionEn {
	_AppStringsComponentsDateSelectionFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Choisir la date';
	@override String get subtitle => 'Sélectionne la date';
	@override String get selectedDate => 'Date sélectionnée';
	@override String get confirm => 'Confirmer';
}

// Path: components.selection
class _AppStringsComponentsSelectionFr extends AppStringsComponentsSelectionEn {
	_AppStringsComponentsSelectionFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Annuler';
	@override String get confirm => 'Confirmer';
	@override String get select => 'Sélectionner';
}

// Path: components.contactSelection
class _AppStringsComponentsContactSelectionFr extends AppStringsComponentsContactSelectionEn {
	_AppStringsComponentsContactSelectionFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sélectionner le contact';
	@override String get subtitle => 'Avec qui se fait la transaction';
	@override String get searchPlaceholder => 'Chercher un contact';
	@override String get noContact => 'Aucun contact';
	@override String get noContactDetails => 'Transaction sans contact';
	@override String get allContacts => 'Tous les contacts';
	@override String get create => 'Créer un contact';
}

// Path: components.categorySelection
class _AppStringsComponentsCategorySelectionFr extends AppStringsComponentsCategorySelectionEn {
	_AppStringsComponentsCategorySelectionFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Choisir une catégorie';
	@override String get subtitle => 'Trouve la bonne catégorie';
	@override String get searchPlaceholder => 'Chercher...';
}

// Path: components.currencySelection
class _AppStringsComponentsCurrencySelectionFr extends AppStringsComponentsCurrencySelectionEn {
	_AppStringsComponentsCurrencySelectionFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Devise';
	@override String get subtitle => 'Choisis la monnaie';
	@override String get searchPlaceholder => 'Chercher...';
}

// Path: components.accountSelection
class _AppStringsComponentsAccountSelectionFr extends AppStringsComponentsAccountSelectionEn {
	_AppStringsComponentsAccountSelectionFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sélectionner le compte';
	@override String get subtitle => 'D\'où vient l\'argent';
	@override String get searchPlaceholder => 'Chercher un compte';
	@override String get wallets => 'Portefeuilles';
	@override String get creditCards => 'Cartes de Crédit';
	@override String get selectAccount => 'Choisir';
	@override String get confirm => 'Confirmer';
}

// Path: components.parentWalletSelection
class _AppStringsComponentsParentWalletSelectionFr extends AppStringsComponentsParentWalletSelectionEn {
	_AppStringsComponentsParentWalletSelectionFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Portefeuille principal';
	@override String get subtitle => 'Lier à un portefeuille parent';
	@override String get searchPlaceholder => 'Chercher...';
	@override String get noParent => 'Aucun parent';
	@override String get createRoot => 'Créer comme principal';
	@override String get available => 'Disponibles';
}

// Path: components.walletTypes
class _AppStringsComponentsWalletTypesFr extends AppStringsComponentsWalletTypesEn {
	_AppStringsComponentsWalletTypesFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get checking => 'Compte Courant';
	@override String get savings => 'Épargne';
	@override String get cash => 'Espèces';
	@override String get creditCard => 'Carte de Crédit';
}

// Path: navigation.sections
class _AppStringsNavigationSectionsFr extends AppStringsNavigationSectionsEn {
	_AppStringsNavigationSectionsFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get operations => 'OPÉRATIONS';
	@override String get financialTools => 'OUTILS FINANCIERS';
	@override String get management => 'GESTION';
	@override String get advanced => 'AVANCÉ';
}

// Path: transactions.types
class _AppStringsTransactionsTypesFr extends AppStringsTransactionsTypesEn {
	_AppStringsTransactionsTypesFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get all => 'Tout';
	@override String get income => 'Revenu';
	@override String get expense => 'Dépense';
	@override String get transfer => 'Virement';
}

// Path: transactions.filter
class _AppStringsTransactionsFilterFr extends AppStringsTransactionsFilterEn {
	_AppStringsTransactionsFilterFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Filtres';
	@override String get date => 'Date';
	@override String get categories => 'Catégories';
	@override String get accounts => 'Comptes';
	@override String get contacts => 'Contacts';
	@override String get amount => 'Montant';
	@override String get apply => 'Appliquer';
	@override String get clear => 'Effacer';
	@override String get add => 'Ajouter filtre';
	@override String get minAmount => 'Min';
	@override String get maxAmount => 'Max';
	@override String get selectDate => 'Date';
	@override String get selectCategory => 'Catégorie';
	@override String get selectAccount => 'Compte';
	@override String get selectContact => 'Contact';
	@override String get quickFilters => 'Filtres rapides';
	@override late final _AppStringsTransactionsFilterRangesFr ranges = _AppStringsTransactionsFilterRangesFr._(_root);
	@override String get customRange => 'Période personnalisée';
	@override String get startDate => 'Début';
	@override String get endDate => 'Fin';
	@override String get active => 'Filtres actifs';
	@override late final _AppStringsTransactionsFilterSubtitlesFr subtitles = _AppStringsTransactionsFilterSubtitlesFr._(_root);
}

// Path: transactions.form
class _AppStringsTransactionsFormFr extends AppStringsTransactionsFormEn {
	_AppStringsTransactionsFormFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get newTitle => 'Nouvelle Transaction';
	@override String get editTitle => 'Modifier Transaction';
	@override String get amount => 'Montant';
	@override String get type => 'Type';
	@override String get amountRequired => 'Montant requis';
	@override String get date => 'Date';
	@override String get account => 'Compte';
	@override String get toAccount => 'Vers';
	@override String get category => 'Catégorie';
	@override String get contact => 'Contact';
	@override String get contactOptional => 'Contact (optionnel)';
	@override String get description => 'Description';
	@override String get descriptionOptional => 'Description (optionnelle)';
	@override String get selectAccount => 'Choisir le compte';
	@override String get selectDestination => 'Choisir la destination';
	@override String get selectCategory => 'Choisir la catégorie';
	@override String get selectContact => 'Choisir le contact';
	@override String get saveSuccess => 'Transaction enregistrée';
	@override String get updateSuccess => 'Transaction mise à jour';
	@override String get saveError => 'Erreur d\'enregistrement';
	@override String get share => 'Partager';
	@override String get created => 'Créée avec succès';
	@override String get crossCurrencyConversion => 'Conversion de devise';
	@override String get receivedAmount => 'Montant reçu';
	@override String get exchangeRate => 'Taux de change';
	@override String get receivedAmountRequired => 'Veuillez entrer le montant';
	@override String exchangeRateLabel({required Object from, required Object rate, required Object to}) => '1 ${from} = ${rate} ${to}';
}

// Path: transactions.errors
class _AppStringsTransactionsErrorsFr extends AppStringsTransactionsErrorsEn {
	_AppStringsTransactionsErrorsFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get load => 'Erreur de chargement';
}

// Path: transactions.empty
class _AppStringsTransactionsEmptyFr extends AppStringsTransactionsEmptyEn {
	_AppStringsTransactionsEmptyFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Rien à afficher';
	@override String get message => 'Aucune transaction avec ces filtres';
	@override String get clearFilters => 'Effacer les filtres';
}

// Path: transactions.list
class _AppStringsTransactionsListFr extends AppStringsTransactionsListEn {
	_AppStringsTransactionsListFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String count({required Object n}) => '${n} transactions';
}

// Path: transactions.detail
class _AppStringsTransactionsDetailFr extends AppStringsTransactionsDetailEn {
	_AppStringsTransactionsDetailFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Détails';
	@override String get delete => 'Supprimer';
	@override String get deleteConfirmation => 'Tu es sûr ? Irréversible.';
	@override String get deleted => 'Transaction supprimée';
	@override String get duplicate => 'Dupliquer';
	@override String get duplicateNotImplemented => 'Bientôt';
	@override String get edit => 'Modifier';
	@override String get errorLoad => 'Erreur';
	@override String errorPrepareEdit({required Object error}) => 'Erreur d\'édition: ${error}';
	@override String errorDelete({required Object error}) => 'Erreur de suppression: ${error}';
	@override String get category => 'Catégorie';
	@override String get account => 'Compte';
	@override String get contact => 'Contact';
	@override String get description => 'Description';
	@override String get transferDetails => 'Virement';
	@override String get from => 'De';
	@override String get to => 'À';
	@override String get unknownAccount => 'Inconnu';
	@override String errorUrl({required Object url}) => 'Impossible d\'ouvrir ${url}';
	@override String get date => 'Date';
	@override String get time => 'Heure';
	@override String get loanLinkedWarning => 'Géré automatiquement via un prêt.';
}

// Path: transactions.share
class _AppStringsTransactionsShareFr extends AppStringsTransactionsShareEn {
	_AppStringsTransactionsShareFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Partager';
	@override String get copyText => 'Copier';
	@override String get shareButton => 'Partager';
	@override String get shareMessage => 'Voici mon reçu :';
	@override String get copied => 'Copié dans le presse-papiers !';
	@override String get paymentMethod => 'Méthode';
	@override String get receiptTitle => 'Reçu';
	@override String get poweredBy => 'Via MoneyT • moneyt.io';
	@override String errorImage({required Object error}) => 'Erreur: ${error}';
	@override late final _AppStringsTransactionsShareReceiptFr receipt = _AppStringsTransactionsShareReceiptFr._(_root);
	@override String generatedOn({required Object date}) => 'Généré le ${date}';
}

// Path: contacts.fields
class _AppStringsContactsFieldsFr extends AppStringsContactsFieldsEn {
	_AppStringsContactsFieldsFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get name => 'Nom';
	@override String get fullName => 'Nom complet';
	@override String get email => 'E-mail';
	@override String get phone => 'Téléphone';
	@override String get address => 'Adresse';
	@override String get notes => 'Notes';
}

// Path: contacts.placeholders
class _AppStringsContactsPlaceholdersFr extends AppStringsContactsPlaceholdersEn {
	_AppStringsContactsPlaceholdersFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get enterFullName => 'Nom complet';
	@override String get enterPhone => 'Numéro';
	@override String get enterEmail => 'Adresse e-mail';
}

// Path: contacts.validation
class _AppStringsContactsValidationFr extends AppStringsContactsValidationEn {
	_AppStringsContactsValidationFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get nameRequired => 'Le nom est requis';
	@override String get invalidEmail => 'E-mail invalide';
	@override String get invalidPhone => 'Numéro invalide';
}

// Path: settings.account
class _AppStringsSettingsAccountFr extends AppStringsSettingsAccountEn {
	_AppStringsSettingsAccountFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Compte';
	@override String get profile => 'Profil';
	@override String get profileSubtitle => 'Gérer tes informations';
}

// Path: settings.appearance
class _AppStringsSettingsAppearanceFr extends AppStringsSettingsAppearanceEn {
	_AppStringsSettingsAppearanceFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Préférences';
	@override String get darkMode => 'Mode sombre';
	@override String get darkModeSubtitle => 'Passer au thème sombre';
	@override String get language => 'Langue';
	@override String get currency => 'Devise principale';
	@override String get currencySubtitle => 'Devise par défaut';
	@override String get darkTheme => 'Sombre';
	@override String get lightTheme => 'Clair';
	@override String get systemTheme => 'Système';
}

// Path: settings.data
class _AppStringsSettingsDataFr extends AppStringsSettingsDataEn {
	_AppStringsSettingsDataFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Données';
	@override String get backup => 'Sauvegardes';
	@override String get backupSubtitle => 'Gère tes données';
}

// Path: settings.info
class _AppStringsSettingsInfoFr extends AppStringsSettingsInfoEn {
	_AppStringsSettingsInfoFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Informations';
	@override String get contact => 'Contact & Réseaux';
	@override String get contactSubtitle => 'Rejoins la communauté';
	@override String get privacy => 'Confidentialité';
	@override String get privacySubtitle => 'Notre politique';
	@override String get share => 'Partager MoneyT';
	@override String get shareSubtitle => 'Fais tourner l\'app';
}

// Path: settings.logout
class _AppStringsSettingsLogoutFr extends AppStringsSettingsLogoutEn {
	_AppStringsSettingsLogoutFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get button => 'Se déconnecter';
	@override String get dialogTitle => 'Déconnexion';
	@override String get dialogMessage => 'Es-tu sûr de vouloir te déconnecter ?';
	@override String get cancel => 'Annuler';
	@override String get confirm => 'Oui';
}

// Path: settings.social
class _AppStringsSettingsSocialFr extends AppStringsSettingsSocialEn {
	_AppStringsSettingsSocialFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Contact & Réseaux';
	@override String get follow => 'Suivre MoneyT';
	@override String get description => 'Reste connecté avec la commu.';
	@override String get networks => 'Réseaux Sociaux';
	@override String get github => 'GitHub';
	@override String get githubSubtitle => 'Voir le code';
	@override String get linkedin => 'LinkedIn';
	@override String get linkedinSubtitle => 'News pro';
	@override String get twitter => 'X (Twitter)';
	@override String get twitterSubtitle => 'News en direct';
	@override String get reddit => 'Reddit';
	@override String get redditSubtitle => 'Discussion';
	@override String get discord => 'Discord';
	@override String get discordSubtitle => 'Chat avec nous';
	@override String get contact => 'Support';
	@override String get email => 'Envoyer un e-mail';
	@override String get website => 'Site Officiel';
}

// Path: settings.language
class _AppStringsSettingsLanguageFr extends AppStringsSettingsLanguageEn {
	_AppStringsSettingsLanguageFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Langue';
	@override String get available => 'LANGUES DISPONIBLES';
	@override String get apply => 'Appliquer';
}

// Path: settings.currency
class _AppStringsSettingsCurrencyFr extends AppStringsSettingsCurrencyEn {
	_AppStringsSettingsCurrencyFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Devise par défaut';
	@override String get available => 'DEVISES DISPONIBLES';
	@override String get apply => 'Appliquer';
}

// Path: settings.messages
class _AppStringsSettingsMessagesFr extends AppStringsSettingsMessagesEn {
	_AppStringsSettingsMessagesFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get profileComingSoon => 'Profil à venir';
	@override String get privacyError => 'Impossible d\'ouvrir';
	@override String get logoutComingSoon => 'Déconnexion à venir';
}

// Path: onboarding.welcome
class _AppStringsOnboardingWelcomeFr extends AppStringsOnboardingWelcomeEn {
	_AppStringsOnboardingWelcomeFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Bienvenue sur MoneyT 👋';
	@override String get subtitle => 'Gère ton argent en 2 minutes ✨';
}

// Path: onboarding.problemStatement
class _AppStringsOnboardingProblemStatementFr extends AppStringsOnboardingProblemStatementEn {
	_AppStringsOnboardingProblemStatementFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'L\'argent te file entre les doigts ?';
	@override String get subtitle => 'T\'es pas seul. 70% des gens ne savent pas où va leur salaire.';
}

// Path: onboarding.specificProblem
class _AppStringsOnboardingSpecificProblemFr extends AppStringsOnboardingSpecificProblemEn {
	_AppStringsOnboardingSpecificProblemFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'C\'est quoi ta galère ?';
	@override late final _AppStringsOnboardingSpecificProblemOptionsFr options = _AppStringsOnboardingSpecificProblemOptionsFr._(_root);
}

// Path: onboarding.personalGoal
class _AppStringsOnboardingPersonalGoalFr extends AppStringsOnboardingPersonalGoalEn {
	_AppStringsOnboardingPersonalGoalFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'C\'est quoi ton objectif ?';
	@override late final _AppStringsOnboardingPersonalGoalOptionsFr options = _AppStringsOnboardingPersonalGoalOptionsFr._(_root);
}

// Path: onboarding.solutionPreview
class _AppStringsOnboardingSolutionPreviewFr extends AppStringsOnboardingSolutionPreviewEn {
	_AppStringsOnboardingSolutionPreviewFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'MoneyT t\'éclaire';
	@override String get subtitle => 'Tout voir au même endroit. Adieu les tableurs ennuyeux.';
	@override late final _AppStringsOnboardingSolutionPreviewBenefitsFr benefits = _AppStringsOnboardingSolutionPreviewBenefitsFr._(_root);
}

// Path: onboarding.currentMethod
class _AppStringsOnboardingCurrentMethodFr extends AppStringsOnboardingCurrentMethodEn {
	_AppStringsOnboardingCurrentMethodFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Comment tu gères ton fric aujourd\'hui ?';
	@override String get subtitle => 'Choisis ce qui te ressemble.';
	@override late final _AppStringsOnboardingCurrentMethodOptionsFr options = _AppStringsOnboardingCurrentMethodOptionsFr._(_root);
}

// Path: onboarding.featuresShowcase
class _AppStringsOnboardingFeaturesShowcaseFr extends AppStringsOnboardingFeaturesShowcaseEn {
	_AppStringsOnboardingFeaturesShowcaseFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ce qui est là et ce qui arrive ✨';
	@override String get subtitle => 'Le basique est là, la suite arrive lourd.';
	@override String get available => 'MAINTENANT';
	@override String get comingSoon => 'À VENIR';
	@override late final _AppStringsOnboardingFeaturesShowcaseFeaturesFr features = _AppStringsOnboardingFeaturesShowcaseFeaturesFr._(_root);
}

// Path: onboarding.complete
class _AppStringsOnboardingCompleteFr extends AppStringsOnboardingCompleteEn {
	_AppStringsOnboardingCompleteFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Prêt au décollage ! 🚀';
	@override String get subtitle => 'Note ta première dépense et vois la différence 📈';
	@override late final _AppStringsOnboardingCompleteStatsFr stats = _AppStringsOnboardingCompleteStatsFr._(_root);
}

// Path: onboarding.buttons
class _AppStringsOnboardingButtonsFr extends AppStringsOnboardingButtonsEn {
	_AppStringsOnboardingButtonsFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get start => 'C\'est parti 🚀';
	@override String get fixIt => 'On règle ça ⚡';
	@override String get actionContinue => 'Continuer';
	@override String get setGoal => 'Fixer l\'objectif 🎯';
	@override String get wantControl => 'Je veux ce contrôle !';
	@override String get great => 'Super, montre-moi !';
	@override String get firstTransaction => 'Ma première dépense ➕';
	@override String get skip => 'Passer';
}

// Path: dashboard.balance
class _AppStringsDashboardBalanceFr extends AppStringsDashboardBalanceEn {
	_AppStringsDashboardBalanceFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get total => 'SOLDE TOTAL';
	@override String get income => 'REVENUS';
	@override String get expenses => 'DÉPENSES';
	@override String get thisMonth => 'ce mois-ci';
}

// Path: dashboard.actions
class _AppStringsDashboardActionsFr extends AppStringsDashboardActionsEn {
	_AppStringsDashboardActionsFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get income => 'Revenu';
	@override String get expense => 'Dépense';
	@override String get transfer => 'Virement';
	@override String get all => 'Tout';
}

// Path: dashboard.wallets
class _AppStringsDashboardWalletsFr extends AppStringsDashboardWalletsEn {
	_AppStringsDashboardWalletsFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Portefeuilles';
	@override String count({required Object n}) => '${n} comptes';
	@override String more({required Object n}) => '+${n} comptes';
	@override String viewDetails({required Object name}) => 'Voir ${name}';
}

// Path: dashboard.transactions
class _AppStringsDashboardTransactionsFr extends AppStringsDashboardTransactionsEn {
	_AppStringsDashboardTransactionsFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Transactions récentes';
	@override String get subtitle => 'Les 5 dernières';
	@override String get empty => 'Rien de récent';
	@override String get emptySubtitle => 'Tes dépenses apparaîtront ici';
	@override String more({required Object n}) => '+${n} de plus';
}

// Path: dashboard.widgets
class _AppStringsDashboardWidgetsFr extends AppStringsDashboardWidgetsEn {
	_AppStringsDashboardWidgetsFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override late final _AppStringsDashboardWidgetsBalanceFr balance = _AppStringsDashboardWidgetsBalanceFr._(_root);
	@override late final _AppStringsDashboardWidgetsQuickActionsFr quickActions = _AppStringsDashboardWidgetsQuickActionsFr._(_root);
	@override late final _AppStringsDashboardWidgetsWalletsFr wallets = _AppStringsDashboardWidgetsWalletsFr._(_root);
	@override late final _AppStringsDashboardWidgetsLoansFr loans = _AppStringsDashboardWidgetsLoansFr._(_root);
	@override late final _AppStringsDashboardWidgetsTransactionsFr transactions = _AppStringsDashboardWidgetsTransactionsFr._(_root);
	@override late final _AppStringsDashboardWidgetsCategoryBreakdownFr categoryBreakdown = _AppStringsDashboardWidgetsCategoryBreakdownFr._(_root);
	@override late final _AppStringsDashboardWidgetsChartAccountsFr chartAccounts = _AppStringsDashboardWidgetsChartAccountsFr._(_root);
	@override late final _AppStringsDashboardWidgetsCreditCardsFr creditCards = _AppStringsDashboardWidgetsCreditCardsFr._(_root);
	@override late final _AppStringsDashboardWidgetsSettingsFr settings = _AppStringsDashboardWidgetsSettingsFr._(_root);
}

// Path: wallets.empty
class _AppStringsWalletsEmptyFr extends AppStringsWalletsEmptyEn {
	_AppStringsWalletsEmptyFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Aucun compte';
	@override String get message => 'Ajoute ton premier compte pour démarrer.';
	@override String get action => 'Créer un compte';
}

// Path: wallets.emptyArchived
class _AppStringsWalletsEmptyArchivedFr extends AppStringsWalletsEmptyArchivedEn {
	_AppStringsWalletsEmptyArchivedFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Aucun compte archivé';
	@override String get message => 'Les archives s\'afficheront ici.';
}

// Path: wallets.filter
class _AppStringsWalletsFilterFr extends AppStringsWalletsFilterEn {
	_AppStringsWalletsFilterFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get active => 'Actifs';
	@override String get archived => 'Archivés';
	@override String get all => 'Tous';
}

// Path: wallets.form
class _AppStringsWalletsFormFr extends AppStringsWalletsFormEn {
	_AppStringsWalletsFormFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get newTitle => 'Nouveau';
	@override String get editTitle => 'Modifier';
	@override String get name => 'Nom du compte';
	@override String get namePlaceholder => 'Ex: Banque, Espèces';
	@override String get nameRequired => 'Nom requis';
	@override String get description => 'Description (optionnel)';
	@override String get descriptionPlaceholder => 'À quoi sert ce compte ?';
	@override String get currency => 'Devise';
	@override String get currencyLockedByParent => 'Devise héritée du parent';
	@override String get parent => 'Compte parent (optionnel)';
	@override String get parentEmpty => 'Aucun parent dispo';
	@override String get chartAccount => 'Plan comptable';
	@override String get chartAccountLocked => 'Verrouillé';
	@override String get createSuccess => 'Créé avec succès';
	@override String get updateSuccess => 'Modifié avec succès';
	@override String loadParentError({required Object error}) => 'Erreur: ${error}';
	@override String loadChartAccountError({required Object error}) => 'Erreur: ${error}';
}

// Path: wallets.delete
class _AppStringsWalletsDeleteFr extends AppStringsWalletsDeleteEn {
	_AppStringsWalletsDeleteFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get dialogTitle => 'Supprimer';
	@override String dialogMessage({required Object name}) => 'Sûr de supprimer ${name} ?';
	@override String get cancel => 'Annuler';
	@override String get confirm => 'Oui';
	@override String get success => 'Supprimé';
	@override String error({required Object error}) => 'Erreur: ${error}';
}

// Path: wallets.errors
class _AppStringsWalletsErrorsFr extends AppStringsWalletsErrorsEn {
	_AppStringsWalletsErrorsFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get load => 'Erreur de chargement';
	@override String get retry => 'Réessayer';
	@override String comingSoon({required Object name}) => '${name} bientôt';
}

// Path: wallets.subtitle
class _AppStringsWalletsSubtitleFr extends AppStringsWalletsSubtitleEn {
	_AppStringsWalletsSubtitleFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get mainAccount => 'Compte principal';
	@override String get cashDigital => 'Espèces & digital';
	@override String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} compte',
		other: '${n} comptes',
	);
	@override String get account => 'Compte';
	@override String get physicalCash => 'Argent liquide';
	@override String get digitalWallet => 'Digital';
}

// Path: wallets.options
class _AppStringsWalletsOptionsFr extends AppStringsWalletsOptionsEn {
	_AppStringsWalletsOptionsFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get viewTransactions => 'Voir les transactions';
	@override String get viewTransactionsSubtitle => 'Afficher l\'historique';
	@override String get transferFunds => 'Faire un virement';
	@override String get transferFundsSubtitle => 'Déplacer de l\'argent';
	@override String get editWallet => 'Modifier';
	@override String get editWalletSubtitle => 'Changer le nom ou la couleur';
	@override String get duplicateWallet => 'Dupliquer';
	@override String get duplicateWalletSubtitle => 'Copier ce compte';
	@override String get archiveWallet => 'Archiver';
	@override String get archiveWalletSubtitle => 'Cacher ce compte';
	@override String get unarchiveWallet => 'Désarchiver';
	@override String get unarchiveWalletSubtitle => 'Remettre';
	@override String get deleteWallet => 'Supprimer';
	@override String get deleteWalletSubtitle => 'Effacer définitivement';
	@override String get defaultTitle => 'Compte';
}

// Path: loans.filter
class _AppStringsLoansFilterFr extends AppStringsLoansFilterEn {
	_AppStringsLoansFilterFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get active => 'En cours';
	@override String get history => 'Histo';
	@override String get all => 'Tout';
	@override String get pending => 'En attente';
	@override String get lent => 'Prêtés';
	@override String get borrowed => 'Empruntés';
}

// Path: loans.summary
class _AppStringsLoansSummaryFr extends AppStringsLoansSummaryEn {
	_AppStringsLoansSummaryFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get netBalance => 'SOLDE NET';
	@override String get activeLoans => 'EN COURS';
	@override String get noActive => 'Tout est propre';
	@override String lent({required Object n}) => '${n} prêtés';
	@override String borrowed({required Object n}) => '${n} dus';
	@override String pending({required Object n}) => '${n} en attente';
}

// Path: loans.card
class _AppStringsLoansCardFr extends AppStringsLoansCardEn {
	_AppStringsLoansCardFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get lent => 'À recevoir';
	@override String get borrowed => 'À payer';
	@override String active({required Object n}) => '${n} en cours';
	@override String multiple({required Object n}) => '${n} prêts';
	@override String transactions({required Object n}) => '${n} act.';
	@override String overdue({required Object n}) => 'Retard de ${n} j';
	@override String due({required Object date}) => 'Pour le ${date}';
}

// Path: loans.form
class _AppStringsLoansFormFr extends AppStringsLoansFormEn {
	_AppStringsLoansFormFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get newTitle => 'Nouveau';
	@override String get editTitle => 'Modifier';
	@override String get type => 'Type';
	@override String get lend => 'J\'ai prêté';
	@override String get borrow => 'J\'ai emprunté';
	@override String get contact => 'À qui ?';
	@override String get contactPlaceholder => 'Choisir';
	@override String get account => 'Depuis le compte';
	@override String get accountPlaceholder => 'Choisir';
	@override String get amount => 'Montant';
	@override String get description => 'Motif';
	@override String get date => 'Date';
	@override String get dueDate => 'À rendre le';
	@override String get selectDate => 'Choisir';
	@override String get optional => '(Optionnel)';
	@override String get createTransaction => 'Enregistrer sur mon compte';
	@override String get recordAutomatically => 'Créer la transaction';
	@override String get transactionCategory => 'Catégorie';
	@override String get category => 'Catégorie';
	@override String get categoryPlaceholder => 'Choisir';
	@override String get save => 'Valider';
	@override String get successCreate => 'Enregistré !';
	@override String get successUpdate => 'Mis à jour';
	@override String get contactRequired => 'Contact requis';
	@override String get accountRequired => 'Compte requis';
	@override String get amountRequired => 'Montant requis';
}

// Path: loans.detail
class _AppStringsLoansDetailFr extends AppStringsLoansDetailEn {
	_AppStringsLoansDetailFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Détails';
	@override String get deleteTitle => 'Supprimer';
	@override String get deleteMessage => 'Sûr de vouloir effacer ça ?';
	@override String get deleteSuccess => 'Effacé';
	@override String deleteError({required Object error}) => 'Erreur: ${error}';
	@override String get notFound => 'Introuvable';
	@override String get progress => 'Avancement';
	@override String get info => 'Infos';
	@override String get pay => 'Payer / Recevoir';
	@override String get viewHistory => 'Historique complet';
	@override String original({required Object amount}) => 'Base: ${amount}';
	@override String get section => 'Détails';
	@override String get activeSummary => 'Résumé';
	@override String get activeLent => 'À récupérer';
	@override String get activeBorrowed => 'À rembourser';
	@override String get activeNet => 'Solde Net';
	@override String get activeTotal => 'Total';
	@override String get startDate => 'Début';
	@override String get dueDate => 'Date limite';
	@override late final _AppStringsLoansDetailTypeFr type = _AppStringsLoansDetailTypeFr._(_root);
	@override late final _AppStringsLoansDetailPaymentFr payment = _AppStringsLoansDetailPaymentFr._(_root);
}

// Path: loans.history
class _AppStringsLoansHistoryFr extends AppStringsLoansHistoryEn {
	_AppStringsLoansHistoryFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Historique';
	@override String get section => 'Tout voir';
	@override String get totalLoaned => 'Total global';
	@override String get noLoans => 'Rien trouvé.';
	@override late final _AppStringsLoansHistoryFilterFr filter = _AppStringsLoansHistoryFilterFr._(_root);
	@override late final _AppStringsLoansHistoryHeadersFr headers = _AppStringsLoansHistoryHeadersFr._(_root);
	@override late final _AppStringsLoansHistoryItemFr item = _AppStringsLoansHistoryItemFr._(_root);
	@override late final _AppStringsLoansHistorySummaryFr summary = _AppStringsLoansHistorySummaryFr._(_root);
}

// Path: loans.contactDetail
class _AppStringsLoansContactDetailFr extends AppStringsLoansContactDetailEn {
	_AppStringsLoansContactDetailFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String titleWith({required Object name}) => 'Prêts avec ${name}';
}

// Path: loans.share
class _AppStringsLoansShareFr extends AppStringsLoansShareEn {
	_AppStringsLoansShareFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Partager';
	@override String get contactTitle => 'Bilan global';
	@override String get button => 'Envoyer';
	@override String get copy => 'Copier';
	@override String get message => 'Voici notre bilan :';
	@override String contactMessage({required Object name}) => 'Bilan avec ${name} :';
	@override String error({required Object error}) => 'Erreur: ${error}';
	@override String get contactCopied => 'Copié !';
	@override String activeLoans({required Object n}) => 'En cours (${n}):';
	@override String loanItem({required Object description, required Object amount, required Object date, required Object percent}) => '• ${description}: ${amount} (${date}) - ${percent}% payé';
	@override String get loanStatement => 'MoneyT - Relevé';
	@override String get loanSummary => 'MoneyT - Bilan';
	@override String get personalLoan => 'Prêt Perso';
	@override String remaining({required Object amount}) => 'Reste : ${amount}';
	@override String get remainingLabel => 'Restant';
	@override String original({required Object amount}) => 'sur ${amount}';
	@override String progress({required Object percent}) => 'Avancée : ${percent}%';
	@override String get progressLabel => 'Avancée';
	@override String get paidSuffix => 'Réglé';
	@override String date({required Object date}) => 'Date : ${date}';
	@override String get dateLabel => 'Date';
	@override String contact({required Object name}) => 'Avec : ${name}';
	@override String get contactLabel => 'Contact';
	@override String generated({required Object date}) => 'Généré le ${date}';
	@override String generatedLabel({required Object date}) => 'Généré le ${date}';
	@override String totalActive({required Object n}) => 'Total en cours : ${n}';
	@override String get active => 'en cours';
	@override String get poweredBy => 'Via MoneyT • moneyt.io';
	@override String get copied => 'Copié !';
	@override String netBalance({required Object amount, required Object status}) => 'Solde Net : ${amount} (${status})';
	@override String get netBalanceLabel => 'Solde Net';
	@override String get owed => 'On te doit';
	@override String get owe => 'Tu dois';
	@override String lent({required Object amount}) => 'Prêté : ${amount}';
	@override String get lentLabel => 'Tu as prêté';
	@override String borrowed({required Object amount}) => 'Emprunté : ${amount}';
	@override String get borrowedLabel => 'Tu as emprunté';
	@override String contactSummary({required Object name}) => 'Bilan - ${name}';
}

// Path: loans.payment
class _AppStringsLoansPaymentFr extends AppStringsLoansPaymentEn {
	_AppStringsLoansPaymentFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Régler';
	@override String get amount => 'Montant';
	@override String get amountPlaceholder => '0.00';
	@override String get amountRequired => 'Montant requis';
	@override String get invalidAmount => 'Montant invalide';
	@override String get exceedsBalance => 'Ça dépasse le reste à payer';
	@override String get date => 'Date';
	@override String get account => 'Sur quel compte ?';
	@override String get selectAccount => 'Choisir';
	@override String get details => 'Détails (Optionnel)';
	@override String get detailsPlaceholder => 'Notes...';
	@override String get success => 'Paiement validé';
	@override String error({required Object error}) => 'Erreur: ${error}';
	@override String get errorAmount => 'Montant invalide';
	@override String get errorAccount => 'Choisis un compte';
	@override String errorLoading({required Object error}) => 'Erreur: ${error}';
	@override late final _AppStringsLoansPaymentSummaryFr summary = _AppStringsLoansPaymentSummaryFr._(_root);
	@override late final _AppStringsLoansPaymentQuickFr quick = _AppStringsLoansPaymentQuickFr._(_root);
}

// Path: loans.item
class _AppStringsLoansItemFr extends AppStringsLoansItemEn {
	_AppStringsLoansItemFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String due({required Object date}) => 'Pour: ${date}';
	@override String paidAmount({required Object amount}) => 'Réglé: ${amount}';
	@override String remaining({required Object amount}) => 'Reste: ${amount}';
	@override String percentPaid({required Object percent}) => '${percent}% réglé';
}

// Path: loans.section
class _AppStringsLoansSectionFr extends AppStringsLoansSectionEn {
	_AppStringsLoansSectionFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get activeLoans => 'En Cours';
	@override String loansCount({required Object n}) => '${n} prêts';
}

// Path: loans.empty
class _AppStringsLoansEmptyFr extends AppStringsLoansEmptyEn {
	_AppStringsLoansEmptyFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Aucun prêt';
	@override String get message => 'Note ici ce qu\'on te doit ou ce que tu dois.';
	@override String get action => 'Ajouter';
}

// Path: categories.form
class _AppStringsCategoriesFormFr extends AppStringsCategoriesFormEn {
	_AppStringsCategoriesFormFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get newTitle => 'Nouvelle Cat.';
	@override String get editTitle => 'Modifier';
	@override String get name => 'Nom';
	@override String get namePlaceholder => 'Ex: Courses, Loyer, Sorties';
	@override String get nameRequired => 'Il faut un nom';
	@override String get parent => 'Sous-catégorie de ? (Optionnel)';
	@override String get noParent => 'Catégorie principale';
	@override String get asSubcategory => 'Sera une sous-catégorie';
	@override String get asRoot => 'Sera principale';
	@override String get active => 'Active';
	@override String get activeDescription => 'Visible pour les nouvelles dépenses';
	@override String get selectIcon => 'Choisir l\'icône';
	@override String get selectColor => 'Choisir la couleur';
	@override String get saveSuccess => 'C\'est bon !';
	@override String saveError({required Object error}) => 'Oups : ${error}';
}

// Path: categories.parentSelection
class _AppStringsCategoriesParentSelectionFr extends AppStringsCategoriesParentSelectionEn {
	_AppStringsCategoriesParentSelectionFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Choisir le parent';
	@override String get subtitle => 'Pour la grouper';
	@override String get noParent => 'Principale';
}

// Path: categories.report
class _AppStringsCategoriesReportFr extends AppStringsCategoriesReportEn {
	_AppStringsCategoriesReportFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Bilan Avancé';
	@override String get timeFilter => 'Période';
	@override String get thisMonth => 'Ce Mois';
	@override String get lastMonth => 'Mois Dernier';
	@override String get thisYear => 'Cette Année';
	@override String get allTime => 'Toujours';
	@override String get details => 'Détails';
	@override String get noTransactions => 'Rien à signaler';
	@override String get income => 'L\'argent qui rentre';
	@override String get expense => 'L\'argent qui sort';
}

// Path: backups.menu
class _AppStringsBackupsMenuFr extends AppStringsBackupsMenuEn {
	_AppStringsBackupsMenuFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get settings => 'Paramètres';
	@override String get comingSoon => 'Bientôt';
}

// Path: backups.filters
class _AppStringsBackupsFiltersFr extends AppStringsBackupsFiltersEn {
	_AppStringsBackupsFiltersFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get all => 'Tout';
	@override String get auto => 'Auto';
	@override String get manual => 'Manuel';
	@override String get thisMonth => 'Mois-ci';
	@override String get lastMonth => 'Mois avant';
	@override String get thisYear => 'Année';
	@override String get lastYear => 'An. avant';
}

// Path: backups.status
class _AppStringsBackupsStatusFr extends AppStringsBackupsStatusEn {
	_AppStringsBackupsStatusFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get loading => 'Chargement...';
	@override String get error => 'Erreur';
	@override String get empty => 'Aucune sauvegarde';
	@override String get emptyAction => 'Crées-en une avec le bouton +';
	@override String get success => 'Succès';
	@override String get created => 'Données protégées !';
	@override String createError({required Object error}) => 'Erreur: ${error}';
	@override String restoreError({required Object error}) => 'Erreur: ${error}';
	@override String deleteError({required Object error}) => 'Erreur: ${error}';
}

// Path: backups.actions
class _AppStringsBackupsActionsFr extends AppStringsBackupsActionsEn {
	_AppStringsBackupsActionsFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get create => 'Créer';
	@override String get import => 'Importer';
	@override String get restore => 'Restaurer';
	@override String get delete => 'Supprimer';
	@override String get share => 'Partager';
	@override String get cancel => 'Annuler';
	@override String get retry => 'Réessayer';
	@override String get ok => 'OK';
}

// Path: backups.dialogs
class _AppStringsBackupsDialogsFr extends AppStringsBackupsDialogsEn {
	_AppStringsBackupsDialogsFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override late final _AppStringsBackupsDialogsInfoFr info = _AppStringsBackupsDialogsInfoFr._(_root);
	@override late final _AppStringsBackupsDialogsRestoreFr restore = _AppStringsBackupsDialogsRestoreFr._(_root);
	@override late final _AppStringsBackupsDialogsDeleteFr delete = _AppStringsBackupsDialogsDeleteFr._(_root);
}

// Path: backups.stats
class _AppStringsBackupsStatsFr extends AppStringsBackupsStatsEn {
	_AppStringsBackupsStatsFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Statistiques';
	@override String get totalBackups => 'Total';
	@override String get totalSize => 'Poids';
	@override String get oldest => 'Plus vieille';
	@override String get latest => 'Dernière';
	@override String get autoBackupStatus => 'Sauvegarde Auto';
	@override String get active => 'Activé';
	@override String get inactive => 'Désactivé';
}

// Path: backups.options
class _AppStringsBackupsOptionsFr extends AppStringsBackupsOptionsEn {
	_AppStringsBackupsOptionsFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override late final _AppStringsBackupsOptionsRestoreFr restore = _AppStringsBackupsOptionsRestoreFr._(_root);
	@override late final _AppStringsBackupsOptionsShareFr share = _AppStringsBackupsOptionsShareFr._(_root);
	@override late final _AppStringsBackupsOptionsDeleteFr delete = _AppStringsBackupsOptionsDeleteFr._(_root);
	@override String get latestBadge => 'Dernière';
	@override String get latestFile => 'Le plus récent';
	@override String get backupFile => 'Fichier de save';
}

// Path: backups.format
class _AppStringsBackupsFormatFr extends AppStringsBackupsFormatEn {
	_AppStringsBackupsFormatFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String auto({required Object date}) => 'Auto - ${date}';
	@override String manual({required Object date}) => 'Manuel - ${date}';
	@override String get initial => 'Premier backup';
	@override String generic({required Object date}) => 'Backup - ${date}';
}

// Path: v2.voice
class _AppStringsV2VoiceFr extends AppStringsV2VoiceEn {
	_AppStringsV2VoiceFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get errorProcessing => 'Rien compris. Tu peux répéter ?';
	@override String get tapMicrophone => 'Appuie sur le micro pour me parler';
	@override String get listening => 'Je t\'écoute...';
	@override String get missingApiKey => 'Il manque la clé GEMINI_API_KEY dans le .env !';
	@override String aiError({required Object error}) => 'Erreur IA: ${error}';
	@override String get cancel => 'Laisse tomber';
	@override String get scan => 'Scanner';
}

// Path: v2.transactions
class _AppStringsV2TransactionsFr extends AppStringsV2TransactionsEn {
	_AppStringsV2TransactionsFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get invalidAmount => 'Mets un vrai montant.';
	@override String get selectAccount => 'Choisis de quel compte ça sort.';
	@override String get selectCategory => 'C\'est quelle catégorie ?';
	@override String errorCreatingCategory({required Object error}) => 'Erreur catégorie: ${error}';
	@override String error({required Object error}) => 'Oups: ${error}';
	@override String get more => 'Plus';
	@override String get expense => 'Dépense';
	@override String get income => 'Entrée';
	@override String get deleteTransaction => 'On efface ça ?';
	@override String get cancel => 'Annuler';
	@override String get delete => 'Virer';
	@override String get yesterday => 'Hier';
	@override String get usedCategories => 'TES HABITUDES';
	@override String get noTransactions => 'Rien de noté';
	@override String get recentActivity => 'Derniers trucs';
	@override String get searchTransaction => 'Chercher une dépense...';
	@override String get date => 'Quand';
	@override String get wallet => 'D\'où';
	@override String get transactionDeleted => 'C\'est supprimé.';
	@override String get selectCategoryTitle => 'C\'est quoi ça ?';
	@override String get searchCategory => 'Chercher la catégorie...';
	@override String get noCategoriesAvailable => 'Aucune catégorie';
	@override String get createNewCategory => 'Créer de zéro';
	@override String get amount => 'MONTANT';
	@override String get description => 'C\'ÉTAIT POUR...';
	@override String get category => 'CATÉGORIE';
	@override String get addNote => 'Une note (facultatif)...';
	@override String get today => 'Aujourd\'hui';
	@override String get editTransaction => 'Modifier le truc';
	@override String get newTransaction => 'Nouveau Mouvement';
	@override String get selectWallet => 'Choisis le compte';
	@override String get save => 'Enregistrer';
	@override String get transactionUpdated => 'C\'est mis à jour.';
	@override String get transactionSaved => 'C\'est dans la boîte.';
}

// Path: v2.settings
class _AppStringsV2SettingsFr extends AppStringsV2SettingsEn {
	_AppStringsV2SettingsFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Personnaliser';
	@override String get categories => 'Catégories';
	@override String get wallets => 'Tes Comptes';
	@override String get language => 'Langue';
	@override String get currency => 'Devise';
	@override String get contact => 'Contact';
	@override String get legacyView => 'Ancienne Vue (V1)';
	@override String get deleteCategory => 'Effacer la catégorie ?';
	@override String get deleteWallet => 'Effacer le compte ?';
	@override String get cannotUndo => 'T\'es sûr ? Tu pourras pas revenir en arrière.';
	@override String get deleteWalletWarning => 'Attention, tu vas perdre toutes les dépenses liées.';
	@override String deleteError({required Object error}) => 'Oups : ${error}';
	@override String get noCategoriesCreated => 'Aucune catégorie.\nIl faut en créer une.';
	@override String get noWalletsCreated => 'T\'as pas de compte.\nCommence par ça.';
	@override String get walletDeleted => 'Compte effacé.';
	@override String get cancel => 'Annuler';
	@override String get delete => 'Poubelle';
	@override String get expenses => 'Dépenses';
	@override String get income => 'Revenus';
	@override String get newWallet => 'Nouveau Compte';
	@override String get editWallet => 'Modifier Compte';
	@override String get walletName => 'Nom du compte';
	@override String get saveWallet => 'Sauvegarder';
	@override String get deleteWalletHasTransactions => 'Impossible de supprimer ce portefeuille car il contient des transactions existantes.';
}

// Path: v2.dashboard
class _AppStringsV2DashboardFr extends AppStringsV2DashboardEn {
	_AppStringsV2DashboardFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get greetingMorning => 'Salut boss !';
	@override String get totalBalance => 'LA THUNE GLOBALE';
	@override late final _AppStringsV2DashboardDateFiltersFr dateFilters = _AppStringsV2DashboardDateFiltersFr._(_root);
	@override late final _AppStringsV2DashboardWalletFiltersFr walletFilters = _AppStringsV2DashboardWalletFiltersFr._(_root);
	@override late final _AppStringsV2DashboardBackgroundFr background = _AppStringsV2DashboardBackgroundFr._(_root);
	@override late final _AppStringsV2DashboardIncomeExpenseFr incomeExpense = _AppStringsV2DashboardIncomeExpenseFr._(_root);
	@override late final _AppStringsV2DashboardGaugeFr gauge = _AppStringsV2DashboardGaugeFr._(_root);
	@override late final _AppStringsV2DashboardActivityListFr activityList = _AppStringsV2DashboardActivityListFr._(_root);
}

// Path: v2.categories
class _AppStringsV2CategoriesFr extends AppStringsV2CategoriesEn {
	_AppStringsV2CategoriesFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Catégories';
	@override String get searchPlaceholder => 'Rechercher...';
	@override String get newCategory => 'Nouvelle';
	@override String get editCategory => 'Modifier';
	@override String get noCategories => 'Vide de chez vide';
	@override late final _AppStringsV2CategoriesFormFr form = _AppStringsV2CategoriesFormFr._(_root);
}

// Path: v2.onboarding
class _AppStringsV2OnboardingFr extends AppStringsV2OnboardingEn {
	_AppStringsV2OnboardingFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override late final _AppStringsV2OnboardingButtonsFr buttons = _AppStringsV2OnboardingButtonsFr._(_root);
	@override late final _AppStringsV2OnboardingSplashFr splash = _AppStringsV2OnboardingSplashFr._(_root);
	@override late final _AppStringsV2OnboardingExpenseCategoriesFr expenseCategories = _AppStringsV2OnboardingExpenseCategoriesFr._(_root);
	@override late final _AppStringsV2OnboardingFinancialGoalsFr financialGoals = _AppStringsV2OnboardingFinancialGoalsFr._(_root);
	@override late final _AppStringsV2OnboardingRegistrationMethodFr registrationMethod = _AppStringsV2OnboardingRegistrationMethodFr._(_root);
	@override late final _AppStringsV2OnboardingAiAnalysisFr aiAnalysis = _AppStringsV2OnboardingAiAnalysisFr._(_root);
	@override late final _AppStringsV2OnboardingMainPriorityFr mainPriority = _AppStringsV2OnboardingMainPriorityFr._(_root);
	@override late final _AppStringsV2OnboardingAiVoiceFr aiVoice = _AppStringsV2OnboardingAiVoiceFr._(_root);
}

// Path: v2.dateSelection
class _AppStringsV2DateSelectionFr extends AppStringsV2DateSelectionEn {
	_AppStringsV2DateSelectionFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get days => 'Jours';
	@override String get months => 'Mois';
	@override String get years => 'Années';
}

// Path: transactions.filter.ranges
class _AppStringsTransactionsFilterRangesFr extends AppStringsTransactionsFilterRangesEn {
	_AppStringsTransactionsFilterRangesFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get thisMonth => 'Ce mois';
	@override String get lastMonth => 'Mois dernier';
	@override String get thisYear => 'Cette année';
	@override String get lastYear => 'L\'an dernier';
}

// Path: transactions.filter.subtitles
class _AppStringsTransactionsFilterSubtitlesFr extends AppStringsTransactionsFilterSubtitlesEn {
	_AppStringsTransactionsFilterSubtitlesFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get income => 'Argent reçu';
	@override String get expense => 'Argent dépensé';
	@override String get transfer => 'Argent déplacé';
}

// Path: transactions.share.receipt
class _AppStringsTransactionsShareReceiptFr extends AppStringsTransactionsShareReceiptEn {
	_AppStringsTransactionsShareReceiptFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => '--- Détails ---';
	@override String amount({required Object amount}) => 'Montant : ${amount}';
	@override String description({required Object description}) => 'Description : ${description}';
	@override String category({required Object category}) => 'Catégorie : ${category}';
	@override String date({required Object date}) => 'Date : ${date}';
	@override String time({required Object time}) => 'Heure : ${time}';
	@override String wallet({required Object wallet}) => 'Compte : ${wallet}';
	@override String contact({required Object contact}) => 'Contact : ${contact}';
	@override String id({required Object id}) => 'ID : ${id}';
	@override String get separator => '--------------------------';
}

// Path: onboarding.specificProblem.options
class _AppStringsOnboardingSpecificProblemOptionsFr extends AppStringsOnboardingSpecificProblemOptionsEn {
	_AppStringsOnboardingSpecificProblemOptionsFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get debts => 'Les dettes et prêts';
	@override String get savings => 'Impossible de mettre de côté';
	@override String get unknown => 'Je sais pas où ça part';
	@override String get chaos => 'C\'est le chaos total';
}

// Path: onboarding.personalGoal.options
class _AppStringsOnboardingPersonalGoalOptionsFr extends AppStringsOnboardingPersonalGoalOptionsEn {
	_AppStringsOnboardingPersonalGoalOptionsFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get debtFree => 'Sortir du rouge';
	@override String get saveTrip => 'Épargner pour un projet';
	@override String get invest => 'Commencer à investir';
	@override String get peace => 'La tranquillité financière';
}

// Path: onboarding.solutionPreview.benefits
class _AppStringsOnboardingSolutionPreviewBenefitsFr extends AppStringsOnboardingSolutionPreviewBenefitsEn {
	_AppStringsOnboardingSolutionPreviewBenefitsFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get visualize => 'Suis tes dépenses en live';
	@override String get goals => 'Atteins tes objectifs';
	@override String get smart => 'Prends des décisions malines';
}

// Path: onboarding.currentMethod.options
class _AppStringsOnboardingCurrentMethodOptionsFr extends AppStringsOnboardingCurrentMethodOptionsEn {
	_AppStringsOnboardingCurrentMethodOptionsFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get excel => 'Excel / Tableurs';
	@override String get notebook => 'Petit carnet';
	@override String get mental => 'De tête (au pif)';
	@override String get none => 'Je gère rien du tout';
}

// Path: onboarding.featuresShowcase.features
class _AppStringsOnboardingFeaturesShowcaseFeaturesFr extends AppStringsOnboardingFeaturesShowcaseFeaturesEn {
	_AppStringsOnboardingFeaturesShowcaseFeaturesFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get income => 'Revenus';
	@override String get expense => 'Dépenses';
	@override String get transfer => 'Virements';
	@override String get loans => 'Prêts';
	@override String get goals => 'Objectifs';
	@override String get budgets => 'Budgets';
	@override String get investments => 'Investissements';
	@override String get cloud => 'Cloud MoneyT';
	@override String get openBanking => 'Open Banking';
}

// Path: onboarding.complete.stats
class _AppStringsOnboardingCompleteStatsFr extends AppStringsOnboardingCompleteStatsEn {
	_AppStringsOnboardingCompleteStatsFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Probabilité de succès';
	@override String get before => 'Avant MoneyT';
	@override String get after => 'Avec MoneyT';
}

// Path: dashboard.widgets.balance
class _AppStringsDashboardWidgetsBalanceFr extends AppStringsDashboardWidgetsBalanceEn {
	_AppStringsDashboardWidgetsBalanceFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Solde';
	@override String get description => 'Statut général';
}

// Path: dashboard.widgets.quickActions
class _AppStringsDashboardWidgetsQuickActionsFr extends AppStringsDashboardWidgetsQuickActionsEn {
	_AppStringsDashboardWidgetsQuickActionsFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Actions rapides';
	@override String get description => 'Raccourcis';
}

// Path: dashboard.widgets.wallets
class _AppStringsDashboardWidgetsWalletsFr extends AppStringsDashboardWidgetsWalletsEn {
	_AppStringsDashboardWidgetsWalletsFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Portefeuilles';
	@override String get description => 'Vue des comptes';
}

// Path: dashboard.widgets.loans
class _AppStringsDashboardWidgetsLoansFr extends AppStringsDashboardWidgetsLoansEn {
	_AppStringsDashboardWidgetsLoansFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Prêts';
	@override String get description => 'Prêts et emprunts';
}

// Path: dashboard.widgets.transactions
class _AppStringsDashboardWidgetsTransactionsFr extends AppStringsDashboardWidgetsTransactionsEn {
	_AppStringsDashboardWidgetsTransactionsFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Transactions';
	@override String get description => 'Activité récente';
}

// Path: dashboard.widgets.categoryBreakdown
class _AppStringsDashboardWidgetsCategoryBreakdownFr extends AppStringsDashboardWidgetsCategoryBreakdownEn {
	_AppStringsDashboardWidgetsCategoryBreakdownFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Par catégorie';
	@override String get description => 'Dépenses du mois';
	@override String get empty_message => 'Rien ce mois-ci.';
	@override String get others => 'Autres';
	@override String get back => 'Retour';
	@override String get monthlyBudget => 'Budget mensuel';
	@override String leftover({required Object amount}) => 'Il te reste ${amount}.';
	@override String exceeded({required Object amount}) => 'T\'as dépassé de ${amount}.';
	@override String noIncome({required Object amount}) => 'Dépenses : ${amount} (Sans revenu)';
}

// Path: dashboard.widgets.chartAccounts
class _AppStringsDashboardWidgetsChartAccountsFr extends AppStringsDashboardWidgetsChartAccountsEn {
	_AppStringsDashboardWidgetsChartAccountsFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Plan comptable';
	@override String get description => 'Structure';
}

// Path: dashboard.widgets.creditCards
class _AppStringsDashboardWidgetsCreditCardsFr extends AppStringsDashboardWidgetsCreditCardsEn {
	_AppStringsDashboardWidgetsCreditCardsFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Cartes';
	@override String get description => 'Limites et dettes';
}

// Path: dashboard.widgets.settings
class _AppStringsDashboardWidgetsSettingsFr extends AppStringsDashboardWidgetsSettingsEn {
	_AppStringsDashboardWidgetsSettingsFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Layout';
	@override String get subtitle => 'Organise tes widgets.';
	@override late final _AppStringsDashboardWidgetsSettingsResetFr reset = _AppStringsDashboardWidgetsSettingsResetFr._(_root);
	@override String get saveSuccess => 'Enregistré !';
	@override String saveError({required Object error}) => 'Erreur : ${error}';
	@override String get saving => 'Sauvegarde...';
	@override String get save => 'Sauvegarder';
}

// Path: loans.detail.type
class _AppStringsLoansDetailTypeFr extends AppStringsLoansDetailTypeEn {
	_AppStringsLoansDetailTypeFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get label => 'Type';
	@override String get personal => 'Prêt perso';
	@override String get borrowed => 'Dette';
	@override String get auto => 'Crédit auto';
	@override String get mortgage => 'Prêt immo';
	@override String get student => 'Prêt étudiant';
}

// Path: loans.detail.payment
class _AppStringsLoansDetailPaymentFr extends AppStringsLoansDetailPaymentEn {
	_AppStringsLoansDetailPaymentFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get history => 'Paiements';
	@override String date({required Object date}) => 'Le ${date}';
	@override String transactionId({required Object id}) => 'ID: ${id}';
	@override String paid({required Object amount}) => '${amount} réglé';
	@override String remaining({required Object amount}) => 'Reste ${amount}';
}

// Path: loans.history.filter
class _AppStringsLoansHistoryFilterFr extends AppStringsLoansHistoryFilterEn {
	_AppStringsLoansHistoryFilterFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get all => 'Tout';
	@override String get lent => 'Prêtés';
	@override String get borrowed => 'Dus';
	@override String get completed => 'Clôturés';
	@override String get title => 'Filtres';
	@override String get reset => 'Zéro';
	@override String get apply => 'Appliquer';
	@override String get dateRange => 'Période';
	@override String get amountRange => 'Montant';
	@override String get startDate => 'Du';
	@override String get endDate => 'Au';
	@override String get select => 'Choisir';
}

// Path: loans.history.headers
class _AppStringsLoansHistoryHeadersFr extends AppStringsLoansHistoryHeadersEn {
	_AppStringsLoansHistoryHeadersFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get lent => 'Argent Prêté';
	@override String get borrowed => 'Argent Emprunté';
	@override String get completed => 'Remboursés';
	@override String get active => 'En Cours';
	@override String get cancelled => 'Annulés';
	@override String get writtenOff => 'Pertes';
}

// Path: loans.history.item
class _AppStringsLoansHistoryItemFr extends AppStringsLoansHistoryItemEn {
	_AppStringsLoansHistoryItemFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get defaultTitle => 'Prêt';
	@override String date({required Object date}) => 'Date: ${date}';
	@override String get lent => 'Prêté';
	@override String get borrowed => 'Dû';
	@override late final _AppStringsLoansHistoryItemStatusFr status = _AppStringsLoansHistoryItemStatusFr._(_root);
}

// Path: loans.history.summary
class _AppStringsLoansHistorySummaryFr extends AppStringsLoansHistorySummaryEn {
	_AppStringsLoansHistorySummaryFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Bilan';
	@override String get viewDetails => 'Détails';
	@override String get hideDetails => 'Cacher';
	@override String get outstandingLent => 'On te doit';
	@override String get outstandingBorrowed => 'Tu dois';
	@override String get netPosition => 'Bilan net';
	@override String get totalLent => 'Total prêté à vie';
	@override String get totalBorrowed => 'Total emprunté à vie';
	@override String get totalRepaidToYou => 'Remboursé à toi';
	@override String get totalYouRepaid => 'Tu as remboursé';
	@override String get totalLoans => 'Total de prêts';
	@override String get completedLoans => 'Clôturés';
}

// Path: loans.payment.summary
class _AppStringsLoansPaymentSummaryFr extends AppStringsLoansPaymentSummaryEn {
	_AppStringsLoansPaymentSummaryFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Résumé';
	@override String get defaultTitle => 'Prêt';
	@override String get amount => 'Montant du règlement';
	@override String get remaining => 'Reste';
	@override String get progress => 'Nouveau solde';
	@override String description({required Object loan, required Object contact}) => '${loan} à ${contact}';
	@override String get unknownContact => 'Inconnu';
	@override String total({required Object amount}) => '${amount} total';
	@override String paid({required Object amount}) => 'Réglé: ${amount}';
	@override String remainingLabel({required Object amount}) => 'Reste: ${amount}';
}

// Path: loans.payment.quick
class _AppStringsLoansPaymentQuickFr extends AppStringsLoansPaymentQuickEn {
	_AppStringsLoansPaymentQuickFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String full({required Object amount}) => 'Payer tout (${amount})';
	@override String half({required Object amount}) => 'Moitié (${amount})';
}

// Path: backups.dialogs.info
class _AppStringsBackupsDialogsInfoFr extends AppStringsBackupsDialogsInfoEn {
	_AppStringsBackupsDialogsInfoFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Infos';
	@override String get file => 'Fichier:';
	@override String get size => 'Taille:';
	@override String get created => 'Date:';
	@override String get transactions => 'Transacs:';
}

// Path: backups.dialogs.restore
class _AppStringsBackupsDialogsRestoreFr extends AppStringsBackupsDialogsRestoreEn {
	_AppStringsBackupsDialogsRestoreFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Restaurer';
	@override String content({required Object file}) => 'Sûr de vouloir restaurer "${file}" ? Ça va remplacer les données actuelles.';
	@override String get success => 'Restauration... L\'app va redémarrer.';
}

// Path: backups.dialogs.delete
class _AppStringsBackupsDialogsDeleteFr extends AppStringsBackupsDialogsDeleteEn {
	_AppStringsBackupsDialogsDeleteFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Supprimer';
	@override String content({required Object file}) => 'Sûr d\'effacer "${file}" ? Irréversible.';
	@override String get success => 'Sauvegarde supprimée.';
}

// Path: backups.options.restore
class _AppStringsBackupsOptionsRestoreFr extends AppStringsBackupsOptionsRestoreEn {
	_AppStringsBackupsOptionsRestoreFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Restaurer';
	@override String get subtitle => 'Remplacer par cette version';
}

// Path: backups.options.share
class _AppStringsBackupsOptionsShareFr extends AppStringsBackupsOptionsShareEn {
	_AppStringsBackupsOptionsShareFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Partager';
	@override String get subtitle => 'Envoyer ailleurs';
}

// Path: backups.options.delete
class _AppStringsBackupsOptionsDeleteFr extends AppStringsBackupsOptionsDeleteEn {
	_AppStringsBackupsOptionsDeleteFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Supprimer';
	@override String get subtitle => 'C\'est définitif';
}

// Path: v2.dashboard.dateFilters
class _AppStringsV2DashboardDateFiltersFr extends AppStringsV2DashboardDateFiltersEn {
	_AppStringsV2DashboardDateFiltersFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get thisMonth => 'Ce mois-ci';
	@override String get lastMonth => 'Le mois dernier';
	@override String get customRange => 'Dates au choix...';
}

// Path: v2.dashboard.walletFilters
class _AppStringsV2DashboardWalletFiltersFr extends AppStringsV2DashboardWalletFiltersEn {
	_AppStringsV2DashboardWalletFiltersFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get all => 'Tout';
	@override String get allWallets => 'Tous tes comptes';
}

// Path: v2.dashboard.background
class _AppStringsV2DashboardBackgroundFr extends AppStringsV2DashboardBackgroundEn {
	_AppStringsV2DashboardBackgroundFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Fond d\'écran focus';
	@override String get chooseFromGallery => 'Prendre de la galerie';
	@override String get restoreDefault => 'Remettre par défaut';
}

// Path: v2.dashboard.incomeExpense
class _AppStringsV2DashboardIncomeExpenseFr extends AppStringsV2DashboardIncomeExpenseEn {
	_AppStringsV2DashboardIncomeExpenseFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get income => 'REVENUS';
	@override String get expenses => 'DÉPENSES';
}

// Path: v2.dashboard.gauge
class _AppStringsV2DashboardGaugeFr extends AppStringsV2DashboardGaugeEn {
	_AppStringsV2DashboardGaugeFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get exceeded => 'DÉPASSÉ';
	@override String get spent => 'DÉPENSÉ';
	@override String get available => 'DISPO';
	@override String get overdrawn => 'À DÉCOUVERT';
}

// Path: v2.dashboard.activityList
class _AppStringsV2DashboardActivityListFr extends AppStringsV2DashboardActivityListEn {
	_AppStringsV2DashboardActivityListFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get seeAll => 'Voir tout';
	@override String get newUi => 'Nouvelle UI';
	@override String get expensesByCategory => 'Où part ton fric';
	@override String get noRecentExpenses => 'Rien dépensé. Bravo !';
	@override String percentOfTotal({required Object percent}) => '${percent}% du total';
	@override String topExpenses({required Object count}) => 'Top ${count} des dépenses';
	@override String get others => 'Le Reste';
}

// Path: v2.categories.form
class _AppStringsV2CategoriesFormFr extends AppStringsV2CategoriesFormEn {
	_AppStringsV2CategoriesFormFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get nameLabel => 'Nom de la catégorie';
	@override String get save => 'Enregistrer';
}

// Path: v2.onboarding.buttons
class _AppStringsV2OnboardingButtonsFr extends AppStringsV2OnboardingButtonsEn {
	_AppStringsV2OnboardingButtonsFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get start => 'C\'est parti !';
	@override String get actionContinue => 'On continue';
	@override String get great => 'Super !';
	@override String get setGoal => 'Fixer un but';
	@override String get skip => 'Zapper';
}

// Path: v2.onboarding.splash
class _AppStringsV2OnboardingSplashFr extends AppStringsV2OnboardingSplashEn {
	_AppStringsV2OnboardingSplashFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title1 => 'Et si l\'Intelligence\nArtificielle (IA) ';
	@override String get title2 => 'gérait ton argent\nmieux que toi ?';
	@override String get benefit1 => 'Zéro effort.';
	@override String get benefit2 => 'Hyper clair.';
	@override String get benefit3 => 'De meilleurs choix.';
}

// Path: v2.onboarding.expenseCategories
class _AppStringsV2OnboardingExpenseCategoriesFr extends AppStringsV2OnboardingExpenseCategoriesEn {
	_AppStringsV2OnboardingExpenseCategoriesFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title1 => 'Qu\'est-ce qui te bouffe tout ton fric ?';
	@override String get subtitle => 'Choisis jusqu\'à 3 trucs';
	@override String get diningOut => 'Manger dehors';
	@override String get cravings => 'Les petits creux';
	@override String get subscriptions => 'Les abonnements zappés';
	@override String get outings => 'Les soirées';
	@override String get shopping => 'Les achats impulsifs';
	@override String get delivery => 'Les UberEats & co';
}

// Path: v2.onboarding.financialGoals
class _AppStringsV2OnboardingFinancialGoalsFr extends AppStringsV2OnboardingFinancialGoalsEn {
	_AppStringsV2OnboardingFinancialGoalsFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Qu\'est-ce qui changerait\ntes finances d\'un coup ?';
	@override String get subtitle => 'Choisis-en un';
	@override String get trackMoney => 'Savoir où part exactement mon salaire';
	@override String get spendLess => 'Arrêter d\'acheter des trucs inutiles';
	@override String get lessStress => 'Arrêter de stresser pour l\'argent';
	@override String get saveMoney => 'Réussir à épargner pour de vrai';
}

// Path: v2.onboarding.registrationMethod
class _AppStringsV2OnboardingRegistrationMethodFr extends AppStringsV2OnboardingRegistrationMethodEn {
	_AppStringsV2OnboardingRegistrationMethodFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tu préfères noter\ntes dépenses comment ?';
	@override String get subtitle => 'Choisis ta méthode';
	@override String get voice => 'Juste en parlant au tél';
	@override String get auto => 'Automatique par la banque';
	@override String get write => 'Taper comme à l\'ancienne';
	@override String get easy => 'Peu importe, le plus rapide possible';
}

// Path: v2.onboarding.aiAnalysis
class _AppStringsV2OnboardingAiAnalysisFr extends AppStringsV2OnboardingAiAnalysisEn {
	_AppStringsV2OnboardingAiAnalysisFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override late final _AppStringsV2OnboardingAiAnalysisLoadingFr loading = _AppStringsV2OnboardingAiAnalysisLoadingFr._(_root);
	@override late final _AppStringsV2OnboardingAiAnalysisShowcaseFr showcase = _AppStringsV2OnboardingAiAnalysisShowcaseFr._(_root);
}

// Path: v2.onboarding.mainPriority
class _AppStringsV2OnboardingMainPriorityFr extends AppStringsV2OnboardingMainPriorityEn {
	_AppStringsV2OnboardingMainPriorityFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'C\'est quoi ta\npriorité numéro 1 ?';
	@override String get subtitle => 'Choisis où MoneyT va te sauver la vie';
	@override String get breakHabits => 'Casser mes mauvaises habitudes';
	@override String get stopStress => 'Arrêter de stresser fin du mois';
	@override String get buildFuture => 'Me bâtir un avenir solide';
	@override String get feelControl => 'Savoir exactement où j\'en suis';
	@override String get saveGoal => 'Mettre de côté pour un objectif';
}

// Path: v2.onboarding.aiVoice
class _AppStringsV2OnboardingAiVoiceFr extends AppStringsV2OnboardingAiVoiceEn {
	_AppStringsV2OnboardingAiVoiceFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override late final _AppStringsV2OnboardingAiVoiceTitleFr title = _AppStringsV2OnboardingAiVoiceTitleFr._(_root);
	@override String get subtitle => 'T\'as juste à lui parler, elle s\'occupe de noter tes dépenses toute seule';
	@override String get listening => 'Parle, je t\'écoute...';
	@override List<String> get examples => [
		'Café 3,50 €',
		'Uber 12,00 €',
		'Ciné 15,00 €',
		'Courses 45,20 €',
		'Essence 30,00 €',
		'Netflix 10,99 €',
		'Dîner 25,00 €',
		'Pharmacie 18,50 €',
	];
}

// Path: dashboard.widgets.settings.reset
class _AppStringsDashboardWidgetsSettingsResetFr extends AppStringsDashboardWidgetsSettingsResetEn {
	_AppStringsDashboardWidgetsSettingsResetFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get button => 'Réinitialiser';
	@override String get dialogTitle => 'Par défaut';
	@override String get dialogContent => 'Remettre comme avant ?';
	@override String get cancel => 'Annuler';
	@override String get confirm => 'Oui';
	@override String get success => 'Réinitialisé';
}

// Path: loans.history.item.status
class _AppStringsLoansHistoryItemStatusFr extends AppStringsLoansHistoryItemStatusEn {
	_AppStringsLoansHistoryItemStatusFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get completed => 'Clos';
	@override String get active => 'En cours';
	@override String get cancelled => 'Annulé';
	@override String get writtenOff => 'Perdu';
}

// Path: v2.onboarding.aiAnalysis.loading
class _AppStringsV2OnboardingAiAnalysisLoadingFr extends AppStringsV2OnboardingAiAnalysisLoadingEn {
	_AppStringsV2OnboardingAiAnalysisLoadingFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'JE RÈGLE L\'APP POUR\nTOI LÀ...';
	@override String get subtitle => 'Analyse en cours';
	@override List<String> get messages => [
		'Je regarde comment tu dépenses...',
		'Je prépare tes catégories...',
		'Je cherche où ça coince...',
		'Je te prépare une stratégie de dingue...',
	];
}

// Path: v2.onboarding.aiAnalysis.showcase
class _AppStringsV2OnboardingAiAnalysisShowcaseFr extends AppStringsV2OnboardingAiAnalysisShowcaseEn {
	_AppStringsV2OnboardingAiAnalysisShowcaseFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Analyse finie. Boom.';
	@override late final _AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextFr dynamicText = _AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextFr._(_root);
	@override late final _AppStringsV2OnboardingAiAnalysisShowcaseResultFr result = _AppStringsV2OnboardingAiAnalysisShowcaseResultFr._(_root);
}

// Path: v2.onboarding.aiVoice.title
class _AppStringsV2OnboardingAiVoiceTitleFr extends AppStringsV2OnboardingAiVoiceTitleEn {
	_AppStringsV2OnboardingAiVoiceTitleFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get kDefault => 'Atteindre ton objectif';
	@override String get breakHabits => 'Casser enfin tes vieilles habitudes';
	@override String get stopStress => 'Retrouver la paix d\'esprit';
	@override String get buildFuture => 'Bâtir un bel avenir financier';
	@override String get feelControl => 'Reprendre le contrôle total';
	@override String get saveGoal => 'Atteindre ton objectif d\'épargne';
	@override String get suffix => ' sera un jeu d\'enfant grâce à notre IA.';
}

// Path: v2.onboarding.aiAnalysis.showcase.dynamicText
class _AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextFr extends AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextEn {
	_AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get kDefault => 'Tes dépenses mangent ton budget. Clairement ta méthode actuelle marche plus.';
	@override String get part2 => ' bouffent une grosse partie, et le fait que tu veuilles ';
	@override String get part3 => ' prouve qu\'il faut changer de méthode.';
	@override late final _AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextCategoriesFr categories = _AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextCategoriesFr._(_root);
	@override late final _AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextIntentionsFr intentions = _AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextIntentionsFr._(_root);
}

// Path: v2.onboarding.aiAnalysis.showcase.result
class _AppStringsV2OnboardingAiAnalysisShowcaseResultFr extends AppStringsV2OnboardingAiAnalysisShowcaseResultEn {
	_AppStringsV2OnboardingAiAnalysisShowcaseResultFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get yourResult => 'Ton résultat';
	@override String get average => 'Moyenne';
	@override String get messagePart1 => 'Tu dépenses 68% ';
	@override String get messagePart2 => 'de plus que la moyenne là-dedans, et ça ';
	@override String get messagePart3 => 'détruit complètement\n';
	@override String get messagePart4 => 'tes objectifs à moyen terme';
}

// Path: v2.onboarding.aiAnalysis.showcase.dynamicText.categories
class _AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextCategoriesFr extends AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextCategoriesEn {
	_AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextCategoriesFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get diningOut => 'Les restos';
	@override String get cravings => 'Les fringales';
	@override String get subscriptions => 'Les abos';
	@override String get outings => 'Les soirées';
	@override String get shopping => 'Le shopping impulsif';
	@override String get delivery => 'Les livraisons';
}

// Path: v2.onboarding.aiAnalysis.showcase.dynamicText.intentions
class _AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextIntentionsFr extends AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextIntentionsEn {
	_AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextIntentionsFr._(AppStringsFr root) : this._root = root, super.internal(root);

	final AppStringsFr _root; // ignore: unused_field

	// Translations
	@override String get trackMoney => 'savoir où va l\'argent';
	@override String get spendLess => 'dépenser moins';
	@override String get lessStress => 'stresser moins';
	@override String get saveMoney => 'enfin épargner';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on AppStringsFr {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'app.name': return 'MoneyT';
			case 'app.description': return 'Gestionnaire Financier';
			case 'common.save': return 'Enregistrer';
			case 'common.cancel': return 'Annuler';
			case 'common.delete': return 'Supprimer';
			case 'common.edit': return 'Modifier';
			case 'common.loading': return 'Chargement...';
			case 'common.error': return 'Erreur';
			case 'common.success': return 'Succès';
			case 'common.search': return 'Rechercher';
			case 'common.clearSearch': return 'Effacer la recherche';
			case 'common.viewAll': return 'Voir tout';
			case 'common.retry': return 'Réessayer';
			case 'common.add': return 'Ajouter';
			case 'common.remove': return 'Retirer';
			case 'common.moreOptions': return 'Plus d\'options';
			case 'common.addToFavorites': return 'Ajouter aux favoris';
			case 'common.removeFromFavorites': return 'Retirer des favoris';
			case 'common.today': return 'Aujourd\'hui';
			case 'common.yesterday': return 'Hier';
			case 'components.dateSelection.title': return 'Choisir la date';
			case 'components.dateSelection.subtitle': return 'Sélectionne la date';
			case 'components.dateSelection.selectedDate': return 'Date sélectionnée';
			case 'components.dateSelection.confirm': return 'Confirmer';
			case 'components.selection.cancel': return 'Annuler';
			case 'components.selection.confirm': return 'Confirmer';
			case 'components.selection.select': return 'Sélectionner';
			case 'components.contactSelection.title': return 'Sélectionner le contact';
			case 'components.contactSelection.subtitle': return 'Avec qui se fait la transaction';
			case 'components.contactSelection.searchPlaceholder': return 'Chercher un contact';
			case 'components.contactSelection.noContact': return 'Aucun contact';
			case 'components.contactSelection.noContactDetails': return 'Transaction sans contact';
			case 'components.contactSelection.allContacts': return 'Tous les contacts';
			case 'components.contactSelection.create': return 'Créer un contact';
			case 'components.categorySelection.title': return 'Choisir une catégorie';
			case 'components.categorySelection.subtitle': return 'Trouve la bonne catégorie';
			case 'components.categorySelection.searchPlaceholder': return 'Chercher...';
			case 'components.currencySelection.title': return 'Devise';
			case 'components.currencySelection.subtitle': return 'Choisis la monnaie';
			case 'components.currencySelection.searchPlaceholder': return 'Chercher...';
			case 'components.accountSelection.title': return 'Sélectionner le compte';
			case 'components.accountSelection.subtitle': return 'D\'où vient l\'argent';
			case 'components.accountSelection.searchPlaceholder': return 'Chercher un compte';
			case 'components.accountSelection.wallets': return 'Portefeuilles';
			case 'components.accountSelection.creditCards': return 'Cartes de Crédit';
			case 'components.accountSelection.selectAccount': return 'Choisir';
			case 'components.accountSelection.confirm': return 'Confirmer';
			case 'components.parentWalletSelection.title': return 'Portefeuille principal';
			case 'components.parentWalletSelection.subtitle': return 'Lier à un portefeuille parent';
			case 'components.parentWalletSelection.searchPlaceholder': return 'Chercher...';
			case 'components.parentWalletSelection.noParent': return 'Aucun parent';
			case 'components.parentWalletSelection.createRoot': return 'Créer comme principal';
			case 'components.parentWalletSelection.available': return 'Disponibles';
			case 'components.walletTypes.checking': return 'Compte Courant';
			case 'components.walletTypes.savings': return 'Épargne';
			case 'components.walletTypes.cash': return 'Espèces';
			case 'components.walletTypes.creditCard': return 'Carte de Crédit';
			case 'navigation.home': return 'Accueil';
			case 'navigation.transactions': return 'Transactions';
			case 'navigation.contacts': return 'Contacts';
			case 'navigation.settings': return 'Paramètres';
			case 'navigation.wallets': return 'Comptes';
			case 'navigation.categories': return 'Catégories';
			case 'navigation.loans': return 'Prêts';
			case 'navigation.charts': return 'Plan comptable';
			case 'navigation.backups': return 'Sauvegardes';
			case 'navigation.creditCards': return 'Cartes';
			case 'navigation.sections.operations': return 'OPÉRATIONS';
			case 'navigation.sections.financialTools': return 'OUTILS FINANCIERS';
			case 'navigation.sections.management': return 'GESTION';
			case 'navigation.sections.advanced': return 'AVANCÉ';
			case 'transactions.title': return 'Transactions';
			case 'transactions.types.all': return 'Tout';
			case 'transactions.types.income': return 'Revenu';
			case 'transactions.types.expense': return 'Dépense';
			case 'transactions.types.transfer': return 'Virement';
			case 'transactions.filter.title': return 'Filtres';
			case 'transactions.filter.date': return 'Date';
			case 'transactions.filter.categories': return 'Catégories';
			case 'transactions.filter.accounts': return 'Comptes';
			case 'transactions.filter.contacts': return 'Contacts';
			case 'transactions.filter.amount': return 'Montant';
			case 'transactions.filter.apply': return 'Appliquer';
			case 'transactions.filter.clear': return 'Effacer';
			case 'transactions.filter.add': return 'Ajouter filtre';
			case 'transactions.filter.minAmount': return 'Min';
			case 'transactions.filter.maxAmount': return 'Max';
			case 'transactions.filter.selectDate': return 'Date';
			case 'transactions.filter.selectCategory': return 'Catégorie';
			case 'transactions.filter.selectAccount': return 'Compte';
			case 'transactions.filter.selectContact': return 'Contact';
			case 'transactions.filter.quickFilters': return 'Filtres rapides';
			case 'transactions.filter.ranges.thisMonth': return 'Ce mois';
			case 'transactions.filter.ranges.lastMonth': return 'Mois dernier';
			case 'transactions.filter.ranges.thisYear': return 'Cette année';
			case 'transactions.filter.ranges.lastYear': return 'L\'an dernier';
			case 'transactions.filter.customRange': return 'Période personnalisée';
			case 'transactions.filter.startDate': return 'Début';
			case 'transactions.filter.endDate': return 'Fin';
			case 'transactions.filter.active': return 'Filtres actifs';
			case 'transactions.filter.subtitles.income': return 'Argent reçu';
			case 'transactions.filter.subtitles.expense': return 'Argent dépensé';
			case 'transactions.filter.subtitles.transfer': return 'Argent déplacé';
			case 'transactions.form.newTitle': return 'Nouvelle Transaction';
			case 'transactions.form.editTitle': return 'Modifier Transaction';
			case 'transactions.form.amount': return 'Montant';
			case 'transactions.form.type': return 'Type';
			case 'transactions.form.amountRequired': return 'Montant requis';
			case 'transactions.form.date': return 'Date';
			case 'transactions.form.account': return 'Compte';
			case 'transactions.form.toAccount': return 'Vers';
			case 'transactions.form.category': return 'Catégorie';
			case 'transactions.form.contact': return 'Contact';
			case 'transactions.form.contactOptional': return 'Contact (optionnel)';
			case 'transactions.form.description': return 'Description';
			case 'transactions.form.descriptionOptional': return 'Description (optionnelle)';
			case 'transactions.form.selectAccount': return 'Choisir le compte';
			case 'transactions.form.selectDestination': return 'Choisir la destination';
			case 'transactions.form.selectCategory': return 'Choisir la catégorie';
			case 'transactions.form.selectContact': return 'Choisir le contact';
			case 'transactions.form.saveSuccess': return 'Transaction enregistrée';
			case 'transactions.form.updateSuccess': return 'Transaction mise à jour';
			case 'transactions.form.saveError': return 'Erreur d\'enregistrement';
			case 'transactions.form.share': return 'Partager';
			case 'transactions.form.created': return 'Créée avec succès';
			case 'transactions.form.crossCurrencyConversion': return 'Conversion de devise';
			case 'transactions.form.receivedAmount': return 'Montant reçu';
			case 'transactions.form.exchangeRate': return 'Taux de change';
			case 'transactions.form.receivedAmountRequired': return 'Veuillez entrer le montant';
			case 'transactions.form.exchangeRateLabel': return ({required Object from, required Object rate, required Object to}) => '1 ${from} = ${rate} ${to}';
			case 'transactions.errors.load': return 'Erreur de chargement';
			case 'transactions.empty.title': return 'Rien à afficher';
			case 'transactions.empty.message': return 'Aucune transaction avec ces filtres';
			case 'transactions.empty.clearFilters': return 'Effacer les filtres';
			case 'transactions.list.count': return ({required Object n}) => '${n} transactions';
			case 'transactions.detail.title': return 'Détails';
			case 'transactions.detail.delete': return 'Supprimer';
			case 'transactions.detail.deleteConfirmation': return 'Tu es sûr ? Irréversible.';
			case 'transactions.detail.deleted': return 'Transaction supprimée';
			case 'transactions.detail.duplicate': return 'Dupliquer';
			case 'transactions.detail.duplicateNotImplemented': return 'Bientôt';
			case 'transactions.detail.edit': return 'Modifier';
			case 'transactions.detail.errorLoad': return 'Erreur';
			case 'transactions.detail.errorPrepareEdit': return ({required Object error}) => 'Erreur d\'édition: ${error}';
			case 'transactions.detail.errorDelete': return ({required Object error}) => 'Erreur de suppression: ${error}';
			case 'transactions.detail.category': return 'Catégorie';
			case 'transactions.detail.account': return 'Compte';
			case 'transactions.detail.contact': return 'Contact';
			case 'transactions.detail.description': return 'Description';
			case 'transactions.detail.transferDetails': return 'Virement';
			case 'transactions.detail.from': return 'De';
			case 'transactions.detail.to': return 'À';
			case 'transactions.detail.unknownAccount': return 'Inconnu';
			case 'transactions.detail.errorUrl': return ({required Object url}) => 'Impossible d\'ouvrir ${url}';
			case 'transactions.detail.date': return 'Date';
			case 'transactions.detail.time': return 'Heure';
			case 'transactions.detail.loanLinkedWarning': return 'Géré automatiquement via un prêt.';
			case 'transactions.share.title': return 'Partager';
			case 'transactions.share.copyText': return 'Copier';
			case 'transactions.share.shareButton': return 'Partager';
			case 'transactions.share.shareMessage': return 'Voici mon reçu :';
			case 'transactions.share.copied': return 'Copié dans le presse-papiers !';
			case 'transactions.share.paymentMethod': return 'Méthode';
			case 'transactions.share.receiptTitle': return 'Reçu';
			case 'transactions.share.poweredBy': return 'Via MoneyT • moneyt.io';
			case 'transactions.share.errorImage': return ({required Object error}) => 'Erreur: ${error}';
			case 'transactions.share.receipt.title': return '--- Détails ---';
			case 'transactions.share.receipt.amount': return ({required Object amount}) => 'Montant : ${amount}';
			case 'transactions.share.receipt.description': return ({required Object description}) => 'Description : ${description}';
			case 'transactions.share.receipt.category': return ({required Object category}) => 'Catégorie : ${category}';
			case 'transactions.share.receipt.date': return ({required Object date}) => 'Date : ${date}';
			case 'transactions.share.receipt.time': return ({required Object time}) => 'Heure : ${time}';
			case 'transactions.share.receipt.wallet': return ({required Object wallet}) => 'Compte : ${wallet}';
			case 'transactions.share.receipt.contact': return ({required Object contact}) => 'Contact : ${contact}';
			case 'transactions.share.receipt.id': return ({required Object id}) => 'ID : ${id}';
			case 'transactions.share.receipt.separator': return '--------------------------';
			case 'transactions.share.generatedOn': return ({required Object date}) => 'Généré le ${date}';
			case 'contacts.title': return 'Contacts';
			case 'contacts.addContact': return 'Nouveau';
			case 'contacts.editContact': return 'Modifier';
			case 'contacts.newContact': return 'Nouveau contact';
			case 'contacts.noContacts': return 'Aucun contact';
			case 'contacts.noContactsMessage': return 'Ajoute ton premier contact';
			case 'contacts.searchContacts': return 'Chercher';
			case 'contacts.deleteContact': return 'Supprimer';
			case 'contacts.confirmDelete': return 'Tu veux vraiment supprimer';
			case 'contacts.contactDeleted': return 'Contact supprimé';
			case 'contacts.errorDeleting': return 'Erreur';
			case 'contacts.noSearchResults': return 'Aucun résultat';
			case 'contacts.noContactsMatch': return ({required Object query}) => 'Personne avec "${query}".';
			case 'contacts.errorLoading': return 'Erreur de chargement';
			case 'contacts.contactSaved': return 'Contact enregistré';
			case 'contacts.errorSaving': return 'Erreur';
			case 'contacts.noContactInfo': return 'Aucune info';
			case 'contacts.importContact': return 'Importer';
			case 'contacts.importContacts': return 'Importer contacts';
			case 'contacts.importContactSoon': return 'Bientôt disponible';
			case 'contacts.fields.name': return 'Nom';
			case 'contacts.fields.fullName': return 'Nom complet';
			case 'contacts.fields.email': return 'E-mail';
			case 'contacts.fields.phone': return 'Téléphone';
			case 'contacts.fields.address': return 'Adresse';
			case 'contacts.fields.notes': return 'Notes';
			case 'contacts.placeholders.enterFullName': return 'Nom complet';
			case 'contacts.placeholders.enterPhone': return 'Numéro';
			case 'contacts.placeholders.enterEmail': return 'Adresse e-mail';
			case 'contacts.validation.nameRequired': return 'Le nom est requis';
			case 'contacts.validation.invalidEmail': return 'E-mail invalide';
			case 'contacts.validation.invalidPhone': return 'Numéro invalide';
			case 'errors.loadingAccounts': return ({required Object error}) => 'Erreur chargement : ${error}';
			case 'errors.unexpected': return 'Oups, erreur inattendue';
			case 'settings.title': return 'Paramètres';
			case 'settings.account.title': return 'Compte';
			case 'settings.account.profile': return 'Profil';
			case 'settings.account.profileSubtitle': return 'Gérer tes informations';
			case 'settings.appearance.title': return 'Préférences';
			case 'settings.appearance.darkMode': return 'Mode sombre';
			case 'settings.appearance.darkModeSubtitle': return 'Passer au thème sombre';
			case 'settings.appearance.language': return 'Langue';
			case 'settings.appearance.currency': return 'Devise principale';
			case 'settings.appearance.currencySubtitle': return 'Devise par défaut';
			case 'settings.appearance.darkTheme': return 'Sombre';
			case 'settings.appearance.lightTheme': return 'Clair';
			case 'settings.appearance.systemTheme': return 'Système';
			case 'settings.data.title': return 'Données';
			case 'settings.data.backup': return 'Sauvegardes';
			case 'settings.data.backupSubtitle': return 'Gère tes données';
			case 'settings.info.title': return 'Informations';
			case 'settings.info.contact': return 'Contact & Réseaux';
			case 'settings.info.contactSubtitle': return 'Rejoins la communauté';
			case 'settings.info.privacy': return 'Confidentialité';
			case 'settings.info.privacySubtitle': return 'Notre politique';
			case 'settings.info.share': return 'Partager MoneyT';
			case 'settings.info.shareSubtitle': return 'Fais tourner l\'app';
			case 'settings.logout.button': return 'Se déconnecter';
			case 'settings.logout.dialogTitle': return 'Déconnexion';
			case 'settings.logout.dialogMessage': return 'Es-tu sûr de vouloir te déconnecter ?';
			case 'settings.logout.cancel': return 'Annuler';
			case 'settings.logout.confirm': return 'Oui';
			case 'settings.social.title': return 'Contact & Réseaux';
			case 'settings.social.follow': return 'Suivre MoneyT';
			case 'settings.social.description': return 'Reste connecté avec la commu.';
			case 'settings.social.networks': return 'Réseaux Sociaux';
			case 'settings.social.github': return 'GitHub';
			case 'settings.social.githubSubtitle': return 'Voir le code';
			case 'settings.social.linkedin': return 'LinkedIn';
			case 'settings.social.linkedinSubtitle': return 'News pro';
			case 'settings.social.twitter': return 'X (Twitter)';
			case 'settings.social.twitterSubtitle': return 'News en direct';
			case 'settings.social.reddit': return 'Reddit';
			case 'settings.social.redditSubtitle': return 'Discussion';
			case 'settings.social.discord': return 'Discord';
			case 'settings.social.discordSubtitle': return 'Chat avec nous';
			case 'settings.social.contact': return 'Support';
			case 'settings.social.email': return 'Envoyer un e-mail';
			case 'settings.social.website': return 'Site Officiel';
			case 'settings.language.title': return 'Langue';
			case 'settings.language.available': return 'LANGUES DISPONIBLES';
			case 'settings.language.apply': return 'Appliquer';
			case 'settings.currency.title': return 'Devise par défaut';
			case 'settings.currency.available': return 'DEVISES DISPONIBLES';
			case 'settings.currency.apply': return 'Appliquer';
			case 'settings.messages.profileComingSoon': return 'Profil à venir';
			case 'settings.messages.privacyError': return 'Impossible d\'ouvrir';
			case 'settings.messages.logoutComingSoon': return 'Déconnexion à venir';
			case 'onboarding.welcome.title': return 'Bienvenue sur MoneyT 👋';
			case 'onboarding.welcome.subtitle': return 'Gère ton argent en 2 minutes ✨';
			case 'onboarding.problemStatement.title': return 'L\'argent te file entre les doigts ?';
			case 'onboarding.problemStatement.subtitle': return 'T\'es pas seul. 70% des gens ne savent pas où va leur salaire.';
			case 'onboarding.specificProblem.title': return 'C\'est quoi ta galère ?';
			case 'onboarding.specificProblem.options.debts': return 'Les dettes et prêts';
			case 'onboarding.specificProblem.options.savings': return 'Impossible de mettre de côté';
			case 'onboarding.specificProblem.options.unknown': return 'Je sais pas où ça part';
			case 'onboarding.specificProblem.options.chaos': return 'C\'est le chaos total';
			case 'onboarding.personalGoal.title': return 'C\'est quoi ton objectif ?';
			case 'onboarding.personalGoal.options.debtFree': return 'Sortir du rouge';
			case 'onboarding.personalGoal.options.saveTrip': return 'Épargner pour un projet';
			case 'onboarding.personalGoal.options.invest': return 'Commencer à investir';
			case 'onboarding.personalGoal.options.peace': return 'La tranquillité financière';
			case 'onboarding.solutionPreview.title': return 'MoneyT t\'éclaire';
			case 'onboarding.solutionPreview.subtitle': return 'Tout voir au même endroit. Adieu les tableurs ennuyeux.';
			case 'onboarding.solutionPreview.benefits.visualize': return 'Suis tes dépenses en live';
			case 'onboarding.solutionPreview.benefits.goals': return 'Atteins tes objectifs';
			case 'onboarding.solutionPreview.benefits.smart': return 'Prends des décisions malines';
			case 'onboarding.currentMethod.title': return 'Comment tu gères ton fric aujourd\'hui ?';
			case 'onboarding.currentMethod.subtitle': return 'Choisis ce qui te ressemble.';
			case 'onboarding.currentMethod.options.excel': return 'Excel / Tableurs';
			case 'onboarding.currentMethod.options.notebook': return 'Petit carnet';
			case 'onboarding.currentMethod.options.mental': return 'De tête (au pif)';
			case 'onboarding.currentMethod.options.none': return 'Je gère rien du tout';
			case 'onboarding.featuresShowcase.title': return 'Ce qui est là et ce qui arrive ✨';
			case 'onboarding.featuresShowcase.subtitle': return 'Le basique est là, la suite arrive lourd.';
			case 'onboarding.featuresShowcase.available': return 'MAINTENANT';
			case 'onboarding.featuresShowcase.comingSoon': return 'À VENIR';
			case 'onboarding.featuresShowcase.features.income': return 'Revenus';
			case 'onboarding.featuresShowcase.features.expense': return 'Dépenses';
			case 'onboarding.featuresShowcase.features.transfer': return 'Virements';
			case 'onboarding.featuresShowcase.features.loans': return 'Prêts';
			case 'onboarding.featuresShowcase.features.goals': return 'Objectifs';
			case 'onboarding.featuresShowcase.features.budgets': return 'Budgets';
			case 'onboarding.featuresShowcase.features.investments': return 'Investissements';
			case 'onboarding.featuresShowcase.features.cloud': return 'Cloud MoneyT';
			case 'onboarding.featuresShowcase.features.openBanking': return 'Open Banking';
			case 'onboarding.complete.title': return 'Prêt au décollage ! 🚀';
			case 'onboarding.complete.subtitle': return 'Note ta première dépense et vois la différence 📈';
			case 'onboarding.complete.stats.title': return 'Probabilité de succès';
			case 'onboarding.complete.stats.before': return 'Avant MoneyT';
			case 'onboarding.complete.stats.after': return 'Avec MoneyT';
			case 'onboarding.buttons.start': return 'C\'est parti 🚀';
			case 'onboarding.buttons.fixIt': return 'On règle ça ⚡';
			case 'onboarding.buttons.actionContinue': return 'Continuer';
			case 'onboarding.buttons.setGoal': return 'Fixer l\'objectif 🎯';
			case 'onboarding.buttons.wantControl': return 'Je veux ce contrôle !';
			case 'onboarding.buttons.great': return 'Super, montre-moi !';
			case 'onboarding.buttons.firstTransaction': return 'Ma première dépense ➕';
			case 'onboarding.buttons.skip': return 'Passer';
			case 'dashboard.greeting': return 'Bienvenue';
			case 'dashboard.balance.total': return 'SOLDE TOTAL';
			case 'dashboard.balance.income': return 'REVENUS';
			case 'dashboard.balance.expenses': return 'DÉPENSES';
			case 'dashboard.balance.thisMonth': return 'ce mois-ci';
			case 'dashboard.actions.income': return 'Revenu';
			case 'dashboard.actions.expense': return 'Dépense';
			case 'dashboard.actions.transfer': return 'Virement';
			case 'dashboard.actions.all': return 'Tout';
			case 'dashboard.wallets.title': return 'Portefeuilles';
			case 'dashboard.wallets.count': return ({required Object n}) => '${n} comptes';
			case 'dashboard.wallets.more': return ({required Object n}) => '+${n} comptes';
			case 'dashboard.wallets.viewDetails': return ({required Object name}) => 'Voir ${name}';
			case 'dashboard.transactions.title': return 'Transactions récentes';
			case 'dashboard.transactions.subtitle': return 'Les 5 dernières';
			case 'dashboard.transactions.empty': return 'Rien de récent';
			case 'dashboard.transactions.emptySubtitle': return 'Tes dépenses apparaîtront ici';
			case 'dashboard.transactions.more': return ({required Object n}) => '+${n} de plus';
			case 'dashboard.customize': return 'Personnaliser';
			case 'dashboard.widgets.balance.title': return 'Solde';
			case 'dashboard.widgets.balance.description': return 'Statut général';
			case 'dashboard.widgets.quickActions.title': return 'Actions rapides';
			case 'dashboard.widgets.quickActions.description': return 'Raccourcis';
			case 'dashboard.widgets.wallets.title': return 'Portefeuilles';
			case 'dashboard.widgets.wallets.description': return 'Vue des comptes';
			case 'dashboard.widgets.loans.title': return 'Prêts';
			case 'dashboard.widgets.loans.description': return 'Prêts et emprunts';
			case 'dashboard.widgets.transactions.title': return 'Transactions';
			case 'dashboard.widgets.transactions.description': return 'Activité récente';
			case 'dashboard.widgets.categoryBreakdown.title': return 'Par catégorie';
			case 'dashboard.widgets.categoryBreakdown.description': return 'Dépenses du mois';
			case 'dashboard.widgets.categoryBreakdown.empty_message': return 'Rien ce mois-ci.';
			case 'dashboard.widgets.categoryBreakdown.others': return 'Autres';
			case 'dashboard.widgets.categoryBreakdown.back': return 'Retour';
			case 'dashboard.widgets.categoryBreakdown.monthlyBudget': return 'Budget mensuel';
			case 'dashboard.widgets.categoryBreakdown.leftover': return ({required Object amount}) => 'Il te reste ${amount}.';
			case 'dashboard.widgets.categoryBreakdown.exceeded': return ({required Object amount}) => 'T\'as dépassé de ${amount}.';
			case 'dashboard.widgets.categoryBreakdown.noIncome': return ({required Object amount}) => 'Dépenses : ${amount} (Sans revenu)';
			case 'dashboard.widgets.chartAccounts.title': return 'Plan comptable';
			case 'dashboard.widgets.chartAccounts.description': return 'Structure';
			case 'dashboard.widgets.creditCards.title': return 'Cartes';
			case 'dashboard.widgets.creditCards.description': return 'Limites et dettes';
			case 'dashboard.widgets.settings.title': return 'Layout';
			case 'dashboard.widgets.settings.subtitle': return 'Organise tes widgets.';
			case 'dashboard.widgets.settings.reset.button': return 'Réinitialiser';
			case 'dashboard.widgets.settings.reset.dialogTitle': return 'Par défaut';
			case 'dashboard.widgets.settings.reset.dialogContent': return 'Remettre comme avant ?';
			case 'dashboard.widgets.settings.reset.cancel': return 'Annuler';
			case 'dashboard.widgets.settings.reset.confirm': return 'Oui';
			case 'dashboard.widgets.settings.reset.success': return 'Réinitialisé';
			case 'dashboard.widgets.settings.saveSuccess': return 'Enregistré !';
			case 'dashboard.widgets.settings.saveError': return ({required Object error}) => 'Erreur : ${error}';
			case 'dashboard.widgets.settings.saving': return 'Sauvegarde...';
			case 'dashboard.widgets.settings.save': return 'Sauvegarder';
			case 'wallets.title': return 'Comptes';
			case 'wallets.empty.title': return 'Aucun compte';
			case 'wallets.empty.message': return 'Ajoute ton premier compte pour démarrer.';
			case 'wallets.empty.action': return 'Créer un compte';
			case 'wallets.emptyArchived.title': return 'Aucun compte archivé';
			case 'wallets.emptyArchived.message': return 'Les archives s\'afficheront ici.';
			case 'wallets.filter.active': return 'Actifs';
			case 'wallets.filter.archived': return 'Archivés';
			case 'wallets.filter.all': return 'Tous';
			case 'wallets.form.newTitle': return 'Nouveau';
			case 'wallets.form.editTitle': return 'Modifier';
			case 'wallets.form.name': return 'Nom du compte';
			case 'wallets.form.namePlaceholder': return 'Ex: Banque, Espèces';
			case 'wallets.form.nameRequired': return 'Nom requis';
			case 'wallets.form.description': return 'Description (optionnel)';
			case 'wallets.form.descriptionPlaceholder': return 'À quoi sert ce compte ?';
			case 'wallets.form.currency': return 'Devise';
			case 'wallets.form.currencyLockedByParent': return 'Devise héritée du parent';
			case 'wallets.form.parent': return 'Compte parent (optionnel)';
			case 'wallets.form.parentEmpty': return 'Aucun parent dispo';
			case 'wallets.form.chartAccount': return 'Plan comptable';
			case 'wallets.form.chartAccountLocked': return 'Verrouillé';
			case 'wallets.form.createSuccess': return 'Créé avec succès';
			case 'wallets.form.updateSuccess': return 'Modifié avec succès';
			case 'wallets.form.loadParentError': return ({required Object error}) => 'Erreur: ${error}';
			case 'wallets.form.loadChartAccountError': return ({required Object error}) => 'Erreur: ${error}';
			case 'wallets.delete.dialogTitle': return 'Supprimer';
			case 'wallets.delete.dialogMessage': return ({required Object name}) => 'Sûr de supprimer ${name} ?';
			case 'wallets.delete.cancel': return 'Annuler';
			case 'wallets.delete.confirm': return 'Oui';
			case 'wallets.delete.success': return 'Supprimé';
			case 'wallets.delete.error': return ({required Object error}) => 'Erreur: ${error}';
			case 'wallets.errors.load': return 'Erreur de chargement';
			case 'wallets.errors.retry': return 'Réessayer';
			case 'wallets.errors.comingSoon': return ({required Object name}) => '${name} bientôt';
			case 'wallets.subtitle.mainAccount': return 'Compte principal';
			case 'wallets.subtitle.cashDigital': return 'Espèces & digital';
			case 'wallets.subtitle.count': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
				one: '${n} compte',
				other: '${n} comptes',
			);
			case 'wallets.subtitle.account': return 'Compte';
			case 'wallets.subtitle.physicalCash': return 'Argent liquide';
			case 'wallets.subtitle.digitalWallet': return 'Digital';
			case 'wallets.options.viewTransactions': return 'Voir les transactions';
			case 'wallets.options.viewTransactionsSubtitle': return 'Afficher l\'historique';
			case 'wallets.options.transferFunds': return 'Faire un virement';
			case 'wallets.options.transferFundsSubtitle': return 'Déplacer de l\'argent';
			case 'wallets.options.editWallet': return 'Modifier';
			case 'wallets.options.editWalletSubtitle': return 'Changer le nom ou la couleur';
			case 'wallets.options.duplicateWallet': return 'Dupliquer';
			case 'wallets.options.duplicateWalletSubtitle': return 'Copier ce compte';
			case 'wallets.options.archiveWallet': return 'Archiver';
			case 'wallets.options.archiveWalletSubtitle': return 'Cacher ce compte';
			case 'wallets.options.unarchiveWallet': return 'Désarchiver';
			case 'wallets.options.unarchiveWalletSubtitle': return 'Remettre';
			case 'wallets.options.deleteWallet': return 'Supprimer';
			case 'wallets.options.deleteWalletSubtitle': return 'Effacer définitivement';
			case 'wallets.options.defaultTitle': return 'Compte';
			case 'loans.title': return 'Prêts';
			case 'loans.filter.active': return 'En cours';
			case 'loans.filter.history': return 'Histo';
			case 'loans.filter.all': return 'Tout';
			case 'loans.filter.pending': return 'En attente';
			case 'loans.filter.lent': return 'Prêtés';
			case 'loans.filter.borrowed': return 'Empruntés';
			case 'loans.summary.netBalance': return 'SOLDE NET';
			case 'loans.summary.activeLoans': return 'EN COURS';
			case 'loans.summary.noActive': return 'Tout est propre';
			case 'loans.summary.lent': return ({required Object n}) => '${n} prêtés';
			case 'loans.summary.borrowed': return ({required Object n}) => '${n} dus';
			case 'loans.summary.pending': return ({required Object n}) => '${n} en attente';
			case 'loans.card.lent': return 'À recevoir';
			case 'loans.card.borrowed': return 'À payer';
			case 'loans.card.active': return ({required Object n}) => '${n} en cours';
			case 'loans.card.multiple': return ({required Object n}) => '${n} prêts';
			case 'loans.card.transactions': return ({required Object n}) => '${n} act.';
			case 'loans.card.overdue': return ({required Object n}) => 'Retard de ${n} j';
			case 'loans.card.due': return ({required Object date}) => 'Pour le ${date}';
			case 'loans.form.newTitle': return 'Nouveau';
			case 'loans.form.editTitle': return 'Modifier';
			case 'loans.form.type': return 'Type';
			case 'loans.form.lend': return 'J\'ai prêté';
			case 'loans.form.borrow': return 'J\'ai emprunté';
			case 'loans.form.contact': return 'À qui ?';
			case 'loans.form.contactPlaceholder': return 'Choisir';
			case 'loans.form.account': return 'Depuis le compte';
			case 'loans.form.accountPlaceholder': return 'Choisir';
			case 'loans.form.amount': return 'Montant';
			case 'loans.form.description': return 'Motif';
			case 'loans.form.date': return 'Date';
			case 'loans.form.dueDate': return 'À rendre le';
			case 'loans.form.selectDate': return 'Choisir';
			case 'loans.form.optional': return '(Optionnel)';
			case 'loans.form.createTransaction': return 'Enregistrer sur mon compte';
			case 'loans.form.recordAutomatically': return 'Créer la transaction';
			case 'loans.form.transactionCategory': return 'Catégorie';
			case 'loans.form.category': return 'Catégorie';
			case 'loans.form.categoryPlaceholder': return 'Choisir';
			case 'loans.form.save': return 'Valider';
			case 'loans.form.successCreate': return 'Enregistré !';
			case 'loans.form.successUpdate': return 'Mis à jour';
			case 'loans.form.contactRequired': return 'Contact requis';
			case 'loans.form.accountRequired': return 'Compte requis';
			case 'loans.form.amountRequired': return 'Montant requis';
			case 'loans.detail.title': return 'Détails';
			case 'loans.detail.deleteTitle': return 'Supprimer';
			case 'loans.detail.deleteMessage': return 'Sûr de vouloir effacer ça ?';
			case 'loans.detail.deleteSuccess': return 'Effacé';
			case 'loans.detail.deleteError': return ({required Object error}) => 'Erreur: ${error}';
			case 'loans.detail.notFound': return 'Introuvable';
			case 'loans.detail.progress': return 'Avancement';
			case 'loans.detail.info': return 'Infos';
			case 'loans.detail.pay': return 'Payer / Recevoir';
			case 'loans.detail.viewHistory': return 'Historique complet';
			case 'loans.detail.original': return ({required Object amount}) => 'Base: ${amount}';
			case 'loans.detail.section': return 'Détails';
			case 'loans.detail.activeSummary': return 'Résumé';
			case 'loans.detail.activeLent': return 'À récupérer';
			case 'loans.detail.activeBorrowed': return 'À rembourser';
			case 'loans.detail.activeNet': return 'Solde Net';
			case 'loans.detail.activeTotal': return 'Total';
			case 'loans.detail.startDate': return 'Début';
			case 'loans.detail.dueDate': return 'Date limite';
			case 'loans.detail.type.label': return 'Type';
			case 'loans.detail.type.personal': return 'Prêt perso';
			case 'loans.detail.type.borrowed': return 'Dette';
			case 'loans.detail.type.auto': return 'Crédit auto';
			case 'loans.detail.type.mortgage': return 'Prêt immo';
			case 'loans.detail.type.student': return 'Prêt étudiant';
			case 'loans.detail.payment.history': return 'Paiements';
			case 'loans.detail.payment.date': return ({required Object date}) => 'Le ${date}';
			case 'loans.detail.payment.transactionId': return ({required Object id}) => 'ID: ${id}';
			case 'loans.detail.payment.paid': return ({required Object amount}) => '${amount} réglé';
			case 'loans.detail.payment.remaining': return ({required Object amount}) => 'Reste ${amount}';
			case 'loans.history.title': return 'Historique';
			case 'loans.history.section': return 'Tout voir';
			case 'loans.history.totalLoaned': return 'Total global';
			case 'loans.history.noLoans': return 'Rien trouvé.';
			case 'loans.history.filter.all': return 'Tout';
			case 'loans.history.filter.lent': return 'Prêtés';
			case 'loans.history.filter.borrowed': return 'Dus';
			case 'loans.history.filter.completed': return 'Clôturés';
			case 'loans.history.filter.title': return 'Filtres';
			case 'loans.history.filter.reset': return 'Zéro';
			case 'loans.history.filter.apply': return 'Appliquer';
			case 'loans.history.filter.dateRange': return 'Période';
			case 'loans.history.filter.amountRange': return 'Montant';
			case 'loans.history.filter.startDate': return 'Du';
			case 'loans.history.filter.endDate': return 'Au';
			case 'loans.history.filter.select': return 'Choisir';
			case 'loans.history.headers.lent': return 'Argent Prêté';
			case 'loans.history.headers.borrowed': return 'Argent Emprunté';
			case 'loans.history.headers.completed': return 'Remboursés';
			case 'loans.history.headers.active': return 'En Cours';
			case 'loans.history.headers.cancelled': return 'Annulés';
			case 'loans.history.headers.writtenOff': return 'Pertes';
			case 'loans.history.item.defaultTitle': return 'Prêt';
			case 'loans.history.item.date': return ({required Object date}) => 'Date: ${date}';
			case 'loans.history.item.lent': return 'Prêté';
			case 'loans.history.item.borrowed': return 'Dû';
			case 'loans.history.item.status.completed': return 'Clos';
			case 'loans.history.item.status.active': return 'En cours';
			case 'loans.history.item.status.cancelled': return 'Annulé';
			case 'loans.history.item.status.writtenOff': return 'Perdu';
			case 'loans.history.summary.title': return 'Bilan';
			case 'loans.history.summary.viewDetails': return 'Détails';
			case 'loans.history.summary.hideDetails': return 'Cacher';
			case 'loans.history.summary.outstandingLent': return 'On te doit';
			case 'loans.history.summary.outstandingBorrowed': return 'Tu dois';
			case 'loans.history.summary.netPosition': return 'Bilan net';
			case 'loans.history.summary.totalLent': return 'Total prêté à vie';
			case 'loans.history.summary.totalBorrowed': return 'Total emprunté à vie';
			case 'loans.history.summary.totalRepaidToYou': return 'Remboursé à toi';
			case 'loans.history.summary.totalYouRepaid': return 'Tu as remboursé';
			case 'loans.history.summary.totalLoans': return 'Total de prêts';
			case 'loans.history.summary.completedLoans': return 'Clôturés';
			case 'loans.contactDetail.titleWith': return ({required Object name}) => 'Prêts avec ${name}';
			case 'loans.share.title': return 'Partager';
			case 'loans.share.contactTitle': return 'Bilan global';
			case 'loans.share.button': return 'Envoyer';
			case 'loans.share.copy': return 'Copier';
			case 'loans.share.message': return 'Voici notre bilan :';
			case 'loans.share.contactMessage': return ({required Object name}) => 'Bilan avec ${name} :';
			case 'loans.share.error': return ({required Object error}) => 'Erreur: ${error}';
			case 'loans.share.contactCopied': return 'Copié !';
			case 'loans.share.activeLoans': return ({required Object n}) => 'En cours (${n}):';
			case 'loans.share.loanItem': return ({required Object description, required Object amount, required Object date, required Object percent}) => '• ${description}: ${amount} (${date}) - ${percent}% payé';
			case 'loans.share.loanStatement': return 'MoneyT - Relevé';
			case 'loans.share.loanSummary': return 'MoneyT - Bilan';
			case 'loans.share.personalLoan': return 'Prêt Perso';
			case 'loans.share.remaining': return ({required Object amount}) => 'Reste : ${amount}';
			case 'loans.share.remainingLabel': return 'Restant';
			case 'loans.share.original': return ({required Object amount}) => 'sur ${amount}';
			case 'loans.share.progress': return ({required Object percent}) => 'Avancée : ${percent}%';
			case 'loans.share.progressLabel': return 'Avancée';
			case 'loans.share.paidSuffix': return 'Réglé';
			case 'loans.share.date': return ({required Object date}) => 'Date : ${date}';
			case 'loans.share.dateLabel': return 'Date';
			case 'loans.share.contact': return ({required Object name}) => 'Avec : ${name}';
			case 'loans.share.contactLabel': return 'Contact';
			case 'loans.share.generated': return ({required Object date}) => 'Généré le ${date}';
			case 'loans.share.generatedLabel': return ({required Object date}) => 'Généré le ${date}';
			case 'loans.share.totalActive': return ({required Object n}) => 'Total en cours : ${n}';
			case 'loans.share.active': return 'en cours';
			case 'loans.share.poweredBy': return 'Via MoneyT • moneyt.io';
			case 'loans.share.copied': return 'Copié !';
			case 'loans.share.netBalance': return ({required Object amount, required Object status}) => 'Solde Net : ${amount} (${status})';
			case 'loans.share.netBalanceLabel': return 'Solde Net';
			case 'loans.share.owed': return 'On te doit';
			case 'loans.share.owe': return 'Tu dois';
			case 'loans.share.lent': return ({required Object amount}) => 'Prêté : ${amount}';
			case 'loans.share.lentLabel': return 'Tu as prêté';
			case 'loans.share.borrowed': return ({required Object amount}) => 'Emprunté : ${amount}';
			case 'loans.share.borrowedLabel': return 'Tu as emprunté';
			case 'loans.share.contactSummary': return ({required Object name}) => 'Bilan - ${name}';
			case 'loans.payment.title': return 'Régler';
			case 'loans.payment.amount': return 'Montant';
			case 'loans.payment.amountPlaceholder': return '0.00';
			case 'loans.payment.amountRequired': return 'Montant requis';
			case 'loans.payment.invalidAmount': return 'Montant invalide';
			case 'loans.payment.exceedsBalance': return 'Ça dépasse le reste à payer';
			case 'loans.payment.date': return 'Date';
			case 'loans.payment.account': return 'Sur quel compte ?';
			case 'loans.payment.selectAccount': return 'Choisir';
			case 'loans.payment.details': return 'Détails (Optionnel)';
			case 'loans.payment.detailsPlaceholder': return 'Notes...';
			case 'loans.payment.success': return 'Paiement validé';
			case 'loans.payment.error': return ({required Object error}) => 'Erreur: ${error}';
			case 'loans.payment.errorAmount': return 'Montant invalide';
			case 'loans.payment.errorAccount': return 'Choisis un compte';
			case 'loans.payment.errorLoading': return ({required Object error}) => 'Erreur: ${error}';
			case 'loans.payment.summary.title': return 'Résumé';
			case 'loans.payment.summary.defaultTitle': return 'Prêt';
			case 'loans.payment.summary.amount': return 'Montant du règlement';
			case 'loans.payment.summary.remaining': return 'Reste';
			case 'loans.payment.summary.progress': return 'Nouveau solde';
			case 'loans.payment.summary.description': return ({required Object loan, required Object contact}) => '${loan} à ${contact}';
			case 'loans.payment.summary.unknownContact': return 'Inconnu';
			case 'loans.payment.summary.total': return ({required Object amount}) => '${amount} total';
			case 'loans.payment.summary.paid': return ({required Object amount}) => 'Réglé: ${amount}';
			case 'loans.payment.summary.remainingLabel': return ({required Object amount}) => 'Reste: ${amount}';
			case 'loans.payment.quick.full': return ({required Object amount}) => 'Payer tout (${amount})';
			case 'loans.payment.quick.half': return ({required Object amount}) => 'Moitié (${amount})';
			case 'loans.given': return 'J\'ai Prêté';
			case 'loans.received': return 'J\'ai Emprunté';
			case 'loans.item.due': return ({required Object date}) => 'Pour: ${date}';
			case 'loans.item.paidAmount': return ({required Object amount}) => 'Réglé: ${amount}';
			case 'loans.item.remaining': return ({required Object amount}) => 'Reste: ${amount}';
			case 'loans.item.percentPaid': return ({required Object percent}) => '${percent}% réglé';
			case 'loans.section.activeLoans': return 'En Cours';
			case 'loans.section.loansCount': return ({required Object n}) => '${n} prêts';
			case 'loans.empty.title': return 'Aucun prêt';
			case 'loans.empty.message': return 'Note ici ce qu\'on te doit ou ce que tu dois.';
			case 'loans.empty.action': return 'Ajouter';
			case 'categories.title': return 'Catégories';
			case 'categories.form.newTitle': return 'Nouvelle Cat.';
			case 'categories.form.editTitle': return 'Modifier';
			case 'categories.form.name': return 'Nom';
			case 'categories.form.namePlaceholder': return 'Ex: Courses, Loyer, Sorties';
			case 'categories.form.nameRequired': return 'Il faut un nom';
			case 'categories.form.parent': return 'Sous-catégorie de ? (Optionnel)';
			case 'categories.form.noParent': return 'Catégorie principale';
			case 'categories.form.asSubcategory': return 'Sera une sous-catégorie';
			case 'categories.form.asRoot': return 'Sera principale';
			case 'categories.form.active': return 'Active';
			case 'categories.form.activeDescription': return 'Visible pour les nouvelles dépenses';
			case 'categories.form.selectIcon': return 'Choisir l\'icône';
			case 'categories.form.selectColor': return 'Choisir la couleur';
			case 'categories.form.saveSuccess': return 'C\'est bon !';
			case 'categories.form.saveError': return ({required Object error}) => 'Oups : ${error}';
			case 'categories.parentSelection.title': return 'Choisir le parent';
			case 'categories.parentSelection.subtitle': return 'Pour la grouper';
			case 'categories.parentSelection.noParent': return 'Principale';
			case 'categories.incomeCategory': return 'Catégorie Revenu';
			case 'categories.expenseCategory': return 'Catégorie Dépense';
			case 'categories.report.title': return 'Bilan Avancé';
			case 'categories.report.timeFilter': return 'Période';
			case 'categories.report.thisMonth': return 'Ce Mois';
			case 'categories.report.lastMonth': return 'Mois Dernier';
			case 'categories.report.thisYear': return 'Cette Année';
			case 'categories.report.allTime': return 'Toujours';
			case 'categories.report.details': return 'Détails';
			case 'categories.report.noTransactions': return 'Rien à signaler';
			case 'categories.report.income': return 'L\'argent qui rentre';
			case 'categories.report.expense': return 'L\'argent qui sort';
			case 'backups.title': return 'Sauvegardes';
			case 'backups.menu.settings': return 'Paramètres';
			case 'backups.menu.comingSoon': return 'Bientôt';
			case 'backups.filters.all': return 'Tout';
			case 'backups.filters.auto': return 'Auto';
			case 'backups.filters.manual': return 'Manuel';
			case 'backups.filters.thisMonth': return 'Mois-ci';
			case 'backups.filters.lastMonth': return 'Mois avant';
			case 'backups.filters.thisYear': return 'Année';
			case 'backups.filters.lastYear': return 'An. avant';
			case 'backups.status.loading': return 'Chargement...';
			case 'backups.status.error': return 'Erreur';
			case 'backups.status.empty': return 'Aucune sauvegarde';
			case 'backups.status.emptyAction': return 'Crées-en une avec le bouton +';
			case 'backups.status.success': return 'Succès';
			case 'backups.status.created': return 'Données protégées !';
			case 'backups.status.createError': return ({required Object error}) => 'Erreur: ${error}';
			case 'backups.status.restoreError': return ({required Object error}) => 'Erreur: ${error}';
			case 'backups.status.deleteError': return ({required Object error}) => 'Erreur: ${error}';
			case 'backups.actions.create': return 'Créer';
			case 'backups.actions.import': return 'Importer';
			case 'backups.actions.restore': return 'Restaurer';
			case 'backups.actions.delete': return 'Supprimer';
			case 'backups.actions.share': return 'Partager';
			case 'backups.actions.cancel': return 'Annuler';
			case 'backups.actions.retry': return 'Réessayer';
			case 'backups.actions.ok': return 'OK';
			case 'backups.dialogs.info.title': return 'Infos';
			case 'backups.dialogs.info.file': return 'Fichier:';
			case 'backups.dialogs.info.size': return 'Taille:';
			case 'backups.dialogs.info.created': return 'Date:';
			case 'backups.dialogs.info.transactions': return 'Transacs:';
			case 'backups.dialogs.restore.title': return 'Restaurer';
			case 'backups.dialogs.restore.content': return ({required Object file}) => 'Sûr de vouloir restaurer "${file}" ? Ça va remplacer les données actuelles.';
			case 'backups.dialogs.restore.success': return 'Restauration... L\'app va redémarrer.';
			case 'backups.dialogs.delete.title': return 'Supprimer';
			case 'backups.dialogs.delete.content': return ({required Object file}) => 'Sûr d\'effacer "${file}" ? Irréversible.';
			case 'backups.dialogs.delete.success': return 'Sauvegarde supprimée.';
			case 'backups.stats.title': return 'Statistiques';
			case 'backups.stats.totalBackups': return 'Total';
			case 'backups.stats.totalSize': return 'Poids';
			case 'backups.stats.oldest': return 'Plus vieille';
			case 'backups.stats.latest': return 'Dernière';
			case 'backups.stats.autoBackupStatus': return 'Sauvegarde Auto';
			case 'backups.stats.active': return 'Activé';
			case 'backups.stats.inactive': return 'Désactivé';
			case 'backups.options.restore.title': return 'Restaurer';
			case 'backups.options.restore.subtitle': return 'Remplacer par cette version';
			case 'backups.options.share.title': return 'Partager';
			case 'backups.options.share.subtitle': return 'Envoyer ailleurs';
			case 'backups.options.delete.title': return 'Supprimer';
			case 'backups.options.delete.subtitle': return 'C\'est définitif';
			case 'backups.options.latestBadge': return 'Dernière';
			case 'backups.options.latestFile': return 'Le plus récent';
			case 'backups.options.backupFile': return 'Fichier de save';
			case 'backups.format.auto': return ({required Object date}) => 'Auto - ${date}';
			case 'backups.format.manual': return ({required Object date}) => 'Manuel - ${date}';
			case 'backups.format.initial': return 'Premier backup';
			case 'backups.format.generic': return ({required Object date}) => 'Backup - ${date}';
			case 'v2.voice.errorProcessing': return 'Rien compris. Tu peux répéter ?';
			case 'v2.voice.tapMicrophone': return 'Appuie sur le micro pour me parler';
			case 'v2.voice.listening': return 'Je t\'écoute...';
			case 'v2.voice.missingApiKey': return 'Il manque la clé GEMINI_API_KEY dans le .env !';
			case 'v2.voice.aiError': return ({required Object error}) => 'Erreur IA: ${error}';
			case 'v2.voice.cancel': return 'Laisse tomber';
			case 'v2.voice.scan': return 'Scanner';
			case 'v2.transactions.invalidAmount': return 'Mets un vrai montant.';
			case 'v2.transactions.selectAccount': return 'Choisis de quel compte ça sort.';
			case 'v2.transactions.selectCategory': return 'C\'est quelle catégorie ?';
			case 'v2.transactions.errorCreatingCategory': return ({required Object error}) => 'Erreur catégorie: ${error}';
			case 'v2.transactions.error': return ({required Object error}) => 'Oups: ${error}';
			case 'v2.transactions.more': return 'Plus';
			case 'v2.transactions.expense': return 'Dépense';
			case 'v2.transactions.income': return 'Entrée';
			case 'v2.transactions.deleteTransaction': return 'On efface ça ?';
			case 'v2.transactions.cancel': return 'Annuler';
			case 'v2.transactions.delete': return 'Virer';
			case 'v2.transactions.yesterday': return 'Hier';
			case 'v2.transactions.usedCategories': return 'TES HABITUDES';
			case 'v2.transactions.noTransactions': return 'Rien de noté';
			case 'v2.transactions.recentActivity': return 'Derniers trucs';
			case 'v2.transactions.searchTransaction': return 'Chercher une dépense...';
			case 'v2.transactions.date': return 'Quand';
			case 'v2.transactions.wallet': return 'D\'où';
			case 'v2.transactions.transactionDeleted': return 'C\'est supprimé.';
			case 'v2.transactions.selectCategoryTitle': return 'C\'est quoi ça ?';
			case 'v2.transactions.searchCategory': return 'Chercher la catégorie...';
			case 'v2.transactions.noCategoriesAvailable': return 'Aucune catégorie';
			case 'v2.transactions.createNewCategory': return 'Créer de zéro';
			case 'v2.transactions.amount': return 'MONTANT';
			case 'v2.transactions.description': return 'C\'ÉTAIT POUR...';
			case 'v2.transactions.category': return 'CATÉGORIE';
			case 'v2.transactions.addNote': return 'Une note (facultatif)...';
			case 'v2.transactions.today': return 'Aujourd\'hui';
			case 'v2.transactions.editTransaction': return 'Modifier le truc';
			case 'v2.transactions.newTransaction': return 'Nouveau Mouvement';
			case 'v2.transactions.selectWallet': return 'Choisis le compte';
			case 'v2.transactions.save': return 'Enregistrer';
			case 'v2.transactions.transactionUpdated': return 'C\'est mis à jour.';
			case 'v2.transactions.transactionSaved': return 'C\'est dans la boîte.';
			case 'v2.settings.title': return 'Personnaliser';
			case 'v2.settings.categories': return 'Catégories';
			case 'v2.settings.wallets': return 'Tes Comptes';
			case 'v2.settings.language': return 'Langue';
			case 'v2.settings.currency': return 'Devise';
			case 'v2.settings.contact': return 'Contact';
			case 'v2.settings.legacyView': return 'Ancienne Vue (V1)';
			case 'v2.settings.deleteCategory': return 'Effacer la catégorie ?';
			case 'v2.settings.deleteWallet': return 'Effacer le compte ?';
			case 'v2.settings.cannotUndo': return 'T\'es sûr ? Tu pourras pas revenir en arrière.';
			case 'v2.settings.deleteWalletWarning': return 'Attention, tu vas perdre toutes les dépenses liées.';
			case 'v2.settings.deleteError': return ({required Object error}) => 'Oups : ${error}';
			case 'v2.settings.noCategoriesCreated': return 'Aucune catégorie.\nIl faut en créer une.';
			case 'v2.settings.noWalletsCreated': return 'T\'as pas de compte.\nCommence par ça.';
			case 'v2.settings.walletDeleted': return 'Compte effacé.';
			case 'v2.settings.cancel': return 'Annuler';
			case 'v2.settings.delete': return 'Poubelle';
			case 'v2.settings.expenses': return 'Dépenses';
			case 'v2.settings.income': return 'Revenus';
			case 'v2.settings.newWallet': return 'Nouveau Compte';
			case 'v2.settings.editWallet': return 'Modifier Compte';
			case 'v2.settings.walletName': return 'Nom du compte';
			case 'v2.settings.saveWallet': return 'Sauvegarder';
			case 'v2.settings.deleteWalletHasTransactions': return 'Impossible de supprimer ce portefeuille car il contient des transactions existantes.';
			case 'v2.dashboard.greetingMorning': return 'Salut boss !';
			case 'v2.dashboard.totalBalance': return 'LA THUNE GLOBALE';
			case 'v2.dashboard.dateFilters.thisMonth': return 'Ce mois-ci';
			case 'v2.dashboard.dateFilters.lastMonth': return 'Le mois dernier';
			case 'v2.dashboard.dateFilters.customRange': return 'Dates au choix...';
			case 'v2.dashboard.walletFilters.all': return 'Tout';
			case 'v2.dashboard.walletFilters.allWallets': return 'Tous tes comptes';
			case 'v2.dashboard.background.title': return 'Fond d\'écran focus';
			case 'v2.dashboard.background.chooseFromGallery': return 'Prendre de la galerie';
			case 'v2.dashboard.background.restoreDefault': return 'Remettre par défaut';
			case 'v2.dashboard.incomeExpense.income': return 'REVENUS';
			case 'v2.dashboard.incomeExpense.expenses': return 'DÉPENSES';
			case 'v2.dashboard.gauge.exceeded': return 'DÉPASSÉ';
			case 'v2.dashboard.gauge.spent': return 'DÉPENSÉ';
			case 'v2.dashboard.gauge.available': return 'DISPO';
			case 'v2.dashboard.gauge.overdrawn': return 'À DÉCOUVERT';
			case 'v2.dashboard.activityList.seeAll': return 'Voir tout';
			case 'v2.dashboard.activityList.newUi': return 'Nouvelle UI';
			case 'v2.dashboard.activityList.expensesByCategory': return 'Où part ton fric';
			case 'v2.dashboard.activityList.noRecentExpenses': return 'Rien dépensé. Bravo !';
			case 'v2.dashboard.activityList.percentOfTotal': return ({required Object percent}) => '${percent}% du total';
			case 'v2.dashboard.activityList.topExpenses': return ({required Object count}) => 'Top ${count} des dépenses';
			case 'v2.dashboard.activityList.others': return 'Le Reste';
			case 'v2.categories.title': return 'Catégories';
			case 'v2.categories.searchPlaceholder': return 'Rechercher...';
			case 'v2.categories.newCategory': return 'Nouvelle';
			case 'v2.categories.editCategory': return 'Modifier';
			case 'v2.categories.noCategories': return 'Vide de chez vide';
			case 'v2.categories.form.nameLabel': return 'Nom de la catégorie';
			case 'v2.categories.form.save': return 'Enregistrer';
			case 'v2.onboarding.buttons.start': return 'C\'est parti !';
			case 'v2.onboarding.buttons.actionContinue': return 'On continue';
			case 'v2.onboarding.buttons.great': return 'Super !';
			case 'v2.onboarding.buttons.setGoal': return 'Fixer un but';
			case 'v2.onboarding.buttons.skip': return 'Zapper';
			case 'v2.onboarding.splash.title1': return 'Et si l\'Intelligence\nArtificielle (IA) ';
			case 'v2.onboarding.splash.title2': return 'gérait ton argent\nmieux que toi ?';
			case 'v2.onboarding.splash.benefit1': return 'Zéro effort.';
			case 'v2.onboarding.splash.benefit2': return 'Hyper clair.';
			case 'v2.onboarding.splash.benefit3': return 'De meilleurs choix.';
			case 'v2.onboarding.expenseCategories.title1': return 'Qu\'est-ce qui te bouffe tout ton fric ?';
			case 'v2.onboarding.expenseCategories.subtitle': return 'Choisis jusqu\'à 3 trucs';
			case 'v2.onboarding.expenseCategories.diningOut': return 'Manger dehors';
			case 'v2.onboarding.expenseCategories.cravings': return 'Les petits creux';
			case 'v2.onboarding.expenseCategories.subscriptions': return 'Les abonnements zappés';
			case 'v2.onboarding.expenseCategories.outings': return 'Les soirées';
			case 'v2.onboarding.expenseCategories.shopping': return 'Les achats impulsifs';
			case 'v2.onboarding.expenseCategories.delivery': return 'Les UberEats & co';
			case 'v2.onboarding.financialGoals.title': return 'Qu\'est-ce qui changerait\ntes finances d\'un coup ?';
			case 'v2.onboarding.financialGoals.subtitle': return 'Choisis-en un';
			case 'v2.onboarding.financialGoals.trackMoney': return 'Savoir où part exactement mon salaire';
			case 'v2.onboarding.financialGoals.spendLess': return 'Arrêter d\'acheter des trucs inutiles';
			case 'v2.onboarding.financialGoals.lessStress': return 'Arrêter de stresser pour l\'argent';
			case 'v2.onboarding.financialGoals.saveMoney': return 'Réussir à épargner pour de vrai';
			case 'v2.onboarding.registrationMethod.title': return 'Tu préfères noter\ntes dépenses comment ?';
			case 'v2.onboarding.registrationMethod.subtitle': return 'Choisis ta méthode';
			case 'v2.onboarding.registrationMethod.voice': return 'Juste en parlant au tél';
			case 'v2.onboarding.registrationMethod.auto': return 'Automatique par la banque';
			case 'v2.onboarding.registrationMethod.write': return 'Taper comme à l\'ancienne';
			case 'v2.onboarding.registrationMethod.easy': return 'Peu importe, le plus rapide possible';
			case 'v2.onboarding.aiAnalysis.loading.title': return 'JE RÈGLE L\'APP POUR\nTOI LÀ...';
			case 'v2.onboarding.aiAnalysis.loading.subtitle': return 'Analyse en cours';
			case 'v2.onboarding.aiAnalysis.loading.messages.0': return 'Je regarde comment tu dépenses...';
			case 'v2.onboarding.aiAnalysis.loading.messages.1': return 'Je prépare tes catégories...';
			case 'v2.onboarding.aiAnalysis.loading.messages.2': return 'Je cherche où ça coince...';
			case 'v2.onboarding.aiAnalysis.loading.messages.3': return 'Je te prépare une stratégie de dingue...';
			case 'v2.onboarding.aiAnalysis.showcase.title': return 'Analyse finie. Boom.';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.kDefault': return 'Tes dépenses mangent ton budget. Clairement ta méthode actuelle marche plus.';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.part2': return ' bouffent une grosse partie, et le fait que tu veuilles ';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.part3': return ' prouve qu\'il faut changer de méthode.';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.categories.diningOut': return 'Les restos';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.categories.cravings': return 'Les fringales';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.categories.subscriptions': return 'Les abos';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.categories.outings': return 'Les soirées';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.categories.shopping': return 'Le shopping impulsif';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.categories.delivery': return 'Les livraisons';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.intentions.trackMoney': return 'savoir où va l\'argent';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.intentions.spendLess': return 'dépenser moins';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.intentions.lessStress': return 'stresser moins';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.intentions.saveMoney': return 'enfin épargner';
			case 'v2.onboarding.aiAnalysis.showcase.result.yourResult': return 'Ton résultat';
			case 'v2.onboarding.aiAnalysis.showcase.result.average': return 'Moyenne';
			case 'v2.onboarding.aiAnalysis.showcase.result.messagePart1': return 'Tu dépenses 68% ';
			case 'v2.onboarding.aiAnalysis.showcase.result.messagePart2': return 'de plus que la moyenne là-dedans, et ça ';
			case 'v2.onboarding.aiAnalysis.showcase.result.messagePart3': return 'détruit complètement\n';
			case 'v2.onboarding.aiAnalysis.showcase.result.messagePart4': return 'tes objectifs à moyen terme';
			case 'v2.onboarding.mainPriority.title': return 'C\'est quoi ta\npriorité numéro 1 ?';
			case 'v2.onboarding.mainPriority.subtitle': return 'Choisis où MoneyT va te sauver la vie';
			case 'v2.onboarding.mainPriority.breakHabits': return 'Casser mes mauvaises habitudes';
			case 'v2.onboarding.mainPriority.stopStress': return 'Arrêter de stresser fin du mois';
			case 'v2.onboarding.mainPriority.buildFuture': return 'Me bâtir un avenir solide';
			case 'v2.onboarding.mainPriority.feelControl': return 'Savoir exactement où j\'en suis';
			case 'v2.onboarding.mainPriority.saveGoal': return 'Mettre de côté pour un objectif';
			case 'v2.onboarding.aiVoice.title.kDefault': return 'Atteindre ton objectif';
			case 'v2.onboarding.aiVoice.title.breakHabits': return 'Casser enfin tes vieilles habitudes';
			case 'v2.onboarding.aiVoice.title.stopStress': return 'Retrouver la paix d\'esprit';
			case 'v2.onboarding.aiVoice.title.buildFuture': return 'Bâtir un bel avenir financier';
			case 'v2.onboarding.aiVoice.title.feelControl': return 'Reprendre le contrôle total';
			case 'v2.onboarding.aiVoice.title.saveGoal': return 'Atteindre ton objectif d\'épargne';
			case 'v2.onboarding.aiVoice.title.suffix': return ' sera un jeu d\'enfant grâce à notre IA.';
			case 'v2.onboarding.aiVoice.subtitle': return 'T\'as juste à lui parler, elle s\'occupe de noter tes dépenses toute seule';
			case 'v2.onboarding.aiVoice.listening': return 'Parle, je t\'écoute...';
			case 'v2.onboarding.aiVoice.examples.0': return 'Café 3,50 €';
			case 'v2.onboarding.aiVoice.examples.1': return 'Uber 12,00 €';
			case 'v2.onboarding.aiVoice.examples.2': return 'Ciné 15,00 €';
			case 'v2.onboarding.aiVoice.examples.3': return 'Courses 45,20 €';
			case 'v2.onboarding.aiVoice.examples.4': return 'Essence 30,00 €';
			case 'v2.onboarding.aiVoice.examples.5': return 'Netflix 10,99 €';
			case 'v2.onboarding.aiVoice.examples.6': return 'Dîner 25,00 €';
			case 'v2.onboarding.aiVoice.examples.7': return 'Pharmacie 18,50 €';
			case 'v2.dateSelection.days': return 'Jours';
			case 'v2.dateSelection.months': return 'Mois';
			case 'v2.dateSelection.years': return 'Années';
			case 'intents.transactionSavedTitle': return '✅ Transaction Enregistrée';
			case 'intents.emptyText': return 'Texte vide';
			case 'intents.emptyData': return 'Données vides';
			case 'intents.cannotUnderstand': return 'Impossible de comprendre la transaction';
			case 'intents.errorSaving': return 'Erreur de sauvegarde';
			case 'intents.noCategories': return 'Aucune catégorie';
			case 'intents.loadingError': return 'Erreur de chargement';
			default: return null;
		}
	}
}

