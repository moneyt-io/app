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
class AppStringsId extends AppStrings {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	AppStringsId({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, AppStrings>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.id,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <id>.
	@override final TranslationMetadata<AppLocale, AppStrings> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final AppStringsId _root = this; // ignore: unused_field

	@override 
	AppStringsId $copyWith({TranslationMetadata<AppLocale, AppStrings>? meta}) => AppStringsId(meta: meta ?? this.$meta);

	// Translations
	@override late final _AppStringsAppId app = _AppStringsAppId._(_root);
	@override late final _AppStringsCommonId common = _AppStringsCommonId._(_root);
	@override late final _AppStringsComponentsId components = _AppStringsComponentsId._(_root);
	@override late final _AppStringsNavigationId navigation = _AppStringsNavigationId._(_root);
	@override late final _AppStringsTransactionsId transactions = _AppStringsTransactionsId._(_root);
	@override late final _AppStringsContactsId contacts = _AppStringsContactsId._(_root);
	@override late final _AppStringsErrorsId errors = _AppStringsErrorsId._(_root);
	@override late final _AppStringsSettingsId settings = _AppStringsSettingsId._(_root);
	@override late final _AppStringsOnboardingId onboarding = _AppStringsOnboardingId._(_root);
	@override late final _AppStringsDashboardId dashboard = _AppStringsDashboardId._(_root);
	@override late final _AppStringsWalletsId wallets = _AppStringsWalletsId._(_root);
	@override late final _AppStringsLoansId loans = _AppStringsLoansId._(_root);
	@override late final _AppStringsCategoriesId categories = _AppStringsCategoriesId._(_root);
	@override late final _AppStringsBackupsId backups = _AppStringsBackupsId._(_root);
	@override late final _AppStringsV2Id v2 = _AppStringsV2Id._(_root);
}

// Path: app
class _AppStringsAppId extends AppStringsAppEn {
	_AppStringsAppId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get name => 'MoneyT';
	@override String get description => 'Pengatur Keuangan';
}

// Path: common
class _AppStringsCommonId extends AppStringsCommonEn {
	_AppStringsCommonId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get save => 'Simpan';
	@override String get cancel => 'Batal';
	@override String get delete => 'Hapus';
	@override String get edit => 'Ubah';
	@override String get loading => 'Memuat...';
	@override String get error => 'Kesalahan';
	@override String get success => 'Berhasil';
	@override String get search => 'Cari';
	@override String get clearSearch => 'Hapus pencarian';
	@override String get viewAll => 'Lihat semua';
	@override String get retry => 'Coba lagi';
	@override String get add => 'Tambah';
	@override String get remove => 'Hapus';
	@override String get moreOptions => 'Opsi lainnya';
	@override String get addToFavorites => 'Tambah ke favorit';
	@override String get removeFromFavorites => 'Hapus dari favorit';
	@override String get today => 'Hari ini';
	@override String get yesterday => 'Kemarin';
}

// Path: components
class _AppStringsComponentsId extends AppStringsComponentsEn {
	_AppStringsComponentsId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override late final _AppStringsComponentsDateSelectionId dateSelection = _AppStringsComponentsDateSelectionId._(_root);
	@override late final _AppStringsComponentsSelectionId selection = _AppStringsComponentsSelectionId._(_root);
	@override late final _AppStringsComponentsContactSelectionId contactSelection = _AppStringsComponentsContactSelectionId._(_root);
	@override late final _AppStringsComponentsCategorySelectionId categorySelection = _AppStringsComponentsCategorySelectionId._(_root);
	@override late final _AppStringsComponentsCurrencySelectionId currencySelection = _AppStringsComponentsCurrencySelectionId._(_root);
	@override late final _AppStringsComponentsAccountSelectionId accountSelection = _AppStringsComponentsAccountSelectionId._(_root);
	@override late final _AppStringsComponentsParentWalletSelectionId parentWalletSelection = _AppStringsComponentsParentWalletSelectionId._(_root);
	@override late final _AppStringsComponentsWalletTypesId walletTypes = _AppStringsComponentsWalletTypesId._(_root);
}

// Path: navigation
class _AppStringsNavigationId extends AppStringsNavigationEn {
	_AppStringsNavigationId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get home => 'Beranda';
	@override String get transactions => 'Transaksi';
	@override String get contacts => 'Kontak';
	@override String get settings => 'Pengaturan';
	@override String get wallets => 'Dompet';
	@override String get categories => 'Kategori';
	@override String get loans => 'Pinjaman';
	@override String get charts => 'Bagan Akun';
	@override String get backups => 'Cadangan';
	@override String get creditCards => 'Kartu Kredit';
	@override late final _AppStringsNavigationSectionsId sections = _AppStringsNavigationSectionsId._(_root);
}

// Path: transactions
class _AppStringsTransactionsId extends AppStringsTransactionsEn {
	_AppStringsTransactionsId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Transaksi';
	@override late final _AppStringsTransactionsTypesId types = _AppStringsTransactionsTypesId._(_root);
	@override late final _AppStringsTransactionsFilterId filter = _AppStringsTransactionsFilterId._(_root);
	@override late final _AppStringsTransactionsFormId form = _AppStringsTransactionsFormId._(_root);
	@override late final _AppStringsTransactionsErrorsId errors = _AppStringsTransactionsErrorsId._(_root);
	@override late final _AppStringsTransactionsEmptyId empty = _AppStringsTransactionsEmptyId._(_root);
	@override late final _AppStringsTransactionsListId list = _AppStringsTransactionsListId._(_root);
	@override late final _AppStringsTransactionsDetailId detail = _AppStringsTransactionsDetailId._(_root);
	@override late final _AppStringsTransactionsShareId share = _AppStringsTransactionsShareId._(_root);
}

// Path: contacts
class _AppStringsContactsId extends AppStringsContactsEn {
	_AppStringsContactsId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Kontak';
	@override String get addContact => 'Tambah Kontak';
	@override String get editContact => 'Ubah Kontak';
	@override String get newContact => 'Kontak baru';
	@override String get noContacts => 'Belum ada kontak';
	@override String get noContactsMessage => 'Tambahkan kontak pertama Anda';
	@override String get searchContacts => 'Cari kontak';
	@override String get deleteContact => 'Hapus';
	@override String get confirmDelete => 'Anda yakin ingin menghapus';
	@override String get contactDeleted => 'Berhasil dihapus';
	@override String get errorDeleting => 'Gagal menghapus';
	@override String get noSearchResults => 'Tidak ditemukan';
	@override String noContactsMatch({required Object query}) => 'Tidak ada kecocokan dengan "${query}".';
	@override String get errorLoading => 'Gagal memuat kontak';
	@override String get contactSaved => 'Berhasil disimpan';
	@override String get errorSaving => 'Gagal menyimpan';
	@override String get noContactInfo => 'Tidak ada info kontak';
	@override String get importContact => 'Impor kontak';
	@override String get importContacts => 'Impor banyak kontak';
	@override String get importContactSoon => 'Akan segera hadir';
	@override late final _AppStringsContactsFieldsId fields = _AppStringsContactsFieldsId._(_root);
	@override late final _AppStringsContactsPlaceholdersId placeholders = _AppStringsContactsPlaceholdersId._(_root);
	@override late final _AppStringsContactsValidationId validation = _AppStringsContactsValidationId._(_root);
}

// Path: errors
class _AppStringsErrorsId extends AppStringsErrorsEn {
	_AppStringsErrorsId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String loadingAccounts({required Object error}) => 'Gagal memuat akun: ${error}';
	@override String get unexpected => 'Kesalahan tak terduga';
}

// Path: settings
class _AppStringsSettingsId extends AppStringsSettingsEn {
	_AppStringsSettingsId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Pengaturan';
	@override late final _AppStringsSettingsAccountId account = _AppStringsSettingsAccountId._(_root);
	@override late final _AppStringsSettingsAppearanceId appearance = _AppStringsSettingsAppearanceId._(_root);
	@override late final _AppStringsSettingsDataId data = _AppStringsSettingsDataId._(_root);
	@override late final _AppStringsSettingsInfoId info = _AppStringsSettingsInfoId._(_root);
	@override late final _AppStringsSettingsLogoutId logout = _AppStringsSettingsLogoutId._(_root);
	@override late final _AppStringsSettingsSocialId social = _AppStringsSettingsSocialId._(_root);
	@override late final _AppStringsSettingsLanguageId language = _AppStringsSettingsLanguageId._(_root);
	@override late final _AppStringsSettingsCurrencyId currency = _AppStringsSettingsCurrencyId._(_root);
	@override late final _AppStringsSettingsMessagesId messages = _AppStringsSettingsMessagesId._(_root);
}

// Path: onboarding
class _AppStringsOnboardingId extends AppStringsOnboardingEn {
	_AppStringsOnboardingId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override late final _AppStringsOnboardingWelcomeId welcome = _AppStringsOnboardingWelcomeId._(_root);
	@override late final _AppStringsOnboardingProblemStatementId problemStatement = _AppStringsOnboardingProblemStatementId._(_root);
	@override late final _AppStringsOnboardingSpecificProblemId specificProblem = _AppStringsOnboardingSpecificProblemId._(_root);
	@override late final _AppStringsOnboardingPersonalGoalId personalGoal = _AppStringsOnboardingPersonalGoalId._(_root);
	@override late final _AppStringsOnboardingSolutionPreviewId solutionPreview = _AppStringsOnboardingSolutionPreviewId._(_root);
	@override late final _AppStringsOnboardingCurrentMethodId currentMethod = _AppStringsOnboardingCurrentMethodId._(_root);
	@override late final _AppStringsOnboardingFeaturesShowcaseId featuresShowcase = _AppStringsOnboardingFeaturesShowcaseId._(_root);
	@override late final _AppStringsOnboardingCompleteId complete = _AppStringsOnboardingCompleteId._(_root);
	@override late final _AppStringsOnboardingButtonsId buttons = _AppStringsOnboardingButtonsId._(_root);
}

// Path: dashboard
class _AppStringsDashboardId extends AppStringsDashboardEn {
	_AppStringsDashboardId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get greeting => 'Halo!';
	@override late final _AppStringsDashboardBalanceId balance = _AppStringsDashboardBalanceId._(_root);
	@override late final _AppStringsDashboardActionsId actions = _AppStringsDashboardActionsId._(_root);
	@override late final _AppStringsDashboardWalletsId wallets = _AppStringsDashboardWalletsId._(_root);
	@override late final _AppStringsDashboardTransactionsId transactions = _AppStringsDashboardTransactionsId._(_root);
	@override String get customize => 'Sesuaikan';
	@override late final _AppStringsDashboardWidgetsId widgets = _AppStringsDashboardWidgetsId._(_root);
}

// Path: wallets
class _AppStringsWalletsId extends AppStringsWalletsEn {
	_AppStringsWalletsId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Dompet';
	@override late final _AppStringsWalletsEmptyId empty = _AppStringsWalletsEmptyId._(_root);
	@override late final _AppStringsWalletsEmptyArchivedId emptyArchived = _AppStringsWalletsEmptyArchivedId._(_root);
	@override late final _AppStringsWalletsFilterId filter = _AppStringsWalletsFilterId._(_root);
	@override late final _AppStringsWalletsFormId form = _AppStringsWalletsFormId._(_root);
	@override late final _AppStringsWalletsDeleteId delete = _AppStringsWalletsDeleteId._(_root);
	@override late final _AppStringsWalletsErrorsId errors = _AppStringsWalletsErrorsId._(_root);
	@override late final _AppStringsWalletsSubtitleId subtitle = _AppStringsWalletsSubtitleId._(_root);
	@override late final _AppStringsWalletsOptionsId options = _AppStringsWalletsOptionsId._(_root);
}

// Path: loans
class _AppStringsLoansId extends AppStringsLoansEn {
	_AppStringsLoansId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Pinjaman';
	@override late final _AppStringsLoansFilterId filter = _AppStringsLoansFilterId._(_root);
	@override late final _AppStringsLoansSummaryId summary = _AppStringsLoansSummaryId._(_root);
	@override late final _AppStringsLoansCardId card = _AppStringsLoansCardId._(_root);
	@override late final _AppStringsLoansFormId form = _AppStringsLoansFormId._(_root);
	@override late final _AppStringsLoansDetailId detail = _AppStringsLoansDetailId._(_root);
	@override late final _AppStringsLoansHistoryId history = _AppStringsLoansHistoryId._(_root);
	@override late final _AppStringsLoansContactDetailId contactDetail = _AppStringsLoansContactDetailId._(_root);
	@override late final _AppStringsLoansShareId share = _AppStringsLoansShareId._(_root);
	@override late final _AppStringsLoansPaymentId payment = _AppStringsLoansPaymentId._(_root);
	@override String get given => 'Diberikan';
	@override String get received => 'Diterima';
	@override late final _AppStringsLoansItemId item = _AppStringsLoansItemId._(_root);
	@override late final _AppStringsLoansSectionId section = _AppStringsLoansSectionId._(_root);
	@override late final _AppStringsLoansEmptyId empty = _AppStringsLoansEmptyId._(_root);
}

// Path: categories
class _AppStringsCategoriesId extends AppStringsCategoriesEn {
	_AppStringsCategoriesId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Kategori';
	@override late final _AppStringsCategoriesFormId form = _AppStringsCategoriesFormId._(_root);
	@override late final _AppStringsCategoriesParentSelectionId parentSelection = _AppStringsCategoriesParentSelectionId._(_root);
	@override String get incomeCategory => 'Kategori Pemasukan';
	@override String get expenseCategory => 'Kategori Pengeluaran';
	@override late final _AppStringsCategoriesReportId report = _AppStringsCategoriesReportId._(_root);
}

// Path: backups
class _AppStringsBackupsId extends AppStringsBackupsEn {
	_AppStringsBackupsId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Cadangan Data';
	@override late final _AppStringsBackupsMenuId menu = _AppStringsBackupsMenuId._(_root);
	@override late final _AppStringsBackupsFiltersId filters = _AppStringsBackupsFiltersId._(_root);
	@override late final _AppStringsBackupsStatusId status = _AppStringsBackupsStatusId._(_root);
	@override late final _AppStringsBackupsActionsId actions = _AppStringsBackupsActionsId._(_root);
	@override late final _AppStringsBackupsDialogsId dialogs = _AppStringsBackupsDialogsId._(_root);
	@override late final _AppStringsBackupsStatsId stats = _AppStringsBackupsStatsId._(_root);
	@override late final _AppStringsBackupsOptionsId options = _AppStringsBackupsOptionsId._(_root);
	@override late final _AppStringsBackupsFormatId format = _AppStringsBackupsFormatId._(_root);
}

// Path: v2
class _AppStringsV2Id extends AppStringsV2En {
	_AppStringsV2Id._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override late final _AppStringsV2VoiceId voice = _AppStringsV2VoiceId._(_root);
	@override late final _AppStringsV2TransactionsId transactions = _AppStringsV2TransactionsId._(_root);
	@override late final _AppStringsV2SettingsId settings = _AppStringsV2SettingsId._(_root);
	@override late final _AppStringsV2DashboardId dashboard = _AppStringsV2DashboardId._(_root);
	@override late final _AppStringsV2CategoriesId categories = _AppStringsV2CategoriesId._(_root);
	@override late final _AppStringsV2OnboardingId onboarding = _AppStringsV2OnboardingId._(_root);
}

// Path: components.dateSelection
class _AppStringsComponentsDateSelectionId extends AppStringsComponentsDateSelectionEn {
	_AppStringsComponentsDateSelectionId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Pilih tanggal';
	@override String get subtitle => 'Pilih tanggal transaksi';
	@override String get selectedDate => 'Tanggal dipilih';
	@override String get confirm => 'Konfirmasi';
}

// Path: components.selection
class _AppStringsComponentsSelectionId extends AppStringsComponentsSelectionEn {
	_AppStringsComponentsSelectionId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Batal';
	@override String get confirm => 'Konfirmasi';
	@override String get select => 'Pilih';
}

// Path: components.contactSelection
class _AppStringsComponentsContactSelectionId extends AppStringsComponentsContactSelectionEn {
	_AppStringsComponentsContactSelectionId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Pilih kontak';
	@override String get subtitle => 'Dengan siapa transaksi ini';
	@override String get searchPlaceholder => 'Cari kontak';
	@override String get noContact => 'Tanpa kontak';
	@override String get noContactDetails => 'Transaksi tanpa kontak';
	@override String get allContacts => 'Semua kontak';
	@override String get create => 'Buat kontak baru';
}

// Path: components.categorySelection
class _AppStringsComponentsCategorySelectionId extends AppStringsComponentsCategorySelectionEn {
	_AppStringsComponentsCategorySelectionId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Pilih kategori';
	@override String get subtitle => 'Pilih kategori transaksi ini';
	@override String get searchPlaceholder => 'Cari kategori';
}

// Path: components.currencySelection
class _AppStringsComponentsCurrencySelectionId extends AppStringsComponentsCurrencySelectionEn {
	_AppStringsComponentsCurrencySelectionId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Pilih mata uang';
	@override String get subtitle => 'Pilih mata uang';
	@override String get searchPlaceholder => 'Cari mata uang';
}

// Path: components.accountSelection
class _AppStringsComponentsAccountSelectionId extends AppStringsComponentsAccountSelectionEn {
	_AppStringsComponentsAccountSelectionId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Pilih akun';
	@override String get subtitle => 'Pilih akun untuk transaksi ini';
	@override String get searchPlaceholder => 'Cari akun';
	@override String get wallets => 'Dompet';
	@override String get creditCards => 'Kartu Kredit';
	@override String get selectAccount => 'Pilih akun';
	@override String get confirm => 'Konfirmasi';
}

// Path: components.parentWalletSelection
class _AppStringsComponentsParentWalletSelectionId extends AppStringsComponentsParentWalletSelectionEn {
	_AppStringsComponentsParentWalletSelectionId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Dompet utama';
	@override String get subtitle => 'Pilih dompet utama';
	@override String get searchPlaceholder => 'Cari dompet';
	@override String get noParent => 'Tidak ada dompet utama';
	@override String get createRoot => 'Buat sebagai utama';
	@override String get available => 'Dompet Tersedia';
}

// Path: components.walletTypes
class _AppStringsComponentsWalletTypesId extends AppStringsComponentsWalletTypesEn {
	_AppStringsComponentsWalletTypesId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get checking => 'Rekening Giro';
	@override String get savings => 'Tabungan';
	@override String get cash => 'Uang Tunai';
	@override String get creditCard => 'Kartu Kredit';
}

// Path: navigation.sections
class _AppStringsNavigationSectionsId extends AppStringsNavigationSectionsEn {
	_AppStringsNavigationSectionsId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get operations => 'OPERASI';
	@override String get financialTools => 'ALAT KEUANGAN';
	@override String get management => 'MANAJEMEN';
	@override String get advanced => 'LANJUTAN';
}

// Path: transactions.types
class _AppStringsTransactionsTypesId extends AppStringsTransactionsTypesEn {
	_AppStringsTransactionsTypesId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get all => 'Semua';
	@override String get income => 'Pemasukan';
	@override String get expense => 'Pengeluaran';
	@override String get transfer => 'Transfer';
}

// Path: transactions.filter
class _AppStringsTransactionsFilterId extends AppStringsTransactionsFilterEn {
	_AppStringsTransactionsFilterId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Saring Transaksi';
	@override String get date => 'Tanggal';
	@override String get categories => 'Kategori';
	@override String get accounts => 'Akun';
	@override String get contacts => 'Kontak';
	@override String get amount => 'Jumlah';
	@override String get apply => 'Terapkan';
	@override String get clear => 'Bersihkan filter';
	@override String get add => 'Tambah filter';
	@override String get minAmount => 'Jumlah Min';
	@override String get maxAmount => 'Jumlah Max';
	@override String get selectDate => 'Pilih tanggal';
	@override String get selectCategory => 'Pilih kategori';
	@override String get selectAccount => 'Pilih akun';
	@override String get selectContact => 'Pilih kontak';
	@override String get quickFilters => 'Filter cepat';
	@override late final _AppStringsTransactionsFilterRangesId ranges = _AppStringsTransactionsFilterRangesId._(_root);
	@override String get customRange => 'Kustom';
	@override String get startDate => 'Tanggal Mulai';
	@override String get endDate => 'Tanggal Selesai';
	@override String get active => 'Filter Aktif';
	@override late final _AppStringsTransactionsFilterSubtitlesId subtitles = _AppStringsTransactionsFilterSubtitlesId._(_root);
}

// Path: transactions.form
class _AppStringsTransactionsFormId extends AppStringsTransactionsFormEn {
	_AppStringsTransactionsFormId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get newTitle => 'Transaksi Baru';
	@override String get editTitle => 'Ubah Transaksi';
	@override String get amount => 'Jumlah';
	@override String get type => 'Jenis transaksi';
	@override String get amountRequired => 'Jumlah wajib diisi';
	@override String get date => 'Tanggal';
	@override String get account => 'Akun';
	@override String get toAccount => 'Ke Akun';
	@override String get category => 'Kategori';
	@override String get contact => 'Kontak';
	@override String get contactOptional => 'Kontak (opsional)';
	@override String get description => 'Keterangan';
	@override String get descriptionOptional => 'Keterangan (opsional)';
	@override String get selectAccount => 'Pilih akun';
	@override String get selectDestination => 'Pilih tujuan';
	@override String get selectCategory => 'Pilih kategori';
	@override String get selectContact => 'Pilih kontak';
	@override String get saveSuccess => 'Transaksi berhasil disimpan';
	@override String get updateSuccess => 'Transaksi berhasil diubah';
	@override String get saveError => 'Gagal menyimpan transaksi';
	@override String get share => 'Bagikan';
	@override String get created => 'Transaksi berhasil dibuat';
	@override String get crossCurrencyConversion => 'Konversi mata uang';
	@override String get receivedAmount => 'Jumlah diterima';
	@override String get exchangeRate => 'Nilai tukar';
	@override String get receivedAmountRequired => 'Masukkan jumlah diterima';
	@override String exchangeRateLabel({required Object from, required Object rate, required Object to}) => '1 ${from} = ${rate} ${to}';
}

// Path: transactions.errors
class _AppStringsTransactionsErrorsId extends AppStringsTransactionsErrorsEn {
	_AppStringsTransactionsErrorsId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get load => 'Gagal memuat transaksi';
}

// Path: transactions.empty
class _AppStringsTransactionsEmptyId extends AppStringsTransactionsEmptyEn {
	_AppStringsTransactionsEmptyId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tidak ada transaksi';
	@override String get message => 'Tidak ada transaksi yang sesuai';
	@override String get clearFilters => 'Bersihkan filter';
}

// Path: transactions.list
class _AppStringsTransactionsListId extends AppStringsTransactionsListEn {
	_AppStringsTransactionsListId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String count({required Object n}) => '${n} transaksi';
}

// Path: transactions.detail
class _AppStringsTransactionsDetailId extends AppStringsTransactionsDetailEn {
	_AppStringsTransactionsDetailId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Detail Transaksi';
	@override String get delete => 'Hapus Transaksi';
	@override String get deleteConfirmation => 'Anda yakin? Ini tidak dapat dikembalikan.';
	@override String get deleted => 'Transaksi dihapus';
	@override String get duplicate => 'Duplikat';
	@override String get duplicateNotImplemented => 'Duplikat belum tersedia';
	@override String get edit => 'Ubah';
	@override String get errorLoad => 'Gagal memuat detail';
	@override String errorPrepareEdit({required Object error}) => 'Error: ${error}';
	@override String errorDelete({required Object error}) => 'Error: ${error}';
	@override String get category => 'Kategori';
	@override String get account => 'Akun';
	@override String get contact => 'Kontak';
	@override String get description => 'Keterangan';
	@override String get transferDetails => 'Detail Transfer';
	@override String get from => 'Dari';
	@override String get to => 'Ke';
	@override String get unknownAccount => 'Akun Tidak Dikenal';
	@override String errorUrl({required Object url}) => 'Tidak dapat membuka ${url}';
	@override String get date => 'Tanggal';
	@override String get time => 'Waktu';
	@override String get loanLinkedWarning => 'Transaksi ini terkait dengan pinjaman dan diatur secara otomatis.';
}

// Path: transactions.share
class _AppStringsTransactionsShareId extends AppStringsTransactionsShareEn {
	_AppStringsTransactionsShareId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Bagikan';
	@override String get copyText => 'Salin Teks';
	@override String get shareButton => 'Bagikan';
	@override String get shareMessage => 'Berikut bukti transaksi saya:';
	@override String get copied => 'Berhasil disalin ke papan klip!';
	@override String get paymentMethod => 'Metode Pembayaran';
	@override String get receiptTitle => 'Bukti Transaksi';
	@override String get poweredBy => 'Didukung oleh MoneyT • moneyt.io';
	@override String errorImage({required Object error}) => 'Gagal: ${error}';
	@override late final _AppStringsTransactionsShareReceiptId receipt = _AppStringsTransactionsShareReceiptId._(_root);
	@override String generatedOn({required Object date}) => 'Dibuat pada ${date}';
}

// Path: contacts.fields
class _AppStringsContactsFieldsId extends AppStringsContactsFieldsEn {
	_AppStringsContactsFieldsId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get name => 'Nama';
	@override String get fullName => 'Nama lengkap';
	@override String get email => 'Email';
	@override String get phone => 'Telepon';
	@override String get address => 'Alamat';
	@override String get notes => 'Catatan';
}

// Path: contacts.placeholders
class _AppStringsContactsPlaceholdersId extends AppStringsContactsPlaceholdersEn {
	_AppStringsContactsPlaceholdersId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get enterFullName => 'Masukkan nama lengkap';
	@override String get enterPhone => 'Masukkan nomor';
	@override String get enterEmail => 'Masukkan email';
}

// Path: contacts.validation
class _AppStringsContactsValidationId extends AppStringsContactsValidationEn {
	_AppStringsContactsValidationId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get nameRequired => 'Nama wajib diisi';
	@override String get invalidEmail => 'Email tidak valid';
	@override String get invalidPhone => 'Nomor tidak valid';
}

// Path: settings.account
class _AppStringsSettingsAccountId extends AppStringsSettingsAccountEn {
	_AppStringsSettingsAccountId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Akun';
	@override String get profile => 'Profil';
	@override String get profileSubtitle => 'Kelola informasi akun';
}

// Path: settings.appearance
class _AppStringsSettingsAppearanceId extends AppStringsSettingsAppearanceEn {
	_AppStringsSettingsAppearanceId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tampilan';
	@override String get darkMode => 'Mode gelap';
	@override String get darkModeSubtitle => 'Gunakan tema gelap';
	@override String get language => 'Bahasa';
	@override String get currency => 'Mata Uang Utama';
	@override String get currencySubtitle => 'Mata uang default untuk akun baru';
	@override String get darkTheme => 'Tema Gelap';
	@override String get lightTheme => 'Tema Terang';
	@override String get systemTheme => 'Tema Sistem';
}

// Path: settings.data
class _AppStringsSettingsDataId extends AppStringsSettingsDataEn {
	_AppStringsSettingsDataId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Data & Penyimpanan';
	@override String get backup => 'Cadangan Data';
	@override String get backupSubtitle => 'Kelola pencadangan Anda';
}

// Path: settings.info
class _AppStringsSettingsInfoId extends AppStringsSettingsInfoEn {
	_AppStringsSettingsInfoId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Informasi';
	@override String get contact => 'Kontak & Media Sosial';
	@override String get contactSubtitle => 'Hubungi kami atau ikuti komunitas';
	@override String get privacy => 'Kebijakan Privasi';
	@override String get privacySubtitle => 'Baca kebijakan kami';
	@override String get share => 'Bagikan MoneyT';
	@override String get shareSubtitle => 'Rekomendasikan ke teman';
}

// Path: settings.logout
class _AppStringsSettingsLogoutId extends AppStringsSettingsLogoutEn {
	_AppStringsSettingsLogoutId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get button => 'Keluar';
	@override String get dialogTitle => 'Keluar';
	@override String get dialogMessage => 'Anda yakin ingin keluar dari akun?';
	@override String get cancel => 'Batal';
	@override String get confirm => 'Keluar';
}

// Path: settings.social
class _AppStringsSettingsSocialId extends AppStringsSettingsSocialEn {
	_AppStringsSettingsSocialId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Kontak dan Sosial';
	@override String get follow => 'Ikuti MoneyT';
	@override String get description => 'Tetap terhubung dengan pembaruan.';
	@override String get networks => 'Media Sosial';
	@override String get github => 'GitHub';
	@override String get githubSubtitle => 'Lihat kode sumber';
	@override String get linkedin => 'LinkedIn';
	@override String get linkedinSubtitle => 'Berita profesional';
	@override String get twitter => 'X (Twitter)';
	@override String get twitterSubtitle => 'Pembaruan langsung';
	@override String get reddit => 'Reddit';
	@override String get redditSubtitle => 'Komunitas';
	@override String get discord => 'Discord';
	@override String get discordSubtitle => 'Obrolan komunitas';
	@override String get contact => 'Dukungan';
	@override String get email => 'Kirim Email';
	@override String get website => 'Situs Web Resmi';
}

// Path: settings.language
class _AppStringsSettingsLanguageId extends AppStringsSettingsLanguageEn {
	_AppStringsSettingsLanguageId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Bahasa';
	@override String get available => 'BAHASA TERSEDIA';
	@override String get apply => 'Terapkan Bahasa';
}

// Path: settings.currency
class _AppStringsSettingsCurrencyId extends AppStringsSettingsCurrencyEn {
	_AppStringsSettingsCurrencyId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Mata Uang';
	@override String get available => 'MATA UANG';
	@override String get apply => 'Terapkan';
}

// Path: settings.messages
class _AppStringsSettingsMessagesId extends AppStringsSettingsMessagesEn {
	_AppStringsSettingsMessagesId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get profileComingSoon => 'Profil akan segera hadir';
	@override String get privacyError => 'Tidak dapat membuka kebijakan privasi';
	@override String get logoutComingSoon => 'Fitur keluar segera hadir';
}

// Path: onboarding.welcome
class _AppStringsOnboardingWelcomeId extends AppStringsOnboardingWelcomeEn {
	_AppStringsOnboardingWelcomeId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Selamat Datang di MoneyT 👋';
	@override String get subtitle => 'Kendalikan keuanganmu dalam hitungan menit ✨';
}

// Path: onboarding.problemStatement
class _AppStringsOnboardingProblemStatementId extends AppStringsOnboardingProblemStatementEn {
	_AppStringsOnboardingProblemStatementId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Merasa uang cepat habis tanpa jejak?';
	@override String get subtitle => 'Kamu tidak sendirian. 70% orang tidak tahu ke mana uang mereka pergi.';
}

// Path: onboarding.specificProblem
class _AppStringsOnboardingSpecificProblemId extends AppStringsOnboardingSpecificProblemEn {
	_AppStringsOnboardingSpecificProblemId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Apa masalah terbesarmu saat ini?';
	@override late final _AppStringsOnboardingSpecificProblemOptionsId options = _AppStringsOnboardingSpecificProblemOptionsId._(_root);
}

// Path: onboarding.personalGoal
class _AppStringsOnboardingPersonalGoalId extends AppStringsOnboardingPersonalGoalEn {
	_AppStringsOnboardingPersonalGoalId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Apa fokus utamamu?';
	@override late final _AppStringsOnboardingPersonalGoalOptionsId options = _AppStringsOnboardingPersonalGoalOptionsId._(_root);
}

// Path: onboarding.solutionPreview
class _AppStringsOnboardingSolutionPreviewId extends AppStringsOnboardingSolutionPreviewEn {
	_AppStringsOnboardingSolutionPreviewId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'MoneyT memberikan kejelasan';
	@override String get subtitle => 'Pantau semua akun, utang, dan pengeluaran di satu tempat. Gak perlu Excel lagi.';
	@override late final _AppStringsOnboardingSolutionPreviewBenefitsId benefits = _AppStringsOnboardingSolutionPreviewBenefitsId._(_root);
}

// Path: onboarding.currentMethod
class _AppStringsOnboardingCurrentMethodId extends AppStringsOnboardingCurrentMethodEn {
	_AppStringsOnboardingCurrentMethodId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Bagaimana kamu mengatur uang saat ini?';
	@override String get subtitle => 'Pilih yang paling mirip denganmu.';
	@override late final _AppStringsOnboardingCurrentMethodOptionsId options = _AppStringsOnboardingCurrentMethodOptionsId._(_root);
}

// Path: onboarding.featuresShowcase
class _AppStringsOnboardingFeaturesShowcaseId extends AppStringsOnboardingFeaturesShowcaseEn {
	_AppStringsOnboardingFeaturesShowcaseId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Fitur saat ini dan yang akan datang ✨';
	@override String get subtitle => 'Sudah siap dipakai, dengan lebih banyak fitur sedang dibuat.';
	@override String get available => 'SUDAH TERSEDIA';
	@override String get comingSoon => 'SEGERA HADIR';
	@override late final _AppStringsOnboardingFeaturesShowcaseFeaturesId features = _AppStringsOnboardingFeaturesShowcaseFeaturesId._(_root);
}

// Path: onboarding.complete
class _AppStringsOnboardingCompleteId extends AppStringsOnboardingCompleteEn {
	_AppStringsOnboardingCompleteId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Siap meluncur! 🚀';
	@override String get subtitle => 'Catat pengeluaran pertamamu dan lihat perubahannya 📈';
	@override late final _AppStringsOnboardingCompleteStatsId stats = _AppStringsOnboardingCompleteStatsId._(_root);
}

// Path: onboarding.buttons
class _AppStringsOnboardingButtonsId extends AppStringsOnboardingButtonsEn {
	_AppStringsOnboardingButtonsId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get start => 'Mulai sekarang 🚀';
	@override String get fixIt => 'Ayo beresin hari ini ⚡';
	@override String get actionContinue => 'Lanjut';
	@override String get setGoal => 'Tentukan Target 🎯';
	@override String get wantControl => 'Gue mau kendali ini!';
	@override String get great => 'Mantap, lanjut!';
	@override String get firstTransaction => 'Catat transaksi pertama ➕';
	@override String get skip => 'Lewati';
}

// Path: dashboard.balance
class _AppStringsDashboardBalanceId extends AppStringsDashboardBalanceEn {
	_AppStringsDashboardBalanceId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get total => 'TOTAL SALDO';
	@override String get income => 'PEMASUKAN';
	@override String get expenses => 'PENGELUARAN';
	@override String get thisMonth => 'bulan ini';
}

// Path: dashboard.actions
class _AppStringsDashboardActionsId extends AppStringsDashboardActionsEn {
	_AppStringsDashboardActionsId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get income => 'Pemasukan';
	@override String get expense => 'Pengeluaran';
	@override String get transfer => 'Transfer';
	@override String get all => 'Semua';
}

// Path: dashboard.wallets
class _AppStringsDashboardWalletsId extends AppStringsDashboardWalletsEn {
	_AppStringsDashboardWalletsId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Dompet';
	@override String count({required Object n}) => '${n} akun';
	@override String more({required Object n}) => '+${n} lainnya';
	@override String viewDetails({required Object name}) => 'Lihat detail ${name}';
}

// Path: dashboard.transactions
class _AppStringsDashboardTransactionsId extends AppStringsDashboardTransactionsEn {
	_AppStringsDashboardTransactionsId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Transaksi Terakhir';
	@override String get subtitle => '5 transaksi terbaru';
	@override String get empty => 'Belum ada transaksi';
	@override String get emptySubtitle => 'Transaksi barumu akan muncul di sini';
	@override String more({required Object n}) => '+${n} lagi';
}

// Path: dashboard.widgets
class _AppStringsDashboardWidgetsId extends AppStringsDashboardWidgetsEn {
	_AppStringsDashboardWidgetsId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override late final _AppStringsDashboardWidgetsBalanceId balance = _AppStringsDashboardWidgetsBalanceId._(_root);
	@override late final _AppStringsDashboardWidgetsQuickActionsId quickActions = _AppStringsDashboardWidgetsQuickActionsId._(_root);
	@override late final _AppStringsDashboardWidgetsWalletsId wallets = _AppStringsDashboardWidgetsWalletsId._(_root);
	@override late final _AppStringsDashboardWidgetsLoansId loans = _AppStringsDashboardWidgetsLoansId._(_root);
	@override late final _AppStringsDashboardWidgetsTransactionsId transactions = _AppStringsDashboardWidgetsTransactionsId._(_root);
	@override late final _AppStringsDashboardWidgetsCategoryBreakdownId categoryBreakdown = _AppStringsDashboardWidgetsCategoryBreakdownId._(_root);
	@override late final _AppStringsDashboardWidgetsChartAccountsId chartAccounts = _AppStringsDashboardWidgetsChartAccountsId._(_root);
	@override late final _AppStringsDashboardWidgetsCreditCardsId creditCards = _AppStringsDashboardWidgetsCreditCardsId._(_root);
	@override late final _AppStringsDashboardWidgetsSettingsId settings = _AppStringsDashboardWidgetsSettingsId._(_root);
}

// Path: wallets.empty
class _AppStringsWalletsEmptyId extends AppStringsWalletsEmptyEn {
	_AppStringsWalletsEmptyId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tidak ada dompet';
	@override String get message => 'Buat dompet pertamamu untuk mulai melacak uang.';
	@override String get action => 'Buat Dompet';
}

// Path: wallets.emptyArchived
class _AppStringsWalletsEmptyArchivedId extends AppStringsWalletsEmptyArchivedEn {
	_AppStringsWalletsEmptyArchivedId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tidak ada yang diarsipkan';
	@override String get message => 'Dompet yang diarsipkan akan muncul di sini.';
}

// Path: wallets.filter
class _AppStringsWalletsFilterId extends AppStringsWalletsFilterEn {
	_AppStringsWalletsFilterId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get active => 'Aktif';
	@override String get archived => 'Diarsipkan';
	@override String get all => 'Semua';
}

// Path: wallets.form
class _AppStringsWalletsFormId extends AppStringsWalletsFormEn {
	_AppStringsWalletsFormId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get newTitle => 'Dompet Baru';
	@override String get editTitle => 'Ubah Dompet';
	@override String get name => 'Nama dompet';
	@override String get namePlaceholder => 'Contoh: BCA, OVO, Dompet Tunai';
	@override String get nameRequired => 'Nama wajib diisi';
	@override String get description => 'Keterangan';
	@override String get descriptionPlaceholder => 'Untuk apa dompet ini? (opsional)';
	@override String get currency => 'Mata uang';
	@override String get currencyLockedByParent => 'Terkunci pada dompet utama';
	@override String get parent => 'Dompet Induk (opsional)';
	@override String get parentEmpty => 'Tidak ada dompet induk';
	@override String get chartAccount => 'Bagan akun';
	@override String get chartAccountLocked => 'Tidak dapat diubah';
	@override String get createSuccess => 'Dompet berhasil dibuat';
	@override String get updateSuccess => 'Berhasil diubah';
	@override String loadParentError({required Object error}) => 'Error: ${error}';
	@override String loadChartAccountError({required Object error}) => 'Error: ${error}';
}

// Path: wallets.delete
class _AppStringsWalletsDeleteId extends AppStringsWalletsDeleteEn {
	_AppStringsWalletsDeleteId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get dialogTitle => 'Hapus Dompet';
	@override String dialogMessage({required Object name}) => 'Kamu yakin? ${name} dan seluruh isinya akan dihapus permanen.';
	@override String get cancel => 'Batal';
	@override String get confirm => 'Hapus';
	@override String get success => 'Dompet dihapus';
	@override String error({required Object error}) => 'Gagal: ${error}';
}

// Path: wallets.errors
class _AppStringsWalletsErrorsId extends AppStringsWalletsErrorsEn {
	_AppStringsWalletsErrorsId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get load => 'Gagal memuat dompet';
	@override String get retry => 'Coba lagi';
	@override String comingSoon({required Object name}) => '${name} segera hadir';
}

// Path: wallets.subtitle
class _AppStringsWalletsSubtitleId extends AppStringsWalletsSubtitleEn {
	_AppStringsWalletsSubtitleId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get mainAccount => 'Akun utama';
	@override String get cashDigital => 'Tunai & Digital';
	@override String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('id'))(n,
		one: '${n} dompet',
		other: '${n} dompet',
	);
	@override String get account => 'Akun';
	@override String get physicalCash => 'Uang Tunai Fisik';
	@override String get digitalWallet => 'Dompet Digital';
}

// Path: wallets.options
class _AppStringsWalletsOptionsId extends AppStringsWalletsOptionsEn {
	_AppStringsWalletsOptionsId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get viewTransactions => 'Lihat transaksi';
	@override String get viewTransactionsSubtitle => 'Lihat riwayat dompet';
	@override String get transferFunds => 'Transfer uang';
	@override String get transferFundsSubtitle => 'Pindahkan uang ke dompet lain';
	@override String get editWallet => 'Ubah';
	@override String get editWalletSubtitle => 'Ganti nama dan warna dompet';
	@override String get duplicateWallet => 'Duplikat';
	@override String get duplicateWalletSubtitle => 'Buat salinan';
	@override String get archiveWallet => 'Arsipkan';
	@override String get archiveWalletSubtitle => 'Sembunyikan dompet ini';
	@override String get unarchiveWallet => 'Batal arsip';
	@override String get unarchiveWalletSubtitle => 'Kembalikan dompet ini';
	@override String get deleteWallet => 'Hapus';
	@override String get deleteWalletSubtitle => 'Hapus permanen';
	@override String get defaultTitle => 'Dompet';
}

// Path: loans.filter
class _AppStringsLoansFilterId extends AppStringsLoansFilterEn {
	_AppStringsLoansFilterId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get active => 'Aktif';
	@override String get history => 'Riwayat';
	@override String get all => 'Semua';
	@override String get pending => 'Tertunda';
	@override String get lent => 'Diutangkan';
	@override String get borrowed => 'Dihutangkan';
}

// Path: loans.summary
class _AppStringsLoansSummaryId extends AppStringsLoansSummaryEn {
	_AppStringsLoansSummaryId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get netBalance => 'SALDO BERSIH';
	@override String get activeLoans => 'PINJAMAN AKTIF';
	@override String get noActive => 'Semua bersih';
	@override String lent({required Object n}) => '${n} dipinjam';
	@override String borrowed({required Object n}) => '${n} meminjam';
	@override String pending({required Object n}) => '${n} tertunda';
}

// Path: loans.card
class _AppStringsLoansCardId extends AppStringsLoansCardEn {
	_AppStringsLoansCardId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get lent => 'Uang Keluar';
	@override String get borrowed => 'Uang Masuk';
	@override String active({required Object n}) => '${n} aktif';
	@override String multiple({required Object n}) => '${n} pinjaman';
	@override String transactions({required Object n}) => '${n} transaksi';
	@override String overdue({required Object n}) => 'Telat ${n} hari';
	@override String due({required Object date}) => 'Jatuh tempo ${date}';
}

// Path: loans.form
class _AppStringsLoansFormId extends AppStringsLoansFormEn {
	_AppStringsLoansFormId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get newTitle => 'Pinjaman Baru';
	@override String get editTitle => 'Ubah Pinjaman';
	@override String get type => 'Jenis';
	@override String get lend => 'Saya meminjamkan';
	@override String get borrow => 'Saya berutang';
	@override String get contact => 'Kontak';
	@override String get contactPlaceholder => 'Kepada/Dari siapa?';
	@override String get account => 'Dari Akun';
	@override String get accountPlaceholder => 'Pilih akun';
	@override String get amount => 'Jumlah';
	@override String get description => 'Keterangan';
	@override String get date => 'Tanggal';
	@override String get dueDate => 'Jatuh Tempo';
	@override String get selectDate => 'Pilih tanggal';
	@override String get optional => '(Opsional)';
	@override String get createTransaction => 'Buat transaksi di dompet';
	@override String get recordAutomatically => 'Catat otomatis';
	@override String get transactionCategory => 'Kategori transaksi';
	@override String get category => 'Kategori';
	@override String get categoryPlaceholder => 'Pilih kategori';
	@override String get save => 'Simpan';
	@override String get successCreate => 'Pinjaman berhasil dicatat!';
	@override String get successUpdate => 'Pinjaman diperbarui';
	@override String get contactRequired => 'Kontak wajib diisi';
	@override String get accountRequired => 'Akun wajib diisi';
	@override String get amountRequired => 'Jumlah wajib diisi';
}

// Path: loans.detail
class _AppStringsLoansDetailId extends AppStringsLoansDetailEn {
	_AppStringsLoansDetailId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Detail';
	@override String get deleteTitle => 'Hapus Pinjaman';
	@override String get deleteMessage => 'Kamu yakin ingin menghapus catatan pinjaman ini?';
	@override String get deleteSuccess => 'Berhasil dihapus.';
	@override String deleteError({required Object error}) => 'Gagal menghapus: ${error}';
	@override String get notFound => 'Tidak ditemukan';
	@override String get progress => 'Progres Pembayaran';
	@override String get info => 'Informasi';
	@override String get pay => 'Bayar / Terima';
	@override String get viewHistory => 'Lihat Seluruh Riwayat';
	@override String original({required Object amount}) => 'Jumlah awal: ${amount}';
	@override String get section => 'Detail';
	@override String get activeSummary => 'Ringkasan';
	@override String get activeLent => 'Diutangkan (Aktif)';
	@override String get activeBorrowed => 'Meminjam (Aktif)';
	@override String get activeNet => 'Saldo Bersih (Aktif)';
	@override String get activeTotal => 'Total Aktif';
	@override String get startDate => 'Tanggal Mulai';
	@override String get dueDate => 'Tanggal Jatuh Tempo';
	@override late final _AppStringsLoansDetailTypeId type = _AppStringsLoansDetailTypeId._(_root);
	@override late final _AppStringsLoansDetailPaymentId payment = _AppStringsLoansDetailPaymentId._(_root);
}

// Path: loans.history
class _AppStringsLoansHistoryId extends AppStringsLoansHistoryEn {
	_AppStringsLoansHistoryId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Riwayat Pinjaman';
	@override String get section => 'Semua Pinjaman';
	@override String get totalLoaned => 'Total jumlah';
	@override String get noLoans => 'Tidak ada pinjaman ditemukan.';
	@override late final _AppStringsLoansHistoryFilterId filter = _AppStringsLoansHistoryFilterId._(_root);
	@override late final _AppStringsLoansHistoryHeadersId headers = _AppStringsLoansHistoryHeadersId._(_root);
	@override late final _AppStringsLoansHistoryItemId item = _AppStringsLoansHistoryItemId._(_root);
	@override late final _AppStringsLoansHistorySummaryId summary = _AppStringsLoansHistorySummaryId._(_root);
}

// Path: loans.contactDetail
class _AppStringsLoansContactDetailId extends AppStringsLoansContactDetailEn {
	_AppStringsLoansContactDetailId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String titleWith({required Object name}) => 'Pinjaman dengan ${name}';
}

// Path: loans.share
class _AppStringsLoansShareId extends AppStringsLoansShareEn {
	_AppStringsLoansShareId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Bagikan';
	@override String get contactTitle => 'Bagikan Ringkasan';
	@override String get button => 'Kirim';
	@override String get copy => 'Salin';
	@override String get message => 'Berikut ringkasan pinjamannya:';
	@override String contactMessage({required Object name}) => 'Ringkasan utang dengan ${name}:';
	@override String error({required Object error}) => 'Gagal: ${error}';
	@override String get contactCopied => 'Disalin ke papan klip!';
	@override String activeLoans({required Object n}) => 'Pinjaman Aktif (${n}):';
	@override String loanItem({required Object description, required Object amount, required Object date, required Object percent}) => '• ${description}: ${amount} (${date}) - ${percent}% lunas';
	@override String get loanStatement => 'MoneyT - Rekap Pinjaman';
	@override String get loanSummary => 'MoneyT - Ringkasan';
	@override String get personalLoan => 'Pinjaman Pribadi';
	@override String remaining({required Object amount}) => 'Sisa: ${amount}';
	@override String get remainingLabel => 'Sisa saldo';
	@override String original({required Object amount}) => 'dari total ${amount}';
	@override String progress({required Object percent}) => 'Progres: ${percent}% lunas';
	@override String get progressLabel => 'Progres';
	@override String get paidSuffix => 'Lunas';
	@override String date({required Object date}) => 'Tanggal: ${date}';
	@override String get dateLabel => 'Tanggal';
	@override String contact({required Object name}) => 'Kontak: ${name}';
	@override String get contactLabel => 'Kontak';
	@override String generated({required Object date}) => 'Dibuat pada ${date}';
	@override String generatedLabel({required Object date}) => 'Dibuat pada ${date}';
	@override String totalActive({required Object n}) => 'Total Aktif: ${n}';
	@override String get active => 'aktif';
	@override String get poweredBy => 'Didukung oleh MoneyT • moneyt.io';
	@override String get copied => 'Berhasil disalin!';
	@override String netBalance({required Object amount, required Object status}) => 'Saldo Bersih: ${amount} (${status})';
	@override String get netBalanceLabel => 'Saldo Bersih';
	@override String get owed => 'Kamu menerima';
	@override String get owe => 'Kamu berutang';
	@override String lent({required Object amount}) => 'Kamu meminjamkan: ${amount}';
	@override String get lentLabel => 'Kamu meminjamkan';
	@override String borrowed({required Object amount}) => 'Kamu meminjam: ${amount}';
	@override String get borrowedLabel => 'Kamu meminjam';
	@override String contactSummary({required Object name}) => 'Ringkasan - ${name}';
}

// Path: loans.payment
class _AppStringsLoansPaymentId extends AppStringsLoansPaymentEn {
	_AppStringsLoansPaymentId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Catat Pembayaran';
	@override String get amount => 'Berapa jumlahnya?';
	@override String get amountPlaceholder => '0';
	@override String get amountRequired => 'Masukkan jumlah';
	@override String get invalidAmount => 'Jumlah tidak valid';
	@override String get exceedsBalance => 'Melebihi sisa pinjaman';
	@override String get date => 'Tanggal pembayaran';
	@override String get account => 'Melalui akun mana?';
	@override String get selectAccount => 'Pilih akun';
	@override String get details => 'Catatan tambahan';
	@override String get detailsPlaceholder => 'Tambahkan catatan... (opsional)';
	@override String get success => 'Pembayaran berhasil dicatat';
	@override String error({required Object error}) => 'Gagal: ${error}';
	@override String get errorAmount => 'Jumlah tidak valid';
	@override String get errorAccount => 'Pilih akun';
	@override String errorLoading({required Object error}) => 'Gagal memuat: ${error}';
	@override late final _AppStringsLoansPaymentSummaryId summary = _AppStringsLoansPaymentSummaryId._(_root);
	@override late final _AppStringsLoansPaymentQuickId quick = _AppStringsLoansPaymentQuickId._(_root);
}

// Path: loans.item
class _AppStringsLoansItemId extends AppStringsLoansItemEn {
	_AppStringsLoansItemId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String due({required Object date}) => 'Batas: ${date}';
	@override String paidAmount({required Object amount}) => 'Lunas: ${amount}';
	@override String remaining({required Object amount}) => 'Sisa: ${amount}';
	@override String percentPaid({required Object percent}) => '${percent}%';
}

// Path: loans.section
class _AppStringsLoansSectionId extends AppStringsLoansSectionEn {
	_AppStringsLoansSectionId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get activeLoans => 'Pinjaman Aktif';
	@override String loansCount({required Object n}) => '${n} pinjaman';
}

// Path: loans.empty
class _AppStringsLoansEmptyId extends AppStringsLoansEmptyEn {
	_AppStringsLoansEmptyId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tidak ada pinjaman aktif';
	@override String get message => 'Tenang rasanya tanpa utang piutang.';
	@override String get action => 'Catat Pinjaman';
}

// Path: categories.form
class _AppStringsCategoriesFormId extends AppStringsCategoriesFormEn {
	_AppStringsCategoriesFormId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get newTitle => 'Kategori Baru';
	@override String get editTitle => 'Ubah Kategori';
	@override String get name => 'Nama kategori';
	@override String get namePlaceholder => 'Contoh: Makanan, Transport, Belanja';
	@override String get nameRequired => 'Nama kategori wajib';
	@override String get parent => 'Kategori Induk (opsional)';
	@override String get noParent => 'Tanpa kategori induk';
	@override String get asSubcategory => 'Akan menjadi sub-kategori';
	@override String get asRoot => 'Akan menjadi kategori utama';
	@override String get active => 'Aktif';
	@override String get activeDescription => 'Bisa dipilih saat membuat transaksi';
	@override String get selectIcon => 'Pilih Ikon';
	@override String get selectColor => 'Pilih Warna';
	@override String get saveSuccess => 'Kategori disimpan!';
	@override String saveError({required Object error}) => 'Gagal menyimpan: ${error}';
}

// Path: categories.parentSelection
class _AppStringsCategoriesParentSelectionId extends AppStringsCategoriesParentSelectionEn {
	_AppStringsCategoriesParentSelectionId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Pilih induk kategori';
	@override String get subtitle => 'Ke mana kategori ini masuk?';
	@override String get noParent => 'Tanpa induk (Utama)';
}

// Path: categories.report
class _AppStringsCategoriesReportId extends AppStringsCategoriesReportEn {
	_AppStringsCategoriesReportId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Laporan Lanjutan';
	@override String get timeFilter => 'Rentang Waktu';
	@override String get thisMonth => 'Bulan Ini';
	@override String get lastMonth => 'Bulan Lalu';
	@override String get thisYear => 'Tahun Ini';
	@override String get allTime => 'Sepanjang Waktu';
	@override String get details => 'Detail';
	@override String get noTransactions => 'Tidak ada transaksi';
	@override String get income => 'Pemasukan';
	@override String get expense => 'Pengeluaran';
}

// Path: backups.menu
class _AppStringsBackupsMenuId extends AppStringsBackupsMenuEn {
	_AppStringsBackupsMenuId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get settings => 'Pengaturan Cadangan';
	@override String get comingSoon => 'Akan segera hadir';
}

// Path: backups.filters
class _AppStringsBackupsFiltersId extends AppStringsBackupsFiltersEn {
	_AppStringsBackupsFiltersId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get all => 'Semua';
	@override String get auto => 'Otomatis';
	@override String get manual => 'Manual';
	@override String get thisMonth => 'Bulan Ini';
	@override String get lastMonth => 'Bulan Lalu';
	@override String get thisYear => 'Tahun Ini';
	@override String get lastYear => 'Tahun Lalu';
}

// Path: backups.status
class _AppStringsBackupsStatusId extends AppStringsBackupsStatusEn {
	_AppStringsBackupsStatusId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get loading => 'Memuat...';
	@override String get error => 'Gagal memuat daftar';
	@override String get empty => 'Belum ada cadangan';
	@override String get emptyAction => 'Tekan tombol + untuk mencadangkan data';
	@override String get success => 'Selesai!';
	@override String get created => 'Data berhasil diamankan.';
	@override String createError({required Object error}) => 'Gagal membuat: ${error}';
	@override String restoreError({required Object error}) => 'Gagal memulihkan: ${error}';
	@override String deleteError({required Object error}) => 'Gagal menghapus: ${error}';
}

// Path: backups.actions
class _AppStringsBackupsActionsId extends AppStringsBackupsActionsEn {
	_AppStringsBackupsActionsId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get create => 'Buat Cadangan';
	@override String get import => 'Impor File';
	@override String get restore => 'Pulihkan Data';
	@override String get delete => 'Hapus';
	@override String get share => 'Bagikan';
	@override String get cancel => 'Batal';
	@override String get retry => 'Coba Lagi';
	@override String get ok => 'OK';
}

// Path: backups.dialogs
class _AppStringsBackupsDialogsId extends AppStringsBackupsDialogsEn {
	_AppStringsBackupsDialogsId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override late final _AppStringsBackupsDialogsInfoId info = _AppStringsBackupsDialogsInfoId._(_root);
	@override late final _AppStringsBackupsDialogsRestoreId restore = _AppStringsBackupsDialogsRestoreId._(_root);
	@override late final _AppStringsBackupsDialogsDeleteId delete = _AppStringsBackupsDialogsDeleteId._(_root);
}

// Path: backups.stats
class _AppStringsBackupsStatsId extends AppStringsBackupsStatsEn {
	_AppStringsBackupsStatsId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Statistik Cadangan';
	@override String get totalBackups => 'Total Cadangan';
	@override String get totalSize => 'Total Ukuran';
	@override String get oldest => 'Paling Lama';
	@override String get latest => 'Terbaru';
	@override String get autoBackupStatus => 'Cadangan Otomatis';
	@override String get active => 'Menyala';
	@override String get inactive => 'Mati';
}

// Path: backups.options
class _AppStringsBackupsOptionsId extends AppStringsBackupsOptionsEn {
	_AppStringsBackupsOptionsId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override late final _AppStringsBackupsOptionsRestoreId restore = _AppStringsBackupsOptionsRestoreId._(_root);
	@override late final _AppStringsBackupsOptionsShareId share = _AppStringsBackupsOptionsShareId._(_root);
	@override late final _AppStringsBackupsOptionsDeleteId delete = _AppStringsBackupsOptionsDeleteId._(_root);
	@override String get latestBadge => 'Terbaru';
	@override String get latestFile => 'File paling baru';
	@override String get backupFile => 'File zip cadangan';
}

// Path: backups.format
class _AppStringsBackupsFormatId extends AppStringsBackupsFormatEn {
	_AppStringsBackupsFormatId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String auto({required Object date}) => 'Otomatis - ${date}';
	@override String manual({required Object date}) => 'Manual - ${date}';
	@override String get initial => 'Cadangan Awal';
	@override String generic({required Object date}) => 'Cadangan - ${date}';
}

// Path: v2.voice
class _AppStringsV2VoiceId extends AppStringsV2VoiceEn {
	_AppStringsV2VoiceId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get errorProcessing => 'Gak kedengeran, bos. Coba ulang lagi?';
	@override String get tapMicrophone => 'Tekan mic buat mulai ngomong';
	@override String get listening => 'Lagi dengerin nih...';
	@override String get missingApiKey => 'Bro, GEMINI_API_KEY di file .env nya belum ada.';
	@override String aiError({required Object error}) => 'AI lagi error: ${error}';
	@override String get cancel => 'Batalin';
	@override String get scan => 'Scan struk';
}

// Path: v2.transactions
class _AppStringsV2TransactionsId extends AppStringsV2TransactionsEn {
	_AppStringsV2TransactionsId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get invalidAmount => 'Angka yang bener dong masukinnya.';
	@override String get selectAccount => 'Ini keluar dari dompet mana?';
	@override String get selectCategory => 'Kategori apaan nih?';
	@override String errorCreatingCategory({required Object error}) => 'Gagal bikin kategori baru: ${error}';
	@override String error({required Object error}) => 'Error euy: ${error}';
	@override String get more => 'Lainnya';
	@override String get expense => 'Pengeluaran';
	@override String get income => 'Pemasukan';
	@override String get deleteTransaction => 'Beneran mau hapus catatan ini?';
	@override String get cancel => 'Gak jadi';
	@override String get delete => 'Hapus';
	@override String get yesterday => 'Kemarin';
	@override String get usedCategories => 'SERING DIPAKAI';
	@override String get noTransactions => 'Belum ada pengeluaran hari ini';
	@override String get recentActivity => 'Aktivitas Terakhir';
	@override String get searchTransaction => 'Nyari pengeluaran apa...';
	@override String get date => 'Kapan';
	@override String get wallet => 'Dari Mana';
	@override String get transactionDeleted => 'Udah dihapus.';
	@override String get selectCategoryTitle => 'Masuk ke mana?';
	@override String get searchCategory => 'Cari kategori...';
	@override String get noCategoriesAvailable => 'Masih kosong';
	@override String get createNewCategory => 'Bikin kategori baru';
	@override String get amount => 'BERAPA';
	@override String get description => 'BUAT APA';
	@override String get category => 'KATEGORI';
	@override String get addNote => 'Kasih catatan tambahan...';
	@override String get today => 'Hari Ini';
	@override String get editTransaction => 'Edit dulu';
	@override String get newTransaction => 'Catat Baru';
	@override String get selectWallet => 'Pilih Dompet';
	@override String get save => 'Simpan';
	@override String get transactionUpdated => 'Sip, udah diupdate.';
	@override String get transactionSaved => 'Oke, udah kesimpen.';
}

// Path: v2.settings
class _AppStringsV2SettingsId extends AppStringsV2SettingsEn {
	_AppStringsV2SettingsId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Atur-atur';
	@override String get categories => 'Kategori Pengeluaran';
	@override String get wallets => 'Akun & Dompet';
	@override String get language => 'Bahasa';
	@override String get currency => 'Mata Uang';
	@override String get contact => 'Hubungi Kita';
	@override String get legacyView => 'Balik ke Tampilan Lama';
	@override String get deleteCategory => 'Hapus kategori ini?';
	@override String get deleteWallet => 'Hapus dompet ini?';
	@override String get cannotUndo => 'Yakin nih? Kalo udah ilang gak bisa balik lho.';
	@override String get deleteWalletWarning => 'Awas, semua riwayat pengeluaran di dompet ini bakal ikut kehapus.';
	@override String deleteError({required Object error}) => 'Gagal hapus: ${error}';
	@override String get noCategoriesCreated => 'Belum ada kategori nih.\nBikin satu dulu gih.';
	@override String get noWalletsCreated => 'Dompet aja belum punya.\nTambahin dulu lah.';
	@override String get walletDeleted => 'Dompet dihapus, bye.';
	@override String get cancel => 'Batal';
	@override String get delete => 'Iya, Hapus';
	@override String get expenses => 'Keluar';
	@override String get income => 'Masuk';
	@override String get newWallet => 'Dompet Baru';
	@override String get editWallet => 'Edit Dompet';
	@override String get walletName => 'Nama Dompet';
	@override String get saveWallet => 'Simpan Dompet';
}

// Path: v2.dashboard
class _AppStringsV2DashboardId extends AppStringsV2DashboardEn {
	_AppStringsV2DashboardId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get greetingMorning => 'Pagi, bos!';
	@override String get totalBalance => 'TOTAL UANG';
	@override late final _AppStringsV2DashboardDateFiltersId dateFilters = _AppStringsV2DashboardDateFiltersId._(_root);
	@override late final _AppStringsV2DashboardWalletFiltersId walletFilters = _AppStringsV2DashboardWalletFiltersId._(_root);
	@override late final _AppStringsV2DashboardBackgroundId background = _AppStringsV2DashboardBackgroundId._(_root);
	@override late final _AppStringsV2DashboardIncomeExpenseId incomeExpense = _AppStringsV2DashboardIncomeExpenseId._(_root);
	@override late final _AppStringsV2DashboardGaugeId gauge = _AppStringsV2DashboardGaugeId._(_root);
	@override late final _AppStringsV2DashboardActivityListId activityList = _AppStringsV2DashboardActivityListId._(_root);
}

// Path: v2.categories
class _AppStringsV2CategoriesId extends AppStringsV2CategoriesEn {
	_AppStringsV2CategoriesId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Kategori';
	@override String get searchPlaceholder => 'Cari kategori...';
	@override String get newCategory => 'Buat Baru';
	@override String get editCategory => 'Edit';
	@override String get noCategories => 'Kosong melompong';
	@override late final _AppStringsV2CategoriesFormId form = _AppStringsV2CategoriesFormId._(_root);
}

// Path: v2.onboarding
class _AppStringsV2OnboardingId extends AppStringsV2OnboardingEn {
	_AppStringsV2OnboardingId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override late final _AppStringsV2OnboardingButtonsId buttons = _AppStringsV2OnboardingButtonsId._(_root);
	@override late final _AppStringsV2OnboardingSplashId splash = _AppStringsV2OnboardingSplashId._(_root);
	@override late final _AppStringsV2OnboardingExpenseCategoriesId expenseCategories = _AppStringsV2OnboardingExpenseCategoriesId._(_root);
	@override late final _AppStringsV2OnboardingFinancialGoalsId financialGoals = _AppStringsV2OnboardingFinancialGoalsId._(_root);
	@override late final _AppStringsV2OnboardingRegistrationMethodId registrationMethod = _AppStringsV2OnboardingRegistrationMethodId._(_root);
	@override late final _AppStringsV2OnboardingAiAnalysisId aiAnalysis = _AppStringsV2OnboardingAiAnalysisId._(_root);
	@override late final _AppStringsV2OnboardingMainPriorityId mainPriority = _AppStringsV2OnboardingMainPriorityId._(_root);
	@override late final _AppStringsV2OnboardingAiVoiceId aiVoice = _AppStringsV2OnboardingAiVoiceId._(_root);
}

// Path: transactions.filter.ranges
class _AppStringsTransactionsFilterRangesId extends AppStringsTransactionsFilterRangesEn {
	_AppStringsTransactionsFilterRangesId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get thisMonth => 'Bulan ini';
	@override String get lastMonth => 'Bulan lalu';
	@override String get thisYear => 'Tahun ini';
	@override String get lastYear => 'Tahun lalu';
}

// Path: transactions.filter.subtitles
class _AppStringsTransactionsFilterSubtitlesId extends AppStringsTransactionsFilterSubtitlesEn {
	_AppStringsTransactionsFilterSubtitlesId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get income => 'Uang masuk';
	@override String get expense => 'Uang keluar';
	@override String get transfer => 'Uang dipindah';
}

// Path: transactions.share.receipt
class _AppStringsTransactionsShareReceiptId extends AppStringsTransactionsShareReceiptEn {
	_AppStringsTransactionsShareReceiptId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => '--- Detail ---';
	@override String amount({required Object amount}) => 'Jumlah: ${amount}';
	@override String description({required Object description}) => 'Keterangan: ${description}';
	@override String category({required Object category}) => 'Kategori: ${category}';
	@override String date({required Object date}) => 'Tanggal: ${date}';
	@override String time({required Object time}) => 'Waktu: ${time}';
	@override String wallet({required Object wallet}) => 'Akun: ${wallet}';
	@override String contact({required Object contact}) => 'Kontak: ${contact}';
	@override String id({required Object id}) => 'ID: ${id}';
	@override String get separator => '--------------------------';
}

// Path: onboarding.specificProblem.options
class _AppStringsOnboardingSpecificProblemOptionsId extends AppStringsOnboardingSpecificProblemOptionsEn {
	_AppStringsOnboardingSpecificProblemOptionsId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get debts => 'Terlilit pinjaman/utang';
	@override String get savings => 'Susah banget nabung';
	@override String get unknown => 'Gak tau duit abis buat apa';
	@override String get chaos => 'Keuangan berantakan banget';
}

// Path: onboarding.personalGoal.options
class _AppStringsOnboardingPersonalGoalOptionsId extends AppStringsOnboardingPersonalGoalOptionsEn {
	_AppStringsOnboardingPersonalGoalOptionsId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get debtFree => 'Bebas dari utang';
	@override String get saveTrip => 'Nabung buat liburan/barang';
	@override String get invest => 'Mulai berinvestasi';
	@override String get peace => 'Hidup tenang tanpa mikirin uang';
}

// Path: onboarding.solutionPreview.benefits
class _AppStringsOnboardingSolutionPreviewBenefitsId extends AppStringsOnboardingSolutionPreviewBenefitsEn {
	_AppStringsOnboardingSolutionPreviewBenefitsId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get visualize => 'Lacak pengeluaran secara real-time';
	@override String get goals => 'Capai target keuangan';
	@override String get smart => 'Buat keputusan yang cerdas';
}

// Path: onboarding.currentMethod.options
class _AppStringsOnboardingCurrentMethodOptionsId extends AppStringsOnboardingCurrentMethodOptionsEn {
	_AppStringsOnboardingCurrentMethodOptionsId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get excel => 'Pakai Excel/Spreadsheet';
	@override String get notebook => 'Catat di buku';
	@override String get mental => 'Cuma diingat di kepala aja';
	@override String get none => 'Gak diatur sama sekali';
}

// Path: onboarding.featuresShowcase.features
class _AppStringsOnboardingFeaturesShowcaseFeaturesId extends AppStringsOnboardingFeaturesShowcaseFeaturesEn {
	_AppStringsOnboardingFeaturesShowcaseFeaturesId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get income => 'Pemasukan';
	@override String get expense => 'Pengeluaran';
	@override String get transfer => 'Transfer';
	@override String get loans => 'Utang Piutang';
	@override String get goals => 'Target';
	@override String get budgets => 'Anggaran';
	@override String get investments => 'Investasi';
	@override String get cloud => 'Sinkronisasi Cloud';
	@override String get openBanking => 'Sambung Rekening Bank';
}

// Path: onboarding.complete.stats
class _AppStringsOnboardingCompleteStatsId extends AppStringsOnboardingCompleteStatsEn {
	_AppStringsOnboardingCompleteStatsId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Peluang Sukses';
	@override String get before => 'Sebelum MoneyT';
	@override String get after => 'Dengan MoneyT';
}

// Path: dashboard.widgets.balance
class _AppStringsDashboardWidgetsBalanceId extends AppStringsDashboardWidgetsBalanceEn {
	_AppStringsDashboardWidgetsBalanceId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Total Saldo';
	@override String get description => 'Status keuangan menyeluruh';
}

// Path: dashboard.widgets.quickActions
class _AppStringsDashboardWidgetsQuickActionsId extends AppStringsDashboardWidgetsQuickActionsEn {
	_AppStringsDashboardWidgetsQuickActionsId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Aksi Cepat';
	@override String get description => 'Pintasan cepat';
}

// Path: dashboard.widgets.wallets
class _AppStringsDashboardWidgetsWalletsId extends AppStringsDashboardWidgetsWalletsEn {
	_AppStringsDashboardWidgetsWalletsId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Dompet';
	@override String get description => 'Ringkasan jumlah uang';
}

// Path: dashboard.widgets.loans
class _AppStringsDashboardWidgetsLoansId extends AppStringsDashboardWidgetsLoansEn {
	_AppStringsDashboardWidgetsLoansId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Pinjaman';
	@override String get description => 'Uang masuk dan keluar dari pinjaman';
}

// Path: dashboard.widgets.transactions
class _AppStringsDashboardWidgetsTransactionsId extends AppStringsDashboardWidgetsTransactionsEn {
	_AppStringsDashboardWidgetsTransactionsId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Transaksi';
	@override String get description => 'Aktivitas terbaru';
}

// Path: dashboard.widgets.categoryBreakdown
class _AppStringsDashboardWidgetsCategoryBreakdownId extends AppStringsDashboardWidgetsCategoryBreakdownEn {
	_AppStringsDashboardWidgetsCategoryBreakdownId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Rincian Kategori';
	@override String get description => 'Pengeluaran bulan ini';
	@override String get empty_message => 'Belum ada pengeluaran.';
	@override String get others => 'Lainnya';
	@override String get back => 'Kembali';
	@override String get monthlyBudget => 'Anggaran bulanan';
	@override String leftover({required Object amount}) => 'Tersisa ${amount} dari penghasilan.';
	@override String exceeded({required Object amount}) => 'Pengeluaran melebih penghasilan sebesar ${amount}.';
	@override String noIncome({required Object amount}) => 'Pengeluaran: ${amount} (Belum ada penghasilan)';
}

// Path: dashboard.widgets.chartAccounts
class _AppStringsDashboardWidgetsChartAccountsId extends AppStringsDashboardWidgetsChartAccountsEn {
	_AppStringsDashboardWidgetsChartAccountsId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Bagan Akun';
	@override String get description => 'Struktur semua akun';
}

// Path: dashboard.widgets.creditCards
class _AppStringsDashboardWidgetsCreditCardsId extends AppStringsDashboardWidgetsCreditCardsEn {
	_AppStringsDashboardWidgetsCreditCardsId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Kartu Kredit';
	@override String get description => 'Batas dan tagihan kartu';
}

// Path: dashboard.widgets.settings
class _AppStringsDashboardWidgetsSettingsId extends AppStringsDashboardWidgetsSettingsEn {
	_AppStringsDashboardWidgetsSettingsId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Atur Dashboard';
	@override String get subtitle => 'Geser dan atur widget sesuai keinginanmu.';
	@override late final _AppStringsDashboardWidgetsSettingsResetId reset = _AppStringsDashboardWidgetsSettingsResetId._(_root);
	@override String get saveSuccess => 'Berhasil disimpan!';
	@override String saveError({required Object error}) => 'Gagal menyimpan: ${error}';
	@override String get saving => 'Menyimpan...';
	@override String get save => 'Simpan Layout';
}

// Path: loans.detail.type
class _AppStringsLoansDetailTypeId extends AppStringsLoansDetailTypeEn {
	_AppStringsLoansDetailTypeId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get label => 'Jenis';
	@override String get personal => 'Pinjaman Pribadi';
	@override String get borrowed => 'Uang Pinjaman';
	@override String get auto => 'Kredit Kendaraan';
	@override String get mortgage => 'KPR / Hipotek';
	@override String get student => 'Pinjaman Pendidikan';
}

// Path: loans.detail.payment
class _AppStringsLoansDetailPaymentId extends AppStringsLoansDetailPaymentEn {
	_AppStringsLoansDetailPaymentId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get history => 'Riwayat Pembayaran';
	@override String date({required Object date}) => 'Dibayar ${date}';
	@override String transactionId({required Object id}) => 'ID: ${id}';
	@override String paid({required Object amount}) => 'Terbayar ${amount}';
	@override String remaining({required Object amount}) => 'Sisa ${amount}';
}

// Path: loans.history.filter
class _AppStringsLoansHistoryFilterId extends AppStringsLoansHistoryFilterEn {
	_AppStringsLoansHistoryFilterId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get all => 'Semua';
	@override String get lent => 'Diutangkan';
	@override String get borrowed => 'Meminjam';
	@override String get completed => 'Lunas';
	@override String get title => 'Filter';
	@override String get reset => 'Reset';
	@override String get apply => 'Terapkan';
	@override String get dateRange => 'Rentang waktu';
	@override String get amountRange => 'Rentang jumlah';
	@override String get startDate => 'Mulai';
	@override String get endDate => 'Selesai';
	@override String get select => 'Pilih';
}

// Path: loans.history.headers
class _AppStringsLoansHistoryHeadersId extends AppStringsLoansHistoryHeadersEn {
	_AppStringsLoansHistoryHeadersId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get lent => 'Uang yang Kamu Pinjamkan';
	@override String get borrowed => 'Uang yang Kamu Pinjam';
	@override String get completed => 'Sudah Lunas';
	@override String get active => 'Pinjaman Aktif';
	@override String get cancelled => 'Dibatalkan';
	@override String get writtenOff => 'Diikhlaskan / Dihapus';
}

// Path: loans.history.item
class _AppStringsLoansHistoryItemId extends AppStringsLoansHistoryItemEn {
	_AppStringsLoansHistoryItemId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get defaultTitle => 'Pinjaman';
	@override String date({required Object date}) => 'Tanggal: ${date}';
	@override String get lent => 'Meminjamkan';
	@override String get borrowed => 'Berutang';
	@override late final _AppStringsLoansHistoryItemStatusId status = _AppStringsLoansHistoryItemStatusId._(_root);
}

// Path: loans.history.summary
class _AppStringsLoansHistorySummaryId extends AppStringsLoansHistorySummaryEn {
	_AppStringsLoansHistorySummaryId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ringkasan Pinjaman';
	@override String get viewDetails => 'Lihat detail';
	@override String get hideDetails => 'Sembunyikan detail';
	@override String get outstandingLent => 'Orang lain berutang ke kamu';
	@override String get outstandingBorrowed => 'Kamu berutang ke orang lain';
	@override String get netPosition => 'Posisi Bersih';
	@override String get totalLent => 'Total Dipinjamkan';
	@override String get totalBorrowed => 'Total Berutang';
	@override String get totalRepaidToYou => 'Total Dibayar Kepadamu';
	@override String get totalYouRepaid => 'Total Kamu Bayar';
	@override String get totalLoans => 'Total Jumlah Pinjaman';
	@override String get completedLoans => 'Pinjaman Lunas';
}

// Path: loans.payment.summary
class _AppStringsLoansPaymentSummaryId extends AppStringsLoansPaymentSummaryEn {
	_AppStringsLoansPaymentSummaryId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ringkasan';
	@override String get defaultTitle => 'Pinjaman';
	@override String get amount => 'Jumlah pembayaran';
	@override String get remaining => 'Sisa saldo';
	@override String get progress => 'Progres terbaru';
	@override String description({required Object loan, required Object contact}) => '${loan} untuk ${contact}';
	@override String get unknownContact => 'Tidak Dikenal';
	@override String total({required Object amount}) => 'Total ${amount}';
	@override String paid({required Object amount}) => 'Lunas ${amount}';
	@override String remainingLabel({required Object amount}) => 'Sisa ${amount}';
}

// Path: loans.payment.quick
class _AppStringsLoansPaymentQuickId extends AppStringsLoansPaymentQuickEn {
	_AppStringsLoansPaymentQuickId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String full({required Object amount}) => 'Lunas Penuh (${amount})';
	@override String half({required Object amount}) => 'Setengah (${amount})';
}

// Path: backups.dialogs.info
class _AppStringsBackupsDialogsInfoId extends AppStringsBackupsDialogsInfoEn {
	_AppStringsBackupsDialogsInfoId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Informasi File';
	@override String get file => 'Nama:';
	@override String get size => 'Ukuran:';
	@override String get created => 'Dibuat pada:';
	@override String get transactions => 'Transaksi:';
}

// Path: backups.dialogs.restore
class _AppStringsBackupsDialogsRestoreId extends AppStringsBackupsDialogsRestoreEn {
	_AppStringsBackupsDialogsRestoreId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Pulihkan Data';
	@override String content({required Object file}) => 'Anda yakin ingin memulihkan dari file "${file}"? Data saat ini akan ditimpa seluruhnya.';
	@override String get success => 'Memulihkan data... Aplikasi akan dimulai ulang.';
}

// Path: backups.dialogs.delete
class _AppStringsBackupsDialogsDeleteId extends AppStringsBackupsDialogsDeleteEn {
	_AppStringsBackupsDialogsDeleteId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Hapus Cadangan';
	@override String content({required Object file}) => 'Yakin ingin menghapus "${file}"? File ini akan hilang secara permanen.';
	@override String get success => 'Berhasil dihapus.';
}

// Path: backups.options.restore
class _AppStringsBackupsOptionsRestoreId extends AppStringsBackupsOptionsRestoreEn {
	_AppStringsBackupsOptionsRestoreId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Pulihkan';
	@override String get subtitle => 'Timpa data saat ini dengan file ini';
}

// Path: backups.options.share
class _AppStringsBackupsOptionsShareId extends AppStringsBackupsOptionsShareEn {
	_AppStringsBackupsOptionsShareId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Bagikan';
	@override String get subtitle => 'Kirim file ini';
}

// Path: backups.options.delete
class _AppStringsBackupsOptionsDeleteId extends AppStringsBackupsOptionsDeleteEn {
	_AppStringsBackupsOptionsDeleteId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Hapus';
	@override String get subtitle => 'Ini tidak dapat dikembalikan';
}

// Path: v2.dashboard.dateFilters
class _AppStringsV2DashboardDateFiltersId extends AppStringsV2DashboardDateFiltersEn {
	_AppStringsV2DashboardDateFiltersId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get thisMonth => 'Bulan ini';
	@override String get lastMonth => 'Bulan kemaren';
	@override String get customRange => 'Tanggal lain...';
}

// Path: v2.dashboard.walletFilters
class _AppStringsV2DashboardWalletFiltersId extends AppStringsV2DashboardWalletFiltersEn {
	_AppStringsV2DashboardWalletFiltersId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get all => 'Semua';
	@override String get allWallets => 'Semua Dompet';
}

// Path: v2.dashboard.background
class _AppStringsV2DashboardBackgroundId extends AppStringsV2DashboardBackgroundEn {
	_AppStringsV2DashboardBackgroundId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ganti Wallpaper';
	@override String get chooseFromGallery => 'Pilih dari Galeri';
	@override String get restoreDefault => 'Balikin kaya semula';
}

// Path: v2.dashboard.incomeExpense
class _AppStringsV2DashboardIncomeExpenseId extends AppStringsV2DashboardIncomeExpenseEn {
	_AppStringsV2DashboardIncomeExpenseId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get income => 'PEMASUKAN';
	@override String get expenses => 'PENGELUARAN';
}

// Path: v2.dashboard.gauge
class _AppStringsV2DashboardGaugeId extends AppStringsV2DashboardGaugeEn {
	_AppStringsV2DashboardGaugeId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get exceeded => 'BONCOS';
	@override String get spent => 'KEPAKAI';
	@override String get available => 'SISA';
	@override String get overdrawn => 'MINUS BOS';
}

// Path: v2.dashboard.activityList
class _AppStringsV2DashboardActivityListId extends AppStringsV2DashboardActivityListEn {
	_AppStringsV2DashboardActivityListId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get seeAll => 'Lihat semua';
	@override String get newUi => 'Tampilan Baru';
	@override String get expensesByCategory => 'Uang Lo Abis Buat Apa Aja';
	@override String get noRecentExpenses => 'Widih, belum jajan!';
	@override String percentOfTotal({required Object percent}) => '${percent}% dari total';
	@override String topExpenses({required Object count}) => 'Top ${count} pengeluaran terboros';
	@override String get others => 'Lain-lain';
}

// Path: v2.categories.form
class _AppStringsV2CategoriesFormId extends AppStringsV2CategoriesFormEn {
	_AppStringsV2CategoriesFormId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get nameLabel => 'Nama Kategori';
	@override String get save => 'Simpan';
}

// Path: v2.onboarding.buttons
class _AppStringsV2OnboardingButtonsId extends AppStringsV2OnboardingButtonsEn {
	_AppStringsV2OnboardingButtonsId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get start => 'Gas, mulai! 🚀';
	@override String get actionContinue => 'Lanjut';
	@override String get great => 'Mantul!';
	@override String get setGoal => 'Pilih Target';
	@override String get skip => 'Lewatin aja';
}

// Path: v2.onboarding.splash
class _AppStringsV2OnboardingSplashId extends AppStringsV2OnboardingSplashEn {
	_AppStringsV2OnboardingSplashId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title1 => 'Gimana jadinya kalau\nKecerdasan Buatan (AI) ';
	@override String get title2 => 'ngurusin keuanganmu\nlebih jago dari kamu?';
	@override String get benefit1 => 'Bebas ribet.';
	@override String get benefit2 => 'Lebih terpantau.';
	@override String get benefit3 => 'Keputusan lebih cerdas.';
}

// Path: v2.onboarding.expenseCategories
class _AppStringsV2OnboardingExpenseCategoriesId extends AppStringsV2OnboardingExpenseCategoriesEn {
	_AppStringsV2OnboardingExpenseCategoriesId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title1 => 'Paling sering boncos buat apa tiap bulan?';
	@override String get subtitle => 'Pilih maksimal 3 ya';
	@override String get diningOut => 'Makan di luar / Nongkrong';
	@override String get cravings => 'Ngopi / Jajan receh';
	@override String get subscriptions => 'Langganan Netflix dkk';
	@override String get outings => 'Main sama temen';
	@override String get shopping => 'Check-out Shopee/Tokped';
	@override String get delivery => 'GoFood / GrabFood';
}

// Path: v2.onboarding.financialGoals
class _AppStringsV2OnboardingFinancialGoalsId extends AppStringsV2OnboardingFinancialGoalsEn {
	_AppStringsV2OnboardingFinancialGoalsId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Apa yang bisa ngubah\nhidup lo sekarang?';
	@override String get subtitle => 'Pilih satu aja yang paling pengen diraih';
	@override String get trackMoney => 'Cuma pengen tau duit gue larinya ke mana';
	@override String get spendLess => 'Berhenti beli barang gak penting';
	@override String get lessStress => 'Gak mau pusing mikirin duit pas akhir bulan';
	@override String get saveMoney => 'Beneran bisa nabung buat sesuatu';
}

// Path: v2.onboarding.registrationMethod
class _AppStringsV2OnboardingRegistrationMethodId extends AppStringsV2OnboardingRegistrationMethodEn {
	_AppStringsV2OnboardingRegistrationMethodId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Lo prefer nyatet pengeluaran\npakai cara apa?';
	@override String get subtitle => 'Pilih yang gak bikin males';
	@override String get voice => 'Tinggal ngomong ke hp, beres';
	@override String get auto => 'Tarik data dari mutasi bank';
	@override String get write => 'Ketik satu-satu secara manual';
	@override String get easy => 'Pokoknya yang paling cepet aja';
}

// Path: v2.onboarding.aiAnalysis
class _AppStringsV2OnboardingAiAnalysisId extends AppStringsV2OnboardingAiAnalysisEn {
	_AppStringsV2OnboardingAiAnalysisId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override late final _AppStringsV2OnboardingAiAnalysisLoadingId loading = _AppStringsV2OnboardingAiAnalysisLoadingId._(_root);
	@override late final _AppStringsV2OnboardingAiAnalysisShowcaseId showcase = _AppStringsV2OnboardingAiAnalysisShowcaseId._(_root);
}

// Path: v2.onboarding.mainPriority
class _AppStringsV2OnboardingMainPriorityId extends AppStringsV2OnboardingMainPriorityEn {
	_AppStringsV2OnboardingMainPriorityId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Prioritas utama lo\nsekarang apaan?';
	@override String get subtitle => 'Pilih satu hal di mana MoneyT bakal bantu banget';
	@override String get breakHabits => 'Ngilangin kebiasaan buruk finansial';
	@override String get stopStress => 'Gak mau deg-degan tiap buka dompet';
	@override String get buildFuture => 'Pelan-pelan nabung buat masa depan';
	@override String get feelControl => 'Gue yang megang kendali duit gue';
	@override String get saveGoal => 'Nabung demi satu barang impian';
}

// Path: v2.onboarding.aiVoice
class _AppStringsV2OnboardingAiVoiceId extends AppStringsV2OnboardingAiVoiceEn {
	_AppStringsV2OnboardingAiVoiceId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override late final _AppStringsV2OnboardingAiVoiceTitleId title = _AppStringsV2OnboardingAiVoiceTitleId._(_root);
	@override String get subtitle => 'Gak usah ribet ngetik lagi, tinggal tekan mic dan ngomong santai ke dia.';
	@override String get listening => 'Ngomong aja, gue dengerin...';
	@override List<String> get examples => [
		'Kopi Rp 35.000',
		'Gojek Rp 45.000',
		'Bioskop Rp 150.000',
		'Belanja Rp 450.000',
		'Bensin Rp 100.000',
		'Netflix Rp 186.000',
		'Makan Rp 120.000',
		'Apotek Rp 85.000',
	];
}

// Path: dashboard.widgets.settings.reset
class _AppStringsDashboardWidgetsSettingsResetId extends AppStringsDashboardWidgetsSettingsResetEn {
	_AppStringsDashboardWidgetsSettingsResetId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get button => 'Kembalikan ke awal';
	@override String get dialogTitle => 'Atur Ulang Tata Letak';
	@override String get dialogContent => 'Ingin mengatur ulang dashboard seperti semula?';
	@override String get cancel => 'Batal';
	@override String get confirm => 'Atur ulang';
	@override String get success => 'Tata letak berhasil diatur ulang';
}

// Path: loans.history.item.status
class _AppStringsLoansHistoryItemStatusId extends AppStringsLoansHistoryItemStatusEn {
	_AppStringsLoansHistoryItemStatusId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get completed => 'Lunas';
	@override String get active => 'Aktif';
	@override String get cancelled => 'Batal';
	@override String get writtenOff => 'Dihapus';
}

// Path: v2.onboarding.aiAnalysis.loading
class _AppStringsV2OnboardingAiAnalysisLoadingId extends AppStringsV2OnboardingAiAnalysisLoadingEn {
	_AppStringsV2OnboardingAiAnalysisLoadingId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'BENTAR, LAGI DISIAPIN\nAPP-NYA BUAT LO';
	@override String get subtitle => 'Sedang dianalisis...';
	@override List<String> get messages => [
		'Lagi merhatiin gaya belanja lo...',
		'Nyusun kategori biar pas...',
		'Nyari tau di mana lo sering boncos...',
		'Ngebangun strategi keuangannya...',
	];
}

// Path: v2.onboarding.aiAnalysis.showcase
class _AppStringsV2OnboardingAiAnalysisShowcaseId extends AppStringsV2OnboardingAiAnalysisShowcaseEn {
	_AppStringsV2OnboardingAiAnalysisShowcaseId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Oke, udah kelar!';
	@override late final _AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextId dynamicText = _AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextId._(_root);
	@override late final _AppStringsV2OnboardingAiAnalysisShowcaseResultId result = _AppStringsV2OnboardingAiAnalysisShowcaseResultId._(_root);
}

// Path: v2.onboarding.aiVoice.title
class _AppStringsV2OnboardingAiVoiceTitleId extends AppStringsV2OnboardingAiVoiceTitleEn {
	_AppStringsV2OnboardingAiVoiceTitleId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get kDefault => 'Mencapai target lo';
	@override String get breakHabits => 'Menghilangkan kebiasaan boncos';
	@override String get stopStress => 'Bikin pikiran tenang tiap bulan';
	@override String get buildFuture => 'Membangun masa depan mapan';
	@override String get feelControl => 'Menguasai arus keuangan';
	@override String get saveGoal => 'Mencapai target nabung lo';
	@override String get suffix => ' bakal jauh lebih gampang dibantuin Asisten AI.';
}

// Path: v2.onboarding.aiAnalysis.showcase.dynamicText
class _AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextId extends AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextEn {
	_AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get kDefault => 'Duit lo bocornya cepet banget. Kayaknya cara lo ngatur uang selama ini emang keliru deh.';
	@override String get part2 => ' ngabisin jatah uang lo paling gede, dan karena lo pengen ';
	@override String get part3 => ' ini tandanya lo butuh ngerubah kebiasaan.';
	@override late final _AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextCategoriesId categories = _AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextCategoriesId._(_root);
	@override late final _AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextIntentionsId intentions = _AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextIntentionsId._(_root);
}

// Path: v2.onboarding.aiAnalysis.showcase.result
class _AppStringsV2OnboardingAiAnalysisShowcaseResultId extends AppStringsV2OnboardingAiAnalysisShowcaseResultEn {
	_AppStringsV2OnboardingAiAnalysisShowcaseResultId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get yourResult => 'Statistik Lo';
	@override String get average => 'Orang Biasa';
	@override String get messagePart1 => 'Lo boros 68% ';
	@override String get messagePart2 => 'lebih banyak dibanding rata-rata orang, ';
	@override String get messagePart3 => 'dan jujur ini pelan-pelan\n';
	@override String get messagePart4 => 'ngerusak masa depan keuangan lo';
}

// Path: v2.onboarding.aiAnalysis.showcase.dynamicText.categories
class _AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextCategoriesId extends AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextCategoriesEn {
	_AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextCategoriesId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get diningOut => 'Sering nongkrong di luar';
	@override String get cravings => 'Jajan receh yang numpuk';
	@override String get subscriptions => 'Langganan numpuk';
	@override String get outings => 'Main terus-terusan';
	@override String get shopping => 'Hobi check-out barang';
	@override String get delivery => 'Ongkir dan pesen antar';
}

// Path: v2.onboarding.aiAnalysis.showcase.dynamicText.intentions
class _AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextIntentionsId extends AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextIntentionsEn {
	_AppStringsV2OnboardingAiAnalysisShowcaseDynamicTextIntentionsId._(AppStringsId root) : this._root = root, super.internal(root);

	final AppStringsId _root; // ignore: unused_field

	// Translations
	@override String get trackMoney => 'nge-track ke mana duit lari';
	@override String get spendLess => 'ngurangin pemborosan';
	@override String get lessStress => 'hidup lebih tenang soal uang';
	@override String get saveMoney => 'mulai serius nabung';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on AppStringsId {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'app.name': return 'MoneyT';
			case 'app.description': return 'Pengatur Keuangan';
			case 'common.save': return 'Simpan';
			case 'common.cancel': return 'Batal';
			case 'common.delete': return 'Hapus';
			case 'common.edit': return 'Ubah';
			case 'common.loading': return 'Memuat...';
			case 'common.error': return 'Kesalahan';
			case 'common.success': return 'Berhasil';
			case 'common.search': return 'Cari';
			case 'common.clearSearch': return 'Hapus pencarian';
			case 'common.viewAll': return 'Lihat semua';
			case 'common.retry': return 'Coba lagi';
			case 'common.add': return 'Tambah';
			case 'common.remove': return 'Hapus';
			case 'common.moreOptions': return 'Opsi lainnya';
			case 'common.addToFavorites': return 'Tambah ke favorit';
			case 'common.removeFromFavorites': return 'Hapus dari favorit';
			case 'common.today': return 'Hari ini';
			case 'common.yesterday': return 'Kemarin';
			case 'components.dateSelection.title': return 'Pilih tanggal';
			case 'components.dateSelection.subtitle': return 'Pilih tanggal transaksi';
			case 'components.dateSelection.selectedDate': return 'Tanggal dipilih';
			case 'components.dateSelection.confirm': return 'Konfirmasi';
			case 'components.selection.cancel': return 'Batal';
			case 'components.selection.confirm': return 'Konfirmasi';
			case 'components.selection.select': return 'Pilih';
			case 'components.contactSelection.title': return 'Pilih kontak';
			case 'components.contactSelection.subtitle': return 'Dengan siapa transaksi ini';
			case 'components.contactSelection.searchPlaceholder': return 'Cari kontak';
			case 'components.contactSelection.noContact': return 'Tanpa kontak';
			case 'components.contactSelection.noContactDetails': return 'Transaksi tanpa kontak';
			case 'components.contactSelection.allContacts': return 'Semua kontak';
			case 'components.contactSelection.create': return 'Buat kontak baru';
			case 'components.categorySelection.title': return 'Pilih kategori';
			case 'components.categorySelection.subtitle': return 'Pilih kategori transaksi ini';
			case 'components.categorySelection.searchPlaceholder': return 'Cari kategori';
			case 'components.currencySelection.title': return 'Pilih mata uang';
			case 'components.currencySelection.subtitle': return 'Pilih mata uang';
			case 'components.currencySelection.searchPlaceholder': return 'Cari mata uang';
			case 'components.accountSelection.title': return 'Pilih akun';
			case 'components.accountSelection.subtitle': return 'Pilih akun untuk transaksi ini';
			case 'components.accountSelection.searchPlaceholder': return 'Cari akun';
			case 'components.accountSelection.wallets': return 'Dompet';
			case 'components.accountSelection.creditCards': return 'Kartu Kredit';
			case 'components.accountSelection.selectAccount': return 'Pilih akun';
			case 'components.accountSelection.confirm': return 'Konfirmasi';
			case 'components.parentWalletSelection.title': return 'Dompet utama';
			case 'components.parentWalletSelection.subtitle': return 'Pilih dompet utama';
			case 'components.parentWalletSelection.searchPlaceholder': return 'Cari dompet';
			case 'components.parentWalletSelection.noParent': return 'Tidak ada dompet utama';
			case 'components.parentWalletSelection.createRoot': return 'Buat sebagai utama';
			case 'components.parentWalletSelection.available': return 'Dompet Tersedia';
			case 'components.walletTypes.checking': return 'Rekening Giro';
			case 'components.walletTypes.savings': return 'Tabungan';
			case 'components.walletTypes.cash': return 'Uang Tunai';
			case 'components.walletTypes.creditCard': return 'Kartu Kredit';
			case 'navigation.home': return 'Beranda';
			case 'navigation.transactions': return 'Transaksi';
			case 'navigation.contacts': return 'Kontak';
			case 'navigation.settings': return 'Pengaturan';
			case 'navigation.wallets': return 'Dompet';
			case 'navigation.categories': return 'Kategori';
			case 'navigation.loans': return 'Pinjaman';
			case 'navigation.charts': return 'Bagan Akun';
			case 'navigation.backups': return 'Cadangan';
			case 'navigation.creditCards': return 'Kartu Kredit';
			case 'navigation.sections.operations': return 'OPERASI';
			case 'navigation.sections.financialTools': return 'ALAT KEUANGAN';
			case 'navigation.sections.management': return 'MANAJEMEN';
			case 'navigation.sections.advanced': return 'LANJUTAN';
			case 'transactions.title': return 'Transaksi';
			case 'transactions.types.all': return 'Semua';
			case 'transactions.types.income': return 'Pemasukan';
			case 'transactions.types.expense': return 'Pengeluaran';
			case 'transactions.types.transfer': return 'Transfer';
			case 'transactions.filter.title': return 'Saring Transaksi';
			case 'transactions.filter.date': return 'Tanggal';
			case 'transactions.filter.categories': return 'Kategori';
			case 'transactions.filter.accounts': return 'Akun';
			case 'transactions.filter.contacts': return 'Kontak';
			case 'transactions.filter.amount': return 'Jumlah';
			case 'transactions.filter.apply': return 'Terapkan';
			case 'transactions.filter.clear': return 'Bersihkan filter';
			case 'transactions.filter.add': return 'Tambah filter';
			case 'transactions.filter.minAmount': return 'Jumlah Min';
			case 'transactions.filter.maxAmount': return 'Jumlah Max';
			case 'transactions.filter.selectDate': return 'Pilih tanggal';
			case 'transactions.filter.selectCategory': return 'Pilih kategori';
			case 'transactions.filter.selectAccount': return 'Pilih akun';
			case 'transactions.filter.selectContact': return 'Pilih kontak';
			case 'transactions.filter.quickFilters': return 'Filter cepat';
			case 'transactions.filter.ranges.thisMonth': return 'Bulan ini';
			case 'transactions.filter.ranges.lastMonth': return 'Bulan lalu';
			case 'transactions.filter.ranges.thisYear': return 'Tahun ini';
			case 'transactions.filter.ranges.lastYear': return 'Tahun lalu';
			case 'transactions.filter.customRange': return 'Kustom';
			case 'transactions.filter.startDate': return 'Tanggal Mulai';
			case 'transactions.filter.endDate': return 'Tanggal Selesai';
			case 'transactions.filter.active': return 'Filter Aktif';
			case 'transactions.filter.subtitles.income': return 'Uang masuk';
			case 'transactions.filter.subtitles.expense': return 'Uang keluar';
			case 'transactions.filter.subtitles.transfer': return 'Uang dipindah';
			case 'transactions.form.newTitle': return 'Transaksi Baru';
			case 'transactions.form.editTitle': return 'Ubah Transaksi';
			case 'transactions.form.amount': return 'Jumlah';
			case 'transactions.form.type': return 'Jenis transaksi';
			case 'transactions.form.amountRequired': return 'Jumlah wajib diisi';
			case 'transactions.form.date': return 'Tanggal';
			case 'transactions.form.account': return 'Akun';
			case 'transactions.form.toAccount': return 'Ke Akun';
			case 'transactions.form.category': return 'Kategori';
			case 'transactions.form.contact': return 'Kontak';
			case 'transactions.form.contactOptional': return 'Kontak (opsional)';
			case 'transactions.form.description': return 'Keterangan';
			case 'transactions.form.descriptionOptional': return 'Keterangan (opsional)';
			case 'transactions.form.selectAccount': return 'Pilih akun';
			case 'transactions.form.selectDestination': return 'Pilih tujuan';
			case 'transactions.form.selectCategory': return 'Pilih kategori';
			case 'transactions.form.selectContact': return 'Pilih kontak';
			case 'transactions.form.saveSuccess': return 'Transaksi berhasil disimpan';
			case 'transactions.form.updateSuccess': return 'Transaksi berhasil diubah';
			case 'transactions.form.saveError': return 'Gagal menyimpan transaksi';
			case 'transactions.form.share': return 'Bagikan';
			case 'transactions.form.created': return 'Transaksi berhasil dibuat';
			case 'transactions.form.crossCurrencyConversion': return 'Konversi mata uang';
			case 'transactions.form.receivedAmount': return 'Jumlah diterima';
			case 'transactions.form.exchangeRate': return 'Nilai tukar';
			case 'transactions.form.receivedAmountRequired': return 'Masukkan jumlah diterima';
			case 'transactions.form.exchangeRateLabel': return ({required Object from, required Object rate, required Object to}) => '1 ${from} = ${rate} ${to}';
			case 'transactions.errors.load': return 'Gagal memuat transaksi';
			case 'transactions.empty.title': return 'Tidak ada transaksi';
			case 'transactions.empty.message': return 'Tidak ada transaksi yang sesuai';
			case 'transactions.empty.clearFilters': return 'Bersihkan filter';
			case 'transactions.list.count': return ({required Object n}) => '${n} transaksi';
			case 'transactions.detail.title': return 'Detail Transaksi';
			case 'transactions.detail.delete': return 'Hapus Transaksi';
			case 'transactions.detail.deleteConfirmation': return 'Anda yakin? Ini tidak dapat dikembalikan.';
			case 'transactions.detail.deleted': return 'Transaksi dihapus';
			case 'transactions.detail.duplicate': return 'Duplikat';
			case 'transactions.detail.duplicateNotImplemented': return 'Duplikat belum tersedia';
			case 'transactions.detail.edit': return 'Ubah';
			case 'transactions.detail.errorLoad': return 'Gagal memuat detail';
			case 'transactions.detail.errorPrepareEdit': return ({required Object error}) => 'Error: ${error}';
			case 'transactions.detail.errorDelete': return ({required Object error}) => 'Error: ${error}';
			case 'transactions.detail.category': return 'Kategori';
			case 'transactions.detail.account': return 'Akun';
			case 'transactions.detail.contact': return 'Kontak';
			case 'transactions.detail.description': return 'Keterangan';
			case 'transactions.detail.transferDetails': return 'Detail Transfer';
			case 'transactions.detail.from': return 'Dari';
			case 'transactions.detail.to': return 'Ke';
			case 'transactions.detail.unknownAccount': return 'Akun Tidak Dikenal';
			case 'transactions.detail.errorUrl': return ({required Object url}) => 'Tidak dapat membuka ${url}';
			case 'transactions.detail.date': return 'Tanggal';
			case 'transactions.detail.time': return 'Waktu';
			case 'transactions.detail.loanLinkedWarning': return 'Transaksi ini terkait dengan pinjaman dan diatur secara otomatis.';
			case 'transactions.share.title': return 'Bagikan';
			case 'transactions.share.copyText': return 'Salin Teks';
			case 'transactions.share.shareButton': return 'Bagikan';
			case 'transactions.share.shareMessage': return 'Berikut bukti transaksi saya:';
			case 'transactions.share.copied': return 'Berhasil disalin ke papan klip!';
			case 'transactions.share.paymentMethod': return 'Metode Pembayaran';
			case 'transactions.share.receiptTitle': return 'Bukti Transaksi';
			case 'transactions.share.poweredBy': return 'Didukung oleh MoneyT • moneyt.io';
			case 'transactions.share.errorImage': return ({required Object error}) => 'Gagal: ${error}';
			case 'transactions.share.receipt.title': return '--- Detail ---';
			case 'transactions.share.receipt.amount': return ({required Object amount}) => 'Jumlah: ${amount}';
			case 'transactions.share.receipt.description': return ({required Object description}) => 'Keterangan: ${description}';
			case 'transactions.share.receipt.category': return ({required Object category}) => 'Kategori: ${category}';
			case 'transactions.share.receipt.date': return ({required Object date}) => 'Tanggal: ${date}';
			case 'transactions.share.receipt.time': return ({required Object time}) => 'Waktu: ${time}';
			case 'transactions.share.receipt.wallet': return ({required Object wallet}) => 'Akun: ${wallet}';
			case 'transactions.share.receipt.contact': return ({required Object contact}) => 'Kontak: ${contact}';
			case 'transactions.share.receipt.id': return ({required Object id}) => 'ID: ${id}';
			case 'transactions.share.receipt.separator': return '--------------------------';
			case 'transactions.share.generatedOn': return ({required Object date}) => 'Dibuat pada ${date}';
			case 'contacts.title': return 'Kontak';
			case 'contacts.addContact': return 'Tambah Kontak';
			case 'contacts.editContact': return 'Ubah Kontak';
			case 'contacts.newContact': return 'Kontak baru';
			case 'contacts.noContacts': return 'Belum ada kontak';
			case 'contacts.noContactsMessage': return 'Tambahkan kontak pertama Anda';
			case 'contacts.searchContacts': return 'Cari kontak';
			case 'contacts.deleteContact': return 'Hapus';
			case 'contacts.confirmDelete': return 'Anda yakin ingin menghapus';
			case 'contacts.contactDeleted': return 'Berhasil dihapus';
			case 'contacts.errorDeleting': return 'Gagal menghapus';
			case 'contacts.noSearchResults': return 'Tidak ditemukan';
			case 'contacts.noContactsMatch': return ({required Object query}) => 'Tidak ada kecocokan dengan "${query}".';
			case 'contacts.errorLoading': return 'Gagal memuat kontak';
			case 'contacts.contactSaved': return 'Berhasil disimpan';
			case 'contacts.errorSaving': return 'Gagal menyimpan';
			case 'contacts.noContactInfo': return 'Tidak ada info kontak';
			case 'contacts.importContact': return 'Impor kontak';
			case 'contacts.importContacts': return 'Impor banyak kontak';
			case 'contacts.importContactSoon': return 'Akan segera hadir';
			case 'contacts.fields.name': return 'Nama';
			case 'contacts.fields.fullName': return 'Nama lengkap';
			case 'contacts.fields.email': return 'Email';
			case 'contacts.fields.phone': return 'Telepon';
			case 'contacts.fields.address': return 'Alamat';
			case 'contacts.fields.notes': return 'Catatan';
			case 'contacts.placeholders.enterFullName': return 'Masukkan nama lengkap';
			case 'contacts.placeholders.enterPhone': return 'Masukkan nomor';
			case 'contacts.placeholders.enterEmail': return 'Masukkan email';
			case 'contacts.validation.nameRequired': return 'Nama wajib diisi';
			case 'contacts.validation.invalidEmail': return 'Email tidak valid';
			case 'contacts.validation.invalidPhone': return 'Nomor tidak valid';
			case 'errors.loadingAccounts': return ({required Object error}) => 'Gagal memuat akun: ${error}';
			case 'errors.unexpected': return 'Kesalahan tak terduga';
			case 'settings.title': return 'Pengaturan';
			case 'settings.account.title': return 'Akun';
			case 'settings.account.profile': return 'Profil';
			case 'settings.account.profileSubtitle': return 'Kelola informasi akun';
			case 'settings.appearance.title': return 'Tampilan';
			case 'settings.appearance.darkMode': return 'Mode gelap';
			case 'settings.appearance.darkModeSubtitle': return 'Gunakan tema gelap';
			case 'settings.appearance.language': return 'Bahasa';
			case 'settings.appearance.currency': return 'Mata Uang Utama';
			case 'settings.appearance.currencySubtitle': return 'Mata uang default untuk akun baru';
			case 'settings.appearance.darkTheme': return 'Tema Gelap';
			case 'settings.appearance.lightTheme': return 'Tema Terang';
			case 'settings.appearance.systemTheme': return 'Tema Sistem';
			case 'settings.data.title': return 'Data & Penyimpanan';
			case 'settings.data.backup': return 'Cadangan Data';
			case 'settings.data.backupSubtitle': return 'Kelola pencadangan Anda';
			case 'settings.info.title': return 'Informasi';
			case 'settings.info.contact': return 'Kontak & Media Sosial';
			case 'settings.info.contactSubtitle': return 'Hubungi kami atau ikuti komunitas';
			case 'settings.info.privacy': return 'Kebijakan Privasi';
			case 'settings.info.privacySubtitle': return 'Baca kebijakan kami';
			case 'settings.info.share': return 'Bagikan MoneyT';
			case 'settings.info.shareSubtitle': return 'Rekomendasikan ke teman';
			case 'settings.logout.button': return 'Keluar';
			case 'settings.logout.dialogTitle': return 'Keluar';
			case 'settings.logout.dialogMessage': return 'Anda yakin ingin keluar dari akun?';
			case 'settings.logout.cancel': return 'Batal';
			case 'settings.logout.confirm': return 'Keluar';
			case 'settings.social.title': return 'Kontak dan Sosial';
			case 'settings.social.follow': return 'Ikuti MoneyT';
			case 'settings.social.description': return 'Tetap terhubung dengan pembaruan.';
			case 'settings.social.networks': return 'Media Sosial';
			case 'settings.social.github': return 'GitHub';
			case 'settings.social.githubSubtitle': return 'Lihat kode sumber';
			case 'settings.social.linkedin': return 'LinkedIn';
			case 'settings.social.linkedinSubtitle': return 'Berita profesional';
			case 'settings.social.twitter': return 'X (Twitter)';
			case 'settings.social.twitterSubtitle': return 'Pembaruan langsung';
			case 'settings.social.reddit': return 'Reddit';
			case 'settings.social.redditSubtitle': return 'Komunitas';
			case 'settings.social.discord': return 'Discord';
			case 'settings.social.discordSubtitle': return 'Obrolan komunitas';
			case 'settings.social.contact': return 'Dukungan';
			case 'settings.social.email': return 'Kirim Email';
			case 'settings.social.website': return 'Situs Web Resmi';
			case 'settings.language.title': return 'Bahasa';
			case 'settings.language.available': return 'BAHASA TERSEDIA';
			case 'settings.language.apply': return 'Terapkan Bahasa';
			case 'settings.currency.title': return 'Mata Uang';
			case 'settings.currency.available': return 'MATA UANG';
			case 'settings.currency.apply': return 'Terapkan';
			case 'settings.messages.profileComingSoon': return 'Profil akan segera hadir';
			case 'settings.messages.privacyError': return 'Tidak dapat membuka kebijakan privasi';
			case 'settings.messages.logoutComingSoon': return 'Fitur keluar segera hadir';
			case 'onboarding.welcome.title': return 'Selamat Datang di MoneyT 👋';
			case 'onboarding.welcome.subtitle': return 'Kendalikan keuanganmu dalam hitungan menit ✨';
			case 'onboarding.problemStatement.title': return 'Merasa uang cepat habis tanpa jejak?';
			case 'onboarding.problemStatement.subtitle': return 'Kamu tidak sendirian. 70% orang tidak tahu ke mana uang mereka pergi.';
			case 'onboarding.specificProblem.title': return 'Apa masalah terbesarmu saat ini?';
			case 'onboarding.specificProblem.options.debts': return 'Terlilit pinjaman/utang';
			case 'onboarding.specificProblem.options.savings': return 'Susah banget nabung';
			case 'onboarding.specificProblem.options.unknown': return 'Gak tau duit abis buat apa';
			case 'onboarding.specificProblem.options.chaos': return 'Keuangan berantakan banget';
			case 'onboarding.personalGoal.title': return 'Apa fokus utamamu?';
			case 'onboarding.personalGoal.options.debtFree': return 'Bebas dari utang';
			case 'onboarding.personalGoal.options.saveTrip': return 'Nabung buat liburan/barang';
			case 'onboarding.personalGoal.options.invest': return 'Mulai berinvestasi';
			case 'onboarding.personalGoal.options.peace': return 'Hidup tenang tanpa mikirin uang';
			case 'onboarding.solutionPreview.title': return 'MoneyT memberikan kejelasan';
			case 'onboarding.solutionPreview.subtitle': return 'Pantau semua akun, utang, dan pengeluaran di satu tempat. Gak perlu Excel lagi.';
			case 'onboarding.solutionPreview.benefits.visualize': return 'Lacak pengeluaran secara real-time';
			case 'onboarding.solutionPreview.benefits.goals': return 'Capai target keuangan';
			case 'onboarding.solutionPreview.benefits.smart': return 'Buat keputusan yang cerdas';
			case 'onboarding.currentMethod.title': return 'Bagaimana kamu mengatur uang saat ini?';
			case 'onboarding.currentMethod.subtitle': return 'Pilih yang paling mirip denganmu.';
			case 'onboarding.currentMethod.options.excel': return 'Pakai Excel/Spreadsheet';
			case 'onboarding.currentMethod.options.notebook': return 'Catat di buku';
			case 'onboarding.currentMethod.options.mental': return 'Cuma diingat di kepala aja';
			case 'onboarding.currentMethod.options.none': return 'Gak diatur sama sekali';
			case 'onboarding.featuresShowcase.title': return 'Fitur saat ini dan yang akan datang ✨';
			case 'onboarding.featuresShowcase.subtitle': return 'Sudah siap dipakai, dengan lebih banyak fitur sedang dibuat.';
			case 'onboarding.featuresShowcase.available': return 'SUDAH TERSEDIA';
			case 'onboarding.featuresShowcase.comingSoon': return 'SEGERA HADIR';
			case 'onboarding.featuresShowcase.features.income': return 'Pemasukan';
			case 'onboarding.featuresShowcase.features.expense': return 'Pengeluaran';
			case 'onboarding.featuresShowcase.features.transfer': return 'Transfer';
			case 'onboarding.featuresShowcase.features.loans': return 'Utang Piutang';
			case 'onboarding.featuresShowcase.features.goals': return 'Target';
			case 'onboarding.featuresShowcase.features.budgets': return 'Anggaran';
			case 'onboarding.featuresShowcase.features.investments': return 'Investasi';
			case 'onboarding.featuresShowcase.features.cloud': return 'Sinkronisasi Cloud';
			case 'onboarding.featuresShowcase.features.openBanking': return 'Sambung Rekening Bank';
			case 'onboarding.complete.title': return 'Siap meluncur! 🚀';
			case 'onboarding.complete.subtitle': return 'Catat pengeluaran pertamamu dan lihat perubahannya 📈';
			case 'onboarding.complete.stats.title': return 'Peluang Sukses';
			case 'onboarding.complete.stats.before': return 'Sebelum MoneyT';
			case 'onboarding.complete.stats.after': return 'Dengan MoneyT';
			case 'onboarding.buttons.start': return 'Mulai sekarang 🚀';
			case 'onboarding.buttons.fixIt': return 'Ayo beresin hari ini ⚡';
			case 'onboarding.buttons.actionContinue': return 'Lanjut';
			case 'onboarding.buttons.setGoal': return 'Tentukan Target 🎯';
			case 'onboarding.buttons.wantControl': return 'Gue mau kendali ini!';
			case 'onboarding.buttons.great': return 'Mantap, lanjut!';
			case 'onboarding.buttons.firstTransaction': return 'Catat transaksi pertama ➕';
			case 'onboarding.buttons.skip': return 'Lewati';
			case 'dashboard.greeting': return 'Halo!';
			case 'dashboard.balance.total': return 'TOTAL SALDO';
			case 'dashboard.balance.income': return 'PEMASUKAN';
			case 'dashboard.balance.expenses': return 'PENGELUARAN';
			case 'dashboard.balance.thisMonth': return 'bulan ini';
			case 'dashboard.actions.income': return 'Pemasukan';
			case 'dashboard.actions.expense': return 'Pengeluaran';
			case 'dashboard.actions.transfer': return 'Transfer';
			case 'dashboard.actions.all': return 'Semua';
			case 'dashboard.wallets.title': return 'Dompet';
			case 'dashboard.wallets.count': return ({required Object n}) => '${n} akun';
			case 'dashboard.wallets.more': return ({required Object n}) => '+${n} lainnya';
			case 'dashboard.wallets.viewDetails': return ({required Object name}) => 'Lihat detail ${name}';
			case 'dashboard.transactions.title': return 'Transaksi Terakhir';
			case 'dashboard.transactions.subtitle': return '5 transaksi terbaru';
			case 'dashboard.transactions.empty': return 'Belum ada transaksi';
			case 'dashboard.transactions.emptySubtitle': return 'Transaksi barumu akan muncul di sini';
			case 'dashboard.transactions.more': return ({required Object n}) => '+${n} lagi';
			case 'dashboard.customize': return 'Sesuaikan';
			case 'dashboard.widgets.balance.title': return 'Total Saldo';
			case 'dashboard.widgets.balance.description': return 'Status keuangan menyeluruh';
			case 'dashboard.widgets.quickActions.title': return 'Aksi Cepat';
			case 'dashboard.widgets.quickActions.description': return 'Pintasan cepat';
			case 'dashboard.widgets.wallets.title': return 'Dompet';
			case 'dashboard.widgets.wallets.description': return 'Ringkasan jumlah uang';
			case 'dashboard.widgets.loans.title': return 'Pinjaman';
			case 'dashboard.widgets.loans.description': return 'Uang masuk dan keluar dari pinjaman';
			case 'dashboard.widgets.transactions.title': return 'Transaksi';
			case 'dashboard.widgets.transactions.description': return 'Aktivitas terbaru';
			case 'dashboard.widgets.categoryBreakdown.title': return 'Rincian Kategori';
			case 'dashboard.widgets.categoryBreakdown.description': return 'Pengeluaran bulan ini';
			case 'dashboard.widgets.categoryBreakdown.empty_message': return 'Belum ada pengeluaran.';
			case 'dashboard.widgets.categoryBreakdown.others': return 'Lainnya';
			case 'dashboard.widgets.categoryBreakdown.back': return 'Kembali';
			case 'dashboard.widgets.categoryBreakdown.monthlyBudget': return 'Anggaran bulanan';
			case 'dashboard.widgets.categoryBreakdown.leftover': return ({required Object amount}) => 'Tersisa ${amount} dari penghasilan.';
			case 'dashboard.widgets.categoryBreakdown.exceeded': return ({required Object amount}) => 'Pengeluaran melebih penghasilan sebesar ${amount}.';
			case 'dashboard.widgets.categoryBreakdown.noIncome': return ({required Object amount}) => 'Pengeluaran: ${amount} (Belum ada penghasilan)';
			case 'dashboard.widgets.chartAccounts.title': return 'Bagan Akun';
			case 'dashboard.widgets.chartAccounts.description': return 'Struktur semua akun';
			case 'dashboard.widgets.creditCards.title': return 'Kartu Kredit';
			case 'dashboard.widgets.creditCards.description': return 'Batas dan tagihan kartu';
			case 'dashboard.widgets.settings.title': return 'Atur Dashboard';
			case 'dashboard.widgets.settings.subtitle': return 'Geser dan atur widget sesuai keinginanmu.';
			case 'dashboard.widgets.settings.reset.button': return 'Kembalikan ke awal';
			case 'dashboard.widgets.settings.reset.dialogTitle': return 'Atur Ulang Tata Letak';
			case 'dashboard.widgets.settings.reset.dialogContent': return 'Ingin mengatur ulang dashboard seperti semula?';
			case 'dashboard.widgets.settings.reset.cancel': return 'Batal';
			case 'dashboard.widgets.settings.reset.confirm': return 'Atur ulang';
			case 'dashboard.widgets.settings.reset.success': return 'Tata letak berhasil diatur ulang';
			case 'dashboard.widgets.settings.saveSuccess': return 'Berhasil disimpan!';
			case 'dashboard.widgets.settings.saveError': return ({required Object error}) => 'Gagal menyimpan: ${error}';
			case 'dashboard.widgets.settings.saving': return 'Menyimpan...';
			case 'dashboard.widgets.settings.save': return 'Simpan Layout';
			case 'wallets.title': return 'Dompet';
			case 'wallets.empty.title': return 'Tidak ada dompet';
			case 'wallets.empty.message': return 'Buat dompet pertamamu untuk mulai melacak uang.';
			case 'wallets.empty.action': return 'Buat Dompet';
			case 'wallets.emptyArchived.title': return 'Tidak ada yang diarsipkan';
			case 'wallets.emptyArchived.message': return 'Dompet yang diarsipkan akan muncul di sini.';
			case 'wallets.filter.active': return 'Aktif';
			case 'wallets.filter.archived': return 'Diarsipkan';
			case 'wallets.filter.all': return 'Semua';
			case 'wallets.form.newTitle': return 'Dompet Baru';
			case 'wallets.form.editTitle': return 'Ubah Dompet';
			case 'wallets.form.name': return 'Nama dompet';
			case 'wallets.form.namePlaceholder': return 'Contoh: BCA, OVO, Dompet Tunai';
			case 'wallets.form.nameRequired': return 'Nama wajib diisi';
			case 'wallets.form.description': return 'Keterangan';
			case 'wallets.form.descriptionPlaceholder': return 'Untuk apa dompet ini? (opsional)';
			case 'wallets.form.currency': return 'Mata uang';
			case 'wallets.form.currencyLockedByParent': return 'Terkunci pada dompet utama';
			case 'wallets.form.parent': return 'Dompet Induk (opsional)';
			case 'wallets.form.parentEmpty': return 'Tidak ada dompet induk';
			case 'wallets.form.chartAccount': return 'Bagan akun';
			case 'wallets.form.chartAccountLocked': return 'Tidak dapat diubah';
			case 'wallets.form.createSuccess': return 'Dompet berhasil dibuat';
			case 'wallets.form.updateSuccess': return 'Berhasil diubah';
			case 'wallets.form.loadParentError': return ({required Object error}) => 'Error: ${error}';
			case 'wallets.form.loadChartAccountError': return ({required Object error}) => 'Error: ${error}';
			case 'wallets.delete.dialogTitle': return 'Hapus Dompet';
			case 'wallets.delete.dialogMessage': return ({required Object name}) => 'Kamu yakin? ${name} dan seluruh isinya akan dihapus permanen.';
			case 'wallets.delete.cancel': return 'Batal';
			case 'wallets.delete.confirm': return 'Hapus';
			case 'wallets.delete.success': return 'Dompet dihapus';
			case 'wallets.delete.error': return ({required Object error}) => 'Gagal: ${error}';
			case 'wallets.errors.load': return 'Gagal memuat dompet';
			case 'wallets.errors.retry': return 'Coba lagi';
			case 'wallets.errors.comingSoon': return ({required Object name}) => '${name} segera hadir';
			case 'wallets.subtitle.mainAccount': return 'Akun utama';
			case 'wallets.subtitle.cashDigital': return 'Tunai & Digital';
			case 'wallets.subtitle.count': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('id'))(n,
				one: '${n} dompet',
				other: '${n} dompet',
			);
			case 'wallets.subtitle.account': return 'Akun';
			case 'wallets.subtitle.physicalCash': return 'Uang Tunai Fisik';
			case 'wallets.subtitle.digitalWallet': return 'Dompet Digital';
			case 'wallets.options.viewTransactions': return 'Lihat transaksi';
			case 'wallets.options.viewTransactionsSubtitle': return 'Lihat riwayat dompet';
			case 'wallets.options.transferFunds': return 'Transfer uang';
			case 'wallets.options.transferFundsSubtitle': return 'Pindahkan uang ke dompet lain';
			case 'wallets.options.editWallet': return 'Ubah';
			case 'wallets.options.editWalletSubtitle': return 'Ganti nama dan warna dompet';
			case 'wallets.options.duplicateWallet': return 'Duplikat';
			case 'wallets.options.duplicateWalletSubtitle': return 'Buat salinan';
			case 'wallets.options.archiveWallet': return 'Arsipkan';
			case 'wallets.options.archiveWalletSubtitle': return 'Sembunyikan dompet ini';
			case 'wallets.options.unarchiveWallet': return 'Batal arsip';
			case 'wallets.options.unarchiveWalletSubtitle': return 'Kembalikan dompet ini';
			case 'wallets.options.deleteWallet': return 'Hapus';
			case 'wallets.options.deleteWalletSubtitle': return 'Hapus permanen';
			case 'wallets.options.defaultTitle': return 'Dompet';
			case 'loans.title': return 'Pinjaman';
			case 'loans.filter.active': return 'Aktif';
			case 'loans.filter.history': return 'Riwayat';
			case 'loans.filter.all': return 'Semua';
			case 'loans.filter.pending': return 'Tertunda';
			case 'loans.filter.lent': return 'Diutangkan';
			case 'loans.filter.borrowed': return 'Dihutangkan';
			case 'loans.summary.netBalance': return 'SALDO BERSIH';
			case 'loans.summary.activeLoans': return 'PINJAMAN AKTIF';
			case 'loans.summary.noActive': return 'Semua bersih';
			case 'loans.summary.lent': return ({required Object n}) => '${n} dipinjam';
			case 'loans.summary.borrowed': return ({required Object n}) => '${n} meminjam';
			case 'loans.summary.pending': return ({required Object n}) => '${n} tertunda';
			case 'loans.card.lent': return 'Uang Keluar';
			case 'loans.card.borrowed': return 'Uang Masuk';
			case 'loans.card.active': return ({required Object n}) => '${n} aktif';
			case 'loans.card.multiple': return ({required Object n}) => '${n} pinjaman';
			case 'loans.card.transactions': return ({required Object n}) => '${n} transaksi';
			case 'loans.card.overdue': return ({required Object n}) => 'Telat ${n} hari';
			case 'loans.card.due': return ({required Object date}) => 'Jatuh tempo ${date}';
			case 'loans.form.newTitle': return 'Pinjaman Baru';
			case 'loans.form.editTitle': return 'Ubah Pinjaman';
			case 'loans.form.type': return 'Jenis';
			case 'loans.form.lend': return 'Saya meminjamkan';
			case 'loans.form.borrow': return 'Saya berutang';
			case 'loans.form.contact': return 'Kontak';
			case 'loans.form.contactPlaceholder': return 'Kepada/Dari siapa?';
			case 'loans.form.account': return 'Dari Akun';
			case 'loans.form.accountPlaceholder': return 'Pilih akun';
			case 'loans.form.amount': return 'Jumlah';
			case 'loans.form.description': return 'Keterangan';
			case 'loans.form.date': return 'Tanggal';
			case 'loans.form.dueDate': return 'Jatuh Tempo';
			case 'loans.form.selectDate': return 'Pilih tanggal';
			case 'loans.form.optional': return '(Opsional)';
			case 'loans.form.createTransaction': return 'Buat transaksi di dompet';
			case 'loans.form.recordAutomatically': return 'Catat otomatis';
			case 'loans.form.transactionCategory': return 'Kategori transaksi';
			case 'loans.form.category': return 'Kategori';
			case 'loans.form.categoryPlaceholder': return 'Pilih kategori';
			case 'loans.form.save': return 'Simpan';
			case 'loans.form.successCreate': return 'Pinjaman berhasil dicatat!';
			case 'loans.form.successUpdate': return 'Pinjaman diperbarui';
			case 'loans.form.contactRequired': return 'Kontak wajib diisi';
			case 'loans.form.accountRequired': return 'Akun wajib diisi';
			case 'loans.form.amountRequired': return 'Jumlah wajib diisi';
			case 'loans.detail.title': return 'Detail';
			case 'loans.detail.deleteTitle': return 'Hapus Pinjaman';
			case 'loans.detail.deleteMessage': return 'Kamu yakin ingin menghapus catatan pinjaman ini?';
			case 'loans.detail.deleteSuccess': return 'Berhasil dihapus.';
			case 'loans.detail.deleteError': return ({required Object error}) => 'Gagal menghapus: ${error}';
			case 'loans.detail.notFound': return 'Tidak ditemukan';
			case 'loans.detail.progress': return 'Progres Pembayaran';
			case 'loans.detail.info': return 'Informasi';
			case 'loans.detail.pay': return 'Bayar / Terima';
			case 'loans.detail.viewHistory': return 'Lihat Seluruh Riwayat';
			case 'loans.detail.original': return ({required Object amount}) => 'Jumlah awal: ${amount}';
			case 'loans.detail.section': return 'Detail';
			case 'loans.detail.activeSummary': return 'Ringkasan';
			case 'loans.detail.activeLent': return 'Diutangkan (Aktif)';
			case 'loans.detail.activeBorrowed': return 'Meminjam (Aktif)';
			case 'loans.detail.activeNet': return 'Saldo Bersih (Aktif)';
			case 'loans.detail.activeTotal': return 'Total Aktif';
			case 'loans.detail.startDate': return 'Tanggal Mulai';
			case 'loans.detail.dueDate': return 'Tanggal Jatuh Tempo';
			case 'loans.detail.type.label': return 'Jenis';
			case 'loans.detail.type.personal': return 'Pinjaman Pribadi';
			case 'loans.detail.type.borrowed': return 'Uang Pinjaman';
			case 'loans.detail.type.auto': return 'Kredit Kendaraan';
			case 'loans.detail.type.mortgage': return 'KPR / Hipotek';
			case 'loans.detail.type.student': return 'Pinjaman Pendidikan';
			case 'loans.detail.payment.history': return 'Riwayat Pembayaran';
			case 'loans.detail.payment.date': return ({required Object date}) => 'Dibayar ${date}';
			case 'loans.detail.payment.transactionId': return ({required Object id}) => 'ID: ${id}';
			case 'loans.detail.payment.paid': return ({required Object amount}) => 'Terbayar ${amount}';
			case 'loans.detail.payment.remaining': return ({required Object amount}) => 'Sisa ${amount}';
			case 'loans.history.title': return 'Riwayat Pinjaman';
			case 'loans.history.section': return 'Semua Pinjaman';
			case 'loans.history.totalLoaned': return 'Total jumlah';
			case 'loans.history.noLoans': return 'Tidak ada pinjaman ditemukan.';
			case 'loans.history.filter.all': return 'Semua';
			case 'loans.history.filter.lent': return 'Diutangkan';
			case 'loans.history.filter.borrowed': return 'Meminjam';
			case 'loans.history.filter.completed': return 'Lunas';
			case 'loans.history.filter.title': return 'Filter';
			case 'loans.history.filter.reset': return 'Reset';
			case 'loans.history.filter.apply': return 'Terapkan';
			case 'loans.history.filter.dateRange': return 'Rentang waktu';
			case 'loans.history.filter.amountRange': return 'Rentang jumlah';
			case 'loans.history.filter.startDate': return 'Mulai';
			case 'loans.history.filter.endDate': return 'Selesai';
			case 'loans.history.filter.select': return 'Pilih';
			case 'loans.history.headers.lent': return 'Uang yang Kamu Pinjamkan';
			case 'loans.history.headers.borrowed': return 'Uang yang Kamu Pinjam';
			case 'loans.history.headers.completed': return 'Sudah Lunas';
			case 'loans.history.headers.active': return 'Pinjaman Aktif';
			case 'loans.history.headers.cancelled': return 'Dibatalkan';
			case 'loans.history.headers.writtenOff': return 'Diikhlaskan / Dihapus';
			case 'loans.history.item.defaultTitle': return 'Pinjaman';
			case 'loans.history.item.date': return ({required Object date}) => 'Tanggal: ${date}';
			case 'loans.history.item.lent': return 'Meminjamkan';
			case 'loans.history.item.borrowed': return 'Berutang';
			case 'loans.history.item.status.completed': return 'Lunas';
			case 'loans.history.item.status.active': return 'Aktif';
			case 'loans.history.item.status.cancelled': return 'Batal';
			case 'loans.history.item.status.writtenOff': return 'Dihapus';
			case 'loans.history.summary.title': return 'Ringkasan Pinjaman';
			case 'loans.history.summary.viewDetails': return 'Lihat detail';
			case 'loans.history.summary.hideDetails': return 'Sembunyikan detail';
			case 'loans.history.summary.outstandingLent': return 'Orang lain berutang ke kamu';
			case 'loans.history.summary.outstandingBorrowed': return 'Kamu berutang ke orang lain';
			case 'loans.history.summary.netPosition': return 'Posisi Bersih';
			case 'loans.history.summary.totalLent': return 'Total Dipinjamkan';
			case 'loans.history.summary.totalBorrowed': return 'Total Berutang';
			case 'loans.history.summary.totalRepaidToYou': return 'Total Dibayar Kepadamu';
			case 'loans.history.summary.totalYouRepaid': return 'Total Kamu Bayar';
			case 'loans.history.summary.totalLoans': return 'Total Jumlah Pinjaman';
			case 'loans.history.summary.completedLoans': return 'Pinjaman Lunas';
			case 'loans.contactDetail.titleWith': return ({required Object name}) => 'Pinjaman dengan ${name}';
			case 'loans.share.title': return 'Bagikan';
			case 'loans.share.contactTitle': return 'Bagikan Ringkasan';
			case 'loans.share.button': return 'Kirim';
			case 'loans.share.copy': return 'Salin';
			case 'loans.share.message': return 'Berikut ringkasan pinjamannya:';
			case 'loans.share.contactMessage': return ({required Object name}) => 'Ringkasan utang dengan ${name}:';
			case 'loans.share.error': return ({required Object error}) => 'Gagal: ${error}';
			case 'loans.share.contactCopied': return 'Disalin ke papan klip!';
			case 'loans.share.activeLoans': return ({required Object n}) => 'Pinjaman Aktif (${n}):';
			case 'loans.share.loanItem': return ({required Object description, required Object amount, required Object date, required Object percent}) => '• ${description}: ${amount} (${date}) - ${percent}% lunas';
			case 'loans.share.loanStatement': return 'MoneyT - Rekap Pinjaman';
			case 'loans.share.loanSummary': return 'MoneyT - Ringkasan';
			case 'loans.share.personalLoan': return 'Pinjaman Pribadi';
			case 'loans.share.remaining': return ({required Object amount}) => 'Sisa: ${amount}';
			case 'loans.share.remainingLabel': return 'Sisa saldo';
			case 'loans.share.original': return ({required Object amount}) => 'dari total ${amount}';
			case 'loans.share.progress': return ({required Object percent}) => 'Progres: ${percent}% lunas';
			case 'loans.share.progressLabel': return 'Progres';
			case 'loans.share.paidSuffix': return 'Lunas';
			case 'loans.share.date': return ({required Object date}) => 'Tanggal: ${date}';
			case 'loans.share.dateLabel': return 'Tanggal';
			case 'loans.share.contact': return ({required Object name}) => 'Kontak: ${name}';
			case 'loans.share.contactLabel': return 'Kontak';
			case 'loans.share.generated': return ({required Object date}) => 'Dibuat pada ${date}';
			case 'loans.share.generatedLabel': return ({required Object date}) => 'Dibuat pada ${date}';
			case 'loans.share.totalActive': return ({required Object n}) => 'Total Aktif: ${n}';
			case 'loans.share.active': return 'aktif';
			case 'loans.share.poweredBy': return 'Didukung oleh MoneyT • moneyt.io';
			case 'loans.share.copied': return 'Berhasil disalin!';
			case 'loans.share.netBalance': return ({required Object amount, required Object status}) => 'Saldo Bersih: ${amount} (${status})';
			case 'loans.share.netBalanceLabel': return 'Saldo Bersih';
			case 'loans.share.owed': return 'Kamu menerima';
			case 'loans.share.owe': return 'Kamu berutang';
			case 'loans.share.lent': return ({required Object amount}) => 'Kamu meminjamkan: ${amount}';
			case 'loans.share.lentLabel': return 'Kamu meminjamkan';
			case 'loans.share.borrowed': return ({required Object amount}) => 'Kamu meminjam: ${amount}';
			case 'loans.share.borrowedLabel': return 'Kamu meminjam';
			case 'loans.share.contactSummary': return ({required Object name}) => 'Ringkasan - ${name}';
			case 'loans.payment.title': return 'Catat Pembayaran';
			case 'loans.payment.amount': return 'Berapa jumlahnya?';
			case 'loans.payment.amountPlaceholder': return '0';
			case 'loans.payment.amountRequired': return 'Masukkan jumlah';
			case 'loans.payment.invalidAmount': return 'Jumlah tidak valid';
			case 'loans.payment.exceedsBalance': return 'Melebihi sisa pinjaman';
			case 'loans.payment.date': return 'Tanggal pembayaran';
			case 'loans.payment.account': return 'Melalui akun mana?';
			case 'loans.payment.selectAccount': return 'Pilih akun';
			case 'loans.payment.details': return 'Catatan tambahan';
			case 'loans.payment.detailsPlaceholder': return 'Tambahkan catatan... (opsional)';
			case 'loans.payment.success': return 'Pembayaran berhasil dicatat';
			case 'loans.payment.error': return ({required Object error}) => 'Gagal: ${error}';
			case 'loans.payment.errorAmount': return 'Jumlah tidak valid';
			case 'loans.payment.errorAccount': return 'Pilih akun';
			case 'loans.payment.errorLoading': return ({required Object error}) => 'Gagal memuat: ${error}';
			case 'loans.payment.summary.title': return 'Ringkasan';
			case 'loans.payment.summary.defaultTitle': return 'Pinjaman';
			case 'loans.payment.summary.amount': return 'Jumlah pembayaran';
			case 'loans.payment.summary.remaining': return 'Sisa saldo';
			case 'loans.payment.summary.progress': return 'Progres terbaru';
			case 'loans.payment.summary.description': return ({required Object loan, required Object contact}) => '${loan} untuk ${contact}';
			case 'loans.payment.summary.unknownContact': return 'Tidak Dikenal';
			case 'loans.payment.summary.total': return ({required Object amount}) => 'Total ${amount}';
			case 'loans.payment.summary.paid': return ({required Object amount}) => 'Lunas ${amount}';
			case 'loans.payment.summary.remainingLabel': return ({required Object amount}) => 'Sisa ${amount}';
			case 'loans.payment.quick.full': return ({required Object amount}) => 'Lunas Penuh (${amount})';
			case 'loans.payment.quick.half': return ({required Object amount}) => 'Setengah (${amount})';
			case 'loans.given': return 'Diberikan';
			case 'loans.received': return 'Diterima';
			case 'loans.item.due': return ({required Object date}) => 'Batas: ${date}';
			case 'loans.item.paidAmount': return ({required Object amount}) => 'Lunas: ${amount}';
			case 'loans.item.remaining': return ({required Object amount}) => 'Sisa: ${amount}';
			case 'loans.item.percentPaid': return ({required Object percent}) => '${percent}%';
			case 'loans.section.activeLoans': return 'Pinjaman Aktif';
			case 'loans.section.loansCount': return ({required Object n}) => '${n} pinjaman';
			case 'loans.empty.title': return 'Tidak ada pinjaman aktif';
			case 'loans.empty.message': return 'Tenang rasanya tanpa utang piutang.';
			case 'loans.empty.action': return 'Catat Pinjaman';
			case 'categories.title': return 'Kategori';
			case 'categories.form.newTitle': return 'Kategori Baru';
			case 'categories.form.editTitle': return 'Ubah Kategori';
			case 'categories.form.name': return 'Nama kategori';
			case 'categories.form.namePlaceholder': return 'Contoh: Makanan, Transport, Belanja';
			case 'categories.form.nameRequired': return 'Nama kategori wajib';
			case 'categories.form.parent': return 'Kategori Induk (opsional)';
			case 'categories.form.noParent': return 'Tanpa kategori induk';
			case 'categories.form.asSubcategory': return 'Akan menjadi sub-kategori';
			case 'categories.form.asRoot': return 'Akan menjadi kategori utama';
			case 'categories.form.active': return 'Aktif';
			case 'categories.form.activeDescription': return 'Bisa dipilih saat membuat transaksi';
			case 'categories.form.selectIcon': return 'Pilih Ikon';
			case 'categories.form.selectColor': return 'Pilih Warna';
			case 'categories.form.saveSuccess': return 'Kategori disimpan!';
			case 'categories.form.saveError': return ({required Object error}) => 'Gagal menyimpan: ${error}';
			case 'categories.parentSelection.title': return 'Pilih induk kategori';
			case 'categories.parentSelection.subtitle': return 'Ke mana kategori ini masuk?';
			case 'categories.parentSelection.noParent': return 'Tanpa induk (Utama)';
			case 'categories.incomeCategory': return 'Kategori Pemasukan';
			case 'categories.expenseCategory': return 'Kategori Pengeluaran';
			case 'categories.report.title': return 'Laporan Lanjutan';
			case 'categories.report.timeFilter': return 'Rentang Waktu';
			case 'categories.report.thisMonth': return 'Bulan Ini';
			case 'categories.report.lastMonth': return 'Bulan Lalu';
			case 'categories.report.thisYear': return 'Tahun Ini';
			case 'categories.report.allTime': return 'Sepanjang Waktu';
			case 'categories.report.details': return 'Detail';
			case 'categories.report.noTransactions': return 'Tidak ada transaksi';
			case 'categories.report.income': return 'Pemasukan';
			case 'categories.report.expense': return 'Pengeluaran';
			case 'backups.title': return 'Cadangan Data';
			case 'backups.menu.settings': return 'Pengaturan Cadangan';
			case 'backups.menu.comingSoon': return 'Akan segera hadir';
			case 'backups.filters.all': return 'Semua';
			case 'backups.filters.auto': return 'Otomatis';
			case 'backups.filters.manual': return 'Manual';
			case 'backups.filters.thisMonth': return 'Bulan Ini';
			case 'backups.filters.lastMonth': return 'Bulan Lalu';
			case 'backups.filters.thisYear': return 'Tahun Ini';
			case 'backups.filters.lastYear': return 'Tahun Lalu';
			case 'backups.status.loading': return 'Memuat...';
			case 'backups.status.error': return 'Gagal memuat daftar';
			case 'backups.status.empty': return 'Belum ada cadangan';
			case 'backups.status.emptyAction': return 'Tekan tombol + untuk mencadangkan data';
			case 'backups.status.success': return 'Selesai!';
			case 'backups.status.created': return 'Data berhasil diamankan.';
			case 'backups.status.createError': return ({required Object error}) => 'Gagal membuat: ${error}';
			case 'backups.status.restoreError': return ({required Object error}) => 'Gagal memulihkan: ${error}';
			case 'backups.status.deleteError': return ({required Object error}) => 'Gagal menghapus: ${error}';
			case 'backups.actions.create': return 'Buat Cadangan';
			case 'backups.actions.import': return 'Impor File';
			case 'backups.actions.restore': return 'Pulihkan Data';
			case 'backups.actions.delete': return 'Hapus';
			case 'backups.actions.share': return 'Bagikan';
			case 'backups.actions.cancel': return 'Batal';
			case 'backups.actions.retry': return 'Coba Lagi';
			case 'backups.actions.ok': return 'OK';
			case 'backups.dialogs.info.title': return 'Informasi File';
			case 'backups.dialogs.info.file': return 'Nama:';
			case 'backups.dialogs.info.size': return 'Ukuran:';
			case 'backups.dialogs.info.created': return 'Dibuat pada:';
			case 'backups.dialogs.info.transactions': return 'Transaksi:';
			case 'backups.dialogs.restore.title': return 'Pulihkan Data';
			case 'backups.dialogs.restore.content': return ({required Object file}) => 'Anda yakin ingin memulihkan dari file "${file}"? Data saat ini akan ditimpa seluruhnya.';
			case 'backups.dialogs.restore.success': return 'Memulihkan data... Aplikasi akan dimulai ulang.';
			case 'backups.dialogs.delete.title': return 'Hapus Cadangan';
			case 'backups.dialogs.delete.content': return ({required Object file}) => 'Yakin ingin menghapus "${file}"? File ini akan hilang secara permanen.';
			case 'backups.dialogs.delete.success': return 'Berhasil dihapus.';
			case 'backups.stats.title': return 'Statistik Cadangan';
			case 'backups.stats.totalBackups': return 'Total Cadangan';
			case 'backups.stats.totalSize': return 'Total Ukuran';
			case 'backups.stats.oldest': return 'Paling Lama';
			case 'backups.stats.latest': return 'Terbaru';
			case 'backups.stats.autoBackupStatus': return 'Cadangan Otomatis';
			case 'backups.stats.active': return 'Menyala';
			case 'backups.stats.inactive': return 'Mati';
			case 'backups.options.restore.title': return 'Pulihkan';
			case 'backups.options.restore.subtitle': return 'Timpa data saat ini dengan file ini';
			case 'backups.options.share.title': return 'Bagikan';
			case 'backups.options.share.subtitle': return 'Kirim file ini';
			case 'backups.options.delete.title': return 'Hapus';
			case 'backups.options.delete.subtitle': return 'Ini tidak dapat dikembalikan';
			case 'backups.options.latestBadge': return 'Terbaru';
			case 'backups.options.latestFile': return 'File paling baru';
			case 'backups.options.backupFile': return 'File zip cadangan';
			case 'backups.format.auto': return ({required Object date}) => 'Otomatis - ${date}';
			case 'backups.format.manual': return ({required Object date}) => 'Manual - ${date}';
			case 'backups.format.initial': return 'Cadangan Awal';
			case 'backups.format.generic': return ({required Object date}) => 'Cadangan - ${date}';
			case 'v2.voice.errorProcessing': return 'Gak kedengeran, bos. Coba ulang lagi?';
			case 'v2.voice.tapMicrophone': return 'Tekan mic buat mulai ngomong';
			case 'v2.voice.listening': return 'Lagi dengerin nih...';
			case 'v2.voice.missingApiKey': return 'Bro, GEMINI_API_KEY di file .env nya belum ada.';
			case 'v2.voice.aiError': return ({required Object error}) => 'AI lagi error: ${error}';
			case 'v2.voice.cancel': return 'Batalin';
			case 'v2.voice.scan': return 'Scan struk';
			case 'v2.transactions.invalidAmount': return 'Angka yang bener dong masukinnya.';
			case 'v2.transactions.selectAccount': return 'Ini keluar dari dompet mana?';
			case 'v2.transactions.selectCategory': return 'Kategori apaan nih?';
			case 'v2.transactions.errorCreatingCategory': return ({required Object error}) => 'Gagal bikin kategori baru: ${error}';
			case 'v2.transactions.error': return ({required Object error}) => 'Error euy: ${error}';
			case 'v2.transactions.more': return 'Lainnya';
			case 'v2.transactions.expense': return 'Pengeluaran';
			case 'v2.transactions.income': return 'Pemasukan';
			case 'v2.transactions.deleteTransaction': return 'Beneran mau hapus catatan ini?';
			case 'v2.transactions.cancel': return 'Gak jadi';
			case 'v2.transactions.delete': return 'Hapus';
			case 'v2.transactions.yesterday': return 'Kemarin';
			case 'v2.transactions.usedCategories': return 'SERING DIPAKAI';
			case 'v2.transactions.noTransactions': return 'Belum ada pengeluaran hari ini';
			case 'v2.transactions.recentActivity': return 'Aktivitas Terakhir';
			case 'v2.transactions.searchTransaction': return 'Nyari pengeluaran apa...';
			case 'v2.transactions.date': return 'Kapan';
			case 'v2.transactions.wallet': return 'Dari Mana';
			case 'v2.transactions.transactionDeleted': return 'Udah dihapus.';
			case 'v2.transactions.selectCategoryTitle': return 'Masuk ke mana?';
			case 'v2.transactions.searchCategory': return 'Cari kategori...';
			case 'v2.transactions.noCategoriesAvailable': return 'Masih kosong';
			case 'v2.transactions.createNewCategory': return 'Bikin kategori baru';
			case 'v2.transactions.amount': return 'BERAPA';
			case 'v2.transactions.description': return 'BUAT APA';
			case 'v2.transactions.category': return 'KATEGORI';
			case 'v2.transactions.addNote': return 'Kasih catatan tambahan...';
			case 'v2.transactions.today': return 'Hari Ini';
			case 'v2.transactions.editTransaction': return 'Edit dulu';
			case 'v2.transactions.newTransaction': return 'Catat Baru';
			case 'v2.transactions.selectWallet': return 'Pilih Dompet';
			case 'v2.transactions.save': return 'Simpan';
			case 'v2.transactions.transactionUpdated': return 'Sip, udah diupdate.';
			case 'v2.transactions.transactionSaved': return 'Oke, udah kesimpen.';
			case 'v2.settings.title': return 'Atur-atur';
			case 'v2.settings.categories': return 'Kategori Pengeluaran';
			case 'v2.settings.wallets': return 'Akun & Dompet';
			case 'v2.settings.language': return 'Bahasa';
			case 'v2.settings.currency': return 'Mata Uang';
			case 'v2.settings.contact': return 'Hubungi Kita';
			case 'v2.settings.legacyView': return 'Balik ke Tampilan Lama';
			case 'v2.settings.deleteCategory': return 'Hapus kategori ini?';
			case 'v2.settings.deleteWallet': return 'Hapus dompet ini?';
			case 'v2.settings.cannotUndo': return 'Yakin nih? Kalo udah ilang gak bisa balik lho.';
			case 'v2.settings.deleteWalletWarning': return 'Awas, semua riwayat pengeluaran di dompet ini bakal ikut kehapus.';
			case 'v2.settings.deleteError': return ({required Object error}) => 'Gagal hapus: ${error}';
			case 'v2.settings.noCategoriesCreated': return 'Belum ada kategori nih.\nBikin satu dulu gih.';
			case 'v2.settings.noWalletsCreated': return 'Dompet aja belum punya.\nTambahin dulu lah.';
			case 'v2.settings.walletDeleted': return 'Dompet dihapus, bye.';
			case 'v2.settings.cancel': return 'Batal';
			case 'v2.settings.delete': return 'Iya, Hapus';
			case 'v2.settings.expenses': return 'Keluar';
			case 'v2.settings.income': return 'Masuk';
			case 'v2.settings.newWallet': return 'Dompet Baru';
			case 'v2.settings.editWallet': return 'Edit Dompet';
			case 'v2.settings.walletName': return 'Nama Dompet';
			case 'v2.settings.saveWallet': return 'Simpan Dompet';
			case 'v2.dashboard.greetingMorning': return 'Pagi, bos!';
			case 'v2.dashboard.totalBalance': return 'TOTAL UANG';
			case 'v2.dashboard.dateFilters.thisMonth': return 'Bulan ini';
			case 'v2.dashboard.dateFilters.lastMonth': return 'Bulan kemaren';
			case 'v2.dashboard.dateFilters.customRange': return 'Tanggal lain...';
			case 'v2.dashboard.walletFilters.all': return 'Semua';
			case 'v2.dashboard.walletFilters.allWallets': return 'Semua Dompet';
			case 'v2.dashboard.background.title': return 'Ganti Wallpaper';
			case 'v2.dashboard.background.chooseFromGallery': return 'Pilih dari Galeri';
			case 'v2.dashboard.background.restoreDefault': return 'Balikin kaya semula';
			case 'v2.dashboard.incomeExpense.income': return 'PEMASUKAN';
			case 'v2.dashboard.incomeExpense.expenses': return 'PENGELUARAN';
			case 'v2.dashboard.gauge.exceeded': return 'BONCOS';
			case 'v2.dashboard.gauge.spent': return 'KEPAKAI';
			case 'v2.dashboard.gauge.available': return 'SISA';
			case 'v2.dashboard.gauge.overdrawn': return 'MINUS BOS';
			case 'v2.dashboard.activityList.seeAll': return 'Lihat semua';
			case 'v2.dashboard.activityList.newUi': return 'Tampilan Baru';
			case 'v2.dashboard.activityList.expensesByCategory': return 'Uang Lo Abis Buat Apa Aja';
			case 'v2.dashboard.activityList.noRecentExpenses': return 'Widih, belum jajan!';
			case 'v2.dashboard.activityList.percentOfTotal': return ({required Object percent}) => '${percent}% dari total';
			case 'v2.dashboard.activityList.topExpenses': return ({required Object count}) => 'Top ${count} pengeluaran terboros';
			case 'v2.dashboard.activityList.others': return 'Lain-lain';
			case 'v2.categories.title': return 'Kategori';
			case 'v2.categories.searchPlaceholder': return 'Cari kategori...';
			case 'v2.categories.newCategory': return 'Buat Baru';
			case 'v2.categories.editCategory': return 'Edit';
			case 'v2.categories.noCategories': return 'Kosong melompong';
			case 'v2.categories.form.nameLabel': return 'Nama Kategori';
			case 'v2.categories.form.save': return 'Simpan';
			case 'v2.onboarding.buttons.start': return 'Gas, mulai! 🚀';
			case 'v2.onboarding.buttons.actionContinue': return 'Lanjut';
			case 'v2.onboarding.buttons.great': return 'Mantul!';
			case 'v2.onboarding.buttons.setGoal': return 'Pilih Target';
			case 'v2.onboarding.buttons.skip': return 'Lewatin aja';
			case 'v2.onboarding.splash.title1': return 'Gimana jadinya kalau\nKecerdasan Buatan (AI) ';
			case 'v2.onboarding.splash.title2': return 'ngurusin keuanganmu\nlebih jago dari kamu?';
			case 'v2.onboarding.splash.benefit1': return 'Bebas ribet.';
			case 'v2.onboarding.splash.benefit2': return 'Lebih terpantau.';
			case 'v2.onboarding.splash.benefit3': return 'Keputusan lebih cerdas.';
			case 'v2.onboarding.expenseCategories.title1': return 'Paling sering boncos buat apa tiap bulan?';
			case 'v2.onboarding.expenseCategories.subtitle': return 'Pilih maksimal 3 ya';
			case 'v2.onboarding.expenseCategories.diningOut': return 'Makan di luar / Nongkrong';
			case 'v2.onboarding.expenseCategories.cravings': return 'Ngopi / Jajan receh';
			case 'v2.onboarding.expenseCategories.subscriptions': return 'Langganan Netflix dkk';
			case 'v2.onboarding.expenseCategories.outings': return 'Main sama temen';
			case 'v2.onboarding.expenseCategories.shopping': return 'Check-out Shopee/Tokped';
			case 'v2.onboarding.expenseCategories.delivery': return 'GoFood / GrabFood';
			case 'v2.onboarding.financialGoals.title': return 'Apa yang bisa ngubah\nhidup lo sekarang?';
			case 'v2.onboarding.financialGoals.subtitle': return 'Pilih satu aja yang paling pengen diraih';
			case 'v2.onboarding.financialGoals.trackMoney': return 'Cuma pengen tau duit gue larinya ke mana';
			case 'v2.onboarding.financialGoals.spendLess': return 'Berhenti beli barang gak penting';
			case 'v2.onboarding.financialGoals.lessStress': return 'Gak mau pusing mikirin duit pas akhir bulan';
			case 'v2.onboarding.financialGoals.saveMoney': return 'Beneran bisa nabung buat sesuatu';
			case 'v2.onboarding.registrationMethod.title': return 'Lo prefer nyatet pengeluaran\npakai cara apa?';
			case 'v2.onboarding.registrationMethod.subtitle': return 'Pilih yang gak bikin males';
			case 'v2.onboarding.registrationMethod.voice': return 'Tinggal ngomong ke hp, beres';
			case 'v2.onboarding.registrationMethod.auto': return 'Tarik data dari mutasi bank';
			case 'v2.onboarding.registrationMethod.write': return 'Ketik satu-satu secara manual';
			case 'v2.onboarding.registrationMethod.easy': return 'Pokoknya yang paling cepet aja';
			case 'v2.onboarding.aiAnalysis.loading.title': return 'BENTAR, LAGI DISIAPIN\nAPP-NYA BUAT LO';
			case 'v2.onboarding.aiAnalysis.loading.subtitle': return 'Sedang dianalisis...';
			case 'v2.onboarding.aiAnalysis.loading.messages.0': return 'Lagi merhatiin gaya belanja lo...';
			case 'v2.onboarding.aiAnalysis.loading.messages.1': return 'Nyusun kategori biar pas...';
			case 'v2.onboarding.aiAnalysis.loading.messages.2': return 'Nyari tau di mana lo sering boncos...';
			case 'v2.onboarding.aiAnalysis.loading.messages.3': return 'Ngebangun strategi keuangannya...';
			case 'v2.onboarding.aiAnalysis.showcase.title': return 'Oke, udah kelar!';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.kDefault': return 'Duit lo bocornya cepet banget. Kayaknya cara lo ngatur uang selama ini emang keliru deh.';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.part2': return ' ngabisin jatah uang lo paling gede, dan karena lo pengen ';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.part3': return ' ini tandanya lo butuh ngerubah kebiasaan.';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.categories.diningOut': return 'Sering nongkrong di luar';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.categories.cravings': return 'Jajan receh yang numpuk';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.categories.subscriptions': return 'Langganan numpuk';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.categories.outings': return 'Main terus-terusan';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.categories.shopping': return 'Hobi check-out barang';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.categories.delivery': return 'Ongkir dan pesen antar';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.intentions.trackMoney': return 'nge-track ke mana duit lari';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.intentions.spendLess': return 'ngurangin pemborosan';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.intentions.lessStress': return 'hidup lebih tenang soal uang';
			case 'v2.onboarding.aiAnalysis.showcase.dynamicText.intentions.saveMoney': return 'mulai serius nabung';
			case 'v2.onboarding.aiAnalysis.showcase.result.yourResult': return 'Statistik Lo';
			case 'v2.onboarding.aiAnalysis.showcase.result.average': return 'Orang Biasa';
			case 'v2.onboarding.aiAnalysis.showcase.result.messagePart1': return 'Lo boros 68% ';
			case 'v2.onboarding.aiAnalysis.showcase.result.messagePart2': return 'lebih banyak dibanding rata-rata orang, ';
			case 'v2.onboarding.aiAnalysis.showcase.result.messagePart3': return 'dan jujur ini pelan-pelan\n';
			case 'v2.onboarding.aiAnalysis.showcase.result.messagePart4': return 'ngerusak masa depan keuangan lo';
			case 'v2.onboarding.mainPriority.title': return 'Prioritas utama lo\nsekarang apaan?';
			case 'v2.onboarding.mainPriority.subtitle': return 'Pilih satu hal di mana MoneyT bakal bantu banget';
			case 'v2.onboarding.mainPriority.breakHabits': return 'Ngilangin kebiasaan buruk finansial';
			case 'v2.onboarding.mainPriority.stopStress': return 'Gak mau deg-degan tiap buka dompet';
			case 'v2.onboarding.mainPriority.buildFuture': return 'Pelan-pelan nabung buat masa depan';
			case 'v2.onboarding.mainPriority.feelControl': return 'Gue yang megang kendali duit gue';
			case 'v2.onboarding.mainPriority.saveGoal': return 'Nabung demi satu barang impian';
			case 'v2.onboarding.aiVoice.title.kDefault': return 'Mencapai target lo';
			case 'v2.onboarding.aiVoice.title.breakHabits': return 'Menghilangkan kebiasaan boncos';
			case 'v2.onboarding.aiVoice.title.stopStress': return 'Bikin pikiran tenang tiap bulan';
			case 'v2.onboarding.aiVoice.title.buildFuture': return 'Membangun masa depan mapan';
			case 'v2.onboarding.aiVoice.title.feelControl': return 'Menguasai arus keuangan';
			case 'v2.onboarding.aiVoice.title.saveGoal': return 'Mencapai target nabung lo';
			case 'v2.onboarding.aiVoice.title.suffix': return ' bakal jauh lebih gampang dibantuin Asisten AI.';
			case 'v2.onboarding.aiVoice.subtitle': return 'Gak usah ribet ngetik lagi, tinggal tekan mic dan ngomong santai ke dia.';
			case 'v2.onboarding.aiVoice.listening': return 'Ngomong aja, gue dengerin...';
			case 'v2.onboarding.aiVoice.examples.0': return 'Kopi Rp 35.000';
			case 'v2.onboarding.aiVoice.examples.1': return 'Gojek Rp 45.000';
			case 'v2.onboarding.aiVoice.examples.2': return 'Bioskop Rp 150.000';
			case 'v2.onboarding.aiVoice.examples.3': return 'Belanja Rp 450.000';
			case 'v2.onboarding.aiVoice.examples.4': return 'Bensin Rp 100.000';
			case 'v2.onboarding.aiVoice.examples.5': return 'Netflix Rp 186.000';
			case 'v2.onboarding.aiVoice.examples.6': return 'Makan Rp 120.000';
			case 'v2.onboarding.aiVoice.examples.7': return 'Apotek Rp 85.000';
			default: return null;
		}
	}
}

