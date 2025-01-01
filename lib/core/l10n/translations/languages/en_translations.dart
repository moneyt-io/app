import '../base_translations.dart';

class EnTranslations extends BaseTranslations {
  @override
  String get languageCode => 'en';

  // App general
  @override
  String get appName => 'MoneyT';

  @override
  String get welcome => 'Welcome';

  @override
  String get welcomeTitle => 'Track your finances with ease';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get continue_ => 'Continue';

  @override
  String get save => 'Save';

  @override
  String get add => 'Add';

  @override
  String get error => 'Error';

  @override
  String get noDescription => 'No description';

  @override
  String get unknown => 'Unknown';

  // Navigation
  @override
  String get home => 'Home';

  @override
  String get accounts => 'Accounts';

  @override
  String get categories => 'Categories';

  @override
  String get transactions => 'Transactions';

  // Account related
  @override
  String get account => 'Account';

  @override
  String get accountName => 'Account Name';

  @override
  String get accountDescription => 'Account Description';

  @override
  String get balance => 'Balance';

  @override
  String get availableBalance => 'Available Balance';

  @override
  String get newAccount => 'New Account';

  @override
  String get editAccount => 'Edit Account';

  @override
  String get deleteAccount => 'Delete Account';

  @override
  String get deleteAccountConfirmation => 'Are you sure you want to delete this account?';

  @override
  String get noAccounts => 'No accounts found';

  // Category related
  @override
  String get category => 'Category';

  @override
  String get categoryName => 'Category Name';

  @override
  String get categoryDescription => 'Category Description';

  @override
  String get newCategory => 'New Category';

  @override
  String get editCategory => 'Edit Category';

  @override
  String get deleteCategory => 'Delete Category';

  @override
  String get deleteCategoryConfirmation => 'Are you sure you want to delete this category?';

  @override
  String get noCategories => 'No categories found';

  @override
  String get basicInformation => 'Basic Information';

  @override
  String get categoryHierarchy => 'Category Hierarchy';

  @override
  String get mainCategory => 'Main Category';

  @override
  String get mainCategoryDescription => 'A main category that can contain subcategories';

  @override
  String get subcategory => 'Subcategory';

  @override
  String get subcategoryDescription => 'A subcategory that belongs to a main category';

  @override
  String get parentCategory => 'Parent Category';

  @override
  String get selectParentCategory => 'Select a parent category';

  @override
  String get categoryType => 'Category type';

  @override
  String noMainCategoriesAvailable(String type) => 'No main $type categories available';

  @override
  String get errorLoadingCategories => 'Error loading categories';

  // Transaction related
  @override
  String get transaction => 'Transaction';

  @override
  String get newTransaction => 'New Transaction';

  @override
  String get editTransaction => 'Edit Transaction';

  @override
  String get deleteTransaction => 'Delete Transaction';

  @override
  String get deleteTransactionConfirmation => 'Are you sure you want to delete this transaction?';

  @override
  String get noTransactions => 'No transactions found';

  @override
  String get amount => 'Amount';

  @override
  String get date => 'Date';

  @override
  String get description => 'Description';

  @override
  String get reference => 'Reference';

  @override
  String get contact => 'Contact';

  @override
  String get details => 'Details';

  @override
  String get additionalInformation => 'Additional Information';

  @override
  String get toAccount => 'To Account';

  @override
  String get income => 'Income';

  @override
  String get expense => 'Expense';

  @override
  String get transfer => 'Transfer';

  @override
  String get newExpense => 'New Expense';

  @override
  String get newIncome => 'New Income';

  @override
  String get newTransfer => 'New Transfer';

  @override
  String get invalidAmount => 'Please enter a valid amount';

  @override
  String get selectAccount => 'Select Account';

  @override
  String get selectCategory => 'Select Category';

  // Filter related
  @override
  String get filter => 'Filter';

  @override
  String get filterAll => 'All';

  @override
  String get filterIncome => 'Income';

  @override
  String get filterExpense => 'Expense';

  @override
  String get filterTransfer => 'Transfer';

  @override
  String get all => 'All';

  @override
  String get apply => 'Apply';

  @override
  String get filters => 'Filters';

  @override
  String get from => 'From';

  @override
  String get to => 'To';

  // Settings related
  @override
  String get settings => 'Settings';

  @override
  String get appearance => 'Appearance';

  @override
  String get about => 'About';

  @override
  String get language => 'Language';

  @override
  String get english => 'English';

  @override
  String get spanish => 'Spanish';

  @override
  String get darkTheme => 'Dark Theme';

  @override
  String get darkThemeDescription => 'Enable dark mode for a better night experience';

  // Form Fields and Sections
  @override
  String get name => 'Name';

  @override
  String get nameRequired => 'Name is required';

  @override
  String get mainCategoryRequired => 'Please select a main category';

  @override
  String get incomeDescription => 'Money coming into your accounts';

  @override
  String get expenseDescription => 'Money going out of your accounts';

  @override
  String get create => 'Create';

  @override
  String get update => 'Update';

  @override
  String get fieldRequired => 'This field is required';

  // Menu sections
  @override
  String get main => 'Main';

  @override
  String get management => 'Management';

  @override
  String get preferences => 'Preferences';

  // Stats and Balance
  @override
  String get totalBalance => 'Total Balance';

  @override
  String get monthlyStats => 'Monthly Stats';

  @override
  String get expenses => 'Expenses';

  @override
  String get monthlyBalance => 'Monthly Balance';

  @override
  String get recentTransactions => 'Recent transactions';

  @override
  String get viewAll => 'View all';

  @override
  String get noRecentTransactions => 'No recent transactions';

  @override
  String get share => 'Share';

  @override
  String get deleteConfirmation => 'Delete confirmation';

  @override
  String get sortDateAsc => 'Date ↑';

  @override
  String get sortDateDesc => 'Date ↓';

  @override
  String get sortAmountAsc => 'Amount ↑';

  @override
  String get sortAmountDesc => 'Amount ↓';

  @override
  String getText(String key) => key;
}
