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
class AppStringsVi extends AppStrings {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	AppStringsVi({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, AppStrings>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.vi,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <vi>.
	@override final TranslationMetadata<AppLocale, AppStrings> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final AppStringsVi _root = this; // ignore: unused_field

	@override 
	AppStringsVi $copyWith({TranslationMetadata<AppLocale, AppStrings>? meta}) => AppStringsVi(meta: meta ?? this.$meta);

	// Translations
	@override late final _AppStringsAppVi app = _AppStringsAppVi._(_root);
	@override late final _AppStringsCommonVi common = _AppStringsCommonVi._(_root);
	@override late final _AppStringsComponentsVi components = _AppStringsComponentsVi._(_root);
	@override late final _AppStringsNavigationVi navigation = _AppStringsNavigationVi._(_root);
	@override late final _AppStringsTransactionsVi transactions = _AppStringsTransactionsVi._(_root);
	@override late final _AppStringsContactsVi contacts = _AppStringsContactsVi._(_root);
	@override late final _AppStringsErrorsVi errors = _AppStringsErrorsVi._(_root);
	@override late final _AppStringsSettingsVi settings = _AppStringsSettingsVi._(_root);
	@override late final _AppStringsOnboardingVi onboarding = _AppStringsOnboardingVi._(_root);
	@override late final _AppStringsDashboardVi dashboard = _AppStringsDashboardVi._(_root);
	@override late final _AppStringsWalletsVi wallets = _AppStringsWalletsVi._(_root);
	@override late final _AppStringsLoansVi loans = _AppStringsLoansVi._(_root);
	@override late final _AppStringsCategoriesVi categories = _AppStringsCategoriesVi._(_root);
	@override late final _AppStringsBackupsVi backups = _AppStringsBackupsVi._(_root);
	@override late final _AppStringsV2Vi v2 = _AppStringsV2Vi._(_root);
}

// Path: app
class _AppStringsAppVi extends AppStringsAppEn {
	_AppStringsAppVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get name => 'MoneyT';
	@override String get description => 'Quản Lý Tài Chính';
}

// Path: common
class _AppStringsCommonVi extends AppStringsCommonEn {
	_AppStringsCommonVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get save => 'Lưu';
	@override String get cancel => 'Hủy';
	@override String get delete => 'Xóa';
	@override String get edit => 'Sửa';
	@override String get loading => 'Đang tải...';
	@override String get error => 'Lỗi';
	@override String get success => 'Thành công';
	@override String get search => 'Tìm kiếm';
	@override String get clearSearch => 'Xóa tìm kiếm';
	@override String get viewAll => 'Xem tất cả';
	@override String get retry => 'Thử lại';
	@override String get add => 'Thêm';
	@override String get remove => 'Xóa bỏ';
	@override String get moreOptions => 'Thêm tùy chọn';
	@override String get addToFavorites => 'Thêm vào yêu thích';
	@override String get removeFromFavorites => 'Xóa khỏi yêu thích';
	@override String get today => 'Hôm nay';
	@override String get yesterday => 'Hôm qua';
}

// Path: components
class _AppStringsComponentsVi extends AppStringsComponentsEn {
	_AppStringsComponentsVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override late final _AppStringsComponentsDateSelectionVi dateSelection = _AppStringsComponentsDateSelectionVi._(_root);
	@override late final _AppStringsComponentsSelectionVi selection = _AppStringsComponentsSelectionVi._(_root);
	@override late final _AppStringsComponentsContactSelectionVi contactSelection = _AppStringsComponentsContactSelectionVi._(_root);
	@override late final _AppStringsComponentsCategorySelectionVi categorySelection = _AppStringsComponentsCategorySelectionVi._(_root);
	@override late final _AppStringsComponentsCurrencySelectionVi currencySelection = _AppStringsComponentsCurrencySelectionVi._(_root);
	@override late final _AppStringsComponentsAccountSelectionVi accountSelection = _AppStringsComponentsAccountSelectionVi._(_root);
	@override late final _AppStringsComponentsParentWalletSelectionVi parentWalletSelection = _AppStringsComponentsParentWalletSelectionVi._(_root);
	@override late final _AppStringsComponentsWalletTypesVi walletTypes = _AppStringsComponentsWalletTypesVi._(_root);
}

// Path: navigation
class _AppStringsNavigationVi extends AppStringsNavigationEn {
	_AppStringsNavigationVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get home => 'Tổng quan';
	@override String get transactions => 'Giao dịch';
	@override String get contacts => 'Liên hệ';
	@override String get settings => 'Cài đặt';
	@override String get wallets => 'Ví';
	@override String get categories => 'Danh mục';
	@override String get loans => 'Khoản vay';
	@override String get charts => 'Biểu đồ tài khoản';
	@override String get backups => 'Sao lưu';
	@override String get creditCards => 'Thẻ tín dụng';
	@override late final _AppStringsNavigationSectionsVi sections = _AppStringsNavigationSectionsVi._(_root);
}

// Path: transactions
class _AppStringsTransactionsVi extends AppStringsTransactionsEn {
	_AppStringsTransactionsVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Giao dịch';
	@override late final _AppStringsTransactionsTypesVi types = _AppStringsTransactionsTypesVi._(_root);
	@override late final _AppStringsTransactionsFilterVi filter = _AppStringsTransactionsFilterVi._(_root);
	@override late final _AppStringsTransactionsFormVi form = _AppStringsTransactionsFormVi._(_root);
	@override late final _AppStringsTransactionsErrorsVi errors = _AppStringsTransactionsErrorsVi._(_root);
	@override late final _AppStringsTransactionsEmptyVi empty = _AppStringsTransactionsEmptyVi._(_root);
	@override late final _AppStringsTransactionsListVi list = _AppStringsTransactionsListVi._(_root);
	@override late final _AppStringsTransactionsDetailVi detail = _AppStringsTransactionsDetailVi._(_root);
	@override late final _AppStringsTransactionsShareVi share = _AppStringsTransactionsShareVi._(_root);
}

// Path: contacts
class _AppStringsContactsVi extends AppStringsContactsEn {
	_AppStringsContactsVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Danh bạ liên hệ';
	@override String get addContact => 'Thêm liên hệ';
	@override String get editContact => 'Sửa liên hệ';
	@override String get newContact => 'Tạo mới';
	@override String get noContacts => 'Chưa có liên hệ';
	@override String get noContactsMessage => 'Thêm liên hệ đầu tiên bằng nút +';
	@override String get searchContacts => 'Tìm kiếm';
	@override String get deleteContact => 'Xóa liên hệ';
	@override String get confirmDelete => 'Bạn có chắc chắn muốn xóa';
	@override String get contactDeleted => 'Đã xóa';
	@override String get errorDeleting => 'Lỗi';
	@override String get noSearchResults => 'Không tìm thấy';
	@override String noContactsMatch({required Object query}) => 'Không có ai tên "${query}".';
	@override String get errorLoading => 'Lỗi tải dữ liệu';
	@override String get contactSaved => 'Đã lưu';
	@override String get errorSaving => 'Lỗi';
	@override String get noContactInfo => 'Không có thông tin';
	@override String get importContact => 'Nhập từ danh bạ';
	@override String get importContacts => 'Nhập hàng loạt';
	@override String get importContactSoon => 'Tính năng sắp ra mắt';
	@override late final _AppStringsContactsFieldsVi fields = _AppStringsContactsFieldsVi._(_root);
	@override late final _AppStringsContactsPlaceholdersVi placeholders = _AppStringsContactsPlaceholdersVi._(_root);
	@override late final _AppStringsContactsValidationVi validation = _AppStringsContactsValidationVi._(_root);
}

// Path: errors
class _AppStringsErrorsVi extends AppStringsErrorsEn {
	_AppStringsErrorsVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String loadingAccounts({required Object error}) => 'Lỗi tải: ${error}';
	@override String get unexpected => 'Lỗi không xác định';
}

// Path: settings
class _AppStringsSettingsVi extends AppStringsSettingsEn {
	_AppStringsSettingsVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Cài đặt';
	@override late final _AppStringsSettingsAccountVi account = _AppStringsSettingsAccountVi._(_root);
	@override late final _AppStringsSettingsAppearanceVi appearance = _AppStringsSettingsAppearanceVi._(_root);
	@override late final _AppStringsSettingsDataVi data = _AppStringsSettingsDataVi._(_root);
	@override late final _AppStringsSettingsInfoVi info = _AppStringsSettingsInfoVi._(_root);
	@override late final _AppStringsSettingsLogoutVi logout = _AppStringsSettingsLogoutVi._(_root);
	@override late final _AppStringsSettingsSocialVi social = _AppStringsSettingsSocialVi._(_root);
	@override late final _AppStringsSettingsLanguageVi language = _AppStringsSettingsLanguageVi._(_root);
	@override late final _AppStringsSettingsCurrencyVi currency = _AppStringsSettingsCurrencyVi._(_root);
	@override late final _AppStringsSettingsMessagesVi messages = _AppStringsSettingsMessagesVi._(_root);
}

// Path: onboarding
class _AppStringsOnboardingVi extends AppStringsOnboardingEn {
	_AppStringsOnboardingVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override late final _AppStringsOnboardingWelcomeVi welcome = _AppStringsOnboardingWelcomeVi._(_root);
	@override late final _AppStringsOnboardingProblemStatementVi problemStatement = _AppStringsOnboardingProblemStatementVi._(_root);
	@override late final _AppStringsOnboardingSpecificProblemVi specificProblem = _AppStringsOnboardingSpecificProblemVi._(_root);
	@override late final _AppStringsOnboardingPersonalGoalVi personalGoal = _AppStringsOnboardingPersonalGoalVi._(_root);
	@override late final _AppStringsOnboardingSolutionPreviewVi solutionPreview = _AppStringsOnboardingSolutionPreviewVi._(_root);
	@override late final _AppStringsOnboardingCurrentMethodVi currentMethod = _AppStringsOnboardingCurrentMethodVi._(_root);
	@override late final _AppStringsOnboardingFeaturesShowcaseVi featuresShowcase = _AppStringsOnboardingFeaturesShowcaseVi._(_root);
	@override late final _AppStringsOnboardingCompleteVi complete = _AppStringsOnboardingCompleteVi._(_root);
	@override late final _AppStringsOnboardingButtonsVi buttons = _AppStringsOnboardingButtonsVi._(_root);
}

// Path: dashboard
class _AppStringsDashboardVi extends AppStringsDashboardEn {
	_AppStringsDashboardVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get greeting => 'Chào bạn';
	@override late final _AppStringsDashboardBalanceVi balance = _AppStringsDashboardBalanceVi._(_root);
	@override late final _AppStringsDashboardActionsVi actions = _AppStringsDashboardActionsVi._(_root);
	@override late final _AppStringsDashboardWalletsVi wallets = _AppStringsDashboardWalletsVi._(_root);
	@override late final _AppStringsDashboardTransactionsVi transactions = _AppStringsDashboardTransactionsVi._(_root);
	@override String get customize => 'Tùy chỉnh';
	@override late final _AppStringsDashboardWidgetsVi widgets = _AppStringsDashboardWidgetsVi._(_root);
}

// Path: wallets
class _AppStringsWalletsVi extends AppStringsWalletsEn {
	_AppStringsWalletsVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ví của bạn';
	@override late final _AppStringsWalletsEmptyVi empty = _AppStringsWalletsEmptyVi._(_root);
	@override late final _AppStringsWalletsEmptyArchivedVi emptyArchived = _AppStringsWalletsEmptyArchivedVi._(_root);
	@override late final _AppStringsWalletsFilterVi filter = _AppStringsWalletsFilterVi._(_root);
	@override late final _AppStringsWalletsFormVi form = _AppStringsWalletsFormVi._(_root);
	@override late final _AppStringsWalletsDeleteVi delete = _AppStringsWalletsDeleteVi._(_root);
	@override late final _AppStringsWalletsErrorsVi errors = _AppStringsWalletsErrorsVi._(_root);
	@override late final _AppStringsWalletsSubtitleVi subtitle = _AppStringsWalletsSubtitleVi._(_root);
	@override late final _AppStringsWalletsOptionsVi options = _AppStringsWalletsOptionsVi._(_root);
}

// Path: loans
class _AppStringsLoansVi extends AppStringsLoansEn {
	_AppStringsLoansVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sổ nợ';
	@override late final _AppStringsLoansFilterVi filter = _AppStringsLoansFilterVi._(_root);
	@override late final _AppStringsLoansSummaryVi summary = _AppStringsLoansSummaryVi._(_root);
	@override late final _AppStringsLoansCardVi card = _AppStringsLoansCardVi._(_root);
	@override late final _AppStringsLoansFormVi form = _AppStringsLoansFormVi._(_root);
	@override late final _AppStringsLoansDetailVi detail = _AppStringsLoansDetailVi._(_root);
	@override late final _AppStringsLoansHistoryVi history = _AppStringsLoansHistoryVi._(_root);
	@override late final _AppStringsLoansContactDetailVi contactDetail = _AppStringsLoansContactDetailVi._(_root);
	@override late final _AppStringsLoansShareVi share = _AppStringsLoansShareVi._(_root);
	@override late final _AppStringsLoansPaymentVi payment = _AppStringsLoansPaymentVi._(_root);
	@override String get given => 'Bạn cho mượn';
	@override String get received => 'Bạn đi mượn';
	@override late final _AppStringsLoansItemVi item = _AppStringsLoansItemVi._(_root);
	@override late final _AppStringsLoansSectionVi section = _AppStringsLoansSectionVi._(_root);
	@override late final _AppStringsLoansEmptyVi empty = _AppStringsLoansEmptyVi._(_root);
}

// Path: categories
class _AppStringsCategoriesVi extends AppStringsCategoriesEn {
	_AppStringsCategoriesVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Danh mục';
	@override late final _AppStringsCategoriesFormVi form = _AppStringsCategoriesFormVi._(_root);
	@override late final _AppStringsCategoriesParentSelectionVi parentSelection = _AppStringsCategoriesParentSelectionVi._(_root);
	@override String get incomeCategory => 'Loại thu';
	@override String get expenseCategory => 'Loại chi';
	@override late final _AppStringsCategoriesReportVi report = _AppStringsCategoriesReportVi._(_root);
}

// Path: backups
class _AppStringsBackupsVi extends AppStringsBackupsEn {
	_AppStringsBackupsVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sao lưu dữ liệu';
	@override late final _AppStringsBackupsMenuVi menu = _AppStringsBackupsMenuVi._(_root);
	@override late final _AppStringsBackupsFiltersVi filters = _AppStringsBackupsFiltersVi._(_root);
	@override late final _AppStringsBackupsStatusVi status = _AppStringsBackupsStatusVi._(_root);
	@override late final _AppStringsBackupsActionsVi actions = _AppStringsBackupsActionsVi._(_root);
	@override late final _AppStringsBackupsDialogsVi dialogs = _AppStringsBackupsDialogsVi._(_root);
	@override late final _AppStringsBackupsStatsVi stats = _AppStringsBackupsStatsVi._(_root);
	@override late final _AppStringsBackupsOptionsVi options = _AppStringsBackupsOptionsVi._(_root);
	@override late final _AppStringsBackupsFormatVi format = _AppStringsBackupsFormatVi._(_root);
}

// Path: v2
class _AppStringsV2Vi extends AppStringsV2En {
	_AppStringsV2Vi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override late final _AppStringsV2VoiceVi voice = _AppStringsV2VoiceVi._(_root);
	@override late final _AppStringsV2TransactionsVi transactions = _AppStringsV2TransactionsVi._(_root);
	@override late final _AppStringsV2SettingsVi settings = _AppStringsV2SettingsVi._(_root);
	@override late final _AppStringsV2DashboardVi dashboard = _AppStringsV2DashboardVi._(_root);
	@override late final _AppStringsV2CategoriesVi categories = _AppStringsV2CategoriesVi._(_root);
	@override late final _AppStringsV2OnboardingVi onboarding = _AppStringsV2OnboardingVi._(_root);
}

// Path: components.dateSelection
class _AppStringsComponentsDateSelectionVi extends AppStringsComponentsDateSelectionEn {
	_AppStringsComponentsDateSelectionVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Chọn ngày';
	@override String get subtitle => 'Chọn ngày giao dịch';
	@override String get selectedDate => 'Ngày đã chọn';
	@override String get confirm => 'Xác nhận';
}

// Path: components.selection
class _AppStringsComponentsSelectionVi extends AppStringsComponentsSelectionEn {
	_AppStringsComponentsSelectionVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Hủy';
	@override String get confirm => 'Xác nhận';
	@override String get select => 'Chọn';
}

// Path: components.contactSelection
class _AppStringsComponentsContactSelectionVi extends AppStringsComponentsContactSelectionEn {
	_AppStringsComponentsContactSelectionVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Chọn người liên hệ';
	@override String get subtitle => 'Giao dịch với ai';
	@override String get searchPlaceholder => 'Tìm người liên hệ';
	@override String get noContact => 'Không có';
	@override String get noContactDetails => 'Giao dịch không có người liên hệ';
	@override String get allContacts => 'Tất cả';
	@override String get create => 'Tạo mới';
}

// Path: components.categorySelection
class _AppStringsComponentsCategorySelectionVi extends AppStringsComponentsCategorySelectionEn {
	_AppStringsComponentsCategorySelectionVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Chọn danh mục';
	@override String get subtitle => 'Chọn danh mục cho giao dịch này';
	@override String get searchPlaceholder => 'Tìm danh mục';
}

// Path: components.currencySelection
class _AppStringsComponentsCurrencySelectionVi extends AppStringsComponentsCurrencySelectionEn {
	_AppStringsComponentsCurrencySelectionVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Chọn tiền tệ';
	@override String get subtitle => 'Chọn loại tiền';
	@override String get searchPlaceholder => 'Tìm tiền tệ';
}

// Path: components.accountSelection
class _AppStringsComponentsAccountSelectionVi extends AppStringsComponentsAccountSelectionEn {
	_AppStringsComponentsAccountSelectionVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Chọn tài khoản';
	@override String get subtitle => 'Chọn tài khoản giao dịch';
	@override String get searchPlaceholder => 'Tìm tài khoản';
	@override String get wallets => 'Ví điện tử & Tiền mặt';
	@override String get creditCards => 'Thẻ tín dụng';
	@override String get selectAccount => 'Chọn tài khoản';
	@override String get confirm => 'Xác nhận';
}

// Path: components.parentWalletSelection
class _AppStringsComponentsParentWalletSelectionVi extends AppStringsComponentsParentWalletSelectionEn {
	_AppStringsComponentsParentWalletSelectionVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ví cha';
	@override String get subtitle => 'Chọn ví chính';
	@override String get searchPlaceholder => 'Tìm ví';
	@override String get noParent => 'Không có ví cha';
	@override String get createRoot => 'Tạo ví gốc';
	@override String get available => 'Ví khả dụng';
}

// Path: components.walletTypes
class _AppStringsComponentsWalletTypesVi extends AppStringsComponentsWalletTypesEn {
	_AppStringsComponentsWalletTypesVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get checking => 'Tài khoản thanh toán';
	@override String get savings => 'Tiết kiệm';
	@override String get cash => 'Tiền mặt';
	@override String get creditCard => 'Thẻ tín dụng';
}

// Path: navigation.sections
class _AppStringsNavigationSectionsVi extends AppStringsNavigationSectionsEn {
	_AppStringsNavigationSectionsVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get operations => 'GIAO DỊCH';
	@override String get financialTools => 'CÔNG CỤ TÀI CHÍNH';
	@override String get management => 'QUẢN LÝ';
	@override String get advanced => 'NÂNG CAO';
}

// Path: transactions.types
class _AppStringsTransactionsTypesVi extends AppStringsTransactionsTypesEn {
	_AppStringsTransactionsTypesVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get all => 'Tất cả';
	@override String get income => 'Thu nhập';
	@override String get expense => 'Chi tiêu';
	@override String get transfer => 'Chuyển khoản';
}

// Path: transactions.filter
class _AppStringsTransactionsFilterVi extends AppStringsTransactionsFilterEn {
	_AppStringsTransactionsFilterVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Lọc Giao dịch';
	@override String get date => 'Ngày';
	@override String get categories => 'Danh mục';
	@override String get accounts => 'Tài khoản';
	@override String get contacts => 'Liên hệ';
	@override String get amount => 'Số tiền';
	@override String get apply => 'Áp dụng';
	@override String get clear => 'Xóa bộ lọc';
	@override String get add => 'Thêm bộ lọc';
	@override String get minAmount => 'Số tiền tối thiểu';
	@override String get maxAmount => 'Số tiền tối đa';
	@override String get selectDate => 'Chọn ngày';
	@override String get selectCategory => 'Chọn danh mục';
	@override String get selectAccount => 'Chọn tài khoản';
	@override String get selectContact => 'Chọn liên hệ';
	@override String get quickFilters => 'Lọc nhanh';
	@override late final _AppStringsTransactionsFilterRangesVi ranges = _AppStringsTransactionsFilterRangesVi._(_root);
	@override String get customRange => 'Tùy chỉnh';
	@override String get startDate => 'Từ ngày';
	@override String get endDate => 'Đến ngày';
	@override String get active => 'Bộ lọc đang bật';
	@override late final _AppStringsTransactionsFilterSubtitlesVi subtitles = _AppStringsTransactionsFilterSubtitlesVi._(_root);
}

// Path: transactions.form
class _AppStringsTransactionsFormVi extends AppStringsTransactionsFormEn {
	_AppStringsTransactionsFormVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get newTitle => 'Thêm Giao Dịch';
	@override String get editTitle => 'Sửa Giao Dịch';
	@override String get amount => 'Số tiền';
	@override String get type => 'Loại giao dịch';
	@override String get amountRequired => 'Bắt buộc nhập số tiền';
	@override String get date => 'Ngày';
	@override String get account => 'Tài khoản';
	@override String get toAccount => 'Đến tài khoản';
	@override String get category => 'Danh mục';
	@override String get contact => 'Người liên hệ';
	@override String get contactOptional => 'Liên hệ (không bắt buộc)';
	@override String get description => 'Ghi chú';
	@override String get descriptionOptional => 'Ghi chú (không bắt buộc)';
	@override String get selectAccount => 'Chọn tài khoản';
	@override String get selectDestination => 'Chọn đích đến';
	@override String get selectCategory => 'Chọn danh mục';
	@override String get selectContact => 'Chọn liên hệ';
	@override String get saveSuccess => 'Lưu thành công';
	@override String get updateSuccess => 'Cập nhật thành công';
	@override String get saveError => 'Lỗi khi lưu';
	@override String get share => 'Chia sẻ';
	@override String get created => 'Đã tạo giao dịch';
	@override String get crossCurrencyConversion => 'Quy đổi ngoại tệ';
	@override String get receivedAmount => 'Số tiền nhận';
	@override String get exchangeRate => 'Tỷ giá';
	@override String get receivedAmountRequired => 'Nhập số tiền nhận';
	@override String exchangeRateLabel({required Object from, required Object rate, required Object to}) => '1 ${from} = ${rate} ${to}';
}

// Path: transactions.errors
class _AppStringsTransactionsErrorsVi extends AppStringsTransactionsErrorsEn {
	_AppStringsTransactionsErrorsVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get load => 'Lỗi tải dữ liệu';
}

// Path: transactions.empty
class _AppStringsTransactionsEmptyVi extends AppStringsTransactionsEmptyEn {
	_AppStringsTransactionsEmptyVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Chưa có giao dịch';
	@override String get message => 'Không tìm thấy giao dịch nào';
	@override String get clearFilters => 'Xóa bộ lọc';
}

// Path: transactions.list
class _AppStringsTransactionsListVi extends AppStringsTransactionsListEn {
	_AppStringsTransactionsListVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String count({required Object n}) => '${n} giao dịch';
}

// Path: transactions.detail
class _AppStringsTransactionsDetailVi extends AppStringsTransactionsDetailEn {
	_AppStringsTransactionsDetailVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Chi tiết Giao Dịch';
	@override String get delete => 'Xóa';
	@override String get deleteConfirmation => 'Bạn có chắc chắn muốn xóa?';
	@override String get deleted => 'Đã xóa giao dịch';
	@override String get duplicate => 'Nhân bản';
	@override String get duplicateNotImplemented => 'Chưa hỗ trợ nhân bản';
	@override String get edit => 'Sửa';
	@override String get errorLoad => 'Lỗi tải chi tiết';
	@override String errorPrepareEdit({required Object error}) => 'Lỗi khi sửa: ${error}';
	@override String errorDelete({required Object error}) => 'Lỗi khi xóa: ${error}';
	@override String get category => 'Danh mục';
	@override String get account => 'Tài khoản';
	@override String get contact => 'Liên hệ';
	@override String get description => 'Ghi chú';
	@override String get transferDetails => 'Chi tiết chuyển khoản';
	@override String get from => 'Từ';
	@override String get to => 'Đến';
	@override String get unknownAccount => 'Tài khoản ẩn';
	@override String errorUrl({required Object url}) => 'Không mở được ${url}';
	@override String get date => 'Ngày';
	@override String get time => 'Giờ';
	@override String get loanLinkedWarning => 'Giao dịch này liên kết với khoản vay.';
}

// Path: transactions.share
class _AppStringsTransactionsShareVi extends AppStringsTransactionsShareEn {
	_AppStringsTransactionsShareVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Chia sẻ';
	@override String get copyText => 'Sao chép';
	@override String get shareButton => 'Chia sẻ';
	@override String get shareMessage => 'Đây là hóa đơn của tôi:';
	@override String get copied => 'Đã sao chép vào khay nhớ tạm!';
	@override String get paymentMethod => 'Phương thức thanh toán';
	@override String get receiptTitle => 'Hóa Đơn';
	@override String get poweredBy => 'Cung cấp bởi MoneyT • moneyt.io';
	@override String errorImage({required Object error}) => 'Lỗi: ${error}';
	@override late final _AppStringsTransactionsShareReceiptVi receipt = _AppStringsTransactionsShareReceiptVi._(_root);
	@override String generatedOn({required Object date}) => 'Tạo ngày ${date}';
}

// Path: contacts.fields
class _AppStringsContactsFieldsVi extends AppStringsContactsFieldsEn {
	_AppStringsContactsFieldsVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get name => 'Tên';
	@override String get fullName => 'Họ và tên';
	@override String get email => 'Email';
	@override String get phone => 'Số điện thoại';
	@override String get address => 'Địa chỉ';
	@override String get notes => 'Ghi chú';
}

// Path: contacts.placeholders
class _AppStringsContactsPlaceholdersVi extends AppStringsContactsPlaceholdersEn {
	_AppStringsContactsPlaceholdersVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get enterFullName => 'Nhập họ tên';
	@override String get enterPhone => 'Nhập SĐT';
	@override String get enterEmail => 'Nhập Email';
}

// Path: contacts.validation
class _AppStringsContactsValidationVi extends AppStringsContactsValidationEn {
	_AppStringsContactsValidationVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get nameRequired => 'Bắt buộc nhập tên';
	@override String get invalidEmail => 'Email không hợp lệ';
	@override String get invalidPhone => 'SĐT không hợp lệ';
}

// Path: settings.account
class _AppStringsSettingsAccountVi extends AppStringsSettingsAccountEn {
	_AppStringsSettingsAccountVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tài khoản';
	@override String get profile => 'Hồ sơ';
	@override String get profileSubtitle => 'Quản lý thông tin cá nhân';
}

// Path: settings.appearance
class _AppStringsSettingsAppearanceVi extends AppStringsSettingsAppearanceEn {
	_AppStringsSettingsAppearanceVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tùy chọn';
	@override String get darkMode => 'Chế độ tối';
	@override String get darkModeSubtitle => 'Bật giao diện tối';
	@override String get language => 'Ngôn ngữ';
	@override String get currency => 'Tiền tệ mặc định';
	@override String get currencySubtitle => 'Đơn vị tiền tệ hiển thị';
	@override String get darkTheme => 'Giao diện tối';
	@override String get lightTheme => 'Giao diện sáng';
	@override String get systemTheme => 'Theo hệ thống';
}

// Path: settings.data
class _AppStringsSettingsDataVi extends AppStringsSettingsDataEn {
	_AppStringsSettingsDataVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Dữ liệu';
	@override String get backup => 'Sao lưu';
	@override String get backupSubtitle => 'Quản lý dữ liệu an toàn';
}

// Path: settings.info
class _AppStringsSettingsInfoVi extends AppStringsSettingsInfoEn {
	_AppStringsSettingsInfoVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Thông tin';
	@override String get contact => 'Liên hệ & Mạng xã hội';
	@override String get contactSubtitle => 'Tham gia cộng đồng';
	@override String get privacy => 'Chính sách bảo mật';
	@override String get privacySubtitle => 'Đọc chính sách của chúng tôi';
	@override String get share => 'Chia sẻ MoneyT';
	@override String get shareSubtitle => 'Giới thiệu bạn bè';
}

// Path: settings.logout
class _AppStringsSettingsLogoutVi extends AppStringsSettingsLogoutEn {
	_AppStringsSettingsLogoutVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get button => 'Đăng xuất';
	@override String get dialogTitle => 'Đăng xuất';
	@override String get dialogMessage => 'Bạn có chắc chắn muốn đăng xuất?';
	@override String get cancel => 'Hủy';
	@override String get confirm => 'Đăng xuất';
}

// Path: settings.social
class _AppStringsSettingsSocialVi extends AppStringsSettingsSocialEn {
	_AppStringsSettingsSocialVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Liên hệ';
	@override String get follow => 'Theo dõi MoneyT';
	@override String get description => 'Nhận tin tức mới nhất.';
	@override String get networks => 'Mạng xã hội';
	@override String get github => 'GitHub';
	@override String get githubSubtitle => 'Xem mã nguồn';
	@override String get linkedin => 'LinkedIn';
	@override String get linkedinSubtitle => 'Tin tức chuyên nghiệp';
	@override String get twitter => 'X (Twitter)';
	@override String get twitterSubtitle => 'Cập nhật nhanh';
	@override String get reddit => 'Reddit';
	@override String get redditSubtitle => 'Cộng đồng';
	@override String get discord => 'Discord';
	@override String get discordSubtitle => 'Trò chuyện trực tiếp';
	@override String get contact => 'Hỗ trợ';
	@override String get email => 'Gửi email hỗ trợ';
	@override String get website => 'Trang chủ';
}

// Path: settings.language
class _AppStringsSettingsLanguageVi extends AppStringsSettingsLanguageEn {
	_AppStringsSettingsLanguageVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ngôn ngữ';
	@override String get available => 'NGÔN NGỮ KHẢ DỤNG';
	@override String get apply => 'Áp dụng';
}

// Path: settings.currency
class _AppStringsSettingsCurrencyVi extends AppStringsSettingsCurrencyEn {
	_AppStringsSettingsCurrencyVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tiền tệ';
	@override String get available => 'TIỀN TỆ KHẢ DỤNG';
	@override String get apply => 'Áp dụng';
}

// Path: settings.messages
class _AppStringsSettingsMessagesVi extends AppStringsSettingsMessagesEn {
	_AppStringsSettingsMessagesVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get profileComingSoon => 'Sắp ra mắt';
	@override String get privacyError => 'Không thể mở';
	@override String get logoutComingSoon => 'Đăng xuất sắp ra mắt';
}

// Path: onboarding.welcome
class _AppStringsOnboardingWelcomeVi extends AppStringsOnboardingWelcomeEn {
	_AppStringsOnboardingWelcomeVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Chào mừng đến MoneyT 👋';
	@override String get subtitle => 'Làm chủ tài chính chỉ trong vài phút ✨';
}

// Path: onboarding.problemStatement
class _AppStringsOnboardingProblemStatementVi extends AppStringsOnboardingProblemStatementEn {
	_AppStringsOnboardingProblemStatementVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Cảm thấy tiền trôi qua kẽ tay?';
	@override String get subtitle => 'Bạn không cô đơn. 70% người không biết tiền của họ đi đâu.';
}

// Path: onboarding.specificProblem
class _AppStringsOnboardingSpecificProblemVi extends AppStringsOnboardingSpecificProblemEn {
	_AppStringsOnboardingSpecificProblemVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Điều gì làm bạn đau đầu nhất?';
	@override late final _AppStringsOnboardingSpecificProblemOptionsVi options = _AppStringsOnboardingSpecificProblemOptionsVi._(_root);
}

// Path: onboarding.personalGoal
class _AppStringsOnboardingPersonalGoalVi extends AppStringsOnboardingPersonalGoalEn {
	_AppStringsOnboardingPersonalGoalVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Mục tiêu số 1 của bạn là gì?';
	@override late final _AppStringsOnboardingPersonalGoalOptionsVi options = _AppStringsOnboardingPersonalGoalOptionsVi._(_root);
}

// Path: onboarding.solutionPreview
class _AppStringsOnboardingSolutionPreviewVi extends AppStringsOnboardingSolutionPreviewEn {
	_AppStringsOnboardingSolutionPreviewVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'MoneyT mang lại sự rõ ràng';
	@override String get subtitle => 'Xem tất cả tài khoản, nợ và chi tiêu ở một nơi. Tạm biệt Excel rắc rối.';
	@override late final _AppStringsOnboardingSolutionPreviewBenefitsVi benefits = _AppStringsOnboardingSolutionPreviewBenefitsVi._(_root);
}

// Path: onboarding.currentMethod
class _AppStringsOnboardingCurrentMethodVi extends AppStringsOnboardingCurrentMethodEn {
	_AppStringsOnboardingCurrentMethodVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Bạn đang quản lý tiền thế nào?';
	@override String get subtitle => 'Chọn cách giống bạn nhất.';
	@override late final _AppStringsOnboardingCurrentMethodOptionsVi options = _AppStringsOnboardingCurrentMethodOptionsVi._(_root);
}

// Path: onboarding.featuresShowcase
class _AppStringsOnboardingFeaturesShowcaseVi extends AppStringsOnboardingFeaturesShowcaseEn {
	_AppStringsOnboardingFeaturesShowcaseVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Những gì đang có và sắp ra mắt ✨';
	@override String get subtitle => 'Dùng được ngay, và còn nhiều tính năng hay sắp đến.';
	@override String get available => 'SẴN SÀNG';
	@override String get comingSoon => 'SẮP RA MẮT';
	@override late final _AppStringsOnboardingFeaturesShowcaseFeaturesVi features = _AppStringsOnboardingFeaturesShowcaseFeaturesVi._(_root);
}

// Path: onboarding.complete
class _AppStringsOnboardingCompleteVi extends AppStringsOnboardingCompleteEn {
	_AppStringsOnboardingCompleteVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sẵn sàng cất cánh! 🚀';
	@override String get subtitle => 'Nhập khoản chi tiêu đầu tiên và xem phép màu xảy ra 📈';
	@override late final _AppStringsOnboardingCompleteStatsVi stats = _AppStringsOnboardingCompleteStatsVi._(_root);
}

// Path: onboarding.buttons
class _AppStringsOnboardingButtonsVi extends AppStringsOnboardingButtonsEn {
	_AppStringsOnboardingButtonsVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get start => 'Bắt đầu nào! 🚀';
	@override String get fixIt => 'Sửa đổi ngay hôm nay ⚡';
	@override String get actionContinue => 'Tiếp tục';
	@override String get setGoal => 'Lên mục tiêu 🎯';
	@override String get wantControl => 'Mình muốn kiểm soát tiền!';
	@override String get great => 'Tuyệt quá, xem thử nào!';
	@override String get firstTransaction => 'Thêm giao dịch đầu tiên ➕';
	@override String get skip => 'Bỏ qua';
}

// Path: dashboard.balance
class _AppStringsDashboardBalanceVi extends AppStringsDashboardBalanceEn {
	_AppStringsDashboardBalanceVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get total => 'TỔNG SỐ DƯ';
	@override String get income => 'TỔNG THU';
	@override String get expenses => 'TỔNG CHI';
	@override String get thisMonth => 'tháng này';
}

// Path: dashboard.actions
class _AppStringsDashboardActionsVi extends AppStringsDashboardActionsEn {
	_AppStringsDashboardActionsVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get income => 'Thu';
	@override String get expense => 'Chi';
	@override String get transfer => 'Chuyển';
	@override String get all => 'Tất cả';
}

// Path: dashboard.wallets
class _AppStringsDashboardWalletsVi extends AppStringsDashboardWalletsEn {
	_AppStringsDashboardWalletsVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ví của bạn';
	@override String count({required Object n}) => '${n} tài khoản';
	@override String more({required Object n}) => '+${n} tài khoản khác';
	@override String viewDetails({required Object name}) => 'Xem chi tiết ${name}';
}

// Path: dashboard.transactions
class _AppStringsDashboardTransactionsVi extends AppStringsDashboardTransactionsEn {
	_AppStringsDashboardTransactionsVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Giao dịch gần đây';
	@override String get subtitle => '5 giao dịch mới nhất';
	@override String get empty => 'Trống trơn';
	@override String get emptySubtitle => 'Chưa có giao dịch nào';
	@override String more({required Object n}) => 'Xem thêm ${n} giao dịch';
}

// Path: dashboard.widgets
class _AppStringsDashboardWidgetsVi extends AppStringsDashboardWidgetsEn {
	_AppStringsDashboardWidgetsVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override late final _AppStringsDashboardWidgetsBalanceVi balance = _AppStringsDashboardWidgetsBalanceVi._(_root);
	@override late final _AppStringsDashboardWidgetsQuickActionsVi quickActions = _AppStringsDashboardWidgetsQuickActionsVi._(_root);
	@override late final _AppStringsDashboardWidgetsWalletsVi wallets = _AppStringsDashboardWidgetsWalletsVi._(_root);
	@override late final _AppStringsDashboardWidgetsLoansVi loans = _AppStringsDashboardWidgetsLoansVi._(_root);
	@override late final _AppStringsDashboardWidgetsTransactionsVi transactions = _AppStringsDashboardWidgetsTransactionsVi._(_root);
	@override late final _AppStringsDashboardWidgetsCategoryBreakdownVi categoryBreakdown = _AppStringsDashboardWidgetsCategoryBreakdownVi._(_root);
	@override late final _AppStringsDashboardWidgetsChartAccountsVi chartAccounts = _AppStringsDashboardWidgetsChartAccountsVi._(_root);
	@override late final _AppStringsDashboardWidgetsCreditCardsVi creditCards = _AppStringsDashboardWidgetsCreditCardsVi._(_root);
	@override late final _AppStringsDashboardWidgetsSettingsVi settings = _AppStringsDashboardWidgetsSettingsVi._(_root);
}

// Path: wallets.empty
class _AppStringsWalletsEmptyVi extends AppStringsWalletsEmptyEn {
	_AppStringsWalletsEmptyVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Chưa có ví nào';
	@override String get message => 'Tạo ví đầu tiên để bắt đầu theo dõi dòng tiền.';
	@override String get action => 'Tạo ví mới';
}

// Path: wallets.emptyArchived
class _AppStringsWalletsEmptyArchivedVi extends AppStringsWalletsEmptyArchivedEn {
	_AppStringsWalletsEmptyArchivedVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Không có ví lưu trữ';
	@override String get message => 'Những ví đã đóng sẽ hiện ở đây.';
}

// Path: wallets.filter
class _AppStringsWalletsFilterVi extends AppStringsWalletsFilterEn {
	_AppStringsWalletsFilterVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get active => 'Đang dùng';
	@override String get archived => 'Lưu trữ';
	@override String get all => 'Tất cả';
}

// Path: wallets.form
class _AppStringsWalletsFormVi extends AppStringsWalletsFormEn {
	_AppStringsWalletsFormVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get newTitle => 'Thêm ví mới';
	@override String get editTitle => 'Sửa ví';
	@override String get name => 'Tên ví';
	@override String get namePlaceholder => 'Ví dụ: Tiền mặt, Ngân hàng VCB';
	@override String get nameRequired => 'Bắt buộc nhập tên ví';
	@override String get description => 'Ghi chú';
	@override String get descriptionPlaceholder => 'Mô tả ngắn gọn (không bắt buộc)';
	@override String get currency => 'Tiền tệ';
	@override String get currencyLockedByParent => 'Cùng loại tiền với ví cha';
	@override String get parent => 'Ví cha (nếu là ví con)';
	@override String get parentEmpty => 'Không có ví cha';
	@override String get chartAccount => 'Loại tài khoản';
	@override String get chartAccountLocked => 'Không thể thay đổi';
	@override String get createSuccess => 'Tạo thành công';
	@override String get updateSuccess => 'Cập nhật thành công';
	@override String loadParentError({required Object error}) => 'Lỗi: ${error}';
	@override String loadChartAccountError({required Object error}) => 'Lỗi: ${error}';
}

// Path: wallets.delete
class _AppStringsWalletsDeleteVi extends AppStringsWalletsDeleteEn {
	_AppStringsWalletsDeleteVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get dialogTitle => 'Xóa ví';
	@override String dialogMessage({required Object name}) => 'Xóa ví ${name} vĩnh viễn?';
	@override String get cancel => 'Hủy';
	@override String get confirm => 'Xóa';
	@override String get success => 'Đã xóa ví';
	@override String error({required Object error}) => 'Lỗi: ${error}';
}

// Path: wallets.errors
class _AppStringsWalletsErrorsVi extends AppStringsWalletsErrorsEn {
	_AppStringsWalletsErrorsVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get load => 'Không tải được danh sách';
	@override String get retry => 'Thử lại';
	@override String comingSoon({required Object name}) => 'Tính năng ${name} sắp có';
}

// Path: wallets.subtitle
class _AppStringsWalletsSubtitleVi extends AppStringsWalletsSubtitleEn {
	_AppStringsWalletsSubtitleVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get mainAccount => 'Tài khoản chính';
	@override String get cashDigital => 'Tiền mặt & Điện tử';
	@override String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('vi'))(n,
		one: '${n} ví',
		other: '${n} ví',
	);
	@override String get account => 'Tài khoản';
	@override String get physicalCash => 'Tiền mặt';
	@override String get digitalWallet => 'Ví điện tử';
}

// Path: wallets.options
class _AppStringsWalletsOptionsVi extends AppStringsWalletsOptionsEn {
	_AppStringsWalletsOptionsVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get viewTransactions => 'Xem lịch sử';
	@override String get viewTransactionsSubtitle => 'Tất cả giao dịch của ví này';
	@override String get transferFunds => 'Chuyển khoản';
	@override String get transferFundsSubtitle => 'Chuyển tiền sang ví khác';
	@override String get editWallet => 'Sửa thông tin';
	@override String get editWalletSubtitle => 'Thay tên, màu sắc';
	@override String get duplicateWallet => 'Nhân bản';
	@override String get duplicateWalletSubtitle => 'Tạo bản sao ví này';
	@override String get archiveWallet => 'Lưu trữ';
	@override String get archiveWalletSubtitle => 'Ẩn ví khỏi trang chính';
	@override String get unarchiveWallet => 'Bỏ lưu trữ';
	@override String get unarchiveWalletSubtitle => 'Hiện lại trên trang chính';
	@override String get deleteWallet => 'Xóa ví';
	@override String get deleteWalletSubtitle => 'Xóa hoàn toàn (cẩn thận nha)';
	@override String get defaultTitle => 'Ví';
}

// Path: loans.filter
class _AppStringsLoansFilterVi extends AppStringsLoansFilterEn {
	_AppStringsLoansFilterVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get active => 'Đang mở';
	@override String get history => 'Lịch sử';
	@override String get all => 'Tất cả';
	@override String get pending => 'Chưa xong';
	@override String get lent => 'Cho vay';
	@override String get borrowed => 'Đi vay';
}

// Path: loans.summary
class _AppStringsLoansSummaryVi extends AppStringsLoansSummaryEn {
	_AppStringsLoansSummaryVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get netBalance => 'TỔNG KẾT';
	@override String get activeLoans => 'ĐANG MỞ';
	@override String get noActive => 'Không có nợ nần';
	@override String lent({required Object n}) => 'Cho vay ${n}';
	@override String borrowed({required Object n}) => 'Đi vay ${n}';
	@override String pending({required Object n}) => 'Đang nợ ${n}';
}

// Path: loans.card
class _AppStringsLoansCardVi extends AppStringsLoansCardEn {
	_AppStringsLoansCardVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get lent => 'Bạn cho vay';
	@override String get borrowed => 'Bạn đi vay';
	@override String active({required Object n}) => '${n} khoản';
	@override String multiple({required Object n}) => '${n} khoản vay';
	@override String transactions({required Object n}) => '${n} lần';
	@override String overdue({required Object n}) => 'Quá hạn ${n} ngày';
	@override String due({required Object date}) => 'Hạn trả: ${date}';
}

// Path: loans.form
class _AppStringsLoansFormVi extends AppStringsLoansFormEn {
	_AppStringsLoansFormVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get newTitle => 'Khoản vay mới';
	@override String get editTitle => 'Sửa khoản vay';
	@override String get type => 'Bạn là';
	@override String get lend => 'Người cho vay';
	@override String get borrow => 'Người đi vay';
	@override String get contact => 'Giao dịch với';
	@override String get contactPlaceholder => 'Chọn ai đó';
	@override String get account => 'Từ tài khoản';
	@override String get accountPlaceholder => 'Chọn ví xuất tiền';
	@override String get amount => 'Số tiền';
	@override String get description => 'Ghi chú';
	@override String get date => 'Ngày mượn';
	@override String get dueDate => 'Ngày hẹn trả';
	@override String get selectDate => 'Chọn ngày';
	@override String get optional => '(Không bắt buộc)';
	@override String get createTransaction => 'Lưu vào ví luôn';
	@override String get recordAutomatically => 'Tự động ghi chép';
	@override String get transactionCategory => 'Danh mục tương ứng';
	@override String get category => 'Danh mục';
	@override String get categoryPlaceholder => 'Chọn danh mục';
	@override String get save => 'Lưu khoản vay';
	@override String get successCreate => 'Ghi nhận thành công!';
	@override String get successUpdate => 'Đã cập nhật';
	@override String get contactRequired => 'Bắt buộc chọn liên hệ';
	@override String get accountRequired => 'Bắt buộc chọn tài khoản';
	@override String get amountRequired => 'Bắt buộc nhập tiền';
}

// Path: loans.detail
class _AppStringsLoansDetailVi extends AppStringsLoansDetailEn {
	_AppStringsLoansDetailVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Chi tiết';
	@override String get deleteTitle => 'Xóa khoản vay';
	@override String get deleteMessage => 'Chắc chắn muốn xóa ghi chép này?';
	@override String get deleteSuccess => 'Đã xóa';
	@override String deleteError({required Object error}) => 'Lỗi: ${error}';
	@override String get notFound => 'Không tìm thấy';
	@override String get progress => 'Tiến độ';
	@override String get info => 'Thông tin';
	@override String get pay => 'Thanh toán khoản này';
	@override String get viewHistory => 'Toàn bộ lịch sử';
	@override String original({required Object amount}) => 'Ban đầu: ${amount}';
	@override String get section => 'Chi tiết';
	@override String get activeSummary => 'Tóm tắt';
	@override String get activeLent => 'Đang cho vay';
	@override String get activeBorrowed => 'Đang nợ người ta';
	@override String get activeNet => 'Số dư thực';
	@override String get activeTotal => 'Tổng cộng';
	@override String get startDate => 'Ngày bắt đầu';
	@override String get dueDate => 'Hạn chót';
	@override late final _AppStringsLoansDetailTypeVi type = _AppStringsLoansDetailTypeVi._(_root);
	@override late final _AppStringsLoansDetailPaymentVi payment = _AppStringsLoansDetailPaymentVi._(_root);
}

// Path: loans.history
class _AppStringsLoansHistoryVi extends AppStringsLoansHistoryEn {
	_AppStringsLoansHistoryVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Lịch sử sổ nợ';
	@override String get section => 'Toàn bộ';
	@override String get totalLoaned => 'Tổng số';
	@override String get noLoans => 'Trống trơn.';
	@override late final _AppStringsLoansHistoryFilterVi filter = _AppStringsLoansHistoryFilterVi._(_root);
	@override late final _AppStringsLoansHistoryHeadersVi headers = _AppStringsLoansHistoryHeadersVi._(_root);
	@override late final _AppStringsLoansHistoryItemVi item = _AppStringsLoansHistoryItemVi._(_root);
	@override late final _AppStringsLoansHistorySummaryVi summary = _AppStringsLoansHistorySummaryVi._(_root);
}

// Path: loans.contactDetail
class _AppStringsLoansContactDetailVi extends AppStringsLoansContactDetailEn {
	_AppStringsLoansContactDetailVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String titleWith({required Object name}) => 'Sổ nợ với ${name}';
}

// Path: loans.share
class _AppStringsLoansShareVi extends AppStringsLoansShareEn {
	_AppStringsLoansShareVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Gửi cho đối tác';
	@override String get contactTitle => 'Gửi tóm tắt';
	@override String get button => 'Gửi đi';
	@override String get copy => 'Chép';
	@override String get message => 'Này, check lại khoản nợ nha:';
	@override String contactMessage({required Object name}) => 'Tóm tắt với ${name}:';
	@override String error({required Object error}) => 'Lỗi: ${error}';
	@override String get contactCopied => 'Đã chép!';
	@override String activeLoans({required Object n}) => 'Đang mở (${n}):';
	@override String loanItem({required Object description, required Object amount, required Object date, required Object percent}) => '• ${description}: ${amount} (Ngày: ${date}) - ${percent}% xong';
	@override String get loanStatement => 'MoneyT - Sao kê';
	@override String get loanSummary => 'MoneyT - Tóm tắt';
	@override String get personalLoan => 'Vay cá nhân';
	@override String remaining({required Object amount}) => 'Còn lại: ${amount}';
	@override String get remainingLabel => 'Còn lại';
	@override String original({required Object amount}) => 'trong số ${amount}';
	@override String progress({required Object percent}) => 'Đã trả ${percent}%';
	@override String get progressLabel => 'Tiến độ';
	@override String get paidSuffix => 'Hoàn tất';
	@override String date({required Object date}) => 'Ngày lập: ${date}';
	@override String get dateLabel => 'Ngày lập';
	@override String contact({required Object name}) => 'Với: ${name}';
	@override String get contactLabel => 'Với';
	@override String generated({required Object date}) => 'Tạo lúc ${date}';
	@override String generatedLabel({required Object date}) => 'Tạo lúc ${date}';
	@override String totalActive({required Object n}) => 'Tổng cộng: ${n} khoản';
	@override String get active => 'đang có';
	@override String get poweredBy => 'Tạo bằng MoneyT • moneyt.io';
	@override String get copied => 'Đã chép!';
	@override String netBalance({required Object amount, required Object status}) => 'Chênh lệch: ${amount} (${status})';
	@override String get netBalanceLabel => 'Chênh lệch';
	@override String get owed => 'Bạn được nhận';
	@override String get owe => 'Bạn phải trả';
	@override String lent({required Object amount}) => 'Đã cho mượn: ${amount}';
	@override String get lentLabel => 'Bạn cho mượn';
	@override String borrowed({required Object amount}) => 'Đã mượn: ${amount}';
	@override String get borrowedLabel => 'Bạn đi mượn';
	@override String contactSummary({required Object name}) => 'Tóm tắt - ${name}';
}

// Path: loans.payment
class _AppStringsLoansPaymentVi extends AppStringsLoansPaymentEn {
	_AppStringsLoansPaymentVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ghi nhận thanh toán';
	@override String get amount => 'Số tiền trả';
	@override String get amountPlaceholder => '0';
	@override String get amountRequired => 'Ghi số tiền vào';
	@override String get invalidAmount => 'Số không đúng';
	@override String get exceedsBalance => 'Đừng trả lố số nợ';
	@override String get date => 'Ngày trả';
	@override String get account => 'Ví nhận tiền';
	@override String get selectAccount => 'Chọn ví';
	@override String get details => 'Ghi chú thêm';
	@override String get detailsPlaceholder => 'Có muốn ghi chú gì không?';
	@override String get success => 'Ghi nhận xong!';
	@override String error({required Object error}) => 'Lỗi: ${error}';
	@override String get errorAmount => 'Nhập số tiền hợp lệ';
	@override String get errorAccount => 'Chọn ví';
	@override String errorLoading({required Object error}) => 'Lỗi: ${error}';
	@override late final _AppStringsLoansPaymentSummaryVi summary = _AppStringsLoansPaymentSummaryVi._(_root);
	@override late final _AppStringsLoansPaymentQuickVi quick = _AppStringsLoansPaymentQuickVi._(_root);
}

// Path: loans.item
class _AppStringsLoansItemVi extends AppStringsLoansItemEn {
	_AppStringsLoansItemVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String due({required Object date}) => 'Hạn: ${date}';
	@override String paidAmount({required Object amount}) => 'Xong: ${amount}';
	@override String remaining({required Object amount}) => 'Còn: ${amount}';
	@override String percentPaid({required Object percent}) => '${percent}%';
}

// Path: loans.section
class _AppStringsLoansSectionVi extends AppStringsLoansSectionEn {
	_AppStringsLoansSectionVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get activeLoans => 'Đang vay/cho vay';
	@override String loansCount({required Object n}) => '${n} khoản';
}

// Path: loans.empty
class _AppStringsLoansEmptyVi extends AppStringsLoansEmptyEn {
	_AppStringsLoansEmptyVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Chưa có gì cả';
	@override String get message => 'Không nợ nần ai là tốt rồi.';
	@override String get action => 'Tạo mới';
}

// Path: categories.form
class _AppStringsCategoriesFormVi extends AppStringsCategoriesFormEn {
	_AppStringsCategoriesFormVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get newTitle => 'Danh mục mới';
	@override String get editTitle => 'Sửa danh mục';
	@override String get name => 'Tên danh mục';
	@override String get namePlaceholder => 'Ví dụ: Ăn uống, Tiền nhà';
	@override String get nameRequired => 'Phải có tên nha';
	@override String get parent => 'Danh mục cha (nếu có)';
	@override String get noParent => 'Nằm ngoài cùng';
	@override String get asSubcategory => 'Sẽ làm danh mục con';
	@override String get asRoot => 'Sẽ làm danh mục gốc';
	@override String get active => 'Sử dụng được';
	@override String get activeDescription => 'Bật để chọn được khi nhập giao dịch';
	@override String get selectIcon => 'Chọn Icon';
	@override String get selectColor => 'Chọn Màu';
	@override String get saveSuccess => 'Xong xuôi!';
	@override String saveError({required Object error}) => 'Lỗi rồi: ${error}';
}

// Path: categories.parentSelection
class _AppStringsCategoriesParentSelectionVi extends AppStringsCategoriesParentSelectionEn {
	_AppStringsCategoriesParentSelectionVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Chọn danh mục cha';
	@override String get subtitle => 'Nằm trong cái nào?';
	@override String get noParent => 'Không nằm trong đâu';
}

// Path: categories.report
class _AppStringsCategoriesReportVi extends AppStringsCategoriesReportEn {
	_AppStringsCategoriesReportVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Phân tích nâng cao';
	@override String get timeFilter => 'Thời gian';
	@override String get thisMonth => 'Tháng này';
	@override String get lastMonth => 'Tháng trước';
	@override String get thisYear => 'Năm nay';
	@override String get allTime => 'Tất cả';
	@override String get details => 'Chi tiết';
	@override String get noTransactions => 'Chưa có giao dịch';
	@override String get income => 'Thu nhập';
	@override String get expense => 'Chi tiêu';
}

// Path: backups.menu
class _AppStringsBackupsMenuVi extends AppStringsBackupsMenuEn {
	_AppStringsBackupsMenuVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get settings => 'Cài đặt sao lưu';
	@override String get comingSoon => 'Sắp ra mắt';
}

// Path: backups.filters
class _AppStringsBackupsFiltersVi extends AppStringsBackupsFiltersEn {
	_AppStringsBackupsFiltersVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get all => 'Tất cả';
	@override String get auto => 'Tự động';
	@override String get manual => 'Tự làm';
	@override String get thisMonth => 'Tháng này';
	@override String get lastMonth => 'Tháng trước';
	@override String get thisYear => 'Năm nay';
	@override String get lastYear => 'Năm trước';
}

// Path: backups.status
class _AppStringsBackupsStatusVi extends AppStringsBackupsStatusEn {
	_AppStringsBackupsStatusVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get loading => 'Đang tải...';
	@override String get error => 'Lỗi tải file sao lưu';
	@override String get empty => 'Chưa sao lưu gì';
	@override String get emptyAction => 'Ấn nút + để lưu dữ liệu của bạn';
	@override String get success => 'Xong!';
	@override String get created => 'Đã sao lưu thành công';
	@override String createError({required Object error}) => 'Lỗi: ${error}';
	@override String restoreError({required Object error}) => 'Lỗi: ${error}';
	@override String deleteError({required Object error}) => 'Lỗi: ${error}';
}

// Path: backups.actions
class _AppStringsBackupsActionsVi extends AppStringsBackupsActionsEn {
	_AppStringsBackupsActionsVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get create => 'Tạo bản sao lưu';
	@override String get import => 'Khôi phục từ file';
	@override String get restore => 'Phục hồi';
	@override String get delete => 'Xóa';
	@override String get share => 'Chia sẻ';
	@override String get cancel => 'Hủy';
	@override String get retry => 'Thử lại';
	@override String get ok => 'OK';
}

// Path: backups.dialogs
class _AppStringsBackupsDialogsVi extends AppStringsBackupsDialogsEn {
	_AppStringsBackupsDialogsVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override late final _AppStringsBackupsDialogsInfoVi info = _AppStringsBackupsDialogsInfoVi._(_root);
	@override late final _AppStringsBackupsDialogsRestoreVi restore = _AppStringsBackupsDialogsRestoreVi._(_root);
	@override late final _AppStringsBackupsDialogsDeleteVi delete = _AppStringsBackupsDialogsDeleteVi._(_root);
}

// Path: backups.stats
class _AppStringsBackupsStatsVi extends AppStringsBackupsStatsEn {
	_AppStringsBackupsStatsVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Thống kê';
	@override String get totalBackups => 'Tổng số';
	@override String get totalSize => 'Dung lượng';
	@override String get oldest => 'Cũ nhất';
	@override String get latest => 'Mới nhất';
	@override String get autoBackupStatus => 'Tự động sao lưu';
	@override String get active => 'Đang bật';
	@override String get inactive => 'Tắt';
}

// Path: backups.options
class _AppStringsBackupsOptionsVi extends AppStringsBackupsOptionsEn {
	_AppStringsBackupsOptionsVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override late final _AppStringsBackupsOptionsRestoreVi restore = _AppStringsBackupsOptionsRestoreVi._(_root);
	@override late final _AppStringsBackupsOptionsShareVi share = _AppStringsBackupsOptionsShareVi._(_root);
	@override late final _AppStringsBackupsOptionsDeleteVi delete = _AppStringsBackupsOptionsDeleteVi._(_root);
	@override String get latestBadge => 'Mới nhất';
	@override String get latestFile => 'Gần đây nhất';
	@override String get backupFile => 'File backup';
}

// Path: backups.format
class _AppStringsBackupsFormatVi extends AppStringsBackupsFormatEn {
	_AppStringsBackupsFormatVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String auto({required Object date}) => 'Tự động - ${date}';
	@override String manual({required Object date}) => 'Thủ công - ${date}';
	@override String get initial => 'Lần đầu tiên';
	@override String generic({required Object date}) => 'Bản sao - ${date}';
}

// Path: v2.voice
class _AppStringsV2VoiceVi extends AppStringsV2VoiceEn {
	_AppStringsV2VoiceVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get errorProcessing => 'Lỗi rồi, không nghe rõ. Bạn nói lại nhé.';
	@override String get tapMicrophone => 'Chạm vào mic để nói chuyện';
	@override String get listening => 'Đang nghe...';
	@override String get missingApiKey => 'Bổ sung GEMINI_API_KEY vào .env để xài AI nha.';
	@override String aiError({required Object error}) => 'Lỗi AI: ${error}';
	@override String get cancel => 'Thôi';
	@override String get scan => 'Quét';
}

// Path: v2.transactions
class _AppStringsV2TransactionsVi extends AppStringsV2TransactionsEn {
	_AppStringsV2TransactionsVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get invalidAmount => 'Ghi lộn số tiền rồi.';
	@override String get selectAccount => 'Chi từ ví nào vậy?';
	@override String get selectCategory => 'Mục nào đây?';
	@override String errorCreatingCategory({required Object error}) => 'Tạo danh mục bị lỗi: ${error}';
	@override String error({required Object error}) => 'Lỗi nè: ${error}';
	@override String get more => 'Khác';
	@override String get expense => 'Chi tiêu';
	@override String get income => 'Thu nhập';
	@override String get deleteTransaction => 'Bỏ giao dịch này nha?';
	@override String get cancel => 'Hủy';
	@override String get delete => 'Bỏ';
	@override String get yesterday => 'Hôm qua';
	@override String get usedCategories => 'HAY DÙNG';
	@override String get noTransactions => 'Hôm nay chưa tiêu gì';
	@override String get recentActivity => 'Vừa tiêu xong';
	@override String get searchTransaction => 'Tìm xem đã tiêu gì...';
	@override String get date => 'Hôm nào';
	@override String get wallet => 'Bằng gì';
	@override String get transactionDeleted => 'Đã xóa.';
	@override String get selectCategoryTitle => 'Cho vào đâu?';
	@override String get searchCategory => 'Tìm danh mục...';
	@override String get noCategoriesAvailable => 'Trống rỗng';
	@override String get createNewCategory => 'Tạo danh mục mới toanh';
	@override String get amount => 'SỐ TIỀN';
	@override String get description => 'TIÊU VÀO VIỆC';
	@override String get category => 'DANH MỤC';
	@override String get addNote => 'Thêm tí ghi chú...';
	@override String get today => 'Hôm nay';
	@override String get editTransaction => 'Chỉnh lại xíu';
	@override String get newTransaction => 'Thêm Mới';
	@override String get selectWallet => 'Từ ví nào';
	@override String get save => 'Lưu lại';
	@override String get transactionUpdated => 'Chỉnh sửa thành công.';
	@override String get transactionSaved => 'Ok, đã lưu.';
}

// Path: v2.settings
class _AppStringsV2SettingsVi extends AppStringsV2SettingsEn {
	_AppStringsV2SettingsVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Cài đặt & Tùy chỉnh';
	@override String get categories => 'Danh mục chi';
	@override String get wallets => 'Các loại Ví';
	@override String get language => 'Ngôn ngữ';
	@override String get currency => 'Loại tiền';
	@override String get contact => 'Phản hồi lỗi';
	@override String get legacyView => 'Trở về bản cũ';
	@override String get deleteCategory => 'Xóa sổ danh mục này?';
	@override String get deleteWallet => 'Xóa ví này đi?';
	@override String get cannotUndo => 'Xóa là bay luôn, không cứu được đâu.';
	@override String get deleteWalletWarning => 'Nhớ là xóa ví thì các giao dịch trong đó đi tông theo nha.';
	@override String deleteError({required Object error}) => 'Lỗi xóa: ${error}';
	@override String get noCategoriesCreated => 'Chưa có gì.\nTạo liền một cái đi.';
	@override String get noWalletsCreated => 'Chưa có ví nào.\nLàm sao xài app, tạo đi.';
	@override String get walletDeleted => 'Bay màu ví.';
	@override String get cancel => 'Từ từ đã';
	@override String get delete => 'Bay màu';
	@override String get expenses => 'Chi';
	@override String get income => 'Thu';
	@override String get newWallet => 'Ví mới';
	@override String get editWallet => 'Đổi thông tin';
	@override String get walletName => 'Tên ví';
	@override String get saveWallet => 'Lưu Ví';
}

// Path: v2.dashboard
class _AppStringsV2DashboardVi extends AppStringsV2DashboardEn {
	_AppStringsV2DashboardVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get greetingMorning => 'Chào buổi sáng!';
	@override String get totalBalance => 'TIỀN CÒN LẠI';
	@override late final _AppStringsV2DashboardDateFiltersVi dateFilters = _AppStringsV2DashboardDateFiltersVi._(_root);
	@override late final _AppStringsV2DashboardWalletFiltersVi walletFilters = _AppStringsV2DashboardWalletFiltersVi._(_root);
	@override late final _AppStringsV2DashboardBackgroundVi background = _AppStringsV2DashboardBackgroundVi._(_root);
	@override late final _AppStringsV2DashboardIncomeExpenseVi incomeExpense = _AppStringsV2DashboardIncomeExpenseVi._(_root);
	@override late final _AppStringsV2DashboardGaugeVi gauge = _AppStringsV2DashboardGaugeVi._(_root);
	@override late final _AppStringsV2DashboardActivityListVi activityList = _AppStringsV2DashboardActivityListVi._(_root);
}

// Path: v2.categories
class _AppStringsV2CategoriesVi extends AppStringsV2CategoriesEn {
	_AppStringsV2CategoriesVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Danh mục';
	@override String get searchPlaceholder => 'Tìm kiếm...';
	@override String get newCategory => 'Tạo mới';
	@override String get editCategory => 'Chỉnh sửa';
	@override String get noCategories => 'Chưa có gì';
	@override late final _AppStringsV2CategoriesFormVi form = _AppStringsV2CategoriesFormVi._(_root);
}

// Path: v2.onboarding
class _AppStringsV2OnboardingVi extends AppStringsV2OnboardingEn {
	_AppStringsV2OnboardingVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override late final _AppStringsV2OnboardingButtonsVi buttons = _AppStringsV2OnboardingButtonsVi._(_root);
	@override late final _AppStringsV2OnboardingSplashVi splash = _AppStringsV2OnboardingSplashVi._(_root);
	@override late final _AppStringsV2OnboardingExpenseCategoriesVi expenseCategories = _AppStringsV2OnboardingExpenseCategoriesVi._(_root);
	@override late final _AppStringsV2OnboardingFinancialGoalsVi financialGoals = _AppStringsV2OnboardingFinancialGoalsVi._(_root);
	@override late final _AppStringsV2OnboardingRegistrationMethodVi registrationMethod = _AppStringsV2OnboardingRegistrationMethodVi._(_root);
	@override late final _AppStringsV2OnboardingAiAnalysisVi aiAnalysis = _AppStringsV2OnboardingAiAnalysisVi._(_root);
	@override late final _AppStringsV2OnboardingMainPriorityVi mainPriority = _AppStringsV2OnboardingMainPriorityVi._(_root);
	@override late final _AppStringsV2OnboardingAiVoiceVi aiVoice = _AppStringsV2OnboardingAiVoiceVi._(_root);
}

// Path: transactions.filter.ranges
class _AppStringsTransactionsFilterRangesVi extends AppStringsTransactionsFilterRangesEn {
	_AppStringsTransactionsFilterRangesVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get thisMonth => 'Tháng này';
	@override String get lastMonth => 'Tháng trước';
	@override String get thisYear => 'Năm nay';
	@override String get lastYear => 'Năm ngoái';
}

// Path: transactions.filter.subtitles
class _AppStringsTransactionsFilterSubtitlesVi extends AppStringsTransactionsFilterSubtitlesEn {
	_AppStringsTransactionsFilterSubtitlesVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get income => 'Tiền nhận';
	@override String get expense => 'Tiền chi';
	@override String get transfer => 'Tiền chuyển';
}

// Path: transactions.share.receipt
class _AppStringsTransactionsShareReceiptVi extends AppStringsTransactionsShareReceiptEn {
	_AppStringsTransactionsShareReceiptVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => '--- Chi tiết ---';
	@override String amount({required Object amount}) => 'Số tiền: ${amount}';
	@override String description({required Object description}) => 'Ghi chú: ${description}';
	@override String category({required Object category}) => 'Danh mục: ${category}';
	@override String date({required Object date}) => 'Ngày: ${date}';
	@override String time({required Object time}) => 'Giờ: ${time}';
	@override String wallet({required Object wallet}) => 'Tài khoản: ${wallet}';
	@override String contact({required Object contact}) => 'Liên hệ: ${contact}';
	@override String id({required Object id}) => 'ID: ${id}';
	@override String get separator => '--------------------------';
}

// Path: onboarding.specificProblem.options
class _AppStringsOnboardingSpecificProblemOptionsVi extends AppStringsOnboardingSpecificProblemOptionsEn {
	_AppStringsOnboardingSpecificProblemOptionsVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get debts => 'Nợ nần và khoản vay';
	@override String get savings => 'Không thể để dành được đồng nào';
	@override String get unknown => 'Tiêu đi đâu không biết';
	@override String get chaos => 'Tài chính rối tinh rối mù';
}

// Path: onboarding.personalGoal.options
class _AppStringsOnboardingPersonalGoalOptionsVi extends AppStringsOnboardingPersonalGoalOptionsEn {
	_AppStringsOnboardingPersonalGoalOptionsVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get debtFree => 'Sạch nợ';
	@override String get saveTrip => 'Để dành mua xe/đi du lịch';
	@override String get invest => 'Bắt đầu đầu tư';
	@override String get peace => 'Ăn ngon ngủ yên';
}

// Path: onboarding.solutionPreview.benefits
class _AppStringsOnboardingSolutionPreviewBenefitsVi extends AppStringsOnboardingSolutionPreviewBenefitsEn {
	_AppStringsOnboardingSolutionPreviewBenefitsVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get visualize => 'Theo dõi chi tiêu theo thời gian thực';
	@override String get goals => 'Đặt mục tiêu và theo dõi';
	@override String get smart => 'Đưa ra quyết định thông minh';
}

// Path: onboarding.currentMethod.options
class _AppStringsOnboardingCurrentMethodOptionsVi extends AppStringsOnboardingCurrentMethodOptionsEn {
	_AppStringsOnboardingCurrentMethodOptionsVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get excel => 'Dùng bảng tính Excel';
	@override String get notebook => 'Sổ tay';
	@override String get mental => 'Nhẩm trong đầu';
	@override String get none => 'Chẳng quản lý gì cả';
}

// Path: onboarding.featuresShowcase.features
class _AppStringsOnboardingFeaturesShowcaseFeaturesVi extends AppStringsOnboardingFeaturesShowcaseFeaturesEn {
	_AppStringsOnboardingFeaturesShowcaseFeaturesVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get income => 'Thu nhập';
	@override String get expense => 'Chi tiêu';
	@override String get transfer => 'Chuyển khoản';
	@override String get loans => 'Khoản vay';
	@override String get goals => 'Mục tiêu';
	@override String get budgets => 'Ngân sách';
	@override String get investments => 'Đầu tư';
	@override String get cloud => 'Lưu trữ Đám mây';
	@override String get openBanking => 'Liên kết Ngân hàng';
}

// Path: onboarding.complete.stats
class _AppStringsOnboardingCompleteStatsVi extends AppStringsOnboardingCompleteStatsEn {
	_AppStringsOnboardingCompleteStatsVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tỷ lệ thành công';
	@override String get before => 'Trước đây';
	@override String get after => 'Dùng MoneyT';
}

// Path: dashboard.widgets.balance
class _AppStringsDashboardWidgetsBalanceVi extends AppStringsDashboardWidgetsBalanceEn {
	_AppStringsDashboardWidgetsBalanceVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tổng số dư';
	@override String get description => 'Tình hình tài chính chung';
}

// Path: dashboard.widgets.quickActions
class _AppStringsDashboardWidgetsQuickActionsVi extends AppStringsDashboardWidgetsQuickActionsEn {
	_AppStringsDashboardWidgetsQuickActionsVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Lối tắt';
	@override String get description => 'Ghi chép siêu nhanh';
}

// Path: dashboard.widgets.wallets
class _AppStringsDashboardWidgetsWalletsVi extends AppStringsDashboardWidgetsWalletsEn {
	_AppStringsDashboardWidgetsWalletsVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Danh sách Ví';
	@override String get description => 'Xem tất cả số dư';
}

// Path: dashboard.widgets.loans
class _AppStringsDashboardWidgetsLoansVi extends AppStringsDashboardWidgetsLoansEn {
	_AppStringsDashboardWidgetsLoansVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Khoản Vay';
	@override String get description => 'Quản lý nợ nần';
}

// Path: dashboard.widgets.transactions
class _AppStringsDashboardWidgetsTransactionsVi extends AppStringsDashboardWidgetsTransactionsEn {
	_AppStringsDashboardWidgetsTransactionsVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Giao dịch gần đây';
	@override String get description => 'Biến động mới nhất';
}

// Path: dashboard.widgets.categoryBreakdown
class _AppStringsDashboardWidgetsCategoryBreakdownVi extends AppStringsDashboardWidgetsCategoryBreakdownEn {
	_AppStringsDashboardWidgetsCategoryBreakdownVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Phân tích theo danh mục';
	@override String get description => 'Chi tiêu tháng hiện tại';
	@override String get empty_message => 'Không có gì để phân tích.';
	@override String get others => 'Khác';
	@override String get back => 'Trở lại';
	@override String get monthlyBudget => 'Ngân sách tháng';
	@override String leftover({required Object amount}) => 'Bạn còn dư ${amount} từ thu nhập.';
	@override String exceeded({required Object amount}) => 'Bạn chi lố ${amount} so với thu nhập.';
	@override String noIncome({required Object amount}) => 'Đã chi: ${amount} (Chưa có khoản thu)';
}

// Path: dashboard.widgets.chartAccounts
class _AppStringsDashboardWidgetsChartAccountsVi extends AppStringsDashboardWidgetsChartAccountsEn {
	_AppStringsDashboardWidgetsChartAccountsVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sơ đồ tài khoản';
	@override String get description => 'Cấu trúc tài chính';
}

// Path: dashboard.widgets.creditCards
class _AppStringsDashboardWidgetsCreditCardsVi extends AppStringsDashboardWidgetsCreditCardsEn {
	_AppStringsDashboardWidgetsCreditCardsVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Thẻ tín dụng';
	@override String get description => 'Số dư và hạn mức thẻ';
}

// Path: dashboard.widgets.settings
class _AppStringsDashboardWidgetsSettingsVi extends AppStringsDashboardWidgetsSettingsEn {
	_AppStringsDashboardWidgetsSettingsVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Chỉnh sửa trang chủ';
	@override String get subtitle => 'Kéo thả để sắp xếp các tiện ích (widgets).';
	@override late final _AppStringsDashboardWidgetsSettingsResetVi reset = _AppStringsDashboardWidgetsSettingsResetVi._(_root);
	@override String get saveSuccess => 'Lưu thành công!';
	@override String saveError({required Object error}) => 'Lỗi: ${error}';
	@override String get saving => 'Đang lưu...';
	@override String get save => 'Lưu thay đổi';
}

// Path: loans.detail.type
class _AppStringsLoansDetailTypeVi extends AppStringsLoansDetailTypeEn {
	_AppStringsLoansDetailTypeVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get label => 'Loại';
	@override String get personal => 'Vay cá nhân';
	@override String get borrowed => 'Vay nặng lãi';
	@override String get auto => 'Vay mua xe';
	@override String get mortgage => 'Vay mua nhà';
	@override String get student => 'Vay sinh viên';
}

// Path: loans.detail.payment
class _AppStringsLoansDetailPaymentVi extends AppStringsLoansDetailPaymentEn {
	_AppStringsLoansDetailPaymentVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get history => 'Lịch sử trả nợ';
	@override String date({required Object date}) => 'Trả ngày ${date}';
	@override String transactionId({required Object id}) => 'ID: ${id}';
	@override String paid({required Object amount}) => 'Đã trả ${amount}';
	@override String remaining({required Object amount}) => 'Còn ${amount}';
}

// Path: loans.history.filter
class _AppStringsLoansHistoryFilterVi extends AppStringsLoansHistoryFilterEn {
	_AppStringsLoansHistoryFilterVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get all => 'Tất cả';
	@override String get lent => 'Cho mượn';
	@override String get borrowed => 'Đi mượn';
	@override String get completed => 'Đã xong';
	@override String get title => 'Lọc sổ nợ';
	@override String get reset => 'Mặc định';
	@override String get apply => 'Áp dụng';
	@override String get dateRange => 'Thời gian';
	@override String get amountRange => 'Khoảng tiền';
	@override String get startDate => 'Từ ngày';
	@override String get endDate => 'Đến ngày';
	@override String get select => 'Chọn';
}

// Path: loans.history.headers
class _AppStringsLoansHistoryHeadersVi extends AppStringsLoansHistoryHeadersEn {
	_AppStringsLoansHistoryHeadersVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get lent => 'Đã cho mượn';
	@override String get borrowed => 'Đã đi mượn';
	@override String get completed => 'Đã trả xong';
	@override String get active => 'Đang mở';
	@override String get cancelled => 'Bị hủy';
	@override String get writtenOff => 'Mất trắng/Xóa nợ';
}

// Path: loans.history.item
class _AppStringsLoansHistoryItemVi extends AppStringsLoansHistoryItemEn {
	_AppStringsLoansHistoryItemVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get defaultTitle => 'Khoản vay';
	@override String date({required Object date}) => 'Ngày: ${date}';
	@override String get lent => 'Cho vay';
	@override String get borrowed => 'Đi vay';
	@override late final _AppStringsLoansHistoryItemStatusVi status = _AppStringsLoansHistoryItemStatusVi._(_root);
}

// Path: loans.history.summary
class _AppStringsLoansHistorySummaryVi extends AppStringsLoansHistorySummaryEn {
	_AppStringsLoansHistorySummaryVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Thống kê';
	@override String get viewDetails => 'Chi tiết';
	@override String get hideDetails => 'Ẩn đi';
	@override String get outstandingLent => 'Người ta còn nợ bạn';
	@override String get outstandingBorrowed => 'Bạn còn nợ người ta';
	@override String get netPosition => 'Thực Tế';
	@override String get totalLent => 'Tổng tiền từng cho mượn';
	@override String get totalBorrowed => 'Tổng tiền từng đi mượn';
	@override String get totalRepaidToYou => 'Tiền đã đòi được';
	@override String get totalYouRepaid => 'Tiền bạn đã trả';
	@override String get totalLoans => 'Tổng giao dịch vay mượn';
	@override String get completedLoans => 'Đã hoàn tất';
}

// Path: loans.payment.summary
class _AppStringsLoansPaymentSummaryVi extends AppStringsLoansPaymentSummaryEn {
	_AppStringsLoansPaymentSummaryVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tóm tắt thay đổi';
	@override String get defaultTitle => 'Khoản nợ';
	@override String get amount => 'Sẽ thanh toán';
	@override String get remaining => 'Số dư mới';
	@override String get progress => 'Tiến độ mới';
	@override String description({required Object loan, required Object contact}) => '${loan} với ${contact}';
	@override String get unknownContact => 'Ai đó';
	@override String total({required Object amount}) => 'Tổng: ${amount}';
	@override String paid({required Object amount}) => 'Đã trả: ${amount}';
	@override String remainingLabel({required Object amount}) => 'Còn lại: ${amount}';
}

// Path: loans.payment.quick
class _AppStringsLoansPaymentQuickVi extends AppStringsLoansPaymentQuickEn {
	_AppStringsLoansPaymentQuickVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String full({required Object amount}) => 'Trả hết (${amount})';
	@override String half({required Object amount}) => 'Trả một nửa (${amount})';
}

// Path: backups.dialogs.info
class _AppStringsBackupsDialogsInfoVi extends AppStringsBackupsDialogsInfoEn {
	_AppStringsBackupsDialogsInfoVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Thông tin file';
	@override String get file => 'Tên:';
	@override String get size => 'Kích cỡ:';
	@override String get created => 'Ngày:';
	@override String get transactions => 'Giao dịch:';
}

// Path: backups.dialogs.restore
class _AppStringsBackupsDialogsRestoreVi extends AppStringsBackupsDialogsRestoreEn {
	_AppStringsBackupsDialogsRestoreVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Phục hồi dữ liệu';
	@override String content({required Object file}) => 'Chắc chắn phục hồi dữ liệu từ "${file}" chứ? App sẽ xóa dữ liệu hiện tại để thay thế.';
	@override String get success => 'Đang phục hồi... App sẽ tự khởi động lại.';
}

// Path: backups.dialogs.delete
class _AppStringsBackupsDialogsDeleteVi extends AppStringsBackupsDialogsDeleteEn {
	_AppStringsBackupsDialogsDeleteVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Xóa file này';
	@override String content({required Object file}) => 'Sẽ xóa vĩnh viễn "${file}". Bạn chắc chứ?';
	@override String get success => 'Đã xóa bay.';
}

// Path: backups.options.restore
class _AppStringsBackupsOptionsRestoreVi extends AppStringsBackupsOptionsRestoreEn {
	_AppStringsBackupsOptionsRestoreVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Phục hồi';
	@override String get subtitle => 'Thay thế dữ liệu bằng bản này';
}

// Path: backups.options.share
class _AppStringsBackupsOptionsShareVi extends AppStringsBackupsOptionsShareEn {
	_AppStringsBackupsOptionsShareVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Chia sẻ';
	@override String get subtitle => 'Gửi file này cho máy khác';
}

// Path: backups.options.delete
class _AppStringsBackupsOptionsDeleteVi extends AppStringsBackupsOptionsDeleteEn {
	_AppStringsBackupsOptionsDeleteVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Xóa bỏ';
	@override String get subtitle => 'Hành động này không thể hoàn tác';
}

// Path: v2.dashboard.dateFilters
class _AppStringsV2DashboardDateFiltersVi extends AppStringsV2DashboardDateFiltersEn {
	_AppStringsV2DashboardDateFiltersVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get thisMonth => 'Tháng này';
	@override String get lastMonth => 'Tháng trước';
	@override String get customRange => 'Ngày khác...';
}

// Path: v2.dashboard.walletFilters
class _AppStringsV2DashboardWalletFiltersVi extends AppStringsV2DashboardWalletFiltersEn {
	_AppStringsV2DashboardWalletFiltersVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get all => 'Tất cả';
	@override String get allWallets => 'Gộp mọi ví';
}

// Path: v2.dashboard.background
class _AppStringsV2DashboardBackgroundVi extends AppStringsV2DashboardBackgroundEn {
	_AppStringsV2DashboardBackgroundVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Đổi hình nền';
	@override String get chooseFromGallery => 'Lấy ảnh máy';
	@override String get restoreDefault => 'Về mặc định';
}

// Path: v2.dashboard.incomeExpense
class _AppStringsV2DashboardIncomeExpenseVi extends AppStringsV2DashboardIncomeExpenseEn {
	_AppStringsV2DashboardIncomeExpenseVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get income => 'TỔNG THU';
	@override String get expenses => 'TỔNG CHI';
}

// Path: v2.dashboard.gauge
class _AppStringsV2DashboardGaugeVi extends AppStringsV2DashboardGaugeEn {
	_AppStringsV2DashboardGaugeVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get exceeded => 'VƯỢT NGÂN SÁCH';
	@override String get spent => 'ĐÃ CHI';
	@override String get available => 'ĐƯỢC CHI';
	@override String get overdrawn => 'CHÁY TÚI';
}

// Path: v2.dashboard.activityList
class _AppStringsV2DashboardActivityListVi extends AppStringsV2DashboardActivityListEn {
	_AppStringsV2DashboardActivityListVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get seeAll => 'Tất cả';
	@override String get newUi => 'Giao diện Mới';
	@override String get expensesByCategory => 'Bạn đã tiêu vào đâu';
	@override String get noRecentExpenses => 'Chưa tốn đồng nào';
	@override String percentOfTotal({required Object percent}) => '${percent}% của tổng chi';
	@override String topExpenses({required Object count}) => 'Top ${count} tốn kém nhất';
	@override String get others => 'Các khoản khác';
}

// Path: v2.categories.form
class _AppStringsV2CategoriesFormVi extends AppStringsV2CategoriesFormEn {
	_AppStringsV2CategoriesFormVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get nameLabel => 'Tên';
	@override String get save => 'Lưu';
}

// Path: v2.onboarding.buttons
class _AppStringsV2OnboardingButtonsVi extends AppStringsV2OnboardingButtonsEn {
	_AppStringsV2OnboardingButtonsVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get start => 'Bắt đầu luôn 🚀';
	@override String get actionContinue => 'Tiếp tục';
	@override String get great => 'Đỉnh!';
	@override String get setGoal => 'Đặt mục tiêu';
	@override String get skip => 'Bỏ qua';
}

// Path: v2.onboarding.splash
class _AppStringsV2OnboardingSplashVi extends AppStringsV2OnboardingSplashEn {
	_AppStringsV2OnboardingSplashVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title1 => 'Sẽ thế nào nếu\nTrí tuệ nhân tạo (AI) ';
	@override String get title2 => 'quản lý tiền của bạn\ngiỏi hơn chính bạn?';
	@override String get benefit1 => 'Nhàn hạ hơn.';
	@override String get benefit2 => 'Rõ ràng hơn.';
	@override String get benefit3 => 'Thông minh hơn.';
}

// Path: v2.onboarding.expenseCategories
class _AppStringsV2OnboardingExpenseCategoriesVi extends AppStringsV2OnboardingExpenseCategoriesEn {
	_AppStringsV2OnboardingExpenseCategoriesVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title1 => 'Món nào ngốn tiền của bạn nhiều nhất tháng?';
	@override String get subtitle => 'Chọn tối đa 3 cái';
	@override String get diningOut => 'Ăn nhà hàng';
	@override String get cravings => 'Trà sữa / Ăn vặt';
	@override String get subscriptions => 'Mua sắm / App';
	@override String get outings => 'Đi chơi / Nhậu';
	@override String get shopping => 'Chốt đơn lung tung';
	@override String get delivery => 'Ship đồ ăn';
}

// Path: v2.onboarding.financialGoals
class _AppStringsV2OnboardingFinancialGoalsVi extends AppStringsV2OnboardingFinancialGoalsEn {
	_AppStringsV2OnboardingFinancialGoalsVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Cái gì sẽ làm tài chính\ncủa bạn đổi đời ngay?';
	@override String get subtitle => 'Chọn một thôi nha';
	@override String get trackMoney => 'Chỉ cần biết tiền mình bay đi đâu';
	@override String get spendLess => 'Bớt mua đồ linh tinh lại';
	@override String get lessStress => 'Hết đau đầu vì tiền';
	@override String get saveMoney => 'Để ra được một khoản cho tương lai';
}

// Path: v2.onboarding.registrationMethod
class _AppStringsV2OnboardingRegistrationMethodVi extends AppStringsV2OnboardingRegistrationMethodEn {
	_AppStringsV2OnboardingRegistrationMethodVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Bạn định ghi chép tiêu xài\nkiểu gì cho lẹ?';
	@override String get subtitle => 'Cách nào dễ nhất';
	@override String get voice => 'Chỉ cần nói vào máy';
	@override String get auto => 'Tự quét báo cáo ngân hàng';
	@override String get write => 'Tự tay gõ từng khoản';
	@override String get easy => 'Miễn sao không lười là được';
}

// Path: v2.onboarding.aiAnalysis
class _AppStringsV2OnboardingAiAnalysisVi extends AppStringsV2OnboardingAiAnalysisEn {
	_AppStringsV2OnboardingAiAnalysisVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override late final _AppStringsV2OnboardingAiAnalysisLoadingVi loading = _AppStringsV2OnboardingAiAnalysisLoadingVi._(_root);
	@override late final _AppStringsV2OnboardingAiAnalysisShowcaseVi showcase = _AppStringsV2OnboardingAiAnalysisShowcaseVi._(_root);
}

// Path: v2.onboarding.mainPriority
class _AppStringsV2OnboardingMainPriorityVi extends AppStringsV2OnboardingMainPriorityEn {
	_AppStringsV2OnboardingMainPriorityVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Mục tiêu hàng đầu\ncủa bạn là gì?';
	@override String get subtitle => 'Chọn một thứ MoneyT cần giúp bạn nhất';
	@override String get breakHabits => 'Dẹp bỏ thói quen xài hoang';
	@override String get stopStress => 'Cuối tháng không bị stress';
	@override String get buildFuture => 'Làm giàu từ từ';
	@override String get feelControl => 'Nắm chắc dòng tiền trong tay';
	@override String get saveGoal => 'Tiết kiệm cho một món đồ cụ thể';
}

// Path: v2.onboarding.aiVoice
class _AppStringsV2OnboardingAiVoiceVi extends AppStringsV2OnboardingAiVoiceEn {
	_AppStringsV2OnboardingAiVoiceVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override late final _AppStringsV2OnboardingAiVoiceTitleVi title = _AppStringsV2OnboardingAiVoiceTitleVi._(_root);
	@override String get subtitle => 'Đừng bấm bấm nhập liệu nữa, cứ bấm mic và kể cho nó nghe';
	@override String get listening => 'Nói đi, mình đang nghe...';
	@override List<String> get examples => [
		'Cà phê 35.000 ₫',
		'Grab 120.000 ₫',
		'Xem phim 150.000 ₫',
		'Siêu thị 450.000 ₫',
		'Đổ xăng 100.000 ₫',
		'Netflix 108.000 ₫',
		'Ăn tối 250.000 ₫',
		'Nhà thuốc 185.000 ₫',
	];
}

// Path: dashboard.widgets.settings.reset
class _AppStringsDashboardWidgetsSettingsResetVi extends AppStringsDashboardWidgetsSettingsResetEn {
	_AppStringsDashboardWidgetsSettingsResetVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get button => 'Khôi phục mặc định';
	@override String get dialogTitle => 'Khôi phục bố cục';
	@override String get dialogContent => 'Khôi phục lại giao diện trang chủ như lúc mới tải app?';
	@override String get cancel => 'Hủy';
	@override String get confirm => 'Khôi phục';
	@override String get success => 'Đã trở về mặc định';
}

// Path: loans.history.item.status
class _AppStringsLoansHistoryItemStatusVi extends AppStringsLoansHistoryItemStatusEn {
	_AppStringsLoansHistoryItemStatusVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get completed => 'Đã xong';
	@override String get active => 'Chưa xong';
	@override String get cancelled => 'Hủy';
	@override String get writtenOff => 'Xóa nợ';
}

// Path: v2.onboarding.aiAnalysis.loading
class _AppStringsV2OnboardingAiAnalysisLoadingVi extends AppStringsV2OnboardingAiAnalysisLoadingEn {
	_AppStringsV2OnboardingAiAnalysisLoadingVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'ĐANG TÙY BIẾN MONEYT\nRIÊNG CHO BẠN';
	@override String get subtitle => 'Đang phân tích';
	@override List<String> get messages => [
		'Đang soi thói quen chi tiêu...',
		'Chuẩn bị các danh mục...',
		'Tìm ra các lổ hổng xài hoang...',
		'Lập kế hoạch hoàn hảo...',
	];
}

// Path: v2.onboarding.aiAnalysis.showcase
class _AppStringsV2OnboardingAiAnalysisShowcaseVi extends AppStringsV2OnboardingAiAnalysisShowcaseEn {
	_AppStringsV2OnboardingAiAnalysisShowcaseVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Phân tích xong rồi!';
	@override late final _AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextVi dynamicText = _AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextVi._(_root);
	@override late final _AppStringsV2OnboardingAiAnalysisShowcaseResultVi result = _AppStringsV2OnboardingAiAnalysisShowcaseResultVi._(_root);
}

// Path: v2.onboarding.aiVoice.title
class _AppStringsV2OnboardingAiVoiceTitleVi extends AppStringsV2OnboardingAiVoiceTitleEn {
	_AppStringsV2OnboardingAiVoiceTitleVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get kDefault => 'Hoàn thành mục tiêu';
	@override String get breakHabits => 'Dẹp ngay thói quen xấu';
	@override String get stopStress => 'Hết đau đầu vì tiền';
	@override String get buildFuture => 'Xây dựng sự nghiệp rủng rỉnh';
	@override String get feelControl => 'Làm chủ dòng tiền';
	@override String get saveGoal => 'Để dành tiền mua cái mình thích';
	@override String get suffix => ' nay cực nhàn vì có Trợ lý AI lo hết.';
}

// Path: v2.onboarding.aiAnalysis.showcase.dynamicText
class _AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextVi extends AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextEn {
	_AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get kDefault => 'Tiền của bạn bay đi quá nhanh, có vẻ cách quản lý hiện tại không còn hiệu quả.';
	@override String get part2 => ' ngốn một đống tiền của bạn, và việc bạn muốn ';
	@override String get part3 => ' cho thấy đã đến lúc thay đổi cách làm.';
	@override late final _AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextCategoriesVi categories = _AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextCategoriesVi._(_root);
	@override late final _AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextIntentionsVi intentions = _AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextIntentionsVi._(_root);
}

// Path: v2.onboarding.aiAnalysis.showcase.result
class _AppStringsV2OnboardingAiAnalysisShowcaseResultVi extends AppStringsV2OnboardingAiAnalysisShowcaseResultEn {
	_AppStringsV2OnboardingAiAnalysisShowcaseResultVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get yourResult => 'Theo thống kê';
	@override String get average => 'Mức bình thường';
	@override String get messagePart1 => 'Bạn xài lố 68% ';
	@override String get messagePart2 => 'nhiều hơn so với người bình thường ở mảng này, ';
	@override String get messagePart3 => 'và nó đang phá nát\n';
	@override String get messagePart4 => 'các dự định mua sắm to bự của bạn';
}

// Path: v2.onboarding.aiAnalysis.showcase.dynamicText.categories
class _AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextCategoriesVi extends AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextCategoriesEn {
	_AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextCategoriesVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get diningOut => 'Đi ăn ngoài';
	@override String get cravings => 'Ăn vặt linh tinh';
	@override String get subscriptions => 'Đăng ký dịch vụ mạng';
	@override String get outings => 'Các buổi tiệc tùng';
	@override String get shopping => 'Nghiện chốt đơn';
	@override String get delivery => 'Tiền phí ship';
}

// Path: v2.onboarding.aiAnalysis.showcase.dynamicText.intentions
class _AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextIntentionsVi extends AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextIntentionsEn {
	_AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextIntentionsVi._(AppStringsVi root) : this._root = root, super.internal(root);

	final AppStringsVi _root; // ignore: unused_field

	// Translations
	@override String get trackMoney => 'biết tiền đi đâu';
	@override String get spendLess => 'giảm chi xài hoang';
	@override String get lessStress => 'hết lo lắng về tiền';
	@override String get saveMoney => 'ép bản thân tiết kiệm';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on AppStringsVi {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'app.name': return 'MoneyT';
			case 'app.description': return 'Quản Lý Tài Chính';
			case 'common.save': return 'Lưu';
			case 'common.cancel': return 'Hủy';
			case 'common.delete': return 'Xóa';
			case 'common.edit': return 'Sửa';
			case 'common.loading': return 'Đang tải...';
			case 'common.error': return 'Lỗi';
			case 'common.success': return 'Thành công';
			case 'common.search': return 'Tìm kiếm';
			case 'common.clearSearch': return 'Xóa tìm kiếm';
			case 'common.viewAll': return 'Xem tất cả';
			case 'common.retry': return 'Thử lại';
			case 'common.add': return 'Thêm';
			case 'common.remove': return 'Xóa bỏ';
			case 'common.moreOptions': return 'Thêm tùy chọn';
			case 'common.addToFavorites': return 'Thêm vào yêu thích';
			case 'common.removeFromFavorites': return 'Xóa khỏi yêu thích';
			case 'common.today': return 'Hôm nay';
			case 'common.yesterday': return 'Hôm qua';
			case 'components.dateSelection.title': return 'Chọn ngày';
			case 'components.dateSelection.subtitle': return 'Chọn ngày giao dịch';
			case 'components.dateSelection.selectedDate': return 'Ngày đã chọn';
			case 'components.dateSelection.confirm': return 'Xác nhận';
			case 'components.selection.cancel': return 'Hủy';
			case 'components.selection.confirm': return 'Xác nhận';
			case 'components.selection.select': return 'Chọn';
			case 'components.contactSelection.title': return 'Chọn người liên hệ';
			case 'components.contactSelection.subtitle': return 'Giao dịch với ai';
			case 'components.contactSelection.searchPlaceholder': return 'Tìm người liên hệ';
			case 'components.contactSelection.noContact': return 'Không có';
			case 'components.contactSelection.noContactDetails': return 'Giao dịch không có người liên hệ';
			case 'components.contactSelection.allContacts': return 'Tất cả';
			case 'components.contactSelection.create': return 'Tạo mới';
			case 'components.categorySelection.title': return 'Chọn danh mục';
			case 'components.categorySelection.subtitle': return 'Chọn danh mục cho giao dịch này';
			case 'components.categorySelection.searchPlaceholder': return 'Tìm danh mục';
			case 'components.currencySelection.title': return 'Chọn tiền tệ';
			case 'components.currencySelection.subtitle': return 'Chọn loại tiền';
			case 'components.currencySelection.searchPlaceholder': return 'Tìm tiền tệ';
			case 'components.accountSelection.title': return 'Chọn tài khoản';
			case 'components.accountSelection.subtitle': return 'Chọn tài khoản giao dịch';
			case 'components.accountSelection.searchPlaceholder': return 'Tìm tài khoản';
			case 'components.accountSelection.wallets': return 'Ví điện tử & Tiền mặt';
			case 'components.accountSelection.creditCards': return 'Thẻ tín dụng';
			case 'components.accountSelection.selectAccount': return 'Chọn tài khoản';
			case 'components.accountSelection.confirm': return 'Xác nhận';
			case 'components.parentWalletSelection.title': return 'Ví cha';
			case 'components.parentWalletSelection.subtitle': return 'Chọn ví chính';
			case 'components.parentWalletSelection.searchPlaceholder': return 'Tìm ví';
			case 'components.parentWalletSelection.noParent': return 'Không có ví cha';
			case 'components.parentWalletSelection.createRoot': return 'Tạo ví gốc';
			case 'components.parentWalletSelection.available': return 'Ví khả dụng';
			case 'components.walletTypes.checking': return 'Tài khoản thanh toán';
			case 'components.walletTypes.savings': return 'Tiết kiệm';
			case 'components.walletTypes.cash': return 'Tiền mặt';
			case 'components.walletTypes.creditCard': return 'Thẻ tín dụng';
			case 'navigation.home': return 'Tổng quan';
			case 'navigation.transactions': return 'Giao dịch';
			case 'navigation.contacts': return 'Liên hệ';
			case 'navigation.settings': return 'Cài đặt';
			case 'navigation.wallets': return 'Ví';
			case 'navigation.categories': return 'Danh mục';
			case 'navigation.loans': return 'Khoản vay';
			case 'navigation.charts': return 'Biểu đồ tài khoản';
			case 'navigation.backups': return 'Sao lưu';
			case 'navigation.creditCards': return 'Thẻ tín dụng';
			case 'navigation.sections.operations': return 'GIAO DỊCH';
			case 'navigation.sections.financialTools': return 'CÔNG CỤ TÀI CHÍNH';
			case 'navigation.sections.management': return 'QUẢN LÝ';
			case 'navigation.sections.advanced': return 'NÂNG CAO';
			case 'transactions.title': return 'Giao dịch';
			case 'transactions.types.all': return 'Tất cả';
			case 'transactions.types.income': return 'Thu nhập';
			case 'transactions.types.expense': return 'Chi tiêu';
			case 'transactions.types.transfer': return 'Chuyển khoản';
			case 'transactions.filter.title': return 'Lọc Giao dịch';
			case 'transactions.filter.date': return 'Ngày';
			case 'transactions.filter.categories': return 'Danh mục';
			case 'transactions.filter.accounts': return 'Tài khoản';
			case 'transactions.filter.contacts': return 'Liên hệ';
			case 'transactions.filter.amount': return 'Số tiền';
			case 'transactions.filter.apply': return 'Áp dụng';
			case 'transactions.filter.clear': return 'Xóa bộ lọc';
			case 'transactions.filter.add': return 'Thêm bộ lọc';
			case 'transactions.filter.minAmount': return 'Số tiền tối thiểu';
			case 'transactions.filter.maxAmount': return 'Số tiền tối đa';
			case 'transactions.filter.selectDate': return 'Chọn ngày';
			case 'transactions.filter.selectCategory': return 'Chọn danh mục';
			case 'transactions.filter.selectAccount': return 'Chọn tài khoản';
			case 'transactions.filter.selectContact': return 'Chọn liên hệ';
			case 'transactions.filter.quickFilters': return 'Lọc nhanh';
			case 'transactions.filter.ranges.thisMonth': return 'Tháng này';
			case 'transactions.filter.ranges.lastMonth': return 'Tháng trước';
			case 'transactions.filter.ranges.thisYear': return 'Năm nay';
			case 'transactions.filter.ranges.lastYear': return 'Năm ngoái';
			case 'transactions.filter.customRange': return 'Tùy chỉnh';
			case 'transactions.filter.startDate': return 'Từ ngày';
			case 'transactions.filter.endDate': return 'Đến ngày';
			case 'transactions.filter.active': return 'Bộ lọc đang bật';
			case 'transactions.filter.subtitles.income': return 'Tiền nhận';
			case 'transactions.filter.subtitles.expense': return 'Tiền chi';
			case 'transactions.filter.subtitles.transfer': return 'Tiền chuyển';
			case 'transactions.form.newTitle': return 'Thêm Giao Dịch';
			case 'transactions.form.editTitle': return 'Sửa Giao Dịch';
			case 'transactions.form.amount': return 'Số tiền';
			case 'transactions.form.type': return 'Loại giao dịch';
			case 'transactions.form.amountRequired': return 'Bắt buộc nhập số tiền';
			case 'transactions.form.date': return 'Ngày';
			case 'transactions.form.account': return 'Tài khoản';
			case 'transactions.form.toAccount': return 'Đến tài khoản';
			case 'transactions.form.category': return 'Danh mục';
			case 'transactions.form.contact': return 'Người liên hệ';
			case 'transactions.form.contactOptional': return 'Liên hệ (không bắt buộc)';
			case 'transactions.form.description': return 'Ghi chú';
			case 'transactions.form.descriptionOptional': return 'Ghi chú (không bắt buộc)';
			case 'transactions.form.selectAccount': return 'Chọn tài khoản';
			case 'transactions.form.selectDestination': return 'Chọn đích đến';
			case 'transactions.form.selectCategory': return 'Chọn danh mục';
			case 'transactions.form.selectContact': return 'Chọn liên hệ';
			case 'transactions.form.saveSuccess': return 'Lưu thành công';
			case 'transactions.form.updateSuccess': return 'Cập nhật thành công';
			case 'transactions.form.saveError': return 'Lỗi khi lưu';
			case 'transactions.form.share': return 'Chia sẻ';
			case 'transactions.form.created': return 'Đã tạo giao dịch';
			case 'transactions.form.crossCurrencyConversion': return 'Quy đổi ngoại tệ';
			case 'transactions.form.receivedAmount': return 'Số tiền nhận';
			case 'transactions.form.exchangeRate': return 'Tỷ giá';
			case 'transactions.form.receivedAmountRequired': return 'Nhập số tiền nhận';
			case 'transactions.form.exchangeRateLabel': return ({required Object from, required Object rate, required Object to}) => '1 ${from} = ${rate} ${to}';
			case 'transactions.errors.load': return 'Lỗi tải dữ liệu';
			case 'transactions.empty.title': return 'Chưa có giao dịch';
			case 'transactions.empty.message': return 'Không tìm thấy giao dịch nào';
			case 'transactions.empty.clearFilters': return 'Xóa bộ lọc';
			case 'transactions.list.count': return ({required Object n}) => '${n} giao dịch';
			case 'transactions.detail.title': return 'Chi tiết Giao Dịch';
			case 'transactions.detail.delete': return 'Xóa';
			case 'transactions.detail.deleteConfirmation': return 'Bạn có chắc chắn muốn xóa?';
			case 'transactions.detail.deleted': return 'Đã xóa giao dịch';
			case 'transactions.detail.duplicate': return 'Nhân bản';
			case 'transactions.detail.duplicateNotImplemented': return 'Chưa hỗ trợ nhân bản';
			case 'transactions.detail.edit': return 'Sửa';
			case 'transactions.detail.errorLoad': return 'Lỗi tải chi tiết';
			case 'transactions.detail.errorPrepareEdit': return ({required Object error}) => 'Lỗi khi sửa: ${error}';
			case 'transactions.detail.errorDelete': return ({required Object error}) => 'Lỗi khi xóa: ${error}';
			case 'transactions.detail.category': return 'Danh mục';
			case 'transactions.detail.account': return 'Tài khoản';
			case 'transactions.detail.contact': return 'Liên hệ';
			case 'transactions.detail.description': return 'Ghi chú';
			case 'transactions.detail.transferDetails': return 'Chi tiết chuyển khoản';
			case 'transactions.detail.from': return 'Từ';
			case 'transactions.detail.to': return 'Đến';
			case 'transactions.detail.unknownAccount': return 'Tài khoản ẩn';
			case 'transactions.detail.errorUrl': return ({required Object url}) => 'Không mở được ${url}';
			case 'transactions.detail.date': return 'Ngày';
			case 'transactions.detail.time': return 'Giờ';
			case 'transactions.detail.loanLinkedWarning': return 'Giao dịch này liên kết với khoản vay.';
			case 'transactions.share.title': return 'Chia sẻ';
			case 'transactions.share.copyText': return 'Sao chép';
			case 'transactions.share.shareButton': return 'Chia sẻ';
			case 'transactions.share.shareMessage': return 'Đây là hóa đơn của tôi:';
			case 'transactions.share.copied': return 'Đã sao chép vào khay nhớ tạm!';
			case 'transactions.share.paymentMethod': return 'Phương thức thanh toán';
			case 'transactions.share.receiptTitle': return 'Hóa Đơn';
			case 'transactions.share.poweredBy': return 'Cung cấp bởi MoneyT • moneyt.io';
			case 'transactions.share.errorImage': return ({required Object error}) => 'Lỗi: ${error}';
			case 'transactions.share.receipt.title': return '--- Chi tiết ---';
			case 'transactions.share.receipt.amount': return ({required Object amount}) => 'Số tiền: ${amount}';
			case 'transactions.share.receipt.description': return ({required Object description}) => 'Ghi chú: ${description}';
			case 'transactions.share.receipt.category': return ({required Object category}) => 'Danh mục: ${category}';
			case 'transactions.share.receipt.date': return ({required Object date}) => 'Ngày: ${date}';
			case 'transactions.share.receipt.time': return ({required Object time}) => 'Giờ: ${time}';
			case 'transactions.share.receipt.wallet': return ({required Object wallet}) => 'Tài khoản: ${wallet}';
			case 'transactions.share.receipt.contact': return ({required Object contact}) => 'Liên hệ: ${contact}';
			case 'transactions.share.receipt.id': return ({required Object id}) => 'ID: ${id}';
			case 'transactions.share.receipt.separator': return '--------------------------';
			case 'transactions.share.generatedOn': return ({required Object date}) => 'Tạo ngày ${date}';
			case 'contacts.title': return 'Danh bạ liên hệ';
			case 'contacts.addContact': return 'Thêm liên hệ';
			case 'contacts.editContact': return 'Sửa liên hệ';
			case 'contacts.newContact': return 'Tạo mới';
			case 'contacts.noContacts': return 'Chưa có liên hệ';
			case 'contacts.noContactsMessage': return 'Thêm liên hệ đầu tiên bằng nút +';
			case 'contacts.searchContacts': return 'Tìm kiếm';
			case 'contacts.deleteContact': return 'Xóa liên hệ';
			case 'contacts.confirmDelete': return 'Bạn có chắc chắn muốn xóa';
			case 'contacts.contactDeleted': return 'Đã xóa';
			case 'contacts.errorDeleting': return 'Lỗi';
			case 'contacts.noSearchResults': return 'Không tìm thấy';
			case 'contacts.noContactsMatch': return ({required Object query}) => 'Không có ai tên "${query}".';
			case 'contacts.errorLoading': return 'Lỗi tải dữ liệu';
			case 'contacts.contactSaved': return 'Đã lưu';
			case 'contacts.errorSaving': return 'Lỗi';
			case 'contacts.noContactInfo': return 'Không có thông tin';
			case 'contacts.importContact': return 'Nhập từ danh bạ';
			case 'contacts.importContacts': return 'Nhập hàng loạt';
			case 'contacts.importContactSoon': return 'Tính năng sắp ra mắt';
			case 'contacts.fields.name': return 'Tên';
			case 'contacts.fields.fullName': return 'Họ và tên';
			case 'contacts.fields.email': return 'Email';
			case 'contacts.fields.phone': return 'Số điện thoại';
			case 'contacts.fields.address': return 'Địa chỉ';
			case 'contacts.fields.notes': return 'Ghi chú';
			case 'contacts.placeholders.enterFullName': return 'Nhập họ tên';
			case 'contacts.placeholders.enterPhone': return 'Nhập SĐT';
			case 'contacts.placeholders.enterEmail': return 'Nhập Email';
			case 'contacts.validation.nameRequired': return 'Bắt buộc nhập tên';
			case 'contacts.validation.invalidEmail': return 'Email không hợp lệ';
			case 'contacts.validation.invalidPhone': return 'SĐT không hợp lệ';
			case 'errors.loadingAccounts': return ({required Object error}) => 'Lỗi tải: ${error}';
			case 'errors.unexpected': return 'Lỗi không xác định';
			case 'settings.title': return 'Cài đặt';
			case 'settings.account.title': return 'Tài khoản';
			case 'settings.account.profile': return 'Hồ sơ';
			case 'settings.account.profileSubtitle': return 'Quản lý thông tin cá nhân';
			case 'settings.appearance.title': return 'Tùy chọn';
			case 'settings.appearance.darkMode': return 'Chế độ tối';
			case 'settings.appearance.darkModeSubtitle': return 'Bật giao diện tối';
			case 'settings.appearance.language': return 'Ngôn ngữ';
			case 'settings.appearance.currency': return 'Tiền tệ mặc định';
			case 'settings.appearance.currencySubtitle': return 'Đơn vị tiền tệ hiển thị';
			case 'settings.appearance.darkTheme': return 'Giao diện tối';
			case 'settings.appearance.lightTheme': return 'Giao diện sáng';
			case 'settings.appearance.systemTheme': return 'Theo hệ thống';
			case 'settings.data.title': return 'Dữ liệu';
			case 'settings.data.backup': return 'Sao lưu';
			case 'settings.data.backupSubtitle': return 'Quản lý dữ liệu an toàn';
			case 'settings.info.title': return 'Thông tin';
			case 'settings.info.contact': return 'Liên hệ & Mạng xã hội';
			case 'settings.info.contactSubtitle': return 'Tham gia cộng đồng';
			case 'settings.info.privacy': return 'Chính sách bảo mật';
			case 'settings.info.privacySubtitle': return 'Đọc chính sách của chúng tôi';
			case 'settings.info.share': return 'Chia sẻ MoneyT';
			case 'settings.info.shareSubtitle': return 'Giới thiệu bạn bè';
			case 'settings.logout.button': return 'Đăng xuất';
			case 'settings.logout.dialogTitle': return 'Đăng xuất';
			case 'settings.logout.dialogMessage': return 'Bạn có chắc chắn muốn đăng xuất?';
			case 'settings.logout.cancel': return 'Hủy';
			case 'settings.logout.confirm': return 'Đăng xuất';
			case 'settings.social.title': return 'Liên hệ';
			case 'settings.social.follow': return 'Theo dõi MoneyT';
			case 'settings.social.description': return 'Nhận tin tức mới nhất.';
			case 'settings.social.networks': return 'Mạng xã hội';
			case 'settings.social.github': return 'GitHub';
			case 'settings.social.githubSubtitle': return 'Xem mã nguồn';
			case 'settings.social.linkedin': return 'LinkedIn';
			case 'settings.social.linkedinSubtitle': return 'Tin tức chuyên nghiệp';
			case 'settings.social.twitter': return 'X (Twitter)';
			case 'settings.social.twitterSubtitle': return 'Cập nhật nhanh';
			case 'settings.social.reddit': return 'Reddit';
			case 'settings.social.redditSubtitle': return 'Cộng đồng';
			case 'settings.social.discord': return 'Discord';
			case 'settings.social.discordSubtitle': return 'Trò chuyện trực tiếp';
			case 'settings.social.contact': return 'Hỗ trợ';
			case 'settings.social.email': return 'Gửi email hỗ trợ';
			case 'settings.social.website': return 'Trang chủ';
			case 'settings.language.title': return 'Ngôn ngữ';
			case 'settings.language.available': return 'NGÔN NGỮ KHẢ DỤNG';
			case 'settings.language.apply': return 'Áp dụng';
			case 'settings.currency.title': return 'Tiền tệ';
			case 'settings.currency.available': return 'TIỀN TỆ KHẢ DỤNG';
			case 'settings.currency.apply': return 'Áp dụng';
			case 'settings.messages.profileComingSoon': return 'Sắp ra mắt';
			case 'settings.messages.privacyError': return 'Không thể mở';
			case 'settings.messages.logoutComingSoon': return 'Đăng xuất sắp ra mắt';
			case 'onboarding.welcome.title': return 'Chào mừng đến MoneyT 👋';
			case 'onboarding.welcome.subtitle': return 'Làm chủ tài chính chỉ trong vài phút ✨';
			case 'onboarding.problemStatement.title': return 'Cảm thấy tiền trôi qua kẽ tay?';
			case 'onboarding.problemStatement.subtitle': return 'Bạn không cô đơn. 70% người không biết tiền của họ đi đâu.';
			case 'onboarding.specificProblem.title': return 'Điều gì làm bạn đau đầu nhất?';
			case 'onboarding.specificProblem.options.debts': return 'Nợ nần và khoản vay';
			case 'onboarding.specificProblem.options.savings': return 'Không thể để dành được đồng nào';
			case 'onboarding.specificProblem.options.unknown': return 'Tiêu đi đâu không biết';
			case 'onboarding.specificProblem.options.chaos': return 'Tài chính rối tinh rối mù';
			case 'onboarding.personalGoal.title': return 'Mục tiêu số 1 của bạn là gì?';
			case 'onboarding.personalGoal.options.debtFree': return 'Sạch nợ';
			case 'onboarding.personalGoal.options.saveTrip': return 'Để dành mua xe/đi du lịch';
			case 'onboarding.personalGoal.options.invest': return 'Bắt đầu đầu tư';
			case 'onboarding.personalGoal.options.peace': return 'Ăn ngon ngủ yên';
			case 'onboarding.solutionPreview.title': return 'MoneyT mang lại sự rõ ràng';
			case 'onboarding.solutionPreview.subtitle': return 'Xem tất cả tài khoản, nợ và chi tiêu ở một nơi. Tạm biệt Excel rắc rối.';
			case 'onboarding.solutionPreview.benefits.visualize': return 'Theo dõi chi tiêu theo thời gian thực';
			case 'onboarding.solutionPreview.benefits.goals': return 'Đặt mục tiêu và theo dõi';
			case 'onboarding.solutionPreview.benefits.smart': return 'Đưa ra quyết định thông minh';
			case 'onboarding.currentMethod.title': return 'Bạn đang quản lý tiền thế nào?';
			case 'onboarding.currentMethod.subtitle': return 'Chọn cách giống bạn nhất.';
			case 'onboarding.currentMethod.options.excel': return 'Dùng bảng tính Excel';
			case 'onboarding.currentMethod.options.notebook': return 'Sổ tay';
			case 'onboarding.currentMethod.options.mental': return 'Nhẩm trong đầu';
			case 'onboarding.currentMethod.options.none': return 'Chẳng quản lý gì cả';
			case 'onboarding.featuresShowcase.title': return 'Những gì đang có và sắp ra mắt ✨';
			case 'onboarding.featuresShowcase.subtitle': return 'Dùng được ngay, và còn nhiều tính năng hay sắp đến.';
			case 'onboarding.featuresShowcase.available': return 'SẴN SÀNG';
			case 'onboarding.featuresShowcase.comingSoon': return 'SẮP RA MẮT';
			case 'onboarding.featuresShowcase.features.income': return 'Thu nhập';
			case 'onboarding.featuresShowcase.features.expense': return 'Chi tiêu';
			case 'onboarding.featuresShowcase.features.transfer': return 'Chuyển khoản';
			case 'onboarding.featuresShowcase.features.loans': return 'Khoản vay';
			case 'onboarding.featuresShowcase.features.goals': return 'Mục tiêu';
			case 'onboarding.featuresShowcase.features.budgets': return 'Ngân sách';
			case 'onboarding.featuresShowcase.features.investments': return 'Đầu tư';
			case 'onboarding.featuresShowcase.features.cloud': return 'Lưu trữ Đám mây';
			case 'onboarding.featuresShowcase.features.openBanking': return 'Liên kết Ngân hàng';
			case 'onboarding.complete.title': return 'Sẵn sàng cất cánh! 🚀';
			case 'onboarding.complete.subtitle': return 'Nhập khoản chi tiêu đầu tiên và xem phép màu xảy ra 📈';
			case 'onboarding.complete.stats.title': return 'Tỷ lệ thành công';
			case 'onboarding.complete.stats.before': return 'Trước đây';
			case 'onboarding.complete.stats.after': return 'Dùng MoneyT';
			case 'onboarding.buttons.start': return 'Bắt đầu nào! 🚀';
			case 'onboarding.buttons.fixIt': return 'Sửa đổi ngay hôm nay ⚡';
			case 'onboarding.buttons.actionContinue': return 'Tiếp tục';
			case 'onboarding.buttons.setGoal': return 'Lên mục tiêu 🎯';
			case 'onboarding.buttons.wantControl': return 'Mình muốn kiểm soát tiền!';
			case 'onboarding.buttons.great': return 'Tuyệt quá, xem thử nào!';
			case 'onboarding.buttons.firstTransaction': return 'Thêm giao dịch đầu tiên ➕';
			case 'onboarding.buttons.skip': return 'Bỏ qua';
			case 'dashboard.greeting': return 'Chào bạn';
			case 'dashboard.balance.total': return 'TỔNG SỐ DƯ';
			case 'dashboard.balance.income': return 'TỔNG THU';
			case 'dashboard.balance.expenses': return 'TỔNG CHI';
			case 'dashboard.balance.thisMonth': return 'tháng này';
			case 'dashboard.actions.income': return 'Thu';
			case 'dashboard.actions.expense': return 'Chi';
			case 'dashboard.actions.transfer': return 'Chuyển';
			case 'dashboard.actions.all': return 'Tất cả';
			case 'dashboard.wallets.title': return 'Ví của bạn';
			case 'dashboard.wallets.count': return ({required Object n}) => '${n} tài khoản';
			case 'dashboard.wallets.more': return ({required Object n}) => '+${n} tài khoản khác';
			case 'dashboard.wallets.viewDetails': return ({required Object name}) => 'Xem chi tiết ${name}';
			case 'dashboard.transactions.title': return 'Giao dịch gần đây';
			case 'dashboard.transactions.subtitle': return '5 giao dịch mới nhất';
			case 'dashboard.transactions.empty': return 'Trống trơn';
			case 'dashboard.transactions.emptySubtitle': return 'Chưa có giao dịch nào';
			case 'dashboard.transactions.more': return ({required Object n}) => 'Xem thêm ${n} giao dịch';
			case 'dashboard.customize': return 'Tùy chỉnh';
			case 'dashboard.widgets.balance.title': return 'Tổng số dư';
			case 'dashboard.widgets.balance.description': return 'Tình hình tài chính chung';
			case 'dashboard.widgets.quickActions.title': return 'Lối tắt';
			case 'dashboard.widgets.quickActions.description': return 'Ghi chép siêu nhanh';
			case 'dashboard.widgets.wallets.title': return 'Danh sách Ví';
			case 'dashboard.widgets.wallets.description': return 'Xem tất cả số dư';
			case 'dashboard.widgets.loans.title': return 'Khoản Vay';
			case 'dashboard.widgets.loans.description': return 'Quản lý nợ nần';
			case 'dashboard.widgets.transactions.title': return 'Giao dịch gần đây';
			case 'dashboard.widgets.transactions.description': return 'Biến động mới nhất';
			case 'dashboard.widgets.categoryBreakdown.title': return 'Phân tích theo danh mục';
			case 'dashboard.widgets.categoryBreakdown.description': return 'Chi tiêu tháng hiện tại';
			case 'dashboard.widgets.categoryBreakdown.empty_message': return 'Không có gì để phân tích.';
			case 'dashboard.widgets.categoryBreakdown.others': return 'Khác';
			case 'dashboard.widgets.categoryBreakdown.back': return 'Trở lại';
			case 'dashboard.widgets.categoryBreakdown.monthlyBudget': return 'Ngân sách tháng';
			case 'dashboard.widgets.categoryBreakdown.leftover': return ({required Object amount}) => 'Bạn còn dư ${amount} từ thu nhập.';
			case 'dashboard.widgets.categoryBreakdown.exceeded': return ({required Object amount}) => 'Bạn chi lố ${amount} so với thu nhập.';
			case 'dashboard.widgets.categoryBreakdown.noIncome': return ({required Object amount}) => 'Đã chi: ${amount} (Chưa có khoản thu)';
			case 'dashboard.widgets.chartAccounts.title': return 'Sơ đồ tài khoản';
			case 'dashboard.widgets.chartAccounts.description': return 'Cấu trúc tài chính';
			case 'dashboard.widgets.creditCards.title': return 'Thẻ tín dụng';
			case 'dashboard.widgets.creditCards.description': return 'Số dư và hạn mức thẻ';
			case 'dashboard.widgets.settings.title': return 'Chỉnh sửa trang chủ';
			case 'dashboard.widgets.settings.subtitle': return 'Kéo thả để sắp xếp các tiện ích (widgets).';
			case 'dashboard.widgets.settings.reset.button': return 'Khôi phục mặc định';
			case 'dashboard.widgets.settings.reset.dialogTitle': return 'Khôi phục bố cục';
			case 'dashboard.widgets.settings.reset.dialogContent': return 'Khôi phục lại giao diện trang chủ như lúc mới tải app?';
			case 'dashboard.widgets.settings.reset.cancel': return 'Hủy';
			case 'dashboard.widgets.settings.reset.confirm': return 'Khôi phục';
			case 'dashboard.widgets.settings.reset.success': return 'Đã trở về mặc định';
			case 'dashboard.widgets.settings.saveSuccess': return 'Lưu thành công!';
			case 'dashboard.widgets.settings.saveError': return ({required Object error}) => 'Lỗi: ${error}';
			case 'dashboard.widgets.settings.saving': return 'Đang lưu...';
			case 'dashboard.widgets.settings.save': return 'Lưu thay đổi';
			case 'wallets.title': return 'Ví của bạn';
			case 'wallets.empty.title': return 'Chưa có ví nào';
			case 'wallets.empty.message': return 'Tạo ví đầu tiên để bắt đầu theo dõi dòng tiền.';
			case 'wallets.empty.action': return 'Tạo ví mới';
			case 'wallets.emptyArchived.title': return 'Không có ví lưu trữ';
			case 'wallets.emptyArchived.message': return 'Những ví đã đóng sẽ hiện ở đây.';
			case 'wallets.filter.active': return 'Đang dùng';
			case 'wallets.filter.archived': return 'Lưu trữ';
			case 'wallets.filter.all': return 'Tất cả';
			case 'wallets.form.newTitle': return 'Thêm ví mới';
			case 'wallets.form.editTitle': return 'Sửa ví';
			case 'wallets.form.name': return 'Tên ví';
			case 'wallets.form.namePlaceholder': return 'Ví dụ: Tiền mặt, Ngân hàng VCB';
			case 'wallets.form.nameRequired': return 'Bắt buộc nhập tên ví';
			case 'wallets.form.description': return 'Ghi chú';
			case 'wallets.form.descriptionPlaceholder': return 'Mô tả ngắn gọn (không bắt buộc)';
			case 'wallets.form.currency': return 'Tiền tệ';
			case 'wallets.form.currencyLockedByParent': return 'Cùng loại tiền với ví cha';
			case 'wallets.form.parent': return 'Ví cha (nếu là ví con)';
			case 'wallets.form.parentEmpty': return 'Không có ví cha';
			case 'wallets.form.chartAccount': return 'Loại tài khoản';
			case 'wallets.form.chartAccountLocked': return 'Không thể thay đổi';
			case 'wallets.form.createSuccess': return 'Tạo thành công';
			case 'wallets.form.updateSuccess': return 'Cập nhật thành công';
			case 'wallets.form.loadParentError': return ({required Object error}) => 'Lỗi: ${error}';
			case 'wallets.form.loadChartAccountError': return ({required Object error}) => 'Lỗi: ${error}';
			case 'wallets.delete.dialogTitle': return 'Xóa ví';
			case 'wallets.delete.dialogMessage': return ({required Object name}) => 'Xóa ví ${name} vĩnh viễn?';
			case 'wallets.delete.cancel': return 'Hủy';
			case 'wallets.delete.confirm': return 'Xóa';
			case 'wallets.delete.success': return 'Đã xóa ví';
			case 'wallets.delete.error': return ({required Object error}) => 'Lỗi: ${error}';
			case 'wallets.errors.load': return 'Không tải được danh sách';
			case 'wallets.errors.retry': return 'Thử lại';
			case 'wallets.errors.comingSoon': return ({required Object name}) => 'Tính năng ${name} sắp có';
			case 'wallets.subtitle.mainAccount': return 'Tài khoản chính';
			case 'wallets.subtitle.cashDigital': return 'Tiền mặt & Điện tử';
			case 'wallets.subtitle.count': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('vi'))(n,
				one: '${n} ví',
				other: '${n} ví',
			);
			case 'wallets.subtitle.account': return 'Tài khoản';
			case 'wallets.subtitle.physicalCash': return 'Tiền mặt';
			case 'wallets.subtitle.digitalWallet': return 'Ví điện tử';
			case 'wallets.options.viewTransactions': return 'Xem lịch sử';
			case 'wallets.options.viewTransactionsSubtitle': return 'Tất cả giao dịch của ví này';
			case 'wallets.options.transferFunds': return 'Chuyển khoản';
			case 'wallets.options.transferFundsSubtitle': return 'Chuyển tiền sang ví khác';
			case 'wallets.options.editWallet': return 'Sửa thông tin';
			case 'wallets.options.editWalletSubtitle': return 'Thay tên, màu sắc';
			case 'wallets.options.duplicateWallet': return 'Nhân bản';
			case 'wallets.options.duplicateWalletSubtitle': return 'Tạo bản sao ví này';
			case 'wallets.options.archiveWallet': return 'Lưu trữ';
			case 'wallets.options.archiveWalletSubtitle': return 'Ẩn ví khỏi trang chính';
			case 'wallets.options.unarchiveWallet': return 'Bỏ lưu trữ';
			case 'wallets.options.unarchiveWalletSubtitle': return 'Hiện lại trên trang chính';
			case 'wallets.options.deleteWallet': return 'Xóa ví';
			case 'wallets.options.deleteWalletSubtitle': return 'Xóa hoàn toàn (cẩn thận nha)';
			case 'wallets.options.defaultTitle': return 'Ví';
			case 'loans.title': return 'Sổ nợ';
			case 'loans.filter.active': return 'Đang mở';
			case 'loans.filter.history': return 'Lịch sử';
			case 'loans.filter.all': return 'Tất cả';
			case 'loans.filter.pending': return 'Chưa xong';
			case 'loans.filter.lent': return 'Cho vay';
			case 'loans.filter.borrowed': return 'Đi vay';
			case 'loans.summary.netBalance': return 'TỔNG KẾT';
			case 'loans.summary.activeLoans': return 'ĐANG MỞ';
			case 'loans.summary.noActive': return 'Không có nợ nần';
			case 'loans.summary.lent': return ({required Object n}) => 'Cho vay ${n}';
			case 'loans.summary.borrowed': return ({required Object n}) => 'Đi vay ${n}';
			case 'loans.summary.pending': return ({required Object n}) => 'Đang nợ ${n}';
			case 'loans.card.lent': return 'Bạn cho vay';
			case 'loans.card.borrowed': return 'Bạn đi vay';
			case 'loans.card.active': return ({required Object n}) => '${n} khoản';
			case 'loans.card.multiple': return ({required Object n}) => '${n} khoản vay';
			case 'loans.card.transactions': return ({required Object n}) => '${n} lần';
			case 'loans.card.overdue': return ({required Object n}) => 'Quá hạn ${n} ngày';
			case 'loans.card.due': return ({required Object date}) => 'Hạn trả: ${date}';
			case 'loans.form.newTitle': return 'Khoản vay mới';
			case 'loans.form.editTitle': return 'Sửa khoản vay';
			case 'loans.form.type': return 'Bạn là';
			case 'loans.form.lend': return 'Người cho vay';
			case 'loans.form.borrow': return 'Người đi vay';
			case 'loans.form.contact': return 'Giao dịch với';
			case 'loans.form.contactPlaceholder': return 'Chọn ai đó';
			case 'loans.form.account': return 'Từ tài khoản';
			case 'loans.form.accountPlaceholder': return 'Chọn ví xuất tiền';
			case 'loans.form.amount': return 'Số tiền';
			case 'loans.form.description': return 'Ghi chú';
			case 'loans.form.date': return 'Ngày mượn';
			case 'loans.form.dueDate': return 'Ngày hẹn trả';
			case 'loans.form.selectDate': return 'Chọn ngày';
			case 'loans.form.optional': return '(Không bắt buộc)';
			case 'loans.form.createTransaction': return 'Lưu vào ví luôn';
			case 'loans.form.recordAutomatically': return 'Tự động ghi chép';
			case 'loans.form.transactionCategory': return 'Danh mục tương ứng';
			case 'loans.form.category': return 'Danh mục';
			case 'loans.form.categoryPlaceholder': return 'Chọn danh mục';
			case 'loans.form.save': return 'Lưu khoản vay';
			case 'loans.form.successCreate': return 'Ghi nhận thành công!';
			case 'loans.form.successUpdate': return 'Đã cập nhật';
			case 'loans.form.contactRequired': return 'Bắt buộc chọn liên hệ';
			case 'loans.form.accountRequired': return 'Bắt buộc chọn tài khoản';
			case 'loans.form.amountRequired': return 'Bắt buộc nhập tiền';
			case 'loans.detail.title': return 'Chi tiết';
			case 'loans.detail.deleteTitle': return 'Xóa khoản vay';
			case 'loans.detail.deleteMessage': return 'Chắc chắn muốn xóa ghi chép này?';
			case 'loans.detail.deleteSuccess': return 'Đã xóa';
			case 'loans.detail.deleteError': return ({required Object error}) => 'Lỗi: ${error}';
			case 'loans.detail.notFound': return 'Không tìm thấy';
			case 'loans.detail.progress': return 'Tiến độ';
			case 'loans.detail.info': return 'Thông tin';
			case 'loans.detail.pay': return 'Thanh toán khoản này';
			case 'loans.detail.viewHistory': return 'Toàn bộ lịch sử';
			case 'loans.detail.original': return ({required Object amount}) => 'Ban đầu: ${amount}';
			case 'loans.detail.section': return 'Chi tiết';
			case 'loans.detail.activeSummary': return 'Tóm tắt';
			case 'loans.detail.activeLent': return 'Đang cho vay';
			case 'loans.detail.activeBorrowed': return 'Đang nợ người ta';
			case 'loans.detail.activeNet': return 'Số dư thực';
			case 'loans.detail.activeTotal': return 'Tổng cộng';
			case 'loans.detail.startDate': return 'Ngày bắt đầu';
			case 'loans.detail.dueDate': return 'Hạn chót';
			case 'loans.detail.type.label': return 'Loại';
			case 'loans.detail.type.personal': return 'Vay cá nhân';
			case 'loans.detail.type.borrowed': return 'Vay nặng lãi';
			case 'loans.detail.type.auto': return 'Vay mua xe';
			case 'loans.detail.type.mortgage': return 'Vay mua nhà';
			case 'loans.detail.type.student': return 'Vay sinh viên';
			case 'loans.detail.payment.history': return 'Lịch sử trả nợ';
			case 'loans.detail.payment.date': return ({required Object date}) => 'Trả ngày ${date}';
			case 'loans.detail.payment.transactionId': return ({required Object id}) => 'ID: ${id}';
			case 'loans.detail.payment.paid': return ({required Object amount}) => 'Đã trả ${amount}';
			case 'loans.detail.payment.remaining': return ({required Object amount}) => 'Còn ${amount}';
			case 'loans.history.title': return 'Lịch sử sổ nợ';
			case 'loans.history.section': return 'Toàn bộ';
			case 'loans.history.totalLoaned': return 'Tổng số';
			case 'loans.history.noLoans': return 'Trống trơn.';
			case 'loans.history.filter.all': return 'Tất cả';
			case 'loans.history.filter.lent': return 'Cho mượn';
			case 'loans.history.filter.borrowed': return 'Đi mượn';
			case 'loans.history.filter.completed': return 'Đã xong';
			case 'loans.history.filter.title': return 'Lọc sổ nợ';
			case 'loans.history.filter.reset': return 'Mặc định';
			case 'loans.history.filter.apply': return 'Áp dụng';
			case 'loans.history.filter.dateRange': return 'Thời gian';
			case 'loans.history.filter.amountRange': return 'Khoảng tiền';
			case 'loans.history.filter.startDate': return 'Từ ngày';
			case 'loans.history.filter.endDate': return 'Đến ngày';
			case 'loans.history.filter.select': return 'Chọn';
			case 'loans.history.headers.lent': return 'Đã cho mượn';
			case 'loans.history.headers.borrowed': return 'Đã đi mượn';
			case 'loans.history.headers.completed': return 'Đã trả xong';
			case 'loans.history.headers.active': return 'Đang mở';
			case 'loans.history.headers.cancelled': return 'Bị hủy';
			case 'loans.history.headers.writtenOff': return 'Mất trắng/Xóa nợ';
			case 'loans.history.item.defaultTitle': return 'Khoản vay';
			case 'loans.history.item.date': return ({required Object date}) => 'Ngày: ${date}';
			case 'loans.history.item.lent': return 'Cho vay';
			case 'loans.history.item.borrowed': return 'Đi vay';
			case 'loans.history.item.status.completed': return 'Đã xong';
			case 'loans.history.item.status.active': return 'Chưa xong';
			case 'loans.history.item.status.cancelled': return 'Hủy';
			case 'loans.history.item.status.writtenOff': return 'Xóa nợ';
			case 'loans.history.summary.title': return 'Thống kê';
			case 'loans.history.summary.viewDetails': return 'Chi tiết';
			case 'loans.history.summary.hideDetails': return 'Ẩn đi';
			case 'loans.history.summary.outstandingLent': return 'Người ta còn nợ bạn';
			case 'loans.history.summary.outstandingBorrowed': return 'Bạn còn nợ người ta';
			case 'loans.history.summary.netPosition': return 'Thực Tế';
			case 'loans.history.summary.totalLent': return 'Tổng tiền từng cho mượn';
			case 'loans.history.summary.totalBorrowed': return 'Tổng tiền từng đi mượn';
			case 'loans.history.summary.totalRepaidToYou': return 'Tiền đã đòi được';
			case 'loans.history.summary.totalYouRepaid': return 'Tiền bạn đã trả';
			case 'loans.history.summary.totalLoans': return 'Tổng giao dịch vay mượn';
			case 'loans.history.summary.completedLoans': return 'Đã hoàn tất';
			case 'loans.contactDetail.titleWith': return ({required Object name}) => 'Sổ nợ với ${name}';
			case 'loans.share.title': return 'Gửi cho đối tác';
			case 'loans.share.contactTitle': return 'Gửi tóm tắt';
			case 'loans.share.button': return 'Gửi đi';
			case 'loans.share.copy': return 'Chép';
			case 'loans.share.message': return 'Này, check lại khoản nợ nha:';
			case 'loans.share.contactMessage': return ({required Object name}) => 'Tóm tắt với ${name}:';
			case 'loans.share.error': return ({required Object error}) => 'Lỗi: ${error}';
			case 'loans.share.contactCopied': return 'Đã chép!';
			case 'loans.share.activeLoans': return ({required Object n}) => 'Đang mở (${n}):';
			case 'loans.share.loanItem': return ({required Object description, required Object amount, required Object date, required Object percent}) => '• ${description}: ${amount} (Ngày: ${date}) - ${percent}% xong';
			case 'loans.share.loanStatement': return 'MoneyT - Sao kê';
			case 'loans.share.loanSummary': return 'MoneyT - Tóm tắt';
			case 'loans.share.personalLoan': return 'Vay cá nhân';
			case 'loans.share.remaining': return ({required Object amount}) => 'Còn lại: ${amount}';
			case 'loans.share.remainingLabel': return 'Còn lại';
			case 'loans.share.original': return ({required Object amount}) => 'trong số ${amount}';
			case 'loans.share.progress': return ({required Object percent}) => 'Đã trả ${percent}%';
			case 'loans.share.progressLabel': return 'Tiến độ';
			case 'loans.share.paidSuffix': return 'Hoàn tất';
			case 'loans.share.date': return ({required Object date}) => 'Ngày lập: ${date}';
			case 'loans.share.dateLabel': return 'Ngày lập';
			case 'loans.share.contact': return ({required Object name}) => 'Với: ${name}';
			case 'loans.share.contactLabel': return 'Với';
			case 'loans.share.generated': return ({required Object date}) => 'Tạo lúc ${date}';
			case 'loans.share.generatedLabel': return ({required Object date}) => 'Tạo lúc ${date}';
			case 'loans.share.totalActive': return ({required Object n}) => 'Tổng cộng: ${n} khoản';
			case 'loans.share.active': return 'đang có';
			case 'loans.share.poweredBy': return 'Tạo bằng MoneyT • moneyt.io';
			case 'loans.share.copied': return 'Đã chép!';
			case 'loans.share.netBalance': return ({required Object amount, required Object status}) => 'Chênh lệch: ${amount} (${status})';
			case 'loans.share.netBalanceLabel': return 'Chênh lệch';
			case 'loans.share.owed': return 'Bạn được nhận';
			case 'loans.share.owe': return 'Bạn phải trả';
			case 'loans.share.lent': return ({required Object amount}) => 'Đã cho mượn: ${amount}';
			case 'loans.share.lentLabel': return 'Bạn cho mượn';
			case 'loans.share.borrowed': return ({required Object amount}) => 'Đã mượn: ${amount}';
			case 'loans.share.borrowedLabel': return 'Bạn đi mượn';
			case 'loans.share.contactSummary': return ({required Object name}) => 'Tóm tắt - ${name}';
			case 'loans.payment.title': return 'Ghi nhận thanh toán';
			case 'loans.payment.amount': return 'Số tiền trả';
			case 'loans.payment.amountPlaceholder': return '0';
			case 'loans.payment.amountRequired': return 'Ghi số tiền vào';
			case 'loans.payment.invalidAmount': return 'Số không đúng';
			case 'loans.payment.exceedsBalance': return 'Đừng trả lố số nợ';
			case 'loans.payment.date': return 'Ngày trả';
			case 'loans.payment.account': return 'Ví nhận tiền';
			case 'loans.payment.selectAccount': return 'Chọn ví';
			case 'loans.payment.details': return 'Ghi chú thêm';
			case 'loans.payment.detailsPlaceholder': return 'Có muốn ghi chú gì không?';
			case 'loans.payment.success': return 'Ghi nhận xong!';
			case 'loans.payment.error': return ({required Object error}) => 'Lỗi: ${error}';
			case 'loans.payment.errorAmount': return 'Nhập số tiền hợp lệ';
			case 'loans.payment.errorAccount': return 'Chọn ví';
			case 'loans.payment.errorLoading': return ({required Object error}) => 'Lỗi: ${error}';
			case 'loans.payment.summary.title': return 'Tóm tắt thay đổi';
			case 'loans.payment.summary.defaultTitle': return 'Khoản nợ';
			case 'loans.payment.summary.amount': return 'Sẽ thanh toán';
			case 'loans.payment.summary.remaining': return 'Số dư mới';
			case 'loans.payment.summary.progress': return 'Tiến độ mới';
			case 'loans.payment.summary.description': return ({required Object loan, required Object contact}) => '${loan} với ${contact}';
			case 'loans.payment.summary.unknownContact': return 'Ai đó';
			case 'loans.payment.summary.total': return ({required Object amount}) => 'Tổng: ${amount}';
			case 'loans.payment.summary.paid': return ({required Object amount}) => 'Đã trả: ${amount}';
			case 'loans.payment.summary.remainingLabel': return ({required Object amount}) => 'Còn lại: ${amount}';
			case 'loans.payment.quick.full': return ({required Object amount}) => 'Trả hết (${amount})';
			case 'loans.payment.quick.half': return ({required Object amount}) => 'Trả một nửa (${amount})';
			case 'loans.given': return 'Bạn cho mượn';
			case 'loans.received': return 'Bạn đi mượn';
			case 'loans.item.due': return ({required Object date}) => 'Hạn: ${date}';
			case 'loans.item.paidAmount': return ({required Object amount}) => 'Xong: ${amount}';
			case 'loans.item.remaining': return ({required Object amount}) => 'Còn: ${amount}';
			case 'loans.item.percentPaid': return ({required Object percent}) => '${percent}%';
			case 'loans.section.activeLoans': return 'Đang vay/cho vay';
			case 'loans.section.loansCount': return ({required Object n}) => '${n} khoản';
			case 'loans.empty.title': return 'Chưa có gì cả';
			case 'loans.empty.message': return 'Không nợ nần ai là tốt rồi.';
			case 'loans.empty.action': return 'Tạo mới';
			case 'categories.title': return 'Danh mục';
			case 'categories.form.newTitle': return 'Danh mục mới';
			case 'categories.form.editTitle': return 'Sửa danh mục';
			case 'categories.form.name': return 'Tên danh mục';
			case 'categories.form.namePlaceholder': return 'Ví dụ: Ăn uống, Tiền nhà';
			case 'categories.form.nameRequired': return 'Phải có tên nha';
			case 'categories.form.parent': return 'Danh mục cha (nếu có)';
			case 'categories.form.noParent': return 'Nằm ngoài cùng';
			case 'categories.form.asSubcategory': return 'Sẽ làm danh mục con';
			case 'categories.form.asRoot': return 'Sẽ làm danh mục gốc';
			case 'categories.form.active': return 'Sử dụng được';
			case 'categories.form.activeDescription': return 'Bật để chọn được khi nhập giao dịch';
			case 'categories.form.selectIcon': return 'Chọn Icon';
			case 'categories.form.selectColor': return 'Chọn Màu';
			case 'categories.form.saveSuccess': return 'Xong xuôi!';
			case 'categories.form.saveError': return ({required Object error}) => 'Lỗi rồi: ${error}';
			case 'categories.parentSelection.title': return 'Chọn danh mục cha';
			case 'categories.parentSelection.subtitle': return 'Nằm trong cái nào?';
			case 'categories.parentSelection.noParent': return 'Không nằm trong đâu';
			case 'categories.incomeCategory': return 'Loại thu';
			case 'categories.expenseCategory': return 'Loại chi';
			case 'categories.report.title': return 'Phân tích nâng cao';
			case 'categories.report.timeFilter': return 'Thời gian';
			case 'categories.report.thisMonth': return 'Tháng này';
			case 'categories.report.lastMonth': return 'Tháng trước';
			case 'categories.report.thisYear': return 'Năm nay';
			case 'categories.report.allTime': return 'Tất cả';
			case 'categories.report.details': return 'Chi tiết';
			case 'categories.report.noTransactions': return 'Chưa có giao dịch';
			case 'categories.report.income': return 'Thu nhập';
			case 'categories.report.expense': return 'Chi tiêu';
			case 'backups.title': return 'Sao lưu dữ liệu';
			case 'backups.menu.settings': return 'Cài đặt sao lưu';
			case 'backups.menu.comingSoon': return 'Sắp ra mắt';
			case 'backups.filters.all': return 'Tất cả';
			case 'backups.filters.auto': return 'Tự động';
			case 'backups.filters.manual': return 'Tự làm';
			case 'backups.filters.thisMonth': return 'Tháng này';
			case 'backups.filters.lastMonth': return 'Tháng trước';
			case 'backups.filters.thisYear': return 'Năm nay';
			case 'backups.filters.lastYear': return 'Năm trước';
			case 'backups.status.loading': return 'Đang tải...';
			case 'backups.status.error': return 'Lỗi tải file sao lưu';
			case 'backups.status.empty': return 'Chưa sao lưu gì';
			case 'backups.status.emptyAction': return 'Ấn nút + để lưu dữ liệu của bạn';
			case 'backups.status.success': return 'Xong!';
			case 'backups.status.created': return 'Đã sao lưu thành công';
			case 'backups.status.createError': return ({required Object error}) => 'Lỗi: ${error}';
			case 'backups.status.restoreError': return ({required Object error}) => 'Lỗi: ${error}';
			case 'backups.status.deleteError': return ({required Object error}) => 'Lỗi: ${error}';
			case 'backups.actions.create': return 'Tạo bản sao lưu';
			case 'backups.actions.import': return 'Khôi phục từ file';
			case 'backups.actions.restore': return 'Phục hồi';
			case 'backups.actions.delete': return 'Xóa';
			case 'backups.actions.share': return 'Chia sẻ';
			case 'backups.actions.cancel': return 'Hủy';
			case 'backups.actions.retry': return 'Thử lại';
			case 'backups.actions.ok': return 'OK';
			case 'backups.dialogs.info.title': return 'Thông tin file';
			case 'backups.dialogs.info.file': return 'Tên:';
			case 'backups.dialogs.info.size': return 'Kích cỡ:';
			case 'backups.dialogs.info.created': return 'Ngày:';
			case 'backups.dialogs.info.transactions': return 'Giao dịch:';
			case 'backups.dialogs.restore.title': return 'Phục hồi dữ liệu';
			case 'backups.dialogs.restore.content': return ({required Object file}) => 'Chắc chắn phục hồi dữ liệu từ "${file}" chứ? App sẽ xóa dữ liệu hiện tại để thay thế.';
			case 'backups.dialogs.restore.success': return 'Đang phục hồi... App sẽ tự khởi động lại.';
			case 'backups.dialogs.delete.title': return 'Xóa file này';
			case 'backups.dialogs.delete.content': return ({required Object file}) => 'Sẽ xóa vĩnh viễn "${file}". Bạn chắc chứ?';
			case 'backups.dialogs.delete.success': return 'Đã xóa bay.';
			case 'backups.stats.title': return 'Thống kê';
			case 'backups.stats.totalBackups': return 'Tổng số';
			case 'backups.stats.totalSize': return 'Dung lượng';
			case 'backups.stats.oldest': return 'Cũ nhất';
			case 'backups.stats.latest': return 'Mới nhất';
			case 'backups.stats.autoBackupStatus': return 'Tự động sao lưu';
			case 'backups.stats.active': return 'Đang bật';
			case 'backups.stats.inactive': return 'Tắt';
			case 'backups.options.restore.title': return 'Phục hồi';
			case 'backups.options.restore.subtitle': return 'Thay thế dữ liệu bằng bản này';
			case 'backups.options.share.title': return 'Chia sẻ';
			case 'backups.options.share.subtitle': return 'Gửi file này cho máy khác';
			case 'backups.options.delete.title': return 'Xóa bỏ';
			case 'backups.options.delete.subtitle': return 'Hành động này không thể hoàn tác';
			case 'backups.options.latestBadge': return 'Mới nhất';
			case 'backups.options.latestFile': return 'Gần đây nhất';
			case 'backups.options.backupFile': return 'File backup';
			case 'backups.format.auto': return ({required Object date}) => 'Tự động - ${date}';
			case 'backups.format.manual': return ({required Object date}) => 'Thủ công - ${date}';
			case 'backups.format.initial': return 'Lần đầu tiên';
			case 'backups.format.generic': return ({required Object date}) => 'Bản sao - ${date}';
			case 'v2.voice.errorProcessing': return 'Lỗi rồi, không nghe rõ. Bạn nói lại nhé.';
			case 'v2.voice.tapMicrophone': return 'Chạm vào mic để nói chuyện';
			case 'v2.voice.listening': return 'Đang nghe...';
			case 'v2.voice.missingApiKey': return 'Bổ sung GEMINI_API_KEY vào .env để xài AI nha.';
			case 'v2.voice.aiError': return ({required Object error}) => 'Lỗi AI: ${error}';
			case 'v2.voice.cancel': return 'Thôi';
			case 'v2.voice.scan': return 'Quét';
			case 'v2.transactions.invalidAmount': return 'Ghi lộn số tiền rồi.';
			case 'v2.transactions.selectAccount': return 'Chi từ ví nào vậy?';
			case 'v2.transactions.selectCategory': return 'Mục nào đây?';
			case 'v2.transactions.errorCreatingCategory': return ({required Object error}) => 'Tạo danh mục bị lỗi: ${error}';
			case 'v2.transactions.error': return ({required Object error}) => 'Lỗi nè: ${error}';
			case 'v2.transactions.more': return 'Khác';
			case 'v2.transactions.expense': return 'Chi tiêu';
			case 'v2.transactions.income': return 'Thu nhập';
			case 'v2.transactions.deleteTransaction': return 'Bỏ giao dịch này nha?';
			case 'v2.transactions.cancel': return 'Hủy';
			case 'v2.transactions.delete': return 'Bỏ';
			case 'v2.transactions.yesterday': return 'Hôm qua';
			case 'v2.transactions.usedCategories': return 'HAY DÙNG';
			case 'v2.transactions.noTransactions': return 'Hôm nay chưa tiêu gì';
			case 'v2.transactions.recentActivity': return 'Vừa tiêu xong';
			case 'v2.transactions.searchTransaction': return 'Tìm xem đã tiêu gì...';
			case 'v2.transactions.date': return 'Hôm nào';
			case 'v2.transactions.wallet': return 'Bằng gì';
			case 'v2.transactions.transactionDeleted': return 'Đã xóa.';
			case 'v2.transactions.selectCategoryTitle': return 'Cho vào đâu?';
			case 'v2.transactions.searchCategory': return 'Tìm danh mục...';
			case 'v2.transactions.noCategoriesAvailable': return 'Trống rỗng';
			case 'v2.transactions.createNewCategory': return 'Tạo danh mục mới toanh';
			case 'v2.transactions.amount': return 'SỐ TIỀN';
			case 'v2.transactions.description': return 'TIÊU VÀO VIỆC';
			case 'v2.transactions.category': return 'DANH MỤC';
			case 'v2.transactions.addNote': return 'Thêm tí ghi chú...';
			case 'v2.transactions.today': return 'Hôm nay';
			case 'v2.transactions.editTransaction': return 'Chỉnh lại xíu';
			case 'v2.transactions.newTransaction': return 'Thêm Mới';
			case 'v2.transactions.selectWallet': return 'Từ ví nào';
			case 'v2.transactions.save': return 'Lưu lại';
			case 'v2.transactions.transactionUpdated': return 'Chỉnh sửa thành công.';
			case 'v2.transactions.transactionSaved': return 'Ok, đã lưu.';
			case 'v2.settings.title': return 'Cài đặt & Tùy chỉnh';
			case 'v2.settings.categories': return 'Danh mục chi';
			case 'v2.settings.wallets': return 'Các loại Ví';
			case 'v2.settings.language': return 'Ngôn ngữ';
			case 'v2.settings.currency': return 'Loại tiền';
			case 'v2.settings.contact': return 'Phản hồi lỗi';
			case 'v2.settings.legacyView': return 'Trở về bản cũ';
			case 'v2.settings.deleteCategory': return 'Xóa sổ danh mục này?';
			case 'v2.settings.deleteWallet': return 'Xóa ví này đi?';
			case 'v2.settings.cannotUndo': return 'Xóa là bay luôn, không cứu được đâu.';
			case 'v2.settings.deleteWalletWarning': return 'Nhớ là xóa ví thì các giao dịch trong đó đi tông theo nha.';
			case 'v2.settings.deleteError': return ({required Object error}) => 'Lỗi xóa: ${error}';
			case 'v2.settings.noCategoriesCreated': return 'Chưa có gì.\nTạo liền một cái đi.';
			case 'v2.settings.noWalletsCreated': return 'Chưa có ví nào.\nLàm sao xài app, tạo đi.';
			case 'v2.settings.walletDeleted': return 'Bay màu ví.';
			case 'v2.settings.cancel': return 'Từ từ đã';
			case 'v2.settings.delete': return 'Bay màu';
			case 'v2.settings.expenses': return 'Chi';
			case 'v2.settings.income': return 'Thu';
			case 'v2.settings.newWallet': return 'Ví mới';
			case 'v2.settings.editWallet': return 'Đổi thông tin';
			case 'v2.settings.walletName': return 'Tên ví';
			case 'v2.settings.saveWallet': return 'Lưu Ví';
			case 'v2.dashboard.greetingMorning': return 'Chào buổi sáng!';
			case 'v2.dashboard.totalBalance': return 'TIỀN CÒN LẠI';
			case 'v2.dashboard.dateFilters.thisMonth': return 'Tháng này';
			case 'v2.dashboard.dateFilters.lastMonth': return 'Tháng trước';
			case 'v2.dashboard.dateFilters.customRange': return 'Ngày khác...';
			case 'v2.dashboard.walletFilters.all': return 'Tất cả';
			case 'v2.dashboard.walletFilters.allWallets': return 'Gộp mọi ví';
			case 'v2.dashboard.background.title': return 'Đổi hình nền';
			case 'v2.dashboard.background.chooseFromGallery': return 'Lấy ảnh máy';
			case 'v2.dashboard.background.restoreDefault': return 'Về mặc định';
			case 'v2.dashboard.incomeExpense.income': return 'TỔNG THU';
			case 'v2.dashboard.incomeExpense.expenses': return 'TỔNG CHI';
			case 'v2.dashboard.gauge.exceeded': return 'VƯỢT NGÂN SÁCH';
			case 'v2.dashboard.gauge.spent': return 'ĐÃ CHI';
			case 'v2.dashboard.gauge.available': return 'ĐƯỢC CHI';
			case 'v2.dashboard.gauge.overdrawn': return 'CHÁY TÚI';
			case 'v2.dashboard.activityList.seeAll': return 'Tất cả';
			case 'v2.dashboard.activityList.newUi': return 'Giao diện Mới';
			case 'v2.dashboard.activityList.expensesByCategory': return 'Bạn đã tiêu vào đâu';
			case 'v2.dashboard.activityList.noRecentExpenses': return 'Chưa tốn đồng nào';
			case 'v2.dashboard.activityList.percentOfTotal': return ({required Object percent}) => '${percent}% của tổng chi';
			case 'v2.dashboard.activityList.topExpenses': return ({required Object count}) => 'Top ${count} tốn kém nhất';
			case 'v2.dashboard.activityList.others': return 'Các khoản khác';
			case 'v2.categories.title': return 'Danh mục';
			case 'v2.categories.searchPlaceholder': return 'Tìm kiếm...';
			case 'v2.categories.newCategory': return 'Tạo mới';
			case 'v2.categories.editCategory': return 'Chỉnh sửa';
			case 'v2.categories.noCategories': return 'Chưa có gì';
			case 'v2.categories.form.nameLabel': return 'Tên';
			case 'v2.categories.form.save': return 'Lưu';
			case 'v2.onboarding.buttons.start': return 'Bắt đầu luôn 🚀';
			case 'v2.onboarding.buttons.actionContinue': return 'Tiếp tục';
			case 'v2.onboarding.buttons.great': return 'Đỉnh!';
			case 'v2.onboarding.buttons.setGoal': return 'Đặt mục tiêu';
			case 'v2.onboarding.buttons.skip': return 'Bỏ qua';
			case 'v2.onboarding.splash.title1': return 'Sẽ thế nào nếu\nTrí tuệ nhân tạo (AI) ';
			case 'v2.onboarding.splash.title2': return 'quản lý tiền của bạn\ngiỏi hơn chính bạn?';
			case 'v2.onboarding.splash.benefit1': return 'Nhàn hạ hơn.';
			case 'v2.onboarding.splash.benefit2': return 'Rõ ràng hơn.';
			case 'v2.onboarding.splash.benefit3': return 'Thông minh hơn.';
			case 'v2.onboarding.expenseCategories.title1': return 'Món nào ngốn tiền của bạn nhiều nhất tháng?';
			case 'v2.onboarding.expenseCategories.subtitle': return 'Chọn tối đa 3 cái';
			case 'v2.onboarding.expenseCategories.diningOut': return 'Ăn nhà hàng';
			case 'v2.onboarding.expenseCategories.cravings': return 'Trà sữa / Ăn vặt';
			case 'v2.onboarding.expenseCategories.subscriptions': return 'Mua sắm / App';
			case 'v2.onboarding.expenseCategories.outings': return 'Đi chơi / Nhậu';
			case 'v2.onboarding.expenseCategories.shopping': return 'Chốt đơn lung tung';
			case 'v2.onboarding.expenseCategories.delivery': return 'Ship đồ ăn';
			case 'v2.onboarding.financialGoals.title': return 'Cái gì sẽ làm tài chính\ncủa bạn đổi đời ngay?';
			case 'v2.onboarding.financialGoals.subtitle': return 'Chọn một thôi nha';
			case 'v2.onboarding.financialGoals.trackMoney': return 'Chỉ cần biết tiền mình bay đi đâu';
			case 'v2.onboarding.financialGoals.spendLess': return 'Bớt mua đồ linh tinh lại';
			case 'v2.onboarding.financialGoals.lessStress': return 'Hết đau đầu vì tiền';
			case 'v2.onboarding.financialGoals.saveMoney': return 'Để ra được một khoản cho tương lai';
			case 'v2.onboarding.registrationMethod.title': return 'Bạn định ghi chép tiêu xài\nkiểu gì cho lẹ?';
			case 'v2.onboarding.registrationMethod.subtitle': return 'Cách nào dễ nhất';
			case 'v2.onboarding.registrationMethod.voice': return 'Chỉ cần nói vào máy';
			case 'v2.onboarding.registrationMethod.auto': return 'Tự quét báo cáo ngân hàng';
			case 'v2.onboarding.registrationMethod.write': return 'Tự tay gõ từng khoản';
			case 'v2.onboarding.registrationMethod.easy': return 'Miễn sao không lười là được';
			case 'v2.onboarding.aiAnalysis.loading.title': return 'ĐANG TÙY BIẾN MONEYT\nRIÊNG CHO BẠN';
			case 'v2.onboarding.aiAnalysis.loading.subtitle': return 'Đang phân tích';
			case 'v2.onboarding.aiAnalysis.loading.messages.0': return 'Đang soi thói quen chi tiêu...';
			case 'v2.onboarding.aiAnalysis.loading.messages.1': return 'Chuẩn bị các danh mục...';
			case 'v2.onboarding.aiAnalysis.loading.messages.2': return 'Tìm ra các lổ hổng xài hoang...';
			case 'v2.onboarding.aiAnalysis.loading.messages.3': return 'Lập kế hoạch hoàn hảo...';
			case 'v2.onboarding.aiAnalysis.showcase.title': return 'Phân tích xong rồi!';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.kDefault': return 'Tiền của bạn bay đi quá nhanh, có vẻ cách quản lý hiện tại không còn hiệu quả.';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.part2': return ' ngốn một đống tiền của bạn, và việc bạn muốn ';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.part3': return ' cho thấy đã đến lúc thay đổi cách làm.';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.categories.diningOut': return 'Đi ăn ngoài';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.categories.cravings': return 'Ăn vặt linh tinh';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.categories.subscriptions': return 'Đăng ký dịch vụ mạng';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.categories.outings': return 'Các buổi tiệc tùng';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.categories.shopping': return 'Nghiện chốt đơn';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.categories.delivery': return 'Tiền phí ship';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.intentions.trackMoney': return 'biết tiền đi đâu';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.intentions.spendLess': return 'giảm chi xài hoang';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.intentions.lessStress': return 'hết lo lắng về tiền';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.intentions.saveMoney': return 'ép bản thân tiết kiệm';
			case 'v2.onboarding.aiAnalysis.showcase.result.yourResult': return 'Theo thống kê';
			case 'v2.onboarding.aiAnalysis.showcase.result.average': return 'Mức bình thường';
			case 'v2.onboarding.aiAnalysis.showcase.result.messagePart1': return 'Bạn xài lố 68% ';
			case 'v2.onboarding.aiAnalysis.showcase.result.messagePart2': return 'nhiều hơn so với người bình thường ở mảng này, ';
			case 'v2.onboarding.aiAnalysis.showcase.result.messagePart3': return 'và nó đang phá nát\n';
			case 'v2.onboarding.aiAnalysis.showcase.result.messagePart4': return 'các dự định mua sắm to bự của bạn';
			case 'v2.onboarding.mainPriority.title': return 'Mục tiêu hàng đầu\ncủa bạn là gì?';
			case 'v2.onboarding.mainPriority.subtitle': return 'Chọn một thứ MoneyT cần giúp bạn nhất';
			case 'v2.onboarding.mainPriority.breakHabits': return 'Dẹp bỏ thói quen xài hoang';
			case 'v2.onboarding.mainPriority.stopStress': return 'Cuối tháng không bị stress';
			case 'v2.onboarding.mainPriority.buildFuture': return 'Làm giàu từ từ';
			case 'v2.onboarding.mainPriority.feelControl': return 'Nắm chắc dòng tiền trong tay';
			case 'v2.onboarding.mainPriority.saveGoal': return 'Tiết kiệm cho một món đồ cụ thể';
			case 'v2.onboarding.aiVoice.title.kDefault': return 'Hoàn thành mục tiêu';
			case 'v2.onboarding.aiVoice.title.breakHabits': return 'Dẹp ngay thói quen xấu';
			case 'v2.onboarding.aiVoice.title.stopStress': return 'Hết đau đầu vì tiền';
			case 'v2.onboarding.aiVoice.title.buildFuture': return 'Xây dựng sự nghiệp rủng rỉnh';
			case 'v2.onboarding.aiVoice.title.feelControl': return 'Làm chủ dòng tiền';
			case 'v2.onboarding.aiVoice.title.saveGoal': return 'Để dành tiền mua cái mình thích';
			case 'v2.onboarding.aiVoice.title.suffix': return ' nay cực nhàn vì có Trợ lý AI lo hết.';
			case 'v2.onboarding.aiVoice.subtitle': return 'Đừng bấm bấm nhập liệu nữa, cứ bấm mic và kể cho nó nghe';
			case 'v2.onboarding.aiVoice.listening': return 'Nói đi, mình đang nghe...';
			case 'v2.onboarding.aiVoice.examples.0': return 'Cà phê 35.000 ₫';
			case 'v2.onboarding.aiVoice.examples.1': return 'Grab 120.000 ₫';
			case 'v2.onboarding.aiVoice.examples.2': return 'Xem phim 150.000 ₫';
			case 'v2.onboarding.aiVoice.examples.3': return 'Siêu thị 450.000 ₫';
			case 'v2.onboarding.aiVoice.examples.4': return 'Đổ xăng 100.000 ₫';
			case 'v2.onboarding.aiVoice.examples.5': return 'Netflix 108.000 ₫';
			case 'v2.onboarding.aiVoice.examples.6': return 'Ăn tối 250.000 ₫';
			case 'v2.onboarding.aiVoice.examples.7': return 'Nhà thuốc 185.000 ₫';
			default: return null;
		}
	}
}

