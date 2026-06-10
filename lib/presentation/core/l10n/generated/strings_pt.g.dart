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
class AppStringsPt extends AppStrings {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	AppStringsPt({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, AppStrings>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.pt,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <pt>.
	@override final TranslationMetadata<AppLocale, AppStrings> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final AppStringsPt _root = this; // ignore: unused_field

	@override 
	AppStringsPt $copyWith({TranslationMetadata<AppLocale, AppStrings>? meta}) => AppStringsPt(meta: meta ?? this.$meta);

	// Translations
	@override late final _AppStringsAppPt app = _AppStringsAppPt._(_root);
	@override late final _AppStringsCommonPt common = _AppStringsCommonPt._(_root);
	@override late final _AppStringsComponentsPt components = _AppStringsComponentsPt._(_root);
	@override late final _AppStringsNavigationPt navigation = _AppStringsNavigationPt._(_root);
	@override late final _AppStringsTransactionsPt transactions = _AppStringsTransactionsPt._(_root);
	@override late final _AppStringsContactsPt contacts = _AppStringsContactsPt._(_root);
	@override late final _AppStringsErrorsPt errors = _AppStringsErrorsPt._(_root);
	@override late final _AppStringsSettingsPt settings = _AppStringsSettingsPt._(_root);
	@override late final _AppStringsOnboardingPt onboarding = _AppStringsOnboardingPt._(_root);
	@override late final _AppStringsDashboardPt dashboard = _AppStringsDashboardPt._(_root);
	@override late final _AppStringsWalletsPt wallets = _AppStringsWalletsPt._(_root);
	@override late final _AppStringsLoansPt loans = _AppStringsLoansPt._(_root);
	@override late final _AppStringsCategoriesPt categories = _AppStringsCategoriesPt._(_root);
	@override late final _AppStringsBackupsPt backups = _AppStringsBackupsPt._(_root);
	@override late final _AppStringsV2Pt v2 = _AppStringsV2Pt._(_root);
	@override late final _AppStringsIntentsPt intents = _AppStringsIntentsPt._(_root);
}

// Path: app
class _AppStringsAppPt extends AppStringsAppEn {
	_AppStringsAppPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get name => 'MoneyT';
	@override String get description => 'Gerenciador Financeiro';
}

// Path: common
class _AppStringsCommonPt extends AppStringsCommonEn {
	_AppStringsCommonPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get save => 'Salvar';
	@override String get cancel => 'Cancelar';
	@override String get delete => 'Excluir';
	@override String get edit => 'Editar';
	@override String get loading => 'Carregando...';
	@override String get error => 'Erro';
	@override String get success => 'Sucesso';
	@override String get search => 'Buscar';
	@override String get clearSearch => 'Limpar busca';
	@override String get viewAll => 'Ver tudo';
	@override String get retry => 'Tentar novamente';
	@override String get add => 'Adicionar';
	@override String get remove => 'Remover';
	@override String get moreOptions => 'Mais opções';
	@override String get addToFavorites => 'Adicionar aos favoritos';
	@override String get removeFromFavorites => 'Remover dos favoritos';
	@override String get today => 'Hoje';
	@override String get yesterday => 'Ontem';
}

// Path: components
class _AppStringsComponentsPt extends AppStringsComponentsEn {
	_AppStringsComponentsPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override late final _AppStringsComponentsDateSelectionPt dateSelection = _AppStringsComponentsDateSelectionPt._(_root);
	@override late final _AppStringsComponentsSelectionPt selection = _AppStringsComponentsSelectionPt._(_root);
	@override late final _AppStringsComponentsContactSelectionPt contactSelection = _AppStringsComponentsContactSelectionPt._(_root);
	@override late final _AppStringsComponentsCategorySelectionPt categorySelection = _AppStringsComponentsCategorySelectionPt._(_root);
	@override late final _AppStringsComponentsCurrencySelectionPt currencySelection = _AppStringsComponentsCurrencySelectionPt._(_root);
	@override late final _AppStringsComponentsAccountSelectionPt accountSelection = _AppStringsComponentsAccountSelectionPt._(_root);
	@override late final _AppStringsComponentsParentWalletSelectionPt parentWalletSelection = _AppStringsComponentsParentWalletSelectionPt._(_root);
	@override late final _AppStringsComponentsWalletTypesPt walletTypes = _AppStringsComponentsWalletTypesPt._(_root);
}

// Path: navigation
class _AppStringsNavigationPt extends AppStringsNavigationEn {
	_AppStringsNavigationPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get home => 'Início';
	@override String get transactions => 'Transações';
	@override String get contacts => 'Contatos';
	@override String get settings => 'Ajustes';
	@override String get wallets => 'Carteiras';
	@override String get categories => 'Categorias';
	@override String get loans => 'Empréstimos';
	@override String get charts => 'Plano de Contas';
	@override String get backups => 'Backups';
	@override String get creditCards => 'Cartões de Crédito';
	@override late final _AppStringsNavigationSectionsPt sections = _AppStringsNavigationSectionsPt._(_root);
}

// Path: transactions
class _AppStringsTransactionsPt extends AppStringsTransactionsEn {
	_AppStringsTransactionsPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Transações';
	@override late final _AppStringsTransactionsTypesPt types = _AppStringsTransactionsTypesPt._(_root);
	@override late final _AppStringsTransactionsFilterPt filter = _AppStringsTransactionsFilterPt._(_root);
	@override late final _AppStringsTransactionsFormPt form = _AppStringsTransactionsFormPt._(_root);
	@override late final _AppStringsTransactionsErrorsPt errors = _AppStringsTransactionsErrorsPt._(_root);
	@override late final _AppStringsTransactionsEmptyPt empty = _AppStringsTransactionsEmptyPt._(_root);
	@override late final _AppStringsTransactionsListPt list = _AppStringsTransactionsListPt._(_root);
	@override late final _AppStringsTransactionsDetailPt detail = _AppStringsTransactionsDetailPt._(_root);
	@override late final _AppStringsTransactionsSharePt share = _AppStringsTransactionsSharePt._(_root);
}

// Path: contacts
class _AppStringsContactsPt extends AppStringsContactsEn {
	_AppStringsContactsPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Contatos';
	@override String get addContact => 'Adicionar Contato';
	@override String get editContact => 'Editar Contato';
	@override String get newContact => 'Novo contato';
	@override String get noContacts => 'Nenhum contato';
	@override String get noContactsMessage => 'Adicione seu primeiro contato no botão "+"';
	@override String get searchContacts => 'Buscar contatos';
	@override String get deleteContact => 'Excluir contato';
	@override String get confirmDelete => 'Tem certeza de que deseja excluir';
	@override String get contactDeleted => 'Contato excluído com sucesso';
	@override String get errorDeleting => 'Erro ao excluir contato';
	@override String get noSearchResults => 'Nenhum resultado encontrado';
	@override String noContactsMatch({required Object query}) => 'Nenhum contato corresponde a "${query}".';
	@override String get errorLoading => 'Erro ao carregar contatos';
	@override String get contactSaved => 'Contato salvo com sucesso';
	@override String get errorSaving => 'Erro ao salvar contato';
	@override String get noContactInfo => 'Sem informações de contato';
	@override String get importContact => 'Importar contato';
	@override String get importContacts => 'Importar contatos';
	@override String get importContactSoon => 'A função de importar contatos chegará em breve';
	@override late final _AppStringsContactsFieldsPt fields = _AppStringsContactsFieldsPt._(_root);
	@override late final _AppStringsContactsPlaceholdersPt placeholders = _AppStringsContactsPlaceholdersPt._(_root);
	@override late final _AppStringsContactsValidationPt validation = _AppStringsContactsValidationPt._(_root);
}

// Path: errors
class _AppStringsErrorsPt extends AppStringsErrorsEn {
	_AppStringsErrorsPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String loadingAccounts({required Object error}) => 'Erro ao carregar contas: ${error}';
	@override String get unexpected => 'Erro inesperado';
}

// Path: settings
class _AppStringsSettingsPt extends AppStringsSettingsEn {
	_AppStringsSettingsPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Configurações';
	@override late final _AppStringsSettingsAccountPt account = _AppStringsSettingsAccountPt._(_root);
	@override late final _AppStringsSettingsAppearancePt appearance = _AppStringsSettingsAppearancePt._(_root);
	@override late final _AppStringsSettingsDataPt data = _AppStringsSettingsDataPt._(_root);
	@override late final _AppStringsSettingsInfoPt info = _AppStringsSettingsInfoPt._(_root);
	@override late final _AppStringsSettingsLogoutPt logout = _AppStringsSettingsLogoutPt._(_root);
	@override late final _AppStringsSettingsSocialPt social = _AppStringsSettingsSocialPt._(_root);
	@override late final _AppStringsSettingsLanguagePt language = _AppStringsSettingsLanguagePt._(_root);
	@override late final _AppStringsSettingsCurrencyPt currency = _AppStringsSettingsCurrencyPt._(_root);
	@override late final _AppStringsSettingsMessagesPt messages = _AppStringsSettingsMessagesPt._(_root);
}

// Path: onboarding
class _AppStringsOnboardingPt extends AppStringsOnboardingEn {
	_AppStringsOnboardingPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override late final _AppStringsOnboardingWelcomePt welcome = _AppStringsOnboardingWelcomePt._(_root);
	@override late final _AppStringsOnboardingProblemStatementPt problemStatement = _AppStringsOnboardingProblemStatementPt._(_root);
	@override late final _AppStringsOnboardingSpecificProblemPt specificProblem = _AppStringsOnboardingSpecificProblemPt._(_root);
	@override late final _AppStringsOnboardingPersonalGoalPt personalGoal = _AppStringsOnboardingPersonalGoalPt._(_root);
	@override late final _AppStringsOnboardingSolutionPreviewPt solutionPreview = _AppStringsOnboardingSolutionPreviewPt._(_root);
	@override late final _AppStringsOnboardingCurrentMethodPt currentMethod = _AppStringsOnboardingCurrentMethodPt._(_root);
	@override late final _AppStringsOnboardingFeaturesShowcasePt featuresShowcase = _AppStringsOnboardingFeaturesShowcasePt._(_root);
	@override late final _AppStringsOnboardingCompletePt complete = _AppStringsOnboardingCompletePt._(_root);
	@override late final _AppStringsOnboardingButtonsPt buttons = _AppStringsOnboardingButtonsPt._(_root);
}

// Path: dashboard
class _AppStringsDashboardPt extends AppStringsDashboardEn {
	_AppStringsDashboardPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get greeting => 'Bem-vindo ao MoneyT';
	@override late final _AppStringsDashboardBalancePt balance = _AppStringsDashboardBalancePt._(_root);
	@override late final _AppStringsDashboardActionsPt actions = _AppStringsDashboardActionsPt._(_root);
	@override late final _AppStringsDashboardWalletsPt wallets = _AppStringsDashboardWalletsPt._(_root);
	@override late final _AppStringsDashboardTransactionsPt transactions = _AppStringsDashboardTransactionsPt._(_root);
	@override String get customize => 'Personalizar';
	@override late final _AppStringsDashboardWidgetsPt widgets = _AppStringsDashboardWidgetsPt._(_root);
}

// Path: wallets
class _AppStringsWalletsPt extends AppStringsWalletsEn {
	_AppStringsWalletsPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Carteiras';
	@override late final _AppStringsWalletsEmptyPt empty = _AppStringsWalletsEmptyPt._(_root);
	@override late final _AppStringsWalletsEmptyArchivedPt emptyArchived = _AppStringsWalletsEmptyArchivedPt._(_root);
	@override late final _AppStringsWalletsFilterPt filter = _AppStringsWalletsFilterPt._(_root);
	@override late final _AppStringsWalletsFormPt form = _AppStringsWalletsFormPt._(_root);
	@override late final _AppStringsWalletsDeletePt delete = _AppStringsWalletsDeletePt._(_root);
	@override late final _AppStringsWalletsErrorsPt errors = _AppStringsWalletsErrorsPt._(_root);
	@override late final _AppStringsWalletsSubtitlePt subtitle = _AppStringsWalletsSubtitlePt._(_root);
	@override late final _AppStringsWalletsOptionsPt options = _AppStringsWalletsOptionsPt._(_root);
}

// Path: loans
class _AppStringsLoansPt extends AppStringsLoansEn {
	_AppStringsLoansPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Empréstimos';
	@override late final _AppStringsLoansFilterPt filter = _AppStringsLoansFilterPt._(_root);
	@override late final _AppStringsLoansSummaryPt summary = _AppStringsLoansSummaryPt._(_root);
	@override late final _AppStringsLoansCardPt card = _AppStringsLoansCardPt._(_root);
	@override late final _AppStringsLoansFormPt form = _AppStringsLoansFormPt._(_root);
	@override late final _AppStringsLoansDetailPt detail = _AppStringsLoansDetailPt._(_root);
	@override late final _AppStringsLoansHistoryPt history = _AppStringsLoansHistoryPt._(_root);
	@override late final _AppStringsLoansContactDetailPt contactDetail = _AppStringsLoansContactDetailPt._(_root);
	@override late final _AppStringsLoansSharePt share = _AppStringsLoansSharePt._(_root);
	@override late final _AppStringsLoansPaymentPt payment = _AppStringsLoansPaymentPt._(_root);
	@override String get given => 'Dei Emprestado';
	@override String get received => 'Peguei Emprestado';
	@override late final _AppStringsLoansItemPt item = _AppStringsLoansItemPt._(_root);
	@override late final _AppStringsLoansSectionPt section = _AppStringsLoansSectionPt._(_root);
	@override late final _AppStringsLoansEmptyPt empty = _AppStringsLoansEmptyPt._(_root);
}

// Path: categories
class _AppStringsCategoriesPt extends AppStringsCategoriesEn {
	_AppStringsCategoriesPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Categorias';
	@override late final _AppStringsCategoriesFormPt form = _AppStringsCategoriesFormPt._(_root);
	@override late final _AppStringsCategoriesParentSelectionPt parentSelection = _AppStringsCategoriesParentSelectionPt._(_root);
	@override String get incomeCategory => 'Categoria de Ganho';
	@override String get expenseCategory => 'Categoria de Gasto';
	@override late final _AppStringsCategoriesReportPt report = _AppStringsCategoriesReportPt._(_root);
}

// Path: backups
class _AppStringsBackupsPt extends AppStringsBackupsEn {
	_AppStringsBackupsPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Backups (Nuvem de Segurança)';
	@override late final _AppStringsBackupsMenuPt menu = _AppStringsBackupsMenuPt._(_root);
	@override late final _AppStringsBackupsFiltersPt filters = _AppStringsBackupsFiltersPt._(_root);
	@override late final _AppStringsBackupsStatusPt status = _AppStringsBackupsStatusPt._(_root);
	@override late final _AppStringsBackupsActionsPt actions = _AppStringsBackupsActionsPt._(_root);
	@override late final _AppStringsBackupsDialogsPt dialogs = _AppStringsBackupsDialogsPt._(_root);
	@override late final _AppStringsBackupsStatsPt stats = _AppStringsBackupsStatsPt._(_root);
	@override late final _AppStringsBackupsOptionsPt options = _AppStringsBackupsOptionsPt._(_root);
	@override late final _AppStringsBackupsFormatPt format = _AppStringsBackupsFormatPt._(_root);
}

// Path: v2
class _AppStringsV2Pt extends AppStringsV2En {
	_AppStringsV2Pt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override late final _AppStringsV2VoicePt voice = _AppStringsV2VoicePt._(_root);
	@override late final _AppStringsV2TransactionsPt transactions = _AppStringsV2TransactionsPt._(_root);
	@override late final _AppStringsV2SettingsPt settings = _AppStringsV2SettingsPt._(_root);
	@override late final _AppStringsV2DashboardPt dashboard = _AppStringsV2DashboardPt._(_root);
	@override late final _AppStringsV2CategoriesPt categories = _AppStringsV2CategoriesPt._(_root);
	@override late final _AppStringsV2OnboardingPt onboarding = _AppStringsV2OnboardingPt._(_root);
	@override late final _AppStringsV2DateSelectionPt dateSelection = _AppStringsV2DateSelectionPt._(_root);
}

// Path: intents
class _AppStringsIntentsPt extends AppStringsIntentsEn {
	_AppStringsIntentsPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get transactionSavedTitle => '✅ Transação Salva';
	@override String get emptyText => 'Texto vazio';
	@override String get emptyData => 'Dados vazios';
	@override String get cannotUnderstand => 'Não foi possível entender';
	@override String get errorSaving => 'Erro ao salvar';
	@override String get noCategories => 'Sem categorias';
	@override String get loadingError => 'Erro ao carregar';
}

// Path: components.dateSelection
class _AppStringsComponentsDateSelectionPt extends AppStringsComponentsDateSelectionEn {
	_AppStringsComponentsDateSelectionPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Selecionar data';
	@override String get subtitle => 'Escolha a data da transação';
	@override String get selectedDate => 'Data selecionada';
	@override String get confirm => 'Confirmar';
}

// Path: components.selection
class _AppStringsComponentsSelectionPt extends AppStringsComponentsSelectionEn {
	_AppStringsComponentsSelectionPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Cancelar';
	@override String get confirm => 'Confirmar';
	@override String get select => 'Selecionar';
}

// Path: components.contactSelection
class _AppStringsComponentsContactSelectionPt extends AppStringsComponentsContactSelectionEn {
	_AppStringsComponentsContactSelectionPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Selecionar contato';
	@override String get subtitle => 'Com quem é essa transação';
	@override String get searchPlaceholder => 'Buscar contatos';
	@override String get noContact => 'Sem contato';
	@override String get noContactDetails => 'Transação sem contato específico';
	@override String get allContacts => 'Todos os contatos';
	@override String get create => 'Criar novo contato';
}

// Path: components.categorySelection
class _AppStringsComponentsCategorySelectionPt extends AppStringsComponentsCategorySelectionEn {
	_AppStringsComponentsCategorySelectionPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Selecionar categoria';
	@override String get subtitle => 'Escolha uma categoria para esta transação';
	@override String get searchPlaceholder => 'Buscar categorias';
}

// Path: components.currencySelection
class _AppStringsComponentsCurrencySelectionPt extends AppStringsComponentsCurrencySelectionEn {
	_AppStringsComponentsCurrencySelectionPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Selecionar moeda';
	@override String get subtitle => 'Escolha a moeda desta conta';
	@override String get searchPlaceholder => 'Buscar moedas';
}

// Path: components.accountSelection
class _AppStringsComponentsAccountSelectionPt extends AppStringsComponentsAccountSelectionEn {
	_AppStringsComponentsAccountSelectionPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Selecionar conta';
	@override String get subtitle => 'Escolha uma conta para esta transação';
	@override String get searchPlaceholder => 'Buscar contas';
	@override String get wallets => 'Carteiras';
	@override String get creditCards => 'Cartões de Crédito';
	@override String get selectAccount => 'Selecionar conta';
	@override String get confirm => 'Confirmar';
}

// Path: components.parentWalletSelection
class _AppStringsComponentsParentWalletSelectionPt extends AppStringsComponentsParentWalletSelectionEn {
	_AppStringsComponentsParentWalletSelectionPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Selecionar carteira principal';
	@override String get subtitle => 'Escolha uma carteira para organizar esta dentro de outra';
	@override String get searchPlaceholder => 'Buscar carteiras';
	@override String get noParent => 'Sem carteira principal';
	@override String get createRoot => 'Criar como carteira raiz';
	@override String get available => 'Carteiras Disponíveis';
}

// Path: components.walletTypes
class _AppStringsComponentsWalletTypesPt extends AppStringsComponentsWalletTypesEn {
	_AppStringsComponentsWalletTypesPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get checking => 'Conta Corrente';
	@override String get savings => 'Poupança';
	@override String get cash => 'Dinheiro vivo';
	@override String get creditCard => 'Cartão de Crédito';
}

// Path: navigation.sections
class _AppStringsNavigationSectionsPt extends AppStringsNavigationSectionsEn {
	_AppStringsNavigationSectionsPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get operations => 'OPERAÇÕES';
	@override String get financialTools => 'FERRAMENTAS FINANCEIRAS';
	@override String get management => 'GERENCIAMENTO';
	@override String get advanced => 'AVANÇADO';
}

// Path: transactions.types
class _AppStringsTransactionsTypesPt extends AppStringsTransactionsTypesEn {
	_AppStringsTransactionsTypesPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get all => 'Todas';
	@override String get income => 'Receita';
	@override String get expense => 'Despesa';
	@override String get transfer => 'Transferência';
}

// Path: transactions.filter
class _AppStringsTransactionsFilterPt extends AppStringsTransactionsFilterEn {
	_AppStringsTransactionsFilterPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Filtrar Transações';
	@override String get date => 'Data';
	@override String get categories => 'Categorias';
	@override String get accounts => 'Contas';
	@override String get contacts => 'Contatos';
	@override String get amount => 'Valor';
	@override String get apply => 'Aplicar filtros';
	@override String get clear => 'Limpar filtros';
	@override String get add => 'Adicionar filtro';
	@override String get minAmount => 'Valor Mínimo';
	@override String get maxAmount => 'Valor Máximo';
	@override String get selectDate => 'Selecionar data';
	@override String get selectCategory => 'Selecionar categoria';
	@override String get selectAccount => 'Selecionar conta';
	@override String get selectContact => 'Selecionar contato';
	@override String get quickFilters => 'Filtros rápidos';
	@override late final _AppStringsTransactionsFilterRangesPt ranges = _AppStringsTransactionsFilterRangesPt._(_root);
	@override String get customRange => 'Período Personalizado';
	@override String get startDate => 'Data de Início';
	@override String get endDate => 'Data de Término';
	@override String get active => 'Filtros Ativos';
	@override late final _AppStringsTransactionsFilterSubtitlesPt subtitles = _AppStringsTransactionsFilterSubtitlesPt._(_root);
}

// Path: transactions.form
class _AppStringsTransactionsFormPt extends AppStringsTransactionsFormEn {
	_AppStringsTransactionsFormPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get newTitle => 'Nova Transação';
	@override String get editTitle => 'Editar Transação';
	@override String get amount => 'Valor';
	@override String get type => 'Tipo de transação';
	@override String get amountRequired => 'O valor é obrigatório';
	@override String get date => 'Data';
	@override String get account => 'Conta';
	@override String get toAccount => 'Para Conta';
	@override String get category => 'Categoria';
	@override String get contact => 'Contato';
	@override String get contactOptional => 'Contato (opcional)';
	@override String get description => 'Descrição';
	@override String get descriptionOptional => 'Descrição opcional';
	@override String get selectAccount => 'Selecionar conta';
	@override String get selectDestination => 'Selecionar destino';
	@override String get selectCategory => 'Selecionar categoria';
	@override String get selectContact => 'Selecionar contato';
	@override String get saveSuccess => 'Transação salva com sucesso';
	@override String get updateSuccess => 'Transação atualizada com sucesso';
	@override String get saveError => 'Erro ao salvar transação';
	@override String get share => 'Compartilhar';
	@override String get created => 'Transação criada com sucesso';
	@override String get crossCurrencyConversion => 'Conversão de moeda';
	@override String get receivedAmount => 'Valor recebido';
	@override String get exchangeRate => 'Taxa de câmbio';
	@override String get receivedAmountRequired => 'Informe o valor a receber';
	@override String exchangeRateLabel({required Object from, required Object rate, required Object to}) => '1 ${from} = ${rate} ${to}';
}

// Path: transactions.errors
class _AppStringsTransactionsErrorsPt extends AppStringsTransactionsErrorsEn {
	_AppStringsTransactionsErrorsPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get load => 'Erro ao carregar transações';
}

// Path: transactions.empty
class _AppStringsTransactionsEmptyPt extends AppStringsTransactionsEmptyEn {
	_AppStringsTransactionsEmptyPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Nenhuma transação';
	@override String get message => 'Nenhuma transação encontrada com os filtros atuais';
	@override String get clearFilters => 'Limpar filtros';
}

// Path: transactions.list
class _AppStringsTransactionsListPt extends AppStringsTransactionsListEn {
	_AppStringsTransactionsListPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String count({required Object n}) => '${n} transações';
}

// Path: transactions.detail
class _AppStringsTransactionsDetailPt extends AppStringsTransactionsDetailEn {
	_AppStringsTransactionsDetailPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Detalhes da Transação';
	@override String get delete => 'Excluir Transação';
	@override String get deleteConfirmation => 'Tem certeza? Isso não pode ser desfeito.';
	@override String get deleted => 'Transação excluída';
	@override String get duplicate => 'Duplicar';
	@override String get duplicateNotImplemented => 'Duplicar ainda não implementado';
	@override String get edit => 'Editar';
	@override String get errorLoad => 'Erro ao carregar os detalhes';
	@override String errorPrepareEdit({required Object error}) => 'Erro ao preparar edição: ${error}';
	@override String errorDelete({required Object error}) => 'Erro ao excluir: ${error}';
	@override String get category => 'Categoria';
	@override String get account => 'Conta';
	@override String get contact => 'Contato';
	@override String get description => 'Descrição';
	@override String get transferDetails => 'Detalhes da Transferência';
	@override String get from => 'De';
	@override String get to => 'Para';
	@override String get unknownAccount => 'Conta Desconhecida';
	@override String errorUrl({required Object url}) => 'Não foi possível abrir ${url}';
	@override String get date => 'Data';
	@override String get time => 'Hora';
	@override String get loanLinkedWarning => 'Esta transação está vinculada a um empréstimo e é gerida automaticamente.';
}

// Path: transactions.share
class _AppStringsTransactionsSharePt extends AppStringsTransactionsShareEn {
	_AppStringsTransactionsSharePt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Compartilhar Transação';
	@override String get copyText => 'Copiar Texto';
	@override String get shareButton => 'Compartilhar';
	@override String get shareMessage => 'Aqui está o comprovante da minha transação:';
	@override String get copied => 'Detalhes copiados para a área de transferência!';
	@override String get paymentMethod => 'Método de Pagamento';
	@override String get receiptTitle => 'Comprovante de Transação';
	@override String get poweredBy => 'Gerado por MoneyT • moneyt.io';
	@override String errorImage({required Object error}) => 'Erro ao compartilhar imagem: ${error}';
	@override late final _AppStringsTransactionsShareReceiptPt receipt = _AppStringsTransactionsShareReceiptPt._(_root);
	@override String generatedOn({required Object date}) => 'Gerado em ${date}';
}

// Path: contacts.fields
class _AppStringsContactsFieldsPt extends AppStringsContactsFieldsEn {
	_AppStringsContactsFieldsPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get name => 'Nome';
	@override String get fullName => 'Nome completo';
	@override String get email => 'E-mail';
	@override String get phone => 'Telefone';
	@override String get address => 'Endereço';
	@override String get notes => 'Anotações';
}

// Path: contacts.placeholders
class _AppStringsContactsPlaceholdersPt extends AppStringsContactsPlaceholdersEn {
	_AppStringsContactsPlaceholdersPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get enterFullName => 'Digite o nome completo';
	@override String get enterPhone => 'Digite o número de telefone';
	@override String get enterEmail => 'Digite o e-mail';
}

// Path: contacts.validation
class _AppStringsContactsValidationPt extends AppStringsContactsValidationEn {
	_AppStringsContactsValidationPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get nameRequired => 'O nome é obrigatório';
	@override String get invalidEmail => 'E-mail inválido';
	@override String get invalidPhone => 'Telefone inválido';
}

// Path: settings.account
class _AppStringsSettingsAccountPt extends AppStringsSettingsAccountEn {
	_AppStringsSettingsAccountPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Conta';
	@override String get profile => 'Perfil';
	@override String get profileSubtitle => 'Gerenciar informações da conta';
}

// Path: settings.appearance
class _AppStringsSettingsAppearancePt extends AppStringsSettingsAppearanceEn {
	_AppStringsSettingsAppearancePt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Preferências';
	@override String get darkMode => 'Modo escuro';
	@override String get darkModeSubtitle => 'Mudar para o tema escuro';
	@override String get language => 'Idioma';
	@override String get currency => 'Moeda Principal';
	@override String get currencySubtitle => 'Moeda para exibição e novas contas';
	@override String get darkTheme => 'Tema escuro';
	@override String get lightTheme => 'Tema claro';
	@override String get systemTheme => 'Tema do sistema';
}

// Path: settings.data
class _AppStringsSettingsDataPt extends AppStringsSettingsDataEn {
	_AppStringsSettingsDataPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Dados e Armazenamento';
	@override String get backup => 'Backup do banco';
	@override String get backupSubtitle => 'Gerencie seus backups de dados';
}

// Path: settings.info
class _AppStringsSettingsInfoPt extends AppStringsSettingsInfoEn {
	_AppStringsSettingsInfoPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Informação';
	@override String get contact => 'Contato e Redes Sociais';
	@override String get contactSubtitle => 'Obtenha suporte e siga-nos';
	@override String get privacy => 'Política de privacidade';
	@override String get privacySubtitle => 'Leia nossa política de privacidade';
	@override String get share => 'Compartilhar MoneyT';
	@override String get shareSubtitle => 'Recomende o app aos seus amigos';
}

// Path: settings.logout
class _AppStringsSettingsLogoutPt extends AppStringsSettingsLogoutEn {
	_AppStringsSettingsLogoutPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get button => 'Sair';
	@override String get dialogTitle => 'Sair da conta';
	@override String get dialogMessage => 'Tem certeza que deseja sair da sua conta?';
	@override String get cancel => 'Cancelar';
	@override String get confirm => 'Sair';
}

// Path: settings.social
class _AppStringsSettingsSocialPt extends AppStringsSettingsSocialEn {
	_AppStringsSettingsSocialPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Contato e Redes';
	@override String get follow => 'Siga o MoneyT';
	@override String get description => 'Fique conectado nas redes para novidades e comunidade.';
	@override String get networks => 'Redes Sociais';
	@override String get github => 'GitHub';
	@override String get githubSubtitle => 'Veja o código e contribua';
	@override String get linkedin => 'LinkedIn';
	@override String get linkedinSubtitle => 'Novidades profissionais';
	@override String get twitter => 'X (Twitter)';
	@override String get twitterSubtitle => 'Notícias e anúncios';
	@override String get reddit => 'Reddit';
	@override String get redditSubtitle => 'Entre na comunidade';
	@override String get discord => 'Discord';
	@override String get discordSubtitle => 'Chat da comunidade';
	@override String get contact => 'Contato';
	@override String get email => 'Suporte por E-mail';
	@override String get website => 'Site Oficial';
}

// Path: settings.language
class _AppStringsSettingsLanguagePt extends AppStringsSettingsLanguageEn {
	_AppStringsSettingsLanguagePt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Idioma';
	@override String get available => 'IDIOMAS DISPONÍVEIS';
	@override String get apply => 'Aplicar Idioma';
}

// Path: settings.currency
class _AppStringsSettingsCurrencyPt extends AppStringsSettingsCurrencyEn {
	_AppStringsSettingsCurrencyPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Moeda Principal';
	@override String get available => 'MOEDAS DISPONÍVEIS';
	@override String get apply => 'Aplicar Moeda';
}

// Path: settings.messages
class _AppStringsSettingsMessagesPt extends AppStringsSettingsMessagesEn {
	_AppStringsSettingsMessagesPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get profileComingSoon => 'Tela de perfil em breve';
	@override String get privacyError => 'Não foi possível abrir a política';
	@override String get logoutComingSoon => 'Função de sair em breve';
}

// Path: onboarding.welcome
class _AppStringsOnboardingWelcomePt extends AppStringsOnboardingWelcomeEn {
	_AppStringsOnboardingWelcomePt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Bem-vindo ao MoneyT 👋';
	@override String get subtitle => 'Domine sua grana em minutos ✨';
}

// Path: onboarding.problemStatement
class _AppStringsOnboardingProblemStatementPt extends AppStringsOnboardingProblemStatementEn {
	_AppStringsOnboardingProblemStatementPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sente que a grana foge pelos seus dedos?';
	@override String get subtitle => 'Você não está só. 70% da galera não sabe pra onde o dinheiro vai.';
}

// Path: onboarding.specificProblem
class _AppStringsOnboardingSpecificProblemPt extends AppStringsOnboardingSpecificProblemEn {
	_AppStringsOnboardingSpecificProblemPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'O que mais te pega?';
	@override late final _AppStringsOnboardingSpecificProblemOptionsPt options = _AppStringsOnboardingSpecificProblemOptionsPt._(_root);
}

// Path: onboarding.personalGoal
class _AppStringsOnboardingPersonalGoalPt extends AppStringsOnboardingPersonalGoalEn {
	_AppStringsOnboardingPersonalGoalPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Qual seu foco agora?';
	@override late final _AppStringsOnboardingPersonalGoalOptionsPt options = _AppStringsOnboardingPersonalGoalOptionsPt._(_root);
}

// Path: onboarding.solutionPreview
class _AppStringsOnboardingSolutionPreviewPt extends AppStringsOnboardingSolutionPreviewEn {
	_AppStringsOnboardingSolutionPreviewPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'O MoneyT te dá clareza';
	@override String get subtitle => 'Veja todas as contas e dívidas num só lugar. Sem planilhas chatas.';
	@override late final _AppStringsOnboardingSolutionPreviewBenefitsPt benefits = _AppStringsOnboardingSolutionPreviewBenefitsPt._(_root);
}

// Path: onboarding.currentMethod
class _AppStringsOnboardingCurrentMethodPt extends AppStringsOnboardingCurrentMethodEn {
	_AppStringsOnboardingCurrentMethodPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Como você controla a grana hoje?';
	@override String get subtitle => 'Escolhe o que tem mais a sua cara.';
	@override late final _AppStringsOnboardingCurrentMethodOptionsPt options = _AppStringsOnboardingCurrentMethodOptionsPt._(_root);
}

// Path: onboarding.featuresShowcase
class _AppStringsOnboardingFeaturesShowcasePt extends AppStringsOnboardingFeaturesShowcaseEn {
	_AppStringsOnboardingFeaturesShowcasePt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'O que tem e o que vem aí ✨';
	@override String get subtitle => 'Pronto para usar, com mais novidades no forno.';
	@override String get available => 'JÁ DISPONÍVEL';
	@override String get comingSoon => 'EM BREVE';
	@override late final _AppStringsOnboardingFeaturesShowcaseFeaturesPt features = _AppStringsOnboardingFeaturesShowcaseFeaturesPt._(_root);
}

// Path: onboarding.complete
class _AppStringsOnboardingCompletePt extends AppStringsOnboardingCompleteEn {
	_AppStringsOnboardingCompletePt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Pronto para decolar! 🚀';
	@override String get subtitle => 'Lance sua primeira transação e veja a mágica acontecer 📈';
	@override late final _AppStringsOnboardingCompleteStatsPt stats = _AppStringsOnboardingCompleteStatsPt._(_root);
}

// Path: onboarding.buttons
class _AppStringsOnboardingButtonsPt extends AppStringsOnboardingButtonsEn {
	_AppStringsOnboardingButtonsPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get start => 'Bora começar 🚀';
	@override String get fixIt => 'Arrumar isso hoje ⚡';
	@override String get actionContinue => 'Continuar';
	@override String get setGoal => 'Bora traçar a meta 🎯';
	@override String get wantControl => 'Eu quero ter esse controle!';
	@override String get great => 'Massa, quero ver!';
	@override String get firstTransaction => 'Registrar minha primeira ➕';
	@override String get skip => 'Pular';
}

// Path: dashboard.balance
class _AppStringsDashboardBalancePt extends AppStringsDashboardBalanceEn {
	_AppStringsDashboardBalancePt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get total => 'SALDO TOTAL';
	@override String get income => 'RECEITAS';
	@override String get expenses => 'DESPESAS';
	@override String get thisMonth => 'este mês';
}

// Path: dashboard.actions
class _AppStringsDashboardActionsPt extends AppStringsDashboardActionsEn {
	_AppStringsDashboardActionsPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get income => 'Receita';
	@override String get expense => 'Despesa';
	@override String get transfer => 'Transf.';
	@override String get all => 'Tudo';
}

// Path: dashboard.wallets
class _AppStringsDashboardWalletsPt extends AppStringsDashboardWalletsEn {
	_AppStringsDashboardWalletsPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Carteiras';
	@override String count({required Object n}) => '${n} contas';
	@override String more({required Object n}) => '+${n} contas';
	@override String viewDetails({required Object name}) => 'Ver detalhes de ${name}';
}

// Path: dashboard.transactions
class _AppStringsDashboardTransactionsPt extends AppStringsDashboardTransactionsEn {
	_AppStringsDashboardTransactionsPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Últimas Transações';
	@override String get subtitle => 'As 5 mais recentes';
	@override String get empty => 'Nada recente por aqui';
	@override String get emptySubtitle => 'Suas transações vão aparecer aqui';
	@override String more({required Object n}) => '+${n} transações';
}

// Path: dashboard.widgets
class _AppStringsDashboardWidgetsPt extends AppStringsDashboardWidgetsEn {
	_AppStringsDashboardWidgetsPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override late final _AppStringsDashboardWidgetsBalancePt balance = _AppStringsDashboardWidgetsBalancePt._(_root);
	@override late final _AppStringsDashboardWidgetsQuickActionsPt quickActions = _AppStringsDashboardWidgetsQuickActionsPt._(_root);
	@override late final _AppStringsDashboardWidgetsWalletsPt wallets = _AppStringsDashboardWidgetsWalletsPt._(_root);
	@override late final _AppStringsDashboardWidgetsLoansPt loans = _AppStringsDashboardWidgetsLoansPt._(_root);
	@override late final _AppStringsDashboardWidgetsTransactionsPt transactions = _AppStringsDashboardWidgetsTransactionsPt._(_root);
	@override late final _AppStringsDashboardWidgetsCategoryBreakdownPt categoryBreakdown = _AppStringsDashboardWidgetsCategoryBreakdownPt._(_root);
	@override late final _AppStringsDashboardWidgetsChartAccountsPt chartAccounts = _AppStringsDashboardWidgetsChartAccountsPt._(_root);
	@override late final _AppStringsDashboardWidgetsCreditCardsPt creditCards = _AppStringsDashboardWidgetsCreditCardsPt._(_root);
	@override late final _AppStringsDashboardWidgetsSettingsPt settings = _AppStringsDashboardWidgetsSettingsPt._(_root);
}

// Path: wallets.empty
class _AppStringsWalletsEmptyPt extends AppStringsWalletsEmptyEn {
	_AppStringsWalletsEmptyPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Nenhuma carteira achada';
	@override String get message => 'Cria a primeira pra começar a controlar tudo.';
	@override String get action => 'Criar Carteira';
}

// Path: wallets.emptyArchived
class _AppStringsWalletsEmptyArchivedPt extends AppStringsWalletsEmptyArchivedEn {
	_AppStringsWalletsEmptyArchivedPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sem carteiras arquivadas';
	@override String get message => 'As carteiras arquivadas ficam aqui.';
}

// Path: wallets.filter
class _AppStringsWalletsFilterPt extends AppStringsWalletsFilterEn {
	_AppStringsWalletsFilterPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get active => 'Ativas';
	@override String get archived => 'Arquivadas';
	@override String get all => 'Todas';
}

// Path: wallets.form
class _AppStringsWalletsFormPt extends AppStringsWalletsFormEn {
	_AppStringsWalletsFormPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get newTitle => 'Nova Carteira';
	@override String get editTitle => 'Editar Carteira';
	@override String get name => 'Nome da carteira';
	@override String get namePlaceholder => 'Ex: Nubank, Dinheiro da Carteira';
	@override String get nameRequired => 'Precisamos de um nome';
	@override String get description => 'Descrição';
	@override String get descriptionPlaceholder => 'Pra que serve essa carteira? (opcional)';
	@override String get currency => 'Moeda';
	@override String get currencyLockedByParent => 'Herança da carteira mãe';
	@override String get parent => 'Carteira Mãe (opcional)';
	@override String get parentEmpty => 'Não tem carteira mãe disponível';
	@override String get chartAccount => 'Plano de contas';
	@override String get chartAccountLocked => 'Não pode mudar o plano de conta';
	@override String get createSuccess => 'Carteira criada com sucesso';
	@override String get updateSuccess => 'Carteira editada de boa';
	@override String loadParentError({required Object error}) => 'Erro ao carregar carteiras mãe: ${error}';
	@override String loadChartAccountError({required Object error}) => 'Erro ao carregar o plano: ${error}';
}

// Path: wallets.delete
class _AppStringsWalletsDeletePt extends AppStringsWalletsDeleteEn {
	_AppStringsWalletsDeletePt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get dialogTitle => 'Apagar carteira';
	@override String dialogMessage({required Object name}) => 'Certeza absoluta que quer excluir a ${name}?';
	@override String get cancel => 'Deixa quieto';
	@override String get confirm => 'Apagar de vez';
	@override String get success => 'Carteira apagada';
	@override String error({required Object error}) => 'Deu ruim pra apagar: ${error}';
}

// Path: wallets.errors
class _AppStringsWalletsErrorsPt extends AppStringsWalletsErrorsEn {
	_AppStringsWalletsErrorsPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get load => 'Não conseguimos carregar as carteiras';
	@override String get retry => 'Tentar de novo';
	@override String comingSoon({required Object name}) => '${name} em breve na área';
}

// Path: wallets.subtitle
class _AppStringsWalletsSubtitlePt extends AppStringsWalletsSubtitleEn {
	_AppStringsWalletsSubtitlePt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get mainAccount => 'Conta principal';
	@override String get cashDigital => 'Vivo & Digital';
	@override String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n,
		one: '${n} carteira',
		other: '${n} carteiras',
	);
	@override String get account => 'Conta';
	@override String get physicalCash => 'Dinheiro no bolso';
	@override String get digitalWallet => 'Digital';
}

// Path: wallets.options
class _AppStringsWalletsOptionsPt extends AppStringsWalletsOptionsEn {
	_AppStringsWalletsOptionsPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get viewTransactions => 'Ver o extrato';
	@override String get viewTransactionsSubtitle => 'Checar todas as transações';
	@override String get transferFunds => 'Fazer transferência';
	@override String get transferFundsSubtitle => 'Mover a grana entre as contas';
	@override String get editWallet => 'Editar carteira';
	@override String get editWalletSubtitle => 'Trocar nome, cor, etc';
	@override String get duplicateWallet => 'Duplicar carteira';
	@override String get duplicateWalletSubtitle => 'Criar uma igualzinha';
	@override String get archiveWallet => 'Arquivar carteira';
	@override String get archiveWalletSubtitle => 'Tirar da tela principal';
	@override String get unarchiveWallet => 'Desarquivar';
	@override String get unarchiveWalletSubtitle => 'Voltar pra tela principal';
	@override String get deleteWallet => 'Apagar sem dó';
	@override String get deleteWalletSubtitle => 'Excluir permanentemente';
	@override String get defaultTitle => 'Carteira';
}

// Path: loans.filter
class _AppStringsLoansFilterPt extends AppStringsLoansFilterEn {
	_AppStringsLoansFilterPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get active => 'Em Aberto';
	@override String get history => 'Histórico';
	@override String get all => 'Todos';
	@override String get pending => 'Pendentes';
	@override String get lent => 'A Receber';
	@override String get borrowed => 'A Pagar';
}

// Path: loans.summary
class _AppStringsLoansSummaryPt extends AppStringsLoansSummaryEn {
	_AppStringsLoansSummaryPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get netBalance => 'SALDO LÍQUIDO';
	@override String get activeLoans => 'EM ABERTO';
	@override String get noActive => 'Tudo limpo';
	@override String lent({required Object n}) => '${n} a receber';
	@override String borrowed({required Object n}) => '${n} a pagar';
	@override String pending({required Object n}) => '${n} pendentes';
}

// Path: loans.card
class _AppStringsLoansCardPt extends AppStringsLoansCardEn {
	_AppStringsLoansCardPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get lent => 'Para Receber';
	@override String get borrowed => 'Para Pagar';
	@override String active({required Object n}) => '${n} abertos';
	@override String multiple({required Object n}) => '${n} empréstimos';
	@override String transactions({required Object n}) => '${n} lances';
	@override String overdue({required Object n}) => '${n} dias de atraso';
	@override String due({required Object date}) => 'Vence ${date}';
}

// Path: loans.form
class _AppStringsLoansFormPt extends AppStringsLoansFormEn {
	_AppStringsLoansFormPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get newTitle => 'Novo Empréstimo';
	@override String get editTitle => 'Editar Empréstimo';
	@override String get type => 'Tipo de empréstimo';
	@override String get lend => 'A Receber';
	@override String get borrow => 'A Pagar';
	@override String get contact => 'Contato';
	@override String get contactPlaceholder => 'De quem ou pra quem?';
	@override String get account => 'Da Conta';
	@override String get accountPlaceholder => 'Selecionar a conta';
	@override String get amount => 'Valor';
	@override String get description => 'Descrição';
	@override String get date => 'Data';
	@override String get dueDate => 'Data do pagamento';
	@override String get selectDate => 'Dia do pagamento';
	@override String get optional => '(Opcional)';
	@override String get createTransaction => 'Gerar recibo na carteira';
	@override String get recordAutomatically => 'Registrar a transação sozinho';
	@override String get transactionCategory => 'Categoria pra isso';
	@override String get category => 'Categoria';
	@override String get categoryPlaceholder => 'Seleciona aí';
	@override String get save => 'Salvar';
	@override String get successCreate => 'Feito! Tá registrado.';
	@override String get successUpdate => 'Empréstimo atualizado';
	@override String get contactRequired => 'Tem que pôr o contato';
	@override String get accountRequired => 'Tem que pôr a conta';
	@override String get amountRequired => 'Faltou a grana';
}

// Path: loans.detail
class _AppStringsLoansDetailPt extends AppStringsLoansDetailEn {
	_AppStringsLoansDetailPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Detalhes';
	@override String get deleteTitle => 'Apagar Empréstimo';
	@override String get deleteMessage => 'Tem certeza que quer apagar isso do mapa?';
	@override String get deleteSuccess => 'Pronto, sumiu.';
	@override String deleteError({required Object error}) => 'Deu pau pra apagar: ${error}';
	@override String get notFound => 'Sumiu...';
	@override String get progress => 'Como tá o pagamento';
	@override String get info => 'Informação Geral';
	@override String get pay => 'Pagar/Receber';
	@override String get viewHistory => 'Ver Histórico Completo';
	@override String original({required Object amount}) => 'Valor Inicial: ${amount}';
	@override String get section => 'Detalhes';
	@override String get activeSummary => 'Resumo Ativo';
	@override String get activeLent => 'Pra Receber (Aberto)';
	@override String get activeBorrowed => 'Pra Pagar (Aberto)';
	@override String get activeNet => 'Saldo Final (Ativo)';
	@override String get activeTotal => 'Empréstimos Ativos';
	@override String get startDate => 'Começou em';
	@override String get dueDate => 'Vencimento';
	@override late final _AppStringsLoansDetailTypePt type = _AppStringsLoansDetailTypePt._(_root);
	@override late final _AppStringsLoansDetailPaymentPt payment = _AppStringsLoansDetailPaymentPt._(_root);
}

// Path: loans.history
class _AppStringsLoansHistoryPt extends AppStringsLoansHistoryEn {
	_AppStringsLoansHistoryPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Histórico Geral';
	@override String get section => 'Todos os empréstimos';
	@override String get totalLoaned => 'Total rodado';
	@override String get noLoans => 'Não achamos nada com esses filtros.';
	@override late final _AppStringsLoansHistoryFilterPt filter = _AppStringsLoansHistoryFilterPt._(_root);
	@override late final _AppStringsLoansHistoryHeadersPt headers = _AppStringsLoansHistoryHeadersPt._(_root);
	@override late final _AppStringsLoansHistoryItemPt item = _AppStringsLoansHistoryItemPt._(_root);
	@override late final _AppStringsLoansHistorySummaryPt summary = _AppStringsLoansHistorySummaryPt._(_root);
}

// Path: loans.contactDetail
class _AppStringsLoansContactDetailPt extends AppStringsLoansContactDetailEn {
	_AppStringsLoansContactDetailPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String titleWith({required Object name}) => 'Contas com ${name}';
}

// Path: loans.share
class _AppStringsLoansSharePt extends AppStringsLoansShareEn {
	_AppStringsLoansSharePt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Compartilhar Empréstimo';
	@override String get contactTitle => 'Compartilhar tudo';
	@override String get button => 'Mandar';
	@override String get copy => 'Copiar texto';
	@override String get message => 'Saca só o resumo da conta:';
	@override String contactMessage({required Object name}) => 'Resumo de contas com ${name}:';
	@override String error({required Object error}) => 'Deu ruim: ${error}';
	@override String get contactCopied => 'Tá na área de transferência!';
	@override String activeLoans({required Object n}) => 'Empréstimos ativos (${n}):';
	@override String loanItem({required Object description, required Object amount, required Object date, required Object percent}) => '• ${description}: ${amount} (Data: ${date}) - ${percent}% pago';
	@override String get loanStatement => 'MoneyT - Extrato do Empréstimo';
	@override String get loanSummary => 'MoneyT - Resumo';
	@override String get personalLoan => 'Empréstimo Pessoal';
	@override String remaining({required Object amount}) => 'Falta pagar: ${amount}';
	@override String get remainingLabel => 'Ainda falta';
	@override String original({required Object amount}) => 'de ${amount} no total';
	@override String progress({required Object percent}) => 'Tá em: ${percent}% pago';
	@override String get progressLabel => 'Progresso';
	@override String get paidSuffix => 'Tá pago';
	@override String date({required Object date}) => 'Data: ${date}';
	@override String get dateLabel => 'Data';
	@override String contact({required Object name}) => 'Com quem: ${name}';
	@override String get contactLabel => 'Contato';
	@override String generated({required Object date}) => 'Gerado em ${date}';
	@override String generatedLabel({required Object date}) => 'Gerado em ${date}';
	@override String totalActive({required Object n}) => 'No total: ${n} ativos';
	@override String get active => 'abertos';
	@override String get poweredBy => 'Gerado pelo MoneyT • moneyt.io';
	@override String get copied => 'Copiado!';
	@override String netBalance({required Object amount, required Object status}) => 'Saldo Líquido: ${amount} (${status})';
	@override String get netBalanceLabel => 'Saldo Líquido';
	@override String get owed => 'Você vai receber';
	@override String get owe => 'Você deve';
	@override String lent({required Object amount}) => 'Você emprestou: ${amount}';
	@override String get lentLabel => 'Você Emprestou';
	@override String borrowed({required Object amount}) => 'Você pegou: ${amount}';
	@override String get borrowedLabel => 'Você Pegou';
	@override String contactSummary({required Object name}) => 'Resumo - ${name}';
}

// Path: loans.payment
class _AppStringsLoansPaymentPt extends AppStringsLoansPaymentEn {
	_AppStringsLoansPaymentPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Registrar Pgto.';
	@override String get amount => 'Qual foi o valor?';
	@override String get amountPlaceholder => '0,00';
	@override String get amountRequired => 'Põe o valor aí';
	@override String get invalidAmount => 'Acho que digitou errado';
	@override String get exceedsBalance => 'Aí é mais do que falta pagar, chefe';
	@override String get date => 'Data do pagamento';
	@override String get account => 'Caiu em qual conta?';
	@override String get selectAccount => 'Escolhe aí';
	@override String get details => 'Anotações extras';
	@override String get detailsPlaceholder => 'Qualquer observação (opcional)';
	@override String get success => 'Boa! Pagamento registrado.';
	@override String error({required Object error}) => 'Erro ao registrar: ${error}';
	@override String get errorAmount => 'Põe um valor certo';
	@override String get errorAccount => 'Selecione a conta que recebeu';
	@override String errorLoading({required Object error}) => 'Não rolou carregar: ${error}';
	@override late final _AppStringsLoansPaymentSummaryPt summary = _AppStringsLoansPaymentSummaryPt._(_root);
	@override late final _AppStringsLoansPaymentQuickPt quick = _AppStringsLoansPaymentQuickPt._(_root);
}

// Path: loans.item
class _AppStringsLoansItemPt extends AppStringsLoansItemEn {
	_AppStringsLoansItemPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String due({required Object date}) => 'Vence: ${date}';
	@override String paidAmount({required Object amount}) => 'Pago: ${amount}';
	@override String remaining({required Object amount}) => 'Falta: ${amount}';
	@override String percentPaid({required Object percent}) => '${percent}% já foi';
}

// Path: loans.section
class _AppStringsLoansSectionPt extends AppStringsLoansSectionEn {
	_AppStringsLoansSectionPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get activeLoans => 'Empréstimos Ativos';
	@override String loansCount({required Object n}) => '${n} contratos';
}

// Path: loans.empty
class _AppStringsLoansEmptyPt extends AppStringsLoansEmptyEn {
	_AppStringsLoansEmptyPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Nenhum empréstimo ativo';
	@override String get message => 'Ninguém te deve e você não deve a ninguém.';
	@override String get action => 'Anotar Novo';
}

// Path: categories.form
class _AppStringsCategoriesFormPt extends AppStringsCategoriesFormEn {
	_AppStringsCategoriesFormPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get newTitle => 'Nova Categoria';
	@override String get editTitle => 'Editar Categoria';
	@override String get name => 'Nome';
	@override String get namePlaceholder => 'Ex: Uber, Mercado, Balada';
	@override String get nameRequired => 'Põe o nome da categoria';
	@override String get parent => 'Subcategoria de? (Opcional)';
	@override String get noParent => 'Deixar como principal';
	@override String get asSubcategory => 'Vai ficar dentro de outra';
	@override String get asRoot => 'Vai ficar de fora (Principal)';
	@override String get active => 'Categoria Ativa';
	@override String get activeDescription => 'Deixar visível nas novas compras';
	@override String get selectIcon => 'Escolhe um ícone';
	@override String get selectColor => 'Põe uma cor';
	@override String get saveSuccess => 'Tudo certo, salva!';
	@override String saveError({required Object error}) => 'Vish, erro ao salvar: ${error}';
}

// Path: categories.parentSelection
class _AppStringsCategoriesParentSelectionPt extends AppStringsCategoriesParentSelectionEn {
	_AppStringsCategoriesParentSelectionPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Escolher Categoria Mãe';
	@override String get subtitle => 'Onde ela vai morar?';
	@override String get noParent => 'Deixar solta (Principal)';
}

// Path: categories.report
class _AppStringsCategoriesReportPt extends AppStringsCategoriesReportEn {
	_AppStringsCategoriesReportPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Raio-X Avançado';
	@override String get timeFilter => 'No período de';
	@override String get thisMonth => 'Este Mês';
	@override String get lastMonth => 'Mês Passado';
	@override String get thisYear => 'Este Ano';
	@override String get allTime => 'Toda a Vida';
	@override String get details => 'O que rolou';
	@override String get noTransactions => 'Nenhuma compra registrada';
	@override String get income => 'Grana que entrou';
	@override String get expense => 'Grana que saiu';
}

// Path: backups.menu
class _AppStringsBackupsMenuPt extends AppStringsBackupsMenuEn {
	_AppStringsBackupsMenuPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get settings => 'Ajustes de Backup';
	@override String get comingSoon => 'Os ajustes logo chegam';
}

// Path: backups.filters
class _AppStringsBackupsFiltersPt extends AppStringsBackupsFiltersEn {
	_AppStringsBackupsFiltersPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get all => 'Todos';
	@override String get auto => 'No Automático';
	@override String get manual => 'Você que fez';
	@override String get thisMonth => 'Mês';
	@override String get lastMonth => 'Mês Anterior';
	@override String get thisYear => 'Ano';
	@override String get lastYear => 'Ano Anterior';
}

// Path: backups.status
class _AppStringsBackupsStatusPt extends AppStringsBackupsStatusEn {
	_AppStringsBackupsStatusPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get loading => 'Carregando...';
	@override String get error => 'Erro ao carregar os dados salvos';
	@override String get empty => 'Nenhum backup feito';
	@override String get emptyAction => 'Toca no \'+\' para proteger seus dados';
	@override String get success => 'Pronto!';
	@override String get created => 'Seus dados estão protegidos no backup.';
	@override String createError({required Object error}) => 'Erro ao tentar salvar: ${error}';
	@override String restoreError({required Object error}) => 'Erro ao puxar o backup: ${error}';
	@override String deleteError({required Object error}) => 'Deu ruim para apagar: ${error}';
}

// Path: backups.actions
class _AppStringsBackupsActionsPt extends AppStringsBackupsActionsEn {
	_AppStringsBackupsActionsPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get create => 'Fazer Backup';
	@override String get import => 'Puxar Backup (Importar)';
	@override String get restore => 'Restaurar (Recuperar)';
	@override String get delete => 'Excluir';
	@override String get share => 'Compartilhar';
	@override String get cancel => 'Deixar pra lá';
	@override String get retry => 'Tentar de novo';
	@override String get ok => 'Show';
}

// Path: backups.dialogs
class _AppStringsBackupsDialogsPt extends AppStringsBackupsDialogsEn {
	_AppStringsBackupsDialogsPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override late final _AppStringsBackupsDialogsInfoPt info = _AppStringsBackupsDialogsInfoPt._(_root);
	@override late final _AppStringsBackupsDialogsRestorePt restore = _AppStringsBackupsDialogsRestorePt._(_root);
	@override late final _AppStringsBackupsDialogsDeletePt delete = _AppStringsBackupsDialogsDeletePt._(_root);
}

// Path: backups.stats
class _AppStringsBackupsStatsPt extends AppStringsBackupsStatsEn {
	_AppStringsBackupsStatsPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Métricas de Backup';
	@override String get totalBackups => 'Quantos já fizemos';
	@override String get totalSize => 'Peso total';
	@override String get oldest => 'O mais velhinho';
	@override String get latest => 'O mais recente';
	@override String get autoBackupStatus => 'Auto Backup Ativo?';
	@override String get active => 'Tá on';
	@override String get inactive => 'Tá off';
}

// Path: backups.options
class _AppStringsBackupsOptionsPt extends AppStringsBackupsOptionsEn {
	_AppStringsBackupsOptionsPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override late final _AppStringsBackupsOptionsRestorePt restore = _AppStringsBackupsOptionsRestorePt._(_root);
	@override late final _AppStringsBackupsOptionsSharePt share = _AppStringsBackupsOptionsSharePt._(_root);
	@override late final _AppStringsBackupsOptionsDeletePt delete = _AppStringsBackupsOptionsDeletePt._(_root);
	@override String get latestBadge => 'Último';
	@override String get latestFile => 'Mais recente de todos';
	@override String get backupFile => 'Arquivo zipado';
}

// Path: backups.format
class _AppStringsBackupsFormatPt extends AppStringsBackupsFormatEn {
	_AppStringsBackupsFormatPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String auto({required Object date}) => 'Salvo sozinho - ${date}';
	@override String manual({required Object date}) => 'Você que salvou - ${date}';
	@override String get initial => 'O Primeiro de Todos';
	@override String generic({required Object date}) => 'Backup de ${date}';
}

// Path: v2.voice
class _AppStringsV2VoicePt extends AppStringsV2VoiceEn {
	_AppStringsV2VoicePt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get errorProcessing => 'Não entendi nada do que cê disse. Fala de novo.';
	@override String get tapMicrophone => 'Aperta no microfone pra falar comigo';
	@override String get listening => 'Tô te ouvindo...';
	@override String get missingApiKey => 'Coloca a GEMINI_API_KEY no arquivo .env pra IA funcionar.';
	@override String aiError({required Object error}) => 'Erro na IA: ${error}';
	@override String get cancel => 'Cancela';
	@override String get scan => 'Escanear';
}

// Path: v2.transactions
class _AppStringsV2TransactionsPt extends AppStringsV2TransactionsEn {
	_AppStringsV2TransactionsPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get invalidAmount => 'Coloca um valor certo aí.';
	@override String get selectAccount => 'Avisar pra qual conta vai/foi.';
	@override String get selectCategory => 'Diz qual é a categoria disso.';
	@override String errorCreatingCategory({required Object error}) => 'Vish, erro criando a categoria: ${error}';
	@override String error({required Object error}) => 'Erro: ${error}';
	@override String get more => 'Mais';
	@override String get expense => 'Gasto';
	@override String get income => 'Ganho';
	@override String get deleteTransaction => 'Apagar esse lançamento?';
	@override String get cancel => 'Deixa quieto';
	@override String get delete => 'Apagar';
	@override String get yesterday => 'Ontem';
	@override String get usedCategories => 'SÓ O QUE VOCÊ USA';
	@override String get noTransactions => 'Nadinha registrado.';
	@override String get recentActivity => 'Lances Recentes';
	@override String get searchTransaction => 'Procurar compra...';
	@override String get date => 'Quando';
	@override String get wallet => 'De Onde Saiu';
	@override String get transactionDeleted => 'Lançamento apagado.';
	@override String get selectCategoryTitle => 'Onde encaixa isso?';
	@override String get searchCategory => 'Pesquisar categoria...';
	@override String get noCategoriesAvailable => 'Sem categorias prontas';
	@override String get createNewCategory => 'Criar categoria do zero';
	@override String get amount => 'A GRANA';
	@override String get description => 'O QUE FOI?';
	@override String get category => 'CATEGORIA';
	@override String get addNote => 'Botar uma observação...';
	@override String get today => 'Hoje';
	@override String get editTransaction => 'Editar esse lance';
	@override String get newTransaction => 'Novo Lançamento';
	@override String get selectWallet => 'Avisa de onde saiu';
	@override String get save => 'Registrar';
	@override String get transactionUpdated => 'Lançamento ajeitado.';
	@override String get transactionSaved => 'Pronto, tá no sistema.';
}

// Path: v2.settings
class _AppStringsV2SettingsPt extends AppStringsV2SettingsEn {
	_AppStringsV2SettingsPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ajustar o App';
	@override String get categories => 'Suas Categorias';
	@override String get wallets => 'Onde fica a grana (Carteiras)';
	@override String get language => 'Idioma';
	@override String get currency => 'Qual a moeda?';
	@override String get contact => 'Falar com a gente';
	@override String get legacyView => 'Versão Tradicional (Antiga)';
	@override String get deleteCategory => 'Excluir de vez a categoria?';
	@override String get deleteWallet => 'Apagar carteira toda?';
	@override String get cannotUndo => 'Se fizer, já era, não dá pra desfazer.';
	@override String get deleteWalletWarning => 'Sumiu carteira, sumiram os lançamentos dentro dela.';
	@override String deleteError({required Object error}) => 'Deu pau pra apagar: ${error}';
	@override String get noCategoriesCreated => 'Não achei categorias.\nBora criar uma?';
	@override String get noWalletsCreated => 'Zero carteiras cadastradas.\nCria a primeira aí.';
	@override String get walletDeleted => 'Carteira pro lixo.';
	@override String get cancel => 'Desistir';
	@override String get delete => 'Excluir';
	@override String get expenses => 'Despesas';
	@override String get income => 'Receitas';
	@override String get newWallet => 'Nova Carteira';
	@override String get editWallet => 'Editar Carteira';
	@override String get walletName => 'Nome dela';
	@override String get saveWallet => 'Gravar Carteira';
	@override String get deleteWalletHasTransactions => 'Não é possível excluir esta carteira porque ela possui transações existentes.';
}

// Path: v2.dashboard
class _AppStringsV2DashboardPt extends AppStringsV2DashboardEn {
	_AppStringsV2DashboardPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get greetingMorning => 'Bom dia, patrão!';
	@override String get totalBalance => 'A GRANA TODA';
	@override late final _AppStringsV2DashboardDateFiltersPt dateFilters = _AppStringsV2DashboardDateFiltersPt._(_root);
	@override late final _AppStringsV2DashboardWalletFiltersPt walletFilters = _AppStringsV2DashboardWalletFiltersPt._(_root);
	@override late final _AppStringsV2DashboardBackgroundPt background = _AppStringsV2DashboardBackgroundPt._(_root);
	@override late final _AppStringsV2DashboardIncomeExpensePt incomeExpense = _AppStringsV2DashboardIncomeExpensePt._(_root);
	@override late final _AppStringsV2DashboardGaugePt gauge = _AppStringsV2DashboardGaugePt._(_root);
	@override late final _AppStringsV2DashboardActivityListPt activityList = _AppStringsV2DashboardActivityListPt._(_root);
}

// Path: v2.categories
class _AppStringsV2CategoriesPt extends AppStringsV2CategoriesEn {
	_AppStringsV2CategoriesPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Categorias';
	@override String get searchPlaceholder => 'Caçar categoria...';
	@override String get newCategory => 'Adicionar nova';
	@override String get editCategory => 'Mudar a categoria';
	@override String get noCategories => 'Nadinha cadastrado';
	@override late final _AppStringsV2CategoriesFormPt form = _AppStringsV2CategoriesFormPt._(_root);
}

// Path: v2.onboarding
class _AppStringsV2OnboardingPt extends AppStringsV2OnboardingEn {
	_AppStringsV2OnboardingPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override late final _AppStringsV2OnboardingButtonsPt buttons = _AppStringsV2OnboardingButtonsPt._(_root);
	@override late final _AppStringsV2OnboardingSplashPt splash = _AppStringsV2OnboardingSplashPt._(_root);
	@override late final _AppStringsV2OnboardingExpenseCategoriesPt expenseCategories = _AppStringsV2OnboardingExpenseCategoriesPt._(_root);
	@override late final _AppStringsV2OnboardingFinancialGoalsPt financialGoals = _AppStringsV2OnboardingFinancialGoalsPt._(_root);
	@override late final _AppStringsV2OnboardingRegistrationMethodPt registrationMethod = _AppStringsV2OnboardingRegistrationMethodPt._(_root);
	@override late final _AppStringsV2OnboardingAiAnalysisPt aiAnalysis = _AppStringsV2OnboardingAiAnalysisPt._(_root);
	@override late final _AppStringsV2OnboardingMainPriorityPt mainPriority = _AppStringsV2OnboardingMainPriorityPt._(_root);
	@override late final _AppStringsV2OnboardingAiVoicePt aiVoice = _AppStringsV2OnboardingAiVoicePt._(_root);
}

// Path: v2.dateSelection
class _AppStringsV2DateSelectionPt extends AppStringsV2DateSelectionEn {
	_AppStringsV2DateSelectionPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get days => 'Dias';
	@override String get months => 'Meses';
	@override String get years => 'Anos';
}

// Path: transactions.filter.ranges
class _AppStringsTransactionsFilterRangesPt extends AppStringsTransactionsFilterRangesEn {
	_AppStringsTransactionsFilterRangesPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get thisMonth => 'Este mês';
	@override String get lastMonth => 'Mês passado';
	@override String get thisYear => 'Este ano';
	@override String get lastYear => 'Ano passado';
}

// Path: transactions.filter.subtitles
class _AppStringsTransactionsFilterSubtitlesPt extends AppStringsTransactionsFilterSubtitlesEn {
	_AppStringsTransactionsFilterSubtitlesPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get income => 'Dinheiro que entrou';
	@override String get expense => 'Dinheiro gasto';
	@override String get transfer => 'Dinheiro movido';
}

// Path: transactions.share.receipt
class _AppStringsTransactionsShareReceiptPt extends AppStringsTransactionsShareReceiptEn {
	_AppStringsTransactionsShareReceiptPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => '--- Detalhes da Transação ---';
	@override String amount({required Object amount}) => 'Valor: ${amount}';
	@override String description({required Object description}) => 'Descrição: ${description}';
	@override String category({required Object category}) => 'Categoria: ${category}';
	@override String date({required Object date}) => 'Data: ${date}';
	@override String time({required Object time}) => 'Hora: ${time}';
	@override String wallet({required Object wallet}) => 'Conta: ${wallet}';
	@override String contact({required Object contact}) => 'Contato: ${contact}';
	@override String id({required Object id}) => 'ID da Transação: ${id}';
	@override String get separator => '--------------------------';
}

// Path: onboarding.specificProblem.options
class _AppStringsOnboardingSpecificProblemOptionsPt extends AppStringsOnboardingSpecificProblemOptionsEn {
	_AppStringsOnboardingSpecificProblemOptionsPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get debts => 'Dívidas e empréstimos';
	@override String get savings => 'Não consigo guardar nada';
	@override String get unknown => 'Não sei onde gastei';
	@override String get chaos => 'Um caos financeiro total';
}

// Path: onboarding.personalGoal.options
class _AppStringsOnboardingPersonalGoalOptionsPt extends AppStringsOnboardingPersonalGoalOptionsEn {
	_AppStringsOnboardingPersonalGoalOptionsPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get debtFree => 'Sair do vermelho';
	@override String get saveTrip => 'Guardar pro carro/viagem';
	@override String get invest => 'Começar a investir';
	@override String get peace => 'Paz financeira';
}

// Path: onboarding.solutionPreview.benefits
class _AppStringsOnboardingSolutionPreviewBenefitsPt extends AppStringsOnboardingSolutionPreviewBenefitsEn {
	_AppStringsOnboardingSolutionPreviewBenefitsPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get visualize => 'Veja seus gastos em tempo real';
	@override String get goals => 'Bata suas metas';
	@override String get smart => 'Tome decisões inteligentes';
}

// Path: onboarding.currentMethod.options
class _AppStringsOnboardingCurrentMethodOptionsPt extends AppStringsOnboardingCurrentMethodOptionsEn {
	_AppStringsOnboardingCurrentMethodOptionsPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get excel => 'Planilhas do Excel';
	@override String get notebook => 'Caderninho';
	@override String get mental => 'Tudo na cabeça';
	@override String get none => 'Não controlo nada';
}

// Path: onboarding.featuresShowcase.features
class _AppStringsOnboardingFeaturesShowcaseFeaturesPt extends AppStringsOnboardingFeaturesShowcaseFeaturesEn {
	_AppStringsOnboardingFeaturesShowcaseFeaturesPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get income => 'Receitas';
	@override String get expense => 'Despesas';
	@override String get transfer => 'Transferências';
	@override String get loans => 'Empréstimos';
	@override String get goals => 'Metas';
	@override String get budgets => 'Orçamentos';
	@override String get investments => 'Investimentos';
	@override String get cloud => 'MoneyT na Nuvem';
	@override String get openBanking => 'Open Finance';
}

// Path: onboarding.complete.stats
class _AppStringsOnboardingCompleteStatsPt extends AppStringsOnboardingCompleteStatsEn {
	_AppStringsOnboardingCompleteStatsPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Probabilidade de Sucesso';
	@override String get before => 'Antes do MoneyT';
	@override String get after => 'Com MoneyT';
}

// Path: dashboard.widgets.balance
class _AppStringsDashboardWidgetsBalancePt extends AppStringsDashboardWidgetsBalanceEn {
	_AppStringsDashboardWidgetsBalancePt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Saldo Total';
	@override String get description => 'Seu status financeiro geral';
}

// Path: dashboard.widgets.quickActions
class _AppStringsDashboardWidgetsQuickActionsPt extends AppStringsDashboardWidgetsQuickActionsEn {
	_AppStringsDashboardWidgetsQuickActionsPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ações Rápidas';
	@override String get description => 'Acesso fácil para registrar rápido';
}

// Path: dashboard.widgets.wallets
class _AppStringsDashboardWidgetsWalletsPt extends AppStringsDashboardWidgetsWalletsEn {
	_AppStringsDashboardWidgetsWalletsPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Carteiras';
	@override String get description => 'Visão geral de onde tá o dinheiro';
}

// Path: dashboard.widgets.loans
class _AppStringsDashboardWidgetsLoansPt extends AppStringsDashboardWidgetsLoansEn {
	_AppStringsDashboardWidgetsLoansPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Empréstimos';
	@override String get description => 'Grana que entrou ou saiu emprestada';
}

// Path: dashboard.widgets.transactions
class _AppStringsDashboardWidgetsTransactionsPt extends AppStringsDashboardWidgetsTransactionsEn {
	_AppStringsDashboardWidgetsTransactionsPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Transações Recentes';
	@override String get description => 'Movimentações de última hora';
}

// Path: dashboard.widgets.categoryBreakdown
class _AppStringsDashboardWidgetsCategoryBreakdownPt extends AppStringsDashboardWidgetsCategoryBreakdownEn {
	_AppStringsDashboardWidgetsCategoryBreakdownPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Resumo por Categoria';
	@override String get description => 'Gastos do mês atual';
	@override String get empty_message => 'Sem gastos por enquanto.';
	@override String get others => 'Outros';
	@override String get back => 'Voltar';
	@override String get monthlyBudget => 'Orçamento mensal';
	@override String leftover({required Object amount}) => 'Sobrou ${amount} da sua receita.';
	@override String exceeded({required Object amount}) => 'Você gastou ${amount} a mais que a receita.';
	@override String noIncome({required Object amount}) => 'Gastos registrados: ${amount} (Sem receita)';
}

// Path: dashboard.widgets.chartAccounts
class _AppStringsDashboardWidgetsChartAccountsPt extends AppStringsDashboardWidgetsChartAccountsEn {
	_AppStringsDashboardWidgetsChartAccountsPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Plano de Contas';
	@override String get description => 'Estrutura das contas';
}

// Path: dashboard.widgets.creditCards
class _AppStringsDashboardWidgetsCreditCardsPt extends AppStringsDashboardWidgetsCreditCardsEn {
	_AppStringsDashboardWidgetsCreditCardsPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Cartões de Crédito';
	@override String get description => 'Limites e faturas';
}

// Path: dashboard.widgets.settings
class _AppStringsDashboardWidgetsSettingsPt extends AppStringsDashboardWidgetsSettingsEn {
	_AppStringsDashboardWidgetsSettingsPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Customizar Início';
	@override String get subtitle => 'Arraste e organize os cards como quiser.';
	@override late final _AppStringsDashboardWidgetsSettingsResetPt reset = _AppStringsDashboardWidgetsSettingsResetPt._(_root);
	@override String get saveSuccess => 'Tudo salvo!';
	@override String saveError({required Object error}) => 'Deu ruim ao salvar: ${error}';
	@override String get saving => 'Salvando...';
	@override String get save => 'Salvar Layout';
}

// Path: loans.detail.type
class _AppStringsLoansDetailTypePt extends AppStringsLoansDetailTypeEn {
	_AppStringsLoansDetailTypePt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get label => 'Qual tipo';
	@override String get personal => 'Empréstimo Pessoal';
	@override String get borrowed => 'Boleto/Dívida';
	@override String get auto => 'Financiamento do Carro';
	@override String get mortgage => 'Financiamento da Casa';
	@override String get student => 'Empréstimo Estudantil';
}

// Path: loans.detail.payment
class _AppStringsLoansDetailPaymentPt extends AppStringsLoansDetailPaymentEn {
	_AppStringsLoansDetailPaymentPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get history => 'Histórico de Pagamentos';
	@override String date({required Object date}) => 'Pago dia ${date}';
	@override String transactionId({required Object id}) => 'ID: ${id}';
	@override String paid({required Object amount}) => '${amount} pago';
	@override String remaining({required Object amount}) => 'Falta ${amount}';
}

// Path: loans.history.filter
class _AppStringsLoansHistoryFilterPt extends AppStringsLoansHistoryFilterEn {
	_AppStringsLoansHistoryFilterPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get all => 'Todos';
	@override String get lent => 'Pra Receber';
	@override String get borrowed => 'Pra Pagar';
	@override String get completed => 'Quitados';
	@override String get title => 'Filtros';
	@override String get reset => 'Zerar';
	@override String get apply => 'Aplicar';
	@override String get dateRange => 'Período';
	@override String get amountRange => 'Qual valor';
	@override String get startDate => 'Do dia';
	@override String get endDate => 'Até o dia';
	@override String get select => 'Selecionar';
}

// Path: loans.history.headers
class _AppStringsLoansHistoryHeadersPt extends AppStringsLoansHistoryHeadersEn {
	_AppStringsLoansHistoryHeadersPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get lent => 'Empréstimos a Receber';
	@override String get borrowed => 'Empréstimos a Pagar';
	@override String get completed => 'Tudo Quitado';
	@override String get active => 'Em Aberto';
	@override String get cancelled => 'Cancelados';
	@override String get writtenOff => 'Dados como perdidos';
}

// Path: loans.history.item
class _AppStringsLoansHistoryItemPt extends AppStringsLoansHistoryItemEn {
	_AppStringsLoansHistoryItemPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get defaultTitle => 'Empréstimo';
	@override String date({required Object date}) => 'Data: ${date}';
	@override String get lent => 'Pra Receber';
	@override String get borrowed => 'Pra Pagar';
	@override late final _AppStringsLoansHistoryItemStatusPt status = _AppStringsLoansHistoryItemStatusPt._(_root);
}

// Path: loans.history.summary
class _AppStringsLoansHistorySummaryPt extends AppStringsLoansHistorySummaryEn {
	_AppStringsLoansHistorySummaryPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Resumão';
	@override String get viewDetails => 'Ver os detalhes';
	@override String get hideDetails => 'Ocultar';
	@override String get outstandingLent => 'Grana pendente pra você';
	@override String get outstandingBorrowed => 'Grana que você deve';
	@override String get netPosition => 'Saldo Líquido';
	@override String get totalLent => 'O que você já emprestou';
	@override String get totalBorrowed => 'O que você já pegou';
	@override String get totalRepaidToYou => 'O que já te devolveram';
	@override String get totalYouRepaid => 'O que você já pagou';
	@override String get totalLoans => 'Total de empréstimos';
	@override String get completedLoans => 'Quitados';
}

// Path: loans.payment.summary
class _AppStringsLoansPaymentSummaryPt extends AppStringsLoansPaymentSummaryEn {
	_AppStringsLoansPaymentSummaryPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Resumo da brincadeira';
	@override String get defaultTitle => 'Empréstimo';
	@override String get amount => 'Valor a pagar/receber';
	@override String get remaining => 'O que ainda falta';
	@override String get progress => 'Como ficou';
	@override String description({required Object loan, required Object contact}) => '${loan} para ${contact}';
	@override String get unknownContact => 'Sem Nome';
	@override String total({required Object amount}) => '${amount} no total';
	@override String paid({required Object amount}) => 'Já foi pago: ${amount}';
	@override String remainingLabel({required Object amount}) => 'Falta isso: ${amount}';
}

// Path: loans.payment.quick
class _AppStringsLoansPaymentQuickPt extends AppStringsLoansPaymentQuickEn {
	_AppStringsLoansPaymentQuickPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String full({required Object amount}) => 'Pagar Tudo (${amount})';
	@override String half({required Object amount}) => 'A Metade (${amount})';
}

// Path: backups.dialogs.info
class _AppStringsBackupsDialogsInfoPt extends AppStringsBackupsDialogsInfoEn {
	_AppStringsBackupsDialogsInfoPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Dados do Backup';
	@override String get file => 'Arquivo:';
	@override String get size => 'Tamanho:';
	@override String get created => 'Data:';
	@override String get transactions => 'Transações:';
}

// Path: backups.dialogs.restore
class _AppStringsBackupsDialogsRestorePt extends AppStringsBackupsDialogsRestoreEn {
	_AppStringsBackupsDialogsRestorePt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Recuperar Dados';
	@override String content({required Object file}) => 'Tem certeza que quer voltar os dados pra versão "${file}"? O que tá no app hoje vai ser apagado.';
	@override String get success => 'Voltando os dados... o app vai reiniciar rapidão.';
}

// Path: backups.dialogs.delete
class _AppStringsBackupsDialogsDeletePt extends AppStringsBackupsDialogsDeleteEn {
	_AppStringsBackupsDialogsDeletePt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Apagar Backup';
	@override String content({required Object file}) => 'Certeza absoluta que quer excluir "${file}"? Já era depois disso.';
	@override String get success => 'Backup jogado fora.';
}

// Path: backups.options.restore
class _AppStringsBackupsOptionsRestorePt extends AppStringsBackupsOptionsRestoreEn {
	_AppStringsBackupsOptionsRestorePt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Restaurar (Voltar no Tempo)';
	@override String get subtitle => 'Apaga os dados de hoje pra por os desse arquivo';
}

// Path: backups.options.share
class _AppStringsBackupsOptionsSharePt extends AppStringsBackupsOptionsShareEn {
	_AppStringsBackupsOptionsSharePt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Compartilhar arquivo';
	@override String get subtitle => 'Enviar pra outro aparelho';
}

// Path: backups.options.delete
class _AppStringsBackupsOptionsDeletePt extends AppStringsBackupsOptionsDeleteEn {
	_AppStringsBackupsOptionsDeletePt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Apagar arquivo';
	@override String get subtitle => 'Cuidado que não dá pra desfazer';
}

// Path: v2.dashboard.dateFilters
class _AppStringsV2DashboardDateFiltersPt extends AppStringsV2DashboardDateFiltersEn {
	_AppStringsV2DashboardDateFiltersPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get thisMonth => 'Este mês';
	@override String get lastMonth => 'Mês que passou';
	@override String get customRange => 'Escolher os dias...';
}

// Path: v2.dashboard.walletFilters
class _AppStringsV2DashboardWalletFiltersPt extends AppStringsV2DashboardWalletFiltersEn {
	_AppStringsV2DashboardWalletFiltersPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get all => 'Todas';
	@override String get allWallets => 'Todas as carteiras';
}

// Path: v2.dashboard.background
class _AppStringsV2DashboardBackgroundPt extends AppStringsV2DashboardBackgroundEn {
	_AppStringsV2DashboardBackgroundPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Plano de fundo de foco';
	@override String get chooseFromGallery => 'Pegar foto do celular';
	@override String get restoreDefault => 'Voltar à foto original';
}

// Path: v2.dashboard.incomeExpense
class _AppStringsV2DashboardIncomeExpensePt extends AppStringsV2DashboardIncomeExpenseEn {
	_AppStringsV2DashboardIncomeExpensePt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get income => 'GANHOS';
	@override String get expenses => 'GASTOS';
}

// Path: v2.dashboard.gauge
class _AppStringsV2DashboardGaugePt extends AppStringsV2DashboardGaugeEn {
	_AppStringsV2DashboardGaugePt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get exceeded => 'ESTOUROU';
	@override String get spent => 'GASTOU';
	@override String get available => 'SOBROU';
	@override String get overdrawn => 'NO VERMELHO';
}

// Path: v2.dashboard.activityList
class _AppStringsV2DashboardActivityListPt extends AppStringsV2DashboardActivityListEn {
	_AppStringsV2DashboardActivityListPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get seeAll => 'Ver tudo';
	@override String get newUi => 'Nova Tela';
	@override String get expensesByCategory => 'Pra onde o dinheiro tá indo';
	@override String get noRecentExpenses => 'Nenhum gasto recente, boa!';
	@override String percentOfTotal({required Object percent}) => '${percent}% do total';
	@override String topExpenses({required Object count}) => 'Os top ${count} gastos piores';
	@override String get others => 'Resto';
}

// Path: v2.categories.form
class _AppStringsV2CategoriesFormPt extends AppStringsV2CategoriesFormEn {
	_AppStringsV2CategoriesFormPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get nameLabel => 'Como chama essa categoria?';
	@override String get save => 'Gravar';
}

// Path: v2.onboarding.buttons
class _AppStringsV2OnboardingButtonsPt extends AppStringsV2OnboardingButtonsEn {
	_AppStringsV2OnboardingButtonsPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get start => 'Bora lá!';
	@override String get actionContinue => 'Pode seguir';
	@override String get great => 'Massa!';
	@override String get setGoal => 'Focar nisso';
	@override String get skip => 'Pular chatice';
}

// Path: v2.onboarding.splash
class _AppStringsV2OnboardingSplashPt extends AppStringsV2OnboardingSplashEn {
	_AppStringsV2OnboardingSplashPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title1 => 'E se a Inteligência\nArtificial ';
	@override String get title2 => 'cuidar do seu dindin\nmelhor que você?';
	@override String get benefit1 => 'Menos trabalho.';
	@override String get benefit2 => 'Mais visão.';
	@override String get benefit3 => 'Nada de erro bobo.';
}

// Path: v2.onboarding.expenseCategories
class _AppStringsV2OnboardingExpenseCategoriesPt extends AppStringsV2OnboardingExpenseCategoriesEn {
	_AppStringsV2OnboardingExpenseCategoriesPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title1 => 'Onde o seu dinheiro some todo santo mês?';
	@override String get subtitle => 'Escolhe as piores (até 3)';
	@override String get diningOut => 'Comer fora de casa';
	@override String get cravings => 'Besteiras / Lanches';
	@override String get subscriptions => 'Assinaturas esquecidas';
	@override String get outings => 'Baladas e roles';
	@override String get shopping => 'Comprar sem pensar';
	@override String get delivery => 'Ifood e afins';
}

// Path: v2.onboarding.financialGoals
class _AppStringsV2OnboardingFinancialGoalsPt extends AppStringsV2OnboardingFinancialGoalsEn {
	_AppStringsV2OnboardingFinancialGoalsPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'O que ia mudar a sua\nvida agora mesmo?';
	@override String get subtitle => 'Anota só uma';
	@override String get trackMoney => 'Saber exatamente pra onde vai a grana';
	@override String get spendLess => 'Parar de comprar lixo que eu não preciso';
	@override String get lessStress => 'Ter paz de espírito pra variar';
	@override String get saveMoney => 'Achar grana pra poupar de verdade';
}

// Path: v2.onboarding.registrationMethod
class _AppStringsV2OnboardingRegistrationMethodPt extends AppStringsV2OnboardingRegistrationMethodEn {
	_AppStringsV2OnboardingRegistrationMethodPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Como tu vai lançar os\ngastos no dia a dia?';
	@override String get subtitle => 'Escolhe a mais fácil';
	@override String get voice => 'Chegar falando e o app anota';
	@override String get auto => 'Automático pelo banco';
	@override String get write => 'Digitar do jeito antigo';
	@override String get easy => 'Qualquer uma que não me dê preguiça';
}

// Path: v2.onboarding.aiAnalysis
class _AppStringsV2OnboardingAiAnalysisPt extends AppStringsV2OnboardingAiAnalysisEn {
	_AppStringsV2OnboardingAiAnalysisPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override late final _AppStringsV2OnboardingAiAnalysisLoadingPt loading = _AppStringsV2OnboardingAiAnalysisLoadingPt._(_root);
	@override late final _AppStringsV2OnboardingAiAnalysisShowcasePt showcase = _AppStringsV2OnboardingAiAnalysisShowcasePt._(_root);
}

// Path: v2.onboarding.mainPriority
class _AppStringsV2OnboardingMainPriorityPt extends AppStringsV2OnboardingMainPriorityEn {
	_AppStringsV2OnboardingMainPriorityPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Qual a tua pegada\nagora?';
	@override String get subtitle => 'No que o MoneyT vai ser seu parceiro diário?';
	@override String get breakHabits => 'Destruir meus vícios de gastar';
	@override String get stopStress => 'Paz! Chega de perrengue.';
	@override String get buildFuture => 'Ficar rico no futuro';
	@override String get feelControl => 'Saber tudo da minha grana';
	@override String get saveGoal => 'Guardar pra algo top';
}

// Path: v2.onboarding.aiVoice
class _AppStringsV2OnboardingAiVoicePt extends AppStringsV2OnboardingAiVoiceEn {
	_AppStringsV2OnboardingAiVoicePt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override late final _AppStringsV2OnboardingAiVoiceTitlePt title = _AppStringsV2OnboardingAiVoiceTitlePt._(_root);
	@override String get subtitle => 'Não esquenta com botão, só avisa a IA que ela anota os gastos';
	@override String get listening => 'Pode falar, tô ouvindo...';
	@override List<String> get examples => [
		'Café R\$5,50',
		'Uber R\$22,00',
		'Cinema R\$35,00',
		'Mercado R\$145,20',
		'Gasolina R\$100,00',
		'Netflix R\$39,90',
		'Jantar R\$85,00',
		'Farmácia R\$48,50',
	];
}

// Path: dashboard.widgets.settings.reset
class _AppStringsDashboardWidgetsSettingsResetPt extends AppStringsDashboardWidgetsSettingsResetEn {
	_AppStringsDashboardWidgetsSettingsResetPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get button => 'Voltar ao padrão';
	@override String get dialogTitle => 'Zerar Layout';
	@override String get dialogContent => 'Zerar o dashboard? Vai voltar tudo pro padrão original.';
	@override String get cancel => 'Cancelar';
	@override String get confirm => 'Zerar';
	@override String get success => 'Tudo certo no layout';
}

// Path: loans.history.item.status
class _AppStringsLoansHistoryItemStatusPt extends AppStringsLoansHistoryItemStatusEn {
	_AppStringsLoansHistoryItemStatusPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get completed => 'Quitado';
	@override String get active => 'Aberto';
	@override String get cancelled => 'Cancelado';
	@override String get writtenOff => 'Calote/Perdido';
}

// Path: v2.onboarding.aiAnalysis.loading
class _AppStringsV2OnboardingAiAnalysisLoadingPt extends AppStringsV2OnboardingAiAnalysisLoadingEn {
	_AppStringsV2OnboardingAiAnalysisLoadingPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'MONTANDO O APP PRO\nSEU JEITO';
	@override String get subtitle => 'Processando...';
	@override List<String> get messages => [
		'Checando como você gasta...',
		'Arrumando as categorias pra ti...',
		'Caçando onde você mais erra...',
		'Criando dicas matadoras pra você...',
	];
}

// Path: v2.onboarding.aiAnalysis.showcase
class _AppStringsV2OnboardingAiAnalysisShowcasePt extends AppStringsV2OnboardingAiAnalysisShowcaseEn {
	_AppStringsV2OnboardingAiAnalysisShowcasePt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Pronto! Fica a dica:';
	@override late final _AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextPt dynamicText = _AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextPt._(_root);
	@override late final _AppStringsV2OnboardingAiAnalysisShowcaseResultPt result = _AppStringsV2OnboardingAiAnalysisShowcaseResultPt._(_root);
}

// Path: v2.onboarding.aiVoice.title
class _AppStringsV2OnboardingAiVoiceTitlePt extends AppStringsV2OnboardingAiVoiceTitleEn {
	_AppStringsV2OnboardingAiVoiceTitlePt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get kDefault => 'Bater suas metas';
	@override String get breakHabits => 'Quebrar de vez os hábitos que te ferram';
	@override String get stopStress => 'Chega de perder sono pela grana';
	@override String get buildFuture => 'Fazer a sua fortuna render';
	@override String get feelControl => 'Sentir que tá pilotando a nave financeira';
	@override String get saveGoal => 'Guardar pro objetivo sem desviar';
	@override String get suffix => ' agora vai ser moleza com a nossa IA.';
}

// Path: v2.onboarding.aiAnalysis.showcase.dynamicText
class _AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextPt extends AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextEn {
	_AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get kDefault => 'Sua grana evapora rápido demais, acho que do jeito atual não tá dando certo.';
	@override String get part2 => ' consomem boa parte de tudo, e ver que cê quer ';
	@override String get part3 => ' me diz que o jeito atual já era.';
	@override late final _AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextCategoriesPt categories = _AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextCategoriesPt._(_root);
	@override late final _AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextIntentionsPt intentions = _AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextIntentionsPt._(_root);
}

// Path: v2.onboarding.aiAnalysis.showcase.result
class _AppStringsV2OnboardingAiAnalysisShowcaseResultPt extends AppStringsV2OnboardingAiAnalysisShowcaseResultEn {
	_AppStringsV2OnboardingAiAnalysisShowcaseResultPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get yourResult => 'Sua estatística';
	@override String get average => 'Média Normal';
	@override String get messagePart1 => 'Você gasta 68% ';
	@override String get messagePart2 => 'a mais com isso que o brasileiro médio, ';
	@override String get messagePart3 => 'e isso é péssimo\n';
	@override String get messagePart4 => 'pra quem quer focar nos seus sonhos';
}

// Path: v2.onboarding.aiAnalysis.showcase.dynamicText.categories
class _AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextCategoriesPt extends AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextCategoriesEn {
	_AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextCategoriesPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get diningOut => 'Comer fora';
	@override String get cravings => 'As bobeiras';
	@override String get subscriptions => 'Suas assinaturas';
	@override String get outings => 'Sair no fim de semana';
	@override String get shopping => 'As comprinhas online';
	@override String get delivery => 'Os deliveries';
}

// Path: v2.onboarding.aiAnalysis.showcase.dynamicText.intentions
class _AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextIntentionsPt extends AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextIntentionsEn {
	_AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextIntentionsPt._(AppStringsPt root) : this._root = root, super.internal(root);

	final AppStringsPt _root; // ignore: unused_field

	// Translations
	@override String get trackMoney => 'saber pra onde vai o dinheiro';
	@override String get spendLess => 'gastar menos';
	@override String get lessStress => 'parar de surtar';
	@override String get saveMoney => 'guardar pra algo';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on AppStringsPt {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'app.name': return 'MoneyT';
			case 'app.description': return 'Gerenciador Financeiro';
			case 'common.save': return 'Salvar';
			case 'common.cancel': return 'Cancelar';
			case 'common.delete': return 'Excluir';
			case 'common.edit': return 'Editar';
			case 'common.loading': return 'Carregando...';
			case 'common.error': return 'Erro';
			case 'common.success': return 'Sucesso';
			case 'common.search': return 'Buscar';
			case 'common.clearSearch': return 'Limpar busca';
			case 'common.viewAll': return 'Ver tudo';
			case 'common.retry': return 'Tentar novamente';
			case 'common.add': return 'Adicionar';
			case 'common.remove': return 'Remover';
			case 'common.moreOptions': return 'Mais opções';
			case 'common.addToFavorites': return 'Adicionar aos favoritos';
			case 'common.removeFromFavorites': return 'Remover dos favoritos';
			case 'common.today': return 'Hoje';
			case 'common.yesterday': return 'Ontem';
			case 'components.dateSelection.title': return 'Selecionar data';
			case 'components.dateSelection.subtitle': return 'Escolha a data da transação';
			case 'components.dateSelection.selectedDate': return 'Data selecionada';
			case 'components.dateSelection.confirm': return 'Confirmar';
			case 'components.selection.cancel': return 'Cancelar';
			case 'components.selection.confirm': return 'Confirmar';
			case 'components.selection.select': return 'Selecionar';
			case 'components.contactSelection.title': return 'Selecionar contato';
			case 'components.contactSelection.subtitle': return 'Com quem é essa transação';
			case 'components.contactSelection.searchPlaceholder': return 'Buscar contatos';
			case 'components.contactSelection.noContact': return 'Sem contato';
			case 'components.contactSelection.noContactDetails': return 'Transação sem contato específico';
			case 'components.contactSelection.allContacts': return 'Todos os contatos';
			case 'components.contactSelection.create': return 'Criar novo contato';
			case 'components.categorySelection.title': return 'Selecionar categoria';
			case 'components.categorySelection.subtitle': return 'Escolha uma categoria para esta transação';
			case 'components.categorySelection.searchPlaceholder': return 'Buscar categorias';
			case 'components.currencySelection.title': return 'Selecionar moeda';
			case 'components.currencySelection.subtitle': return 'Escolha a moeda desta conta';
			case 'components.currencySelection.searchPlaceholder': return 'Buscar moedas';
			case 'components.accountSelection.title': return 'Selecionar conta';
			case 'components.accountSelection.subtitle': return 'Escolha uma conta para esta transação';
			case 'components.accountSelection.searchPlaceholder': return 'Buscar contas';
			case 'components.accountSelection.wallets': return 'Carteiras';
			case 'components.accountSelection.creditCards': return 'Cartões de Crédito';
			case 'components.accountSelection.selectAccount': return 'Selecionar conta';
			case 'components.accountSelection.confirm': return 'Confirmar';
			case 'components.parentWalletSelection.title': return 'Selecionar carteira principal';
			case 'components.parentWalletSelection.subtitle': return 'Escolha uma carteira para organizar esta dentro de outra';
			case 'components.parentWalletSelection.searchPlaceholder': return 'Buscar carteiras';
			case 'components.parentWalletSelection.noParent': return 'Sem carteira principal';
			case 'components.parentWalletSelection.createRoot': return 'Criar como carteira raiz';
			case 'components.parentWalletSelection.available': return 'Carteiras Disponíveis';
			case 'components.walletTypes.checking': return 'Conta Corrente';
			case 'components.walletTypes.savings': return 'Poupança';
			case 'components.walletTypes.cash': return 'Dinheiro vivo';
			case 'components.walletTypes.creditCard': return 'Cartão de Crédito';
			case 'navigation.home': return 'Início';
			case 'navigation.transactions': return 'Transações';
			case 'navigation.contacts': return 'Contatos';
			case 'navigation.settings': return 'Ajustes';
			case 'navigation.wallets': return 'Carteiras';
			case 'navigation.categories': return 'Categorias';
			case 'navigation.loans': return 'Empréstimos';
			case 'navigation.charts': return 'Plano de Contas';
			case 'navigation.backups': return 'Backups';
			case 'navigation.creditCards': return 'Cartões de Crédito';
			case 'navigation.sections.operations': return 'OPERAÇÕES';
			case 'navigation.sections.financialTools': return 'FERRAMENTAS FINANCEIRAS';
			case 'navigation.sections.management': return 'GERENCIAMENTO';
			case 'navigation.sections.advanced': return 'AVANÇADO';
			case 'transactions.title': return 'Transações';
			case 'transactions.types.all': return 'Todas';
			case 'transactions.types.income': return 'Receita';
			case 'transactions.types.expense': return 'Despesa';
			case 'transactions.types.transfer': return 'Transferência';
			case 'transactions.filter.title': return 'Filtrar Transações';
			case 'transactions.filter.date': return 'Data';
			case 'transactions.filter.categories': return 'Categorias';
			case 'transactions.filter.accounts': return 'Contas';
			case 'transactions.filter.contacts': return 'Contatos';
			case 'transactions.filter.amount': return 'Valor';
			case 'transactions.filter.apply': return 'Aplicar filtros';
			case 'transactions.filter.clear': return 'Limpar filtros';
			case 'transactions.filter.add': return 'Adicionar filtro';
			case 'transactions.filter.minAmount': return 'Valor Mínimo';
			case 'transactions.filter.maxAmount': return 'Valor Máximo';
			case 'transactions.filter.selectDate': return 'Selecionar data';
			case 'transactions.filter.selectCategory': return 'Selecionar categoria';
			case 'transactions.filter.selectAccount': return 'Selecionar conta';
			case 'transactions.filter.selectContact': return 'Selecionar contato';
			case 'transactions.filter.quickFilters': return 'Filtros rápidos';
			case 'transactions.filter.ranges.thisMonth': return 'Este mês';
			case 'transactions.filter.ranges.lastMonth': return 'Mês passado';
			case 'transactions.filter.ranges.thisYear': return 'Este ano';
			case 'transactions.filter.ranges.lastYear': return 'Ano passado';
			case 'transactions.filter.customRange': return 'Período Personalizado';
			case 'transactions.filter.startDate': return 'Data de Início';
			case 'transactions.filter.endDate': return 'Data de Término';
			case 'transactions.filter.active': return 'Filtros Ativos';
			case 'transactions.filter.subtitles.income': return 'Dinheiro que entrou';
			case 'transactions.filter.subtitles.expense': return 'Dinheiro gasto';
			case 'transactions.filter.subtitles.transfer': return 'Dinheiro movido';
			case 'transactions.form.newTitle': return 'Nova Transação';
			case 'transactions.form.editTitle': return 'Editar Transação';
			case 'transactions.form.amount': return 'Valor';
			case 'transactions.form.type': return 'Tipo de transação';
			case 'transactions.form.amountRequired': return 'O valor é obrigatório';
			case 'transactions.form.date': return 'Data';
			case 'transactions.form.account': return 'Conta';
			case 'transactions.form.toAccount': return 'Para Conta';
			case 'transactions.form.category': return 'Categoria';
			case 'transactions.form.contact': return 'Contato';
			case 'transactions.form.contactOptional': return 'Contato (opcional)';
			case 'transactions.form.description': return 'Descrição';
			case 'transactions.form.descriptionOptional': return 'Descrição opcional';
			case 'transactions.form.selectAccount': return 'Selecionar conta';
			case 'transactions.form.selectDestination': return 'Selecionar destino';
			case 'transactions.form.selectCategory': return 'Selecionar categoria';
			case 'transactions.form.selectContact': return 'Selecionar contato';
			case 'transactions.form.saveSuccess': return 'Transação salva com sucesso';
			case 'transactions.form.updateSuccess': return 'Transação atualizada com sucesso';
			case 'transactions.form.saveError': return 'Erro ao salvar transação';
			case 'transactions.form.share': return 'Compartilhar';
			case 'transactions.form.created': return 'Transação criada com sucesso';
			case 'transactions.form.crossCurrencyConversion': return 'Conversão de moeda';
			case 'transactions.form.receivedAmount': return 'Valor recebido';
			case 'transactions.form.exchangeRate': return 'Taxa de câmbio';
			case 'transactions.form.receivedAmountRequired': return 'Informe o valor a receber';
			case 'transactions.form.exchangeRateLabel': return ({required Object from, required Object rate, required Object to}) => '1 ${from} = ${rate} ${to}';
			case 'transactions.errors.load': return 'Erro ao carregar transações';
			case 'transactions.empty.title': return 'Nenhuma transação';
			case 'transactions.empty.message': return 'Nenhuma transação encontrada com os filtros atuais';
			case 'transactions.empty.clearFilters': return 'Limpar filtros';
			case 'transactions.list.count': return ({required Object n}) => '${n} transações';
			case 'transactions.detail.title': return 'Detalhes da Transação';
			case 'transactions.detail.delete': return 'Excluir Transação';
			case 'transactions.detail.deleteConfirmation': return 'Tem certeza? Isso não pode ser desfeito.';
			case 'transactions.detail.deleted': return 'Transação excluída';
			case 'transactions.detail.duplicate': return 'Duplicar';
			case 'transactions.detail.duplicateNotImplemented': return 'Duplicar ainda não implementado';
			case 'transactions.detail.edit': return 'Editar';
			case 'transactions.detail.errorLoad': return 'Erro ao carregar os detalhes';
			case 'transactions.detail.errorPrepareEdit': return ({required Object error}) => 'Erro ao preparar edição: ${error}';
			case 'transactions.detail.errorDelete': return ({required Object error}) => 'Erro ao excluir: ${error}';
			case 'transactions.detail.category': return 'Categoria';
			case 'transactions.detail.account': return 'Conta';
			case 'transactions.detail.contact': return 'Contato';
			case 'transactions.detail.description': return 'Descrição';
			case 'transactions.detail.transferDetails': return 'Detalhes da Transferência';
			case 'transactions.detail.from': return 'De';
			case 'transactions.detail.to': return 'Para';
			case 'transactions.detail.unknownAccount': return 'Conta Desconhecida';
			case 'transactions.detail.errorUrl': return ({required Object url}) => 'Não foi possível abrir ${url}';
			case 'transactions.detail.date': return 'Data';
			case 'transactions.detail.time': return 'Hora';
			case 'transactions.detail.loanLinkedWarning': return 'Esta transação está vinculada a um empréstimo e é gerida automaticamente.';
			case 'transactions.share.title': return 'Compartilhar Transação';
			case 'transactions.share.copyText': return 'Copiar Texto';
			case 'transactions.share.shareButton': return 'Compartilhar';
			case 'transactions.share.shareMessage': return 'Aqui está o comprovante da minha transação:';
			case 'transactions.share.copied': return 'Detalhes copiados para a área de transferência!';
			case 'transactions.share.paymentMethod': return 'Método de Pagamento';
			case 'transactions.share.receiptTitle': return 'Comprovante de Transação';
			case 'transactions.share.poweredBy': return 'Gerado por MoneyT • moneyt.io';
			case 'transactions.share.errorImage': return ({required Object error}) => 'Erro ao compartilhar imagem: ${error}';
			case 'transactions.share.receipt.title': return '--- Detalhes da Transação ---';
			case 'transactions.share.receipt.amount': return ({required Object amount}) => 'Valor: ${amount}';
			case 'transactions.share.receipt.description': return ({required Object description}) => 'Descrição: ${description}';
			case 'transactions.share.receipt.category': return ({required Object category}) => 'Categoria: ${category}';
			case 'transactions.share.receipt.date': return ({required Object date}) => 'Data: ${date}';
			case 'transactions.share.receipt.time': return ({required Object time}) => 'Hora: ${time}';
			case 'transactions.share.receipt.wallet': return ({required Object wallet}) => 'Conta: ${wallet}';
			case 'transactions.share.receipt.contact': return ({required Object contact}) => 'Contato: ${contact}';
			case 'transactions.share.receipt.id': return ({required Object id}) => 'ID da Transação: ${id}';
			case 'transactions.share.receipt.separator': return '--------------------------';
			case 'transactions.share.generatedOn': return ({required Object date}) => 'Gerado em ${date}';
			case 'contacts.title': return 'Contatos';
			case 'contacts.addContact': return 'Adicionar Contato';
			case 'contacts.editContact': return 'Editar Contato';
			case 'contacts.newContact': return 'Novo contato';
			case 'contacts.noContacts': return 'Nenhum contato';
			case 'contacts.noContactsMessage': return 'Adicione seu primeiro contato no botão "+"';
			case 'contacts.searchContacts': return 'Buscar contatos';
			case 'contacts.deleteContact': return 'Excluir contato';
			case 'contacts.confirmDelete': return 'Tem certeza de que deseja excluir';
			case 'contacts.contactDeleted': return 'Contato excluído com sucesso';
			case 'contacts.errorDeleting': return 'Erro ao excluir contato';
			case 'contacts.noSearchResults': return 'Nenhum resultado encontrado';
			case 'contacts.noContactsMatch': return ({required Object query}) => 'Nenhum contato corresponde a "${query}".';
			case 'contacts.errorLoading': return 'Erro ao carregar contatos';
			case 'contacts.contactSaved': return 'Contato salvo com sucesso';
			case 'contacts.errorSaving': return 'Erro ao salvar contato';
			case 'contacts.noContactInfo': return 'Sem informações de contato';
			case 'contacts.importContact': return 'Importar contato';
			case 'contacts.importContacts': return 'Importar contatos';
			case 'contacts.importContactSoon': return 'A função de importar contatos chegará em breve';
			case 'contacts.fields.name': return 'Nome';
			case 'contacts.fields.fullName': return 'Nome completo';
			case 'contacts.fields.email': return 'E-mail';
			case 'contacts.fields.phone': return 'Telefone';
			case 'contacts.fields.address': return 'Endereço';
			case 'contacts.fields.notes': return 'Anotações';
			case 'contacts.placeholders.enterFullName': return 'Digite o nome completo';
			case 'contacts.placeholders.enterPhone': return 'Digite o número de telefone';
			case 'contacts.placeholders.enterEmail': return 'Digite o e-mail';
			case 'contacts.validation.nameRequired': return 'O nome é obrigatório';
			case 'contacts.validation.invalidEmail': return 'E-mail inválido';
			case 'contacts.validation.invalidPhone': return 'Telefone inválido';
			case 'errors.loadingAccounts': return ({required Object error}) => 'Erro ao carregar contas: ${error}';
			case 'errors.unexpected': return 'Erro inesperado';
			case 'settings.title': return 'Configurações';
			case 'settings.account.title': return 'Conta';
			case 'settings.account.profile': return 'Perfil';
			case 'settings.account.profileSubtitle': return 'Gerenciar informações da conta';
			case 'settings.appearance.title': return 'Preferências';
			case 'settings.appearance.darkMode': return 'Modo escuro';
			case 'settings.appearance.darkModeSubtitle': return 'Mudar para o tema escuro';
			case 'settings.appearance.language': return 'Idioma';
			case 'settings.appearance.currency': return 'Moeda Principal';
			case 'settings.appearance.currencySubtitle': return 'Moeda para exibição e novas contas';
			case 'settings.appearance.darkTheme': return 'Tema escuro';
			case 'settings.appearance.lightTheme': return 'Tema claro';
			case 'settings.appearance.systemTheme': return 'Tema do sistema';
			case 'settings.data.title': return 'Dados e Armazenamento';
			case 'settings.data.backup': return 'Backup do banco';
			case 'settings.data.backupSubtitle': return 'Gerencie seus backups de dados';
			case 'settings.info.title': return 'Informação';
			case 'settings.info.contact': return 'Contato e Redes Sociais';
			case 'settings.info.contactSubtitle': return 'Obtenha suporte e siga-nos';
			case 'settings.info.privacy': return 'Política de privacidade';
			case 'settings.info.privacySubtitle': return 'Leia nossa política de privacidade';
			case 'settings.info.share': return 'Compartilhar MoneyT';
			case 'settings.info.shareSubtitle': return 'Recomende o app aos seus amigos';
			case 'settings.logout.button': return 'Sair';
			case 'settings.logout.dialogTitle': return 'Sair da conta';
			case 'settings.logout.dialogMessage': return 'Tem certeza que deseja sair da sua conta?';
			case 'settings.logout.cancel': return 'Cancelar';
			case 'settings.logout.confirm': return 'Sair';
			case 'settings.social.title': return 'Contato e Redes';
			case 'settings.social.follow': return 'Siga o MoneyT';
			case 'settings.social.description': return 'Fique conectado nas redes para novidades e comunidade.';
			case 'settings.social.networks': return 'Redes Sociais';
			case 'settings.social.github': return 'GitHub';
			case 'settings.social.githubSubtitle': return 'Veja o código e contribua';
			case 'settings.social.linkedin': return 'LinkedIn';
			case 'settings.social.linkedinSubtitle': return 'Novidades profissionais';
			case 'settings.social.twitter': return 'X (Twitter)';
			case 'settings.social.twitterSubtitle': return 'Notícias e anúncios';
			case 'settings.social.reddit': return 'Reddit';
			case 'settings.social.redditSubtitle': return 'Entre na comunidade';
			case 'settings.social.discord': return 'Discord';
			case 'settings.social.discordSubtitle': return 'Chat da comunidade';
			case 'settings.social.contact': return 'Contato';
			case 'settings.social.email': return 'Suporte por E-mail';
			case 'settings.social.website': return 'Site Oficial';
			case 'settings.language.title': return 'Idioma';
			case 'settings.language.available': return 'IDIOMAS DISPONÍVEIS';
			case 'settings.language.apply': return 'Aplicar Idioma';
			case 'settings.currency.title': return 'Moeda Principal';
			case 'settings.currency.available': return 'MOEDAS DISPONÍVEIS';
			case 'settings.currency.apply': return 'Aplicar Moeda';
			case 'settings.messages.profileComingSoon': return 'Tela de perfil em breve';
			case 'settings.messages.privacyError': return 'Não foi possível abrir a política';
			case 'settings.messages.logoutComingSoon': return 'Função de sair em breve';
			case 'onboarding.welcome.title': return 'Bem-vindo ao MoneyT 👋';
			case 'onboarding.welcome.subtitle': return 'Domine sua grana em minutos ✨';
			case 'onboarding.problemStatement.title': return 'Sente que a grana foge pelos seus dedos?';
			case 'onboarding.problemStatement.subtitle': return 'Você não está só. 70% da galera não sabe pra onde o dinheiro vai.';
			case 'onboarding.specificProblem.title': return 'O que mais te pega?';
			case 'onboarding.specificProblem.options.debts': return 'Dívidas e empréstimos';
			case 'onboarding.specificProblem.options.savings': return 'Não consigo guardar nada';
			case 'onboarding.specificProblem.options.unknown': return 'Não sei onde gastei';
			case 'onboarding.specificProblem.options.chaos': return 'Um caos financeiro total';
			case 'onboarding.personalGoal.title': return 'Qual seu foco agora?';
			case 'onboarding.personalGoal.options.debtFree': return 'Sair do vermelho';
			case 'onboarding.personalGoal.options.saveTrip': return 'Guardar pro carro/viagem';
			case 'onboarding.personalGoal.options.invest': return 'Começar a investir';
			case 'onboarding.personalGoal.options.peace': return 'Paz financeira';
			case 'onboarding.solutionPreview.title': return 'O MoneyT te dá clareza';
			case 'onboarding.solutionPreview.subtitle': return 'Veja todas as contas e dívidas num só lugar. Sem planilhas chatas.';
			case 'onboarding.solutionPreview.benefits.visualize': return 'Veja seus gastos em tempo real';
			case 'onboarding.solutionPreview.benefits.goals': return 'Bata suas metas';
			case 'onboarding.solutionPreview.benefits.smart': return 'Tome decisões inteligentes';
			case 'onboarding.currentMethod.title': return 'Como você controla a grana hoje?';
			case 'onboarding.currentMethod.subtitle': return 'Escolhe o que tem mais a sua cara.';
			case 'onboarding.currentMethod.options.excel': return 'Planilhas do Excel';
			case 'onboarding.currentMethod.options.notebook': return 'Caderninho';
			case 'onboarding.currentMethod.options.mental': return 'Tudo na cabeça';
			case 'onboarding.currentMethod.options.none': return 'Não controlo nada';
			case 'onboarding.featuresShowcase.title': return 'O que tem e o que vem aí ✨';
			case 'onboarding.featuresShowcase.subtitle': return 'Pronto para usar, com mais novidades no forno.';
			case 'onboarding.featuresShowcase.available': return 'JÁ DISPONÍVEL';
			case 'onboarding.featuresShowcase.comingSoon': return 'EM BREVE';
			case 'onboarding.featuresShowcase.features.income': return 'Receitas';
			case 'onboarding.featuresShowcase.features.expense': return 'Despesas';
			case 'onboarding.featuresShowcase.features.transfer': return 'Transferências';
			case 'onboarding.featuresShowcase.features.loans': return 'Empréstimos';
			case 'onboarding.featuresShowcase.features.goals': return 'Metas';
			case 'onboarding.featuresShowcase.features.budgets': return 'Orçamentos';
			case 'onboarding.featuresShowcase.features.investments': return 'Investimentos';
			case 'onboarding.featuresShowcase.features.cloud': return 'MoneyT na Nuvem';
			case 'onboarding.featuresShowcase.features.openBanking': return 'Open Finance';
			case 'onboarding.complete.title': return 'Pronto para decolar! 🚀';
			case 'onboarding.complete.subtitle': return 'Lance sua primeira transação e veja a mágica acontecer 📈';
			case 'onboarding.complete.stats.title': return 'Probabilidade de Sucesso';
			case 'onboarding.complete.stats.before': return 'Antes do MoneyT';
			case 'onboarding.complete.stats.after': return 'Com MoneyT';
			case 'onboarding.buttons.start': return 'Bora começar 🚀';
			case 'onboarding.buttons.fixIt': return 'Arrumar isso hoje ⚡';
			case 'onboarding.buttons.actionContinue': return 'Continuar';
			case 'onboarding.buttons.setGoal': return 'Bora traçar a meta 🎯';
			case 'onboarding.buttons.wantControl': return 'Eu quero ter esse controle!';
			case 'onboarding.buttons.great': return 'Massa, quero ver!';
			case 'onboarding.buttons.firstTransaction': return 'Registrar minha primeira ➕';
			case 'onboarding.buttons.skip': return 'Pular';
			case 'dashboard.greeting': return 'Bem-vindo ao MoneyT';
			case 'dashboard.balance.total': return 'SALDO TOTAL';
			case 'dashboard.balance.income': return 'RECEITAS';
			case 'dashboard.balance.expenses': return 'DESPESAS';
			case 'dashboard.balance.thisMonth': return 'este mês';
			case 'dashboard.actions.income': return 'Receita';
			case 'dashboard.actions.expense': return 'Despesa';
			case 'dashboard.actions.transfer': return 'Transf.';
			case 'dashboard.actions.all': return 'Tudo';
			case 'dashboard.wallets.title': return 'Carteiras';
			case 'dashboard.wallets.count': return ({required Object n}) => '${n} contas';
			case 'dashboard.wallets.more': return ({required Object n}) => '+${n} contas';
			case 'dashboard.wallets.viewDetails': return ({required Object name}) => 'Ver detalhes de ${name}';
			case 'dashboard.transactions.title': return 'Últimas Transações';
			case 'dashboard.transactions.subtitle': return 'As 5 mais recentes';
			case 'dashboard.transactions.empty': return 'Nada recente por aqui';
			case 'dashboard.transactions.emptySubtitle': return 'Suas transações vão aparecer aqui';
			case 'dashboard.transactions.more': return ({required Object n}) => '+${n} transações';
			case 'dashboard.customize': return 'Personalizar';
			case 'dashboard.widgets.balance.title': return 'Saldo Total';
			case 'dashboard.widgets.balance.description': return 'Seu status financeiro geral';
			case 'dashboard.widgets.quickActions.title': return 'Ações Rápidas';
			case 'dashboard.widgets.quickActions.description': return 'Acesso fácil para registrar rápido';
			case 'dashboard.widgets.wallets.title': return 'Carteiras';
			case 'dashboard.widgets.wallets.description': return 'Visão geral de onde tá o dinheiro';
			case 'dashboard.widgets.loans.title': return 'Empréstimos';
			case 'dashboard.widgets.loans.description': return 'Grana que entrou ou saiu emprestada';
			case 'dashboard.widgets.transactions.title': return 'Transações Recentes';
			case 'dashboard.widgets.transactions.description': return 'Movimentações de última hora';
			case 'dashboard.widgets.categoryBreakdown.title': return 'Resumo por Categoria';
			case 'dashboard.widgets.categoryBreakdown.description': return 'Gastos do mês atual';
			case 'dashboard.widgets.categoryBreakdown.empty_message': return 'Sem gastos por enquanto.';
			case 'dashboard.widgets.categoryBreakdown.others': return 'Outros';
			case 'dashboard.widgets.categoryBreakdown.back': return 'Voltar';
			case 'dashboard.widgets.categoryBreakdown.monthlyBudget': return 'Orçamento mensal';
			case 'dashboard.widgets.categoryBreakdown.leftover': return ({required Object amount}) => 'Sobrou ${amount} da sua receita.';
			case 'dashboard.widgets.categoryBreakdown.exceeded': return ({required Object amount}) => 'Você gastou ${amount} a mais que a receita.';
			case 'dashboard.widgets.categoryBreakdown.noIncome': return ({required Object amount}) => 'Gastos registrados: ${amount} (Sem receita)';
			case 'dashboard.widgets.chartAccounts.title': return 'Plano de Contas';
			case 'dashboard.widgets.chartAccounts.description': return 'Estrutura das contas';
			case 'dashboard.widgets.creditCards.title': return 'Cartões de Crédito';
			case 'dashboard.widgets.creditCards.description': return 'Limites e faturas';
			case 'dashboard.widgets.settings.title': return 'Customizar Início';
			case 'dashboard.widgets.settings.subtitle': return 'Arraste e organize os cards como quiser.';
			case 'dashboard.widgets.settings.reset.button': return 'Voltar ao padrão';
			case 'dashboard.widgets.settings.reset.dialogTitle': return 'Zerar Layout';
			case 'dashboard.widgets.settings.reset.dialogContent': return 'Zerar o dashboard? Vai voltar tudo pro padrão original.';
			case 'dashboard.widgets.settings.reset.cancel': return 'Cancelar';
			case 'dashboard.widgets.settings.reset.confirm': return 'Zerar';
			case 'dashboard.widgets.settings.reset.success': return 'Tudo certo no layout';
			case 'dashboard.widgets.settings.saveSuccess': return 'Tudo salvo!';
			case 'dashboard.widgets.settings.saveError': return ({required Object error}) => 'Deu ruim ao salvar: ${error}';
			case 'dashboard.widgets.settings.saving': return 'Salvando...';
			case 'dashboard.widgets.settings.save': return 'Salvar Layout';
			case 'wallets.title': return 'Carteiras';
			case 'wallets.empty.title': return 'Nenhuma carteira achada';
			case 'wallets.empty.message': return 'Cria a primeira pra começar a controlar tudo.';
			case 'wallets.empty.action': return 'Criar Carteira';
			case 'wallets.emptyArchived.title': return 'Sem carteiras arquivadas';
			case 'wallets.emptyArchived.message': return 'As carteiras arquivadas ficam aqui.';
			case 'wallets.filter.active': return 'Ativas';
			case 'wallets.filter.archived': return 'Arquivadas';
			case 'wallets.filter.all': return 'Todas';
			case 'wallets.form.newTitle': return 'Nova Carteira';
			case 'wallets.form.editTitle': return 'Editar Carteira';
			case 'wallets.form.name': return 'Nome da carteira';
			case 'wallets.form.namePlaceholder': return 'Ex: Nubank, Dinheiro da Carteira';
			case 'wallets.form.nameRequired': return 'Precisamos de um nome';
			case 'wallets.form.description': return 'Descrição';
			case 'wallets.form.descriptionPlaceholder': return 'Pra que serve essa carteira? (opcional)';
			case 'wallets.form.currency': return 'Moeda';
			case 'wallets.form.currencyLockedByParent': return 'Herança da carteira mãe';
			case 'wallets.form.parent': return 'Carteira Mãe (opcional)';
			case 'wallets.form.parentEmpty': return 'Não tem carteira mãe disponível';
			case 'wallets.form.chartAccount': return 'Plano de contas';
			case 'wallets.form.chartAccountLocked': return 'Não pode mudar o plano de conta';
			case 'wallets.form.createSuccess': return 'Carteira criada com sucesso';
			case 'wallets.form.updateSuccess': return 'Carteira editada de boa';
			case 'wallets.form.loadParentError': return ({required Object error}) => 'Erro ao carregar carteiras mãe: ${error}';
			case 'wallets.form.loadChartAccountError': return ({required Object error}) => 'Erro ao carregar o plano: ${error}';
			case 'wallets.delete.dialogTitle': return 'Apagar carteira';
			case 'wallets.delete.dialogMessage': return ({required Object name}) => 'Certeza absoluta que quer excluir a ${name}?';
			case 'wallets.delete.cancel': return 'Deixa quieto';
			case 'wallets.delete.confirm': return 'Apagar de vez';
			case 'wallets.delete.success': return 'Carteira apagada';
			case 'wallets.delete.error': return ({required Object error}) => 'Deu ruim pra apagar: ${error}';
			case 'wallets.errors.load': return 'Não conseguimos carregar as carteiras';
			case 'wallets.errors.retry': return 'Tentar de novo';
			case 'wallets.errors.comingSoon': return ({required Object name}) => '${name} em breve na área';
			case 'wallets.subtitle.mainAccount': return 'Conta principal';
			case 'wallets.subtitle.cashDigital': return 'Vivo & Digital';
			case 'wallets.subtitle.count': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n,
				one: '${n} carteira',
				other: '${n} carteiras',
			);
			case 'wallets.subtitle.account': return 'Conta';
			case 'wallets.subtitle.physicalCash': return 'Dinheiro no bolso';
			case 'wallets.subtitle.digitalWallet': return 'Digital';
			case 'wallets.options.viewTransactions': return 'Ver o extrato';
			case 'wallets.options.viewTransactionsSubtitle': return 'Checar todas as transações';
			case 'wallets.options.transferFunds': return 'Fazer transferência';
			case 'wallets.options.transferFundsSubtitle': return 'Mover a grana entre as contas';
			case 'wallets.options.editWallet': return 'Editar carteira';
			case 'wallets.options.editWalletSubtitle': return 'Trocar nome, cor, etc';
			case 'wallets.options.duplicateWallet': return 'Duplicar carteira';
			case 'wallets.options.duplicateWalletSubtitle': return 'Criar uma igualzinha';
			case 'wallets.options.archiveWallet': return 'Arquivar carteira';
			case 'wallets.options.archiveWalletSubtitle': return 'Tirar da tela principal';
			case 'wallets.options.unarchiveWallet': return 'Desarquivar';
			case 'wallets.options.unarchiveWalletSubtitle': return 'Voltar pra tela principal';
			case 'wallets.options.deleteWallet': return 'Apagar sem dó';
			case 'wallets.options.deleteWalletSubtitle': return 'Excluir permanentemente';
			case 'wallets.options.defaultTitle': return 'Carteira';
			case 'loans.title': return 'Empréstimos';
			case 'loans.filter.active': return 'Em Aberto';
			case 'loans.filter.history': return 'Histórico';
			case 'loans.filter.all': return 'Todos';
			case 'loans.filter.pending': return 'Pendentes';
			case 'loans.filter.lent': return 'A Receber';
			case 'loans.filter.borrowed': return 'A Pagar';
			case 'loans.summary.netBalance': return 'SALDO LÍQUIDO';
			case 'loans.summary.activeLoans': return 'EM ABERTO';
			case 'loans.summary.noActive': return 'Tudo limpo';
			case 'loans.summary.lent': return ({required Object n}) => '${n} a receber';
			case 'loans.summary.borrowed': return ({required Object n}) => '${n} a pagar';
			case 'loans.summary.pending': return ({required Object n}) => '${n} pendentes';
			case 'loans.card.lent': return 'Para Receber';
			case 'loans.card.borrowed': return 'Para Pagar';
			case 'loans.card.active': return ({required Object n}) => '${n} abertos';
			case 'loans.card.multiple': return ({required Object n}) => '${n} empréstimos';
			case 'loans.card.transactions': return ({required Object n}) => '${n} lances';
			case 'loans.card.overdue': return ({required Object n}) => '${n} dias de atraso';
			case 'loans.card.due': return ({required Object date}) => 'Vence ${date}';
			case 'loans.form.newTitle': return 'Novo Empréstimo';
			case 'loans.form.editTitle': return 'Editar Empréstimo';
			case 'loans.form.type': return 'Tipo de empréstimo';
			case 'loans.form.lend': return 'A Receber';
			case 'loans.form.borrow': return 'A Pagar';
			case 'loans.form.contact': return 'Contato';
			case 'loans.form.contactPlaceholder': return 'De quem ou pra quem?';
			case 'loans.form.account': return 'Da Conta';
			case 'loans.form.accountPlaceholder': return 'Selecionar a conta';
			case 'loans.form.amount': return 'Valor';
			case 'loans.form.description': return 'Descrição';
			case 'loans.form.date': return 'Data';
			case 'loans.form.dueDate': return 'Data do pagamento';
			case 'loans.form.selectDate': return 'Dia do pagamento';
			case 'loans.form.optional': return '(Opcional)';
			case 'loans.form.createTransaction': return 'Gerar recibo na carteira';
			case 'loans.form.recordAutomatically': return 'Registrar a transação sozinho';
			case 'loans.form.transactionCategory': return 'Categoria pra isso';
			case 'loans.form.category': return 'Categoria';
			case 'loans.form.categoryPlaceholder': return 'Seleciona aí';
			case 'loans.form.save': return 'Salvar';
			case 'loans.form.successCreate': return 'Feito! Tá registrado.';
			case 'loans.form.successUpdate': return 'Empréstimo atualizado';
			case 'loans.form.contactRequired': return 'Tem que pôr o contato';
			case 'loans.form.accountRequired': return 'Tem que pôr a conta';
			case 'loans.form.amountRequired': return 'Faltou a grana';
			case 'loans.detail.title': return 'Detalhes';
			case 'loans.detail.deleteTitle': return 'Apagar Empréstimo';
			case 'loans.detail.deleteMessage': return 'Tem certeza que quer apagar isso do mapa?';
			case 'loans.detail.deleteSuccess': return 'Pronto, sumiu.';
			case 'loans.detail.deleteError': return ({required Object error}) => 'Deu pau pra apagar: ${error}';
			case 'loans.detail.notFound': return 'Sumiu...';
			case 'loans.detail.progress': return 'Como tá o pagamento';
			case 'loans.detail.info': return 'Informação Geral';
			case 'loans.detail.pay': return 'Pagar/Receber';
			case 'loans.detail.viewHistory': return 'Ver Histórico Completo';
			case 'loans.detail.original': return ({required Object amount}) => 'Valor Inicial: ${amount}';
			case 'loans.detail.section': return 'Detalhes';
			case 'loans.detail.activeSummary': return 'Resumo Ativo';
			case 'loans.detail.activeLent': return 'Pra Receber (Aberto)';
			case 'loans.detail.activeBorrowed': return 'Pra Pagar (Aberto)';
			case 'loans.detail.activeNet': return 'Saldo Final (Ativo)';
			case 'loans.detail.activeTotal': return 'Empréstimos Ativos';
			case 'loans.detail.startDate': return 'Começou em';
			case 'loans.detail.dueDate': return 'Vencimento';
			case 'loans.detail.type.label': return 'Qual tipo';
			case 'loans.detail.type.personal': return 'Empréstimo Pessoal';
			case 'loans.detail.type.borrowed': return 'Boleto/Dívida';
			case 'loans.detail.type.auto': return 'Financiamento do Carro';
			case 'loans.detail.type.mortgage': return 'Financiamento da Casa';
			case 'loans.detail.type.student': return 'Empréstimo Estudantil';
			case 'loans.detail.payment.history': return 'Histórico de Pagamentos';
			case 'loans.detail.payment.date': return ({required Object date}) => 'Pago dia ${date}';
			case 'loans.detail.payment.transactionId': return ({required Object id}) => 'ID: ${id}';
			case 'loans.detail.payment.paid': return ({required Object amount}) => '${amount} pago';
			case 'loans.detail.payment.remaining': return ({required Object amount}) => 'Falta ${amount}';
			case 'loans.history.title': return 'Histórico Geral';
			case 'loans.history.section': return 'Todos os empréstimos';
			case 'loans.history.totalLoaned': return 'Total rodado';
			case 'loans.history.noLoans': return 'Não achamos nada com esses filtros.';
			case 'loans.history.filter.all': return 'Todos';
			case 'loans.history.filter.lent': return 'Pra Receber';
			case 'loans.history.filter.borrowed': return 'Pra Pagar';
			case 'loans.history.filter.completed': return 'Quitados';
			case 'loans.history.filter.title': return 'Filtros';
			case 'loans.history.filter.reset': return 'Zerar';
			case 'loans.history.filter.apply': return 'Aplicar';
			case 'loans.history.filter.dateRange': return 'Período';
			case 'loans.history.filter.amountRange': return 'Qual valor';
			case 'loans.history.filter.startDate': return 'Do dia';
			case 'loans.history.filter.endDate': return 'Até o dia';
			case 'loans.history.filter.select': return 'Selecionar';
			case 'loans.history.headers.lent': return 'Empréstimos a Receber';
			case 'loans.history.headers.borrowed': return 'Empréstimos a Pagar';
			case 'loans.history.headers.completed': return 'Tudo Quitado';
			case 'loans.history.headers.active': return 'Em Aberto';
			case 'loans.history.headers.cancelled': return 'Cancelados';
			case 'loans.history.headers.writtenOff': return 'Dados como perdidos';
			case 'loans.history.item.defaultTitle': return 'Empréstimo';
			case 'loans.history.item.date': return ({required Object date}) => 'Data: ${date}';
			case 'loans.history.item.lent': return 'Pra Receber';
			case 'loans.history.item.borrowed': return 'Pra Pagar';
			case 'loans.history.item.status.completed': return 'Quitado';
			case 'loans.history.item.status.active': return 'Aberto';
			case 'loans.history.item.status.cancelled': return 'Cancelado';
			case 'loans.history.item.status.writtenOff': return 'Calote/Perdido';
			case 'loans.history.summary.title': return 'Resumão';
			case 'loans.history.summary.viewDetails': return 'Ver os detalhes';
			case 'loans.history.summary.hideDetails': return 'Ocultar';
			case 'loans.history.summary.outstandingLent': return 'Grana pendente pra você';
			case 'loans.history.summary.outstandingBorrowed': return 'Grana que você deve';
			case 'loans.history.summary.netPosition': return 'Saldo Líquido';
			case 'loans.history.summary.totalLent': return 'O que você já emprestou';
			case 'loans.history.summary.totalBorrowed': return 'O que você já pegou';
			case 'loans.history.summary.totalRepaidToYou': return 'O que já te devolveram';
			case 'loans.history.summary.totalYouRepaid': return 'O que você já pagou';
			case 'loans.history.summary.totalLoans': return 'Total de empréstimos';
			case 'loans.history.summary.completedLoans': return 'Quitados';
			case 'loans.contactDetail.titleWith': return ({required Object name}) => 'Contas com ${name}';
			case 'loans.share.title': return 'Compartilhar Empréstimo';
			case 'loans.share.contactTitle': return 'Compartilhar tudo';
			case 'loans.share.button': return 'Mandar';
			case 'loans.share.copy': return 'Copiar texto';
			case 'loans.share.message': return 'Saca só o resumo da conta:';
			case 'loans.share.contactMessage': return ({required Object name}) => 'Resumo de contas com ${name}:';
			case 'loans.share.error': return ({required Object error}) => 'Deu ruim: ${error}';
			case 'loans.share.contactCopied': return 'Tá na área de transferência!';
			case 'loans.share.activeLoans': return ({required Object n}) => 'Empréstimos ativos (${n}):';
			case 'loans.share.loanItem': return ({required Object description, required Object amount, required Object date, required Object percent}) => '• ${description}: ${amount} (Data: ${date}) - ${percent}% pago';
			case 'loans.share.loanStatement': return 'MoneyT - Extrato do Empréstimo';
			case 'loans.share.loanSummary': return 'MoneyT - Resumo';
			case 'loans.share.personalLoan': return 'Empréstimo Pessoal';
			case 'loans.share.remaining': return ({required Object amount}) => 'Falta pagar: ${amount}';
			case 'loans.share.remainingLabel': return 'Ainda falta';
			case 'loans.share.original': return ({required Object amount}) => 'de ${amount} no total';
			case 'loans.share.progress': return ({required Object percent}) => 'Tá em: ${percent}% pago';
			case 'loans.share.progressLabel': return 'Progresso';
			case 'loans.share.paidSuffix': return 'Tá pago';
			case 'loans.share.date': return ({required Object date}) => 'Data: ${date}';
			case 'loans.share.dateLabel': return 'Data';
			case 'loans.share.contact': return ({required Object name}) => 'Com quem: ${name}';
			case 'loans.share.contactLabel': return 'Contato';
			case 'loans.share.generated': return ({required Object date}) => 'Gerado em ${date}';
			case 'loans.share.generatedLabel': return ({required Object date}) => 'Gerado em ${date}';
			case 'loans.share.totalActive': return ({required Object n}) => 'No total: ${n} ativos';
			case 'loans.share.active': return 'abertos';
			case 'loans.share.poweredBy': return 'Gerado pelo MoneyT • moneyt.io';
			case 'loans.share.copied': return 'Copiado!';
			case 'loans.share.netBalance': return ({required Object amount, required Object status}) => 'Saldo Líquido: ${amount} (${status})';
			case 'loans.share.netBalanceLabel': return 'Saldo Líquido';
			case 'loans.share.owed': return 'Você vai receber';
			case 'loans.share.owe': return 'Você deve';
			case 'loans.share.lent': return ({required Object amount}) => 'Você emprestou: ${amount}';
			case 'loans.share.lentLabel': return 'Você Emprestou';
			case 'loans.share.borrowed': return ({required Object amount}) => 'Você pegou: ${amount}';
			case 'loans.share.borrowedLabel': return 'Você Pegou';
			case 'loans.share.contactSummary': return ({required Object name}) => 'Resumo - ${name}';
			case 'loans.payment.title': return 'Registrar Pgto.';
			case 'loans.payment.amount': return 'Qual foi o valor?';
			case 'loans.payment.amountPlaceholder': return '0,00';
			case 'loans.payment.amountRequired': return 'Põe o valor aí';
			case 'loans.payment.invalidAmount': return 'Acho que digitou errado';
			case 'loans.payment.exceedsBalance': return 'Aí é mais do que falta pagar, chefe';
			case 'loans.payment.date': return 'Data do pagamento';
			case 'loans.payment.account': return 'Caiu em qual conta?';
			case 'loans.payment.selectAccount': return 'Escolhe aí';
			case 'loans.payment.details': return 'Anotações extras';
			case 'loans.payment.detailsPlaceholder': return 'Qualquer observação (opcional)';
			case 'loans.payment.success': return 'Boa! Pagamento registrado.';
			case 'loans.payment.error': return ({required Object error}) => 'Erro ao registrar: ${error}';
			case 'loans.payment.errorAmount': return 'Põe um valor certo';
			case 'loans.payment.errorAccount': return 'Selecione a conta que recebeu';
			case 'loans.payment.errorLoading': return ({required Object error}) => 'Não rolou carregar: ${error}';
			case 'loans.payment.summary.title': return 'Resumo da brincadeira';
			case 'loans.payment.summary.defaultTitle': return 'Empréstimo';
			case 'loans.payment.summary.amount': return 'Valor a pagar/receber';
			case 'loans.payment.summary.remaining': return 'O que ainda falta';
			case 'loans.payment.summary.progress': return 'Como ficou';
			case 'loans.payment.summary.description': return ({required Object loan, required Object contact}) => '${loan} para ${contact}';
			case 'loans.payment.summary.unknownContact': return 'Sem Nome';
			case 'loans.payment.summary.total': return ({required Object amount}) => '${amount} no total';
			case 'loans.payment.summary.paid': return ({required Object amount}) => 'Já foi pago: ${amount}';
			case 'loans.payment.summary.remainingLabel': return ({required Object amount}) => 'Falta isso: ${amount}';
			case 'loans.payment.quick.full': return ({required Object amount}) => 'Pagar Tudo (${amount})';
			case 'loans.payment.quick.half': return ({required Object amount}) => 'A Metade (${amount})';
			case 'loans.given': return 'Dei Emprestado';
			case 'loans.received': return 'Peguei Emprestado';
			case 'loans.item.due': return ({required Object date}) => 'Vence: ${date}';
			case 'loans.item.paidAmount': return ({required Object amount}) => 'Pago: ${amount}';
			case 'loans.item.remaining': return ({required Object amount}) => 'Falta: ${amount}';
			case 'loans.item.percentPaid': return ({required Object percent}) => '${percent}% já foi';
			case 'loans.section.activeLoans': return 'Empréstimos Ativos';
			case 'loans.section.loansCount': return ({required Object n}) => '${n} contratos';
			case 'loans.empty.title': return 'Nenhum empréstimo ativo';
			case 'loans.empty.message': return 'Ninguém te deve e você não deve a ninguém.';
			case 'loans.empty.action': return 'Anotar Novo';
			case 'categories.title': return 'Categorias';
			case 'categories.form.newTitle': return 'Nova Categoria';
			case 'categories.form.editTitle': return 'Editar Categoria';
			case 'categories.form.name': return 'Nome';
			case 'categories.form.namePlaceholder': return 'Ex: Uber, Mercado, Balada';
			case 'categories.form.nameRequired': return 'Põe o nome da categoria';
			case 'categories.form.parent': return 'Subcategoria de? (Opcional)';
			case 'categories.form.noParent': return 'Deixar como principal';
			case 'categories.form.asSubcategory': return 'Vai ficar dentro de outra';
			case 'categories.form.asRoot': return 'Vai ficar de fora (Principal)';
			case 'categories.form.active': return 'Categoria Ativa';
			case 'categories.form.activeDescription': return 'Deixar visível nas novas compras';
			case 'categories.form.selectIcon': return 'Escolhe um ícone';
			case 'categories.form.selectColor': return 'Põe uma cor';
			case 'categories.form.saveSuccess': return 'Tudo certo, salva!';
			case 'categories.form.saveError': return ({required Object error}) => 'Vish, erro ao salvar: ${error}';
			case 'categories.parentSelection.title': return 'Escolher Categoria Mãe';
			case 'categories.parentSelection.subtitle': return 'Onde ela vai morar?';
			case 'categories.parentSelection.noParent': return 'Deixar solta (Principal)';
			case 'categories.incomeCategory': return 'Categoria de Ganho';
			case 'categories.expenseCategory': return 'Categoria de Gasto';
			case 'categories.report.title': return 'Raio-X Avançado';
			case 'categories.report.timeFilter': return 'No período de';
			case 'categories.report.thisMonth': return 'Este Mês';
			case 'categories.report.lastMonth': return 'Mês Passado';
			case 'categories.report.thisYear': return 'Este Ano';
			case 'categories.report.allTime': return 'Toda a Vida';
			case 'categories.report.details': return 'O que rolou';
			case 'categories.report.noTransactions': return 'Nenhuma compra registrada';
			case 'categories.report.income': return 'Grana que entrou';
			case 'categories.report.expense': return 'Grana que saiu';
			case 'backups.title': return 'Backups (Nuvem de Segurança)';
			case 'backups.menu.settings': return 'Ajustes de Backup';
			case 'backups.menu.comingSoon': return 'Os ajustes logo chegam';
			case 'backups.filters.all': return 'Todos';
			case 'backups.filters.auto': return 'No Automático';
			case 'backups.filters.manual': return 'Você que fez';
			case 'backups.filters.thisMonth': return 'Mês';
			case 'backups.filters.lastMonth': return 'Mês Anterior';
			case 'backups.filters.thisYear': return 'Ano';
			case 'backups.filters.lastYear': return 'Ano Anterior';
			case 'backups.status.loading': return 'Carregando...';
			case 'backups.status.error': return 'Erro ao carregar os dados salvos';
			case 'backups.status.empty': return 'Nenhum backup feito';
			case 'backups.status.emptyAction': return 'Toca no \'+\' para proteger seus dados';
			case 'backups.status.success': return 'Pronto!';
			case 'backups.status.created': return 'Seus dados estão protegidos no backup.';
			case 'backups.status.createError': return ({required Object error}) => 'Erro ao tentar salvar: ${error}';
			case 'backups.status.restoreError': return ({required Object error}) => 'Erro ao puxar o backup: ${error}';
			case 'backups.status.deleteError': return ({required Object error}) => 'Deu ruim para apagar: ${error}';
			case 'backups.actions.create': return 'Fazer Backup';
			case 'backups.actions.import': return 'Puxar Backup (Importar)';
			case 'backups.actions.restore': return 'Restaurar (Recuperar)';
			case 'backups.actions.delete': return 'Excluir';
			case 'backups.actions.share': return 'Compartilhar';
			case 'backups.actions.cancel': return 'Deixar pra lá';
			case 'backups.actions.retry': return 'Tentar de novo';
			case 'backups.actions.ok': return 'Show';
			case 'backups.dialogs.info.title': return 'Dados do Backup';
			case 'backups.dialogs.info.file': return 'Arquivo:';
			case 'backups.dialogs.info.size': return 'Tamanho:';
			case 'backups.dialogs.info.created': return 'Data:';
			case 'backups.dialogs.info.transactions': return 'Transações:';
			case 'backups.dialogs.restore.title': return 'Recuperar Dados';
			case 'backups.dialogs.restore.content': return ({required Object file}) => 'Tem certeza que quer voltar os dados pra versão "${file}"? O que tá no app hoje vai ser apagado.';
			case 'backups.dialogs.restore.success': return 'Voltando os dados... o app vai reiniciar rapidão.';
			case 'backups.dialogs.delete.title': return 'Apagar Backup';
			case 'backups.dialogs.delete.content': return ({required Object file}) => 'Certeza absoluta que quer excluir "${file}"? Já era depois disso.';
			case 'backups.dialogs.delete.success': return 'Backup jogado fora.';
			case 'backups.stats.title': return 'Métricas de Backup';
			case 'backups.stats.totalBackups': return 'Quantos já fizemos';
			case 'backups.stats.totalSize': return 'Peso total';
			case 'backups.stats.oldest': return 'O mais velhinho';
			case 'backups.stats.latest': return 'O mais recente';
			case 'backups.stats.autoBackupStatus': return 'Auto Backup Ativo?';
			case 'backups.stats.active': return 'Tá on';
			case 'backups.stats.inactive': return 'Tá off';
			case 'backups.options.restore.title': return 'Restaurar (Voltar no Tempo)';
			case 'backups.options.restore.subtitle': return 'Apaga os dados de hoje pra por os desse arquivo';
			case 'backups.options.share.title': return 'Compartilhar arquivo';
			case 'backups.options.share.subtitle': return 'Enviar pra outro aparelho';
			case 'backups.options.delete.title': return 'Apagar arquivo';
			case 'backups.options.delete.subtitle': return 'Cuidado que não dá pra desfazer';
			case 'backups.options.latestBadge': return 'Último';
			case 'backups.options.latestFile': return 'Mais recente de todos';
			case 'backups.options.backupFile': return 'Arquivo zipado';
			case 'backups.format.auto': return ({required Object date}) => 'Salvo sozinho - ${date}';
			case 'backups.format.manual': return ({required Object date}) => 'Você que salvou - ${date}';
			case 'backups.format.initial': return 'O Primeiro de Todos';
			case 'backups.format.generic': return ({required Object date}) => 'Backup de ${date}';
			case 'v2.voice.errorProcessing': return 'Não entendi nada do que cê disse. Fala de novo.';
			case 'v2.voice.tapMicrophone': return 'Aperta no microfone pra falar comigo';
			case 'v2.voice.listening': return 'Tô te ouvindo...';
			case 'v2.voice.missingApiKey': return 'Coloca a GEMINI_API_KEY no arquivo .env pra IA funcionar.';
			case 'v2.voice.aiError': return ({required Object error}) => 'Erro na IA: ${error}';
			case 'v2.voice.cancel': return 'Cancela';
			case 'v2.voice.scan': return 'Escanear';
			case 'v2.transactions.invalidAmount': return 'Coloca um valor certo aí.';
			case 'v2.transactions.selectAccount': return 'Avisar pra qual conta vai/foi.';
			case 'v2.transactions.selectCategory': return 'Diz qual é a categoria disso.';
			case 'v2.transactions.errorCreatingCategory': return ({required Object error}) => 'Vish, erro criando a categoria: ${error}';
			case 'v2.transactions.error': return ({required Object error}) => 'Erro: ${error}';
			case 'v2.transactions.more': return 'Mais';
			case 'v2.transactions.expense': return 'Gasto';
			case 'v2.transactions.income': return 'Ganho';
			case 'v2.transactions.deleteTransaction': return 'Apagar esse lançamento?';
			case 'v2.transactions.cancel': return 'Deixa quieto';
			case 'v2.transactions.delete': return 'Apagar';
			case 'v2.transactions.yesterday': return 'Ontem';
			case 'v2.transactions.usedCategories': return 'SÓ O QUE VOCÊ USA';
			case 'v2.transactions.noTransactions': return 'Nadinha registrado.';
			case 'v2.transactions.recentActivity': return 'Lances Recentes';
			case 'v2.transactions.searchTransaction': return 'Procurar compra...';
			case 'v2.transactions.date': return 'Quando';
			case 'v2.transactions.wallet': return 'De Onde Saiu';
			case 'v2.transactions.transactionDeleted': return 'Lançamento apagado.';
			case 'v2.transactions.selectCategoryTitle': return 'Onde encaixa isso?';
			case 'v2.transactions.searchCategory': return 'Pesquisar categoria...';
			case 'v2.transactions.noCategoriesAvailable': return 'Sem categorias prontas';
			case 'v2.transactions.createNewCategory': return 'Criar categoria do zero';
			case 'v2.transactions.amount': return 'A GRANA';
			case 'v2.transactions.description': return 'O QUE FOI?';
			case 'v2.transactions.category': return 'CATEGORIA';
			case 'v2.transactions.addNote': return 'Botar uma observação...';
			case 'v2.transactions.today': return 'Hoje';
			case 'v2.transactions.editTransaction': return 'Editar esse lance';
			case 'v2.transactions.newTransaction': return 'Novo Lançamento';
			case 'v2.transactions.selectWallet': return 'Avisa de onde saiu';
			case 'v2.transactions.save': return 'Registrar';
			case 'v2.transactions.transactionUpdated': return 'Lançamento ajeitado.';
			case 'v2.transactions.transactionSaved': return 'Pronto, tá no sistema.';
			case 'v2.settings.title': return 'Ajustar o App';
			case 'v2.settings.categories': return 'Suas Categorias';
			case 'v2.settings.wallets': return 'Onde fica a grana (Carteiras)';
			case 'v2.settings.language': return 'Idioma';
			case 'v2.settings.currency': return 'Qual a moeda?';
			case 'v2.settings.contact': return 'Falar com a gente';
			case 'v2.settings.legacyView': return 'Versão Tradicional (Antiga)';
			case 'v2.settings.deleteCategory': return 'Excluir de vez a categoria?';
			case 'v2.settings.deleteWallet': return 'Apagar carteira toda?';
			case 'v2.settings.cannotUndo': return 'Se fizer, já era, não dá pra desfazer.';
			case 'v2.settings.deleteWalletWarning': return 'Sumiu carteira, sumiram os lançamentos dentro dela.';
			case 'v2.settings.deleteError': return ({required Object error}) => 'Deu pau pra apagar: ${error}';
			case 'v2.settings.noCategoriesCreated': return 'Não achei categorias.\nBora criar uma?';
			case 'v2.settings.noWalletsCreated': return 'Zero carteiras cadastradas.\nCria a primeira aí.';
			case 'v2.settings.walletDeleted': return 'Carteira pro lixo.';
			case 'v2.settings.cancel': return 'Desistir';
			case 'v2.settings.delete': return 'Excluir';
			case 'v2.settings.expenses': return 'Despesas';
			case 'v2.settings.income': return 'Receitas';
			case 'v2.settings.newWallet': return 'Nova Carteira';
			case 'v2.settings.editWallet': return 'Editar Carteira';
			case 'v2.settings.walletName': return 'Nome dela';
			case 'v2.settings.saveWallet': return 'Gravar Carteira';
			case 'v2.settings.deleteWalletHasTransactions': return 'Não é possível excluir esta carteira porque ela possui transações existentes.';
			case 'v2.dashboard.greetingMorning': return 'Bom dia, patrão!';
			case 'v2.dashboard.totalBalance': return 'A GRANA TODA';
			case 'v2.dashboard.dateFilters.thisMonth': return 'Este mês';
			case 'v2.dashboard.dateFilters.lastMonth': return 'Mês que passou';
			case 'v2.dashboard.dateFilters.customRange': return 'Escolher os dias...';
			case 'v2.dashboard.walletFilters.all': return 'Todas';
			case 'v2.dashboard.walletFilters.allWallets': return 'Todas as carteiras';
			case 'v2.dashboard.background.title': return 'Plano de fundo de foco';
			case 'v2.dashboard.background.chooseFromGallery': return 'Pegar foto do celular';
			case 'v2.dashboard.background.restoreDefault': return 'Voltar à foto original';
			case 'v2.dashboard.incomeExpense.income': return 'GANHOS';
			case 'v2.dashboard.incomeExpense.expenses': return 'GASTOS';
			case 'v2.dashboard.gauge.exceeded': return 'ESTOUROU';
			case 'v2.dashboard.gauge.spent': return 'GASTOU';
			case 'v2.dashboard.gauge.available': return 'SOBROU';
			case 'v2.dashboard.gauge.overdrawn': return 'NO VERMELHO';
			case 'v2.dashboard.activityList.seeAll': return 'Ver tudo';
			case 'v2.dashboard.activityList.newUi': return 'Nova Tela';
			case 'v2.dashboard.activityList.expensesByCategory': return 'Pra onde o dinheiro tá indo';
			case 'v2.dashboard.activityList.noRecentExpenses': return 'Nenhum gasto recente, boa!';
			case 'v2.dashboard.activityList.percentOfTotal': return ({required Object percent}) => '${percent}% do total';
			case 'v2.dashboard.activityList.topExpenses': return ({required Object count}) => 'Os top ${count} gastos piores';
			case 'v2.dashboard.activityList.others': return 'Resto';
			case 'v2.categories.title': return 'Categorias';
			case 'v2.categories.searchPlaceholder': return 'Caçar categoria...';
			case 'v2.categories.newCategory': return 'Adicionar nova';
			case 'v2.categories.editCategory': return 'Mudar a categoria';
			case 'v2.categories.noCategories': return 'Nadinha cadastrado';
			case 'v2.categories.form.nameLabel': return 'Como chama essa categoria?';
			case 'v2.categories.form.save': return 'Gravar';
			case 'v2.onboarding.buttons.start': return 'Bora lá!';
			case 'v2.onboarding.buttons.actionContinue': return 'Pode seguir';
			case 'v2.onboarding.buttons.great': return 'Massa!';
			case 'v2.onboarding.buttons.setGoal': return 'Focar nisso';
			case 'v2.onboarding.buttons.skip': return 'Pular chatice';
			case 'v2.onboarding.splash.title1': return 'E se a Inteligência\nArtificial ';
			case 'v2.onboarding.splash.title2': return 'cuidar do seu dindin\nmelhor que você?';
			case 'v2.onboarding.splash.benefit1': return 'Menos trabalho.';
			case 'v2.onboarding.splash.benefit2': return 'Mais visão.';
			case 'v2.onboarding.splash.benefit3': return 'Nada de erro bobo.';
			case 'v2.onboarding.expenseCategories.title1': return 'Onde o seu dinheiro some todo santo mês?';
			case 'v2.onboarding.expenseCategories.subtitle': return 'Escolhe as piores (até 3)';
			case 'v2.onboarding.expenseCategories.diningOut': return 'Comer fora de casa';
			case 'v2.onboarding.expenseCategories.cravings': return 'Besteiras / Lanches';
			case 'v2.onboarding.expenseCategories.subscriptions': return 'Assinaturas esquecidas';
			case 'v2.onboarding.expenseCategories.outings': return 'Baladas e roles';
			case 'v2.onboarding.expenseCategories.shopping': return 'Comprar sem pensar';
			case 'v2.onboarding.expenseCategories.delivery': return 'Ifood e afins';
			case 'v2.onboarding.financialGoals.title': return 'O que ia mudar a sua\nvida agora mesmo?';
			case 'v2.onboarding.financialGoals.subtitle': return 'Anota só uma';
			case 'v2.onboarding.financialGoals.trackMoney': return 'Saber exatamente pra onde vai a grana';
			case 'v2.onboarding.financialGoals.spendLess': return 'Parar de comprar lixo que eu não preciso';
			case 'v2.onboarding.financialGoals.lessStress': return 'Ter paz de espírito pra variar';
			case 'v2.onboarding.financialGoals.saveMoney': return 'Achar grana pra poupar de verdade';
			case 'v2.onboarding.registrationMethod.title': return 'Como tu vai lançar os\ngastos no dia a dia?';
			case 'v2.onboarding.registrationMethod.subtitle': return 'Escolhe a mais fácil';
			case 'v2.onboarding.registrationMethod.voice': return 'Chegar falando e o app anota';
			case 'v2.onboarding.registrationMethod.auto': return 'Automático pelo banco';
			case 'v2.onboarding.registrationMethod.write': return 'Digitar do jeito antigo';
			case 'v2.onboarding.registrationMethod.easy': return 'Qualquer uma que não me dê preguiça';
			case 'v2.onboarding.aiAnalysis.loading.title': return 'MONTANDO O APP PRO\nSEU JEITO';
			case 'v2.onboarding.aiAnalysis.loading.subtitle': return 'Processando...';
			case 'v2.onboarding.aiAnalysis.loading.messages.0': return 'Checando como você gasta...';
			case 'v2.onboarding.aiAnalysis.loading.messages.1': return 'Arrumando as categorias pra ti...';
			case 'v2.onboarding.aiAnalysis.loading.messages.2': return 'Caçando onde você mais erra...';
			case 'v2.onboarding.aiAnalysis.loading.messages.3': return 'Criando dicas matadoras pra você...';
			case 'v2.onboarding.aiAnalysis.showcase.title': return 'Pronto! Fica a dica:';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.kDefault': return 'Sua grana evapora rápido demais, acho que do jeito atual não tá dando certo.';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.part2': return ' consomem boa parte de tudo, e ver que cê quer ';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.part3': return ' me diz que o jeito atual já era.';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.categories.diningOut': return 'Comer fora';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.categories.cravings': return 'As bobeiras';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.categories.subscriptions': return 'Suas assinaturas';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.categories.outings': return 'Sair no fim de semana';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.categories.shopping': return 'As comprinhas online';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.categories.delivery': return 'Os deliveries';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.intentions.trackMoney': return 'saber pra onde vai o dinheiro';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.intentions.spendLess': return 'gastar menos';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.intentions.lessStress': return 'parar de surtar';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.intentions.saveMoney': return 'guardar pra algo';
			case 'v2.onboarding.aiAnalysis.showcase.result.yourResult': return 'Sua estatística';
			case 'v2.onboarding.aiAnalysis.showcase.result.average': return 'Média Normal';
			case 'v2.onboarding.aiAnalysis.showcase.result.messagePart1': return 'Você gasta 68% ';
			case 'v2.onboarding.aiAnalysis.showcase.result.messagePart2': return 'a mais com isso que o brasileiro médio, ';
			case 'v2.onboarding.aiAnalysis.showcase.result.messagePart3': return 'e isso é péssimo\n';
			case 'v2.onboarding.aiAnalysis.showcase.result.messagePart4': return 'pra quem quer focar nos seus sonhos';
			case 'v2.onboarding.mainPriority.title': return 'Qual a tua pegada\nagora?';
			case 'v2.onboarding.mainPriority.subtitle': return 'No que o MoneyT vai ser seu parceiro diário?';
			case 'v2.onboarding.mainPriority.breakHabits': return 'Destruir meus vícios de gastar';
			case 'v2.onboarding.mainPriority.stopStress': return 'Paz! Chega de perrengue.';
			case 'v2.onboarding.mainPriority.buildFuture': return 'Ficar rico no futuro';
			case 'v2.onboarding.mainPriority.feelControl': return 'Saber tudo da minha grana';
			case 'v2.onboarding.mainPriority.saveGoal': return 'Guardar pra algo top';
			case 'v2.onboarding.aiVoice.title.kDefault': return 'Bater suas metas';
			case 'v2.onboarding.aiVoice.title.breakHabits': return 'Quebrar de vez os hábitos que te ferram';
			case 'v2.onboarding.aiVoice.title.stopStress': return 'Chega de perder sono pela grana';
			case 'v2.onboarding.aiVoice.title.buildFuture': return 'Fazer a sua fortuna render';
			case 'v2.onboarding.aiVoice.title.feelControl': return 'Sentir que tá pilotando a nave financeira';
			case 'v2.onboarding.aiVoice.title.saveGoal': return 'Guardar pro objetivo sem desviar';
			case 'v2.onboarding.aiVoice.title.suffix': return ' agora vai ser moleza com a nossa IA.';
			case 'v2.onboarding.aiVoice.subtitle': return 'Não esquenta com botão, só avisa a IA que ela anota os gastos';
			case 'v2.onboarding.aiVoice.listening': return 'Pode falar, tô ouvindo...';
			case 'v2.onboarding.aiVoice.examples.0': return 'Café R\$5,50';
			case 'v2.onboarding.aiVoice.examples.1': return 'Uber R\$22,00';
			case 'v2.onboarding.aiVoice.examples.2': return 'Cinema R\$35,00';
			case 'v2.onboarding.aiVoice.examples.3': return 'Mercado R\$145,20';
			case 'v2.onboarding.aiVoice.examples.4': return 'Gasolina R\$100,00';
			case 'v2.onboarding.aiVoice.examples.5': return 'Netflix R\$39,90';
			case 'v2.onboarding.aiVoice.examples.6': return 'Jantar R\$85,00';
			case 'v2.onboarding.aiVoice.examples.7': return 'Farmácia R\$48,50';
			case 'v2.dateSelection.days': return 'Dias';
			case 'v2.dateSelection.months': return 'Meses';
			case 'v2.dateSelection.years': return 'Anos';
			case 'intents.transactionSavedTitle': return '✅ Transação Salva';
			case 'intents.emptyText': return 'Texto vazio';
			case 'intents.emptyData': return 'Dados vazios';
			case 'intents.cannotUnderstand': return 'Não foi possível entender';
			case 'intents.errorSaving': return 'Erro ao salvar';
			case 'intents.noCategories': return 'Sem categorias';
			case 'intents.loadingError': return 'Erro ao carregar';
			default: return null;
		}
	}
}

