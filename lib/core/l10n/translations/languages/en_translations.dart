import '../base_translations.dart';

class EnglishTranslations extends BaseTranslations {
  @override
  String get languageCode => 'en';

  // App general
  @override
  String get appName => 'Personal Finance Manager';
  @override
  String get welcome => 'Welcome';
  @override
  String get selectLanguage => 'Select your language';
  @override
  String get continue_ => 'Continue';
  @override
  String get cancel => 'Cancel';
  @override
  String get save => 'Save';
  @override
  String get delete => 'Delete';
  @override
  String get edit => 'Edit';
  @override
  String get add => 'Add';

  // Navigation
  @override
  String get home => 'Home';
  @override
  String get accounts => 'Accounts';
  @override
  String get categories => 'Categories';
  @override
  String get transactions => 'Transactions';
  @override
  String get settings => 'Settings';

  // Account related
  @override
  String get account => 'Account';
  @override
  String get accountName => 'Account name';
  @override
  String get accountDescription => 'Account description';
  @override
  String get balance => 'Balance';
  @override
  String get newAccount => 'New account';
  @override
  String get editAccount => 'Edit account';
  @override
  String get deleteAccount => 'Delete Account';
  @override
  String get deleteAccountConfirmation => 'Are you sure you want to delete this account?';

  // Category related
  @override
  String get category => 'Category';
  @override
  String get categoryName => 'Category name';
  @override
  String get categoryDescription => 'Category description';
  @override
  String get categoryType => 'Category type';
  @override
  String get newCategory => 'New category';
  @override
  String get editCategory => 'Edit category';
  @override
  String get deleteCategory => 'Delete category';
  @override
  String get deleteCategoryConfirmation => 'Are you sure you want to delete this category?';
  @override
  String get income => 'Income';
  @override
  String get expense => 'Expense';

  // Transaction related
  @override
  String get transaction => 'Transaction';
  @override
  String get amount => 'Amount';
  @override
  String get date => 'Date';
  @override
  String get description => 'Description';
  @override
  String get reference => 'Reference';
  @override
  String get newTransaction => 'New transaction';
  @override
  String get editTransaction => 'Edit transaction';
  @override
  String get deleteTransaction => 'Delete transaction';
  @override
  String get deleteTransactionConfirmation => 'Are you sure you want to delete this transaction?';
  @override
  String get transfer => 'Transfer';
  @override
  String get from => 'From';
  @override
  String get to => 'To';

  // Validation messages
  @override
  String get fieldRequired => 'This field is required';
  @override
  String get invalidAmount => 'Invalid amount';
  @override
  String get selectCategory => 'Select a category';
  @override
  String get selectAccount => 'Select an account';

  // Dynamic text retrieval
  final Map<String, String> _translations = {
    'darkTheme': 'Dark Mode',
    'darkThemeDescription': 'Switch between light and dark theme',
    'version': 'Version 1.0.0',
    'recentTransactions': 'Recent Transactions',
    'viewAll': 'View all',
    'noRecentTransactions': 'No recent transactions',
    'noDescription': 'No description',
    'sortDateAsc': 'Date ↑',
    'sortDateDesc': 'Date ↓',
    'sortAmountAsc': 'Amount ↑',
    'sortAmountDesc': 'Amount ↓',
    'all': 'All',
    'filters': 'Filters',
    'apply': 'Apply',
    'noTransactions': 'No transactions',
    'error': 'Error',
    'noAccounts': 'No accounts',
    'noCategories': 'No categories',
    'settings': 'Settings',
    'language': 'Language',
    'deleteAccount': 'Delete Account',
    'deleteAccountConfirmation': 'Are you sure you want to delete this account?',
    'cancel': 'Cancel',
    'delete': 'Delete',
    'edit': 'Edit',
    'unknown': 'Unknown',
  };

  @override
  String get error => getText('error');

  @override
  String get noDescription => getText('noDescription');

  @override
  String get noAccounts => getText('noAccounts');

  @override
  String get noCategories => getText('noCategories');

  @override
  String get noTransactions => getText('noTransactions');

  @override
  String get recentTransactions => getText('recentTransactions');

  @override
  String get viewAll => getText('viewAll');

  @override
  String get noRecentTransactions => getText('noRecentTransactions');

  @override
  String get sortDateAsc => getText('sortDateAsc');

  @override
  String get sortDateDesc => getText('sortDateDesc');

  @override
  String get sortAmountAsc => getText('sortAmountAsc');

  @override
  String get sortAmountDesc => getText('sortAmountDesc');

  @override
  String get all => getText('all');

  @override
  String get filters => getText('filters');

  @override
  String get apply => getText('apply');

  @override
  String get darkTheme => getText('darkTheme');

  @override
  String get darkThemeDescription => getText('darkThemeDescription');

  @override
  String get unknown => getText('unknown');

  @override
  String getText(String key) {
    return _translations[key] ?? key;
  }
}
