import '../base_translations.dart';

class EnTranslations extends BaseTranslations {
  @override
  String get languageCode => 'en';

  // App general
  @override
  String get appName => 'MoneyT';

  // Authentication
  @override
  String get signIn => 'Sign In';

  @override
  String get signUp => 'Sign Up';

  @override
  String get signInWithEmail => 'Sign in with Email';

  @override
  String get signInWithGoogle => 'Sign in with Google';

  @override
  String get skipSignIn => 'Skip Sign In';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get invalidEmail => 'Please enter a valid email';

  @override
  String get password => 'Password';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get passwordTooShort => 'Password must be at least 6 characters';

  @override
  String get passwordResetEmailSent => 'Password reset email sent successfully';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get alreadyHaveAccount => 'Already have an account? Sign in';

  @override
  String get dontHaveAccount => "Don't have an account? Sign up";

  @override
  String get termsAndConditions => 'Terms and Conditions';

  @override
  String get acceptTerms => 'I accept the Terms and Conditions';

  @override
  String get acceptTermsAndConditions => 'I accept the Terms and Conditions';

  @override
  String get acceptMarketing => 'I would like to receive marketing emails';

  @override
  String get termsText => 'By using this app, you agree to our Terms of Service and Privacy Policy...';

  @override
  String get readTerms => 'Read Terms and Conditions';

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

  // Contacts
  @override
  String get contacts => 'Contacts';

  @override
  String get selectContact => 'Select Contact';

  @override
  String get searchOrCreateContact => 'Search or type to create contact';

  @override
  String get newContact => 'New Contact';

  @override
  String get editContact => 'Edit Contact';

  @override
  String get deleteContact => 'Delete Contact';

  @override
  String get deleteContactTitle => 'Delete Contact';

  @override
  String get deleteContactMessage => 'Are you sure you want to delete this contact?';

  @override
  String get deleteContactSuccess => 'Contact deleted successfully';

  @override
  String get contactDeleted => 'Contact deleted successfully';

  @override
  String get noContacts => 'No Contacts';

  @override
  String get noContactsDescription => 'You haven\'t added any contacts yet. Add your first contact by tapping the + button.';

  @override
  String get addContact => 'Add Contact';

  @override
  String get contactName => 'Name';

  @override
  String get contactEmail => 'Email';

  @override
  String get contactPhone => 'Phone';

  @override
  String get createContact => 'Create Contact';

  @override
  String get contactNameRequired => 'Contact name is required';

  @override
  String get contactInformation => 'Contact Information';

  @override
  String get importContacts => 'Import Contacts';

  @override
  String get contactsPermissionDenied => 'Permission to access contacts was denied';

  @override
  String get contactsError => 'Error accessing contacts';

  @override
  String get noContactsFound => 'No contacts found with that search';

  @override
  String contactsImported(int count) => '$count contact(s) imported successfully';

  @override
  String contactsImportedMessage(int count) => '$count contact(s) imported successfully';

  @override
  String get pickContact => 'Pick Contact';

  @override
  String get selectFromContacts => 'Select from Contacts';

  @override
  String get search => 'Search';

  @override
  String get allContacts => 'All Contacts';

  @override
  String get all => 'All';

  // Filter related
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

  String get darkTheme => 'Dark Theme';

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
  String get contactSaved => 'Contact saved successfully';

  @override
  String get contactUpdated => 'Contact updated successfully';

  @override
  String get contactCreated => 'Contact created successfully';

  @override
  String get requiredField => 'This field is required';

  @override
  String get sync => 'Sync';

  @override
  String get syncing => 'Syncing...';

  @override
  String get syncSuccess => 'Sync successful';

  @override
  String get syncError => 'Sync error';

  @override
  String get lastSync => 'Last sync';

  @override
  String get syncNever => 'Never';

  @override
  String getText(String key) => key;

  // Backup related
  @override
  String get backup => 'Backup';

  @override
  String get backups => 'Backups';

  @override
  String get createBackup => 'Create Backup';

  @override
  String get restoreBackup => 'Restore Backup';

  @override
  String get deleteBackup => 'Delete Backup';

  @override
  String get noBackups => 'No backups available';

  @override
  String get backupCreated => 'Backup created successfully';

  @override
  String get backupRestored => 'Backup restored successfully';

  @override
  String get backupDeleted => 'Backup deleted successfully';

  @override
  String get backupError => 'Error during backup operation';

  @override
  String get restoreBackupConfirmation => 'Are you sure you want to restore this backup? Current data will be replaced.';

  @override
  String get deleteBackupConfirmation => 'Are you sure you want to delete this backup?';

  @override
  String get backupSettings => 'Backup Settings';

  @override
  String get backupDirectory => 'Backup Directory';

  @override
  String get changeDirectory => 'Change Directory';

  @override
  String get resetDirectory => 'Reset Directory';

  @override
  String get backupDirectoryUpdated => 'Backup directory updated';

  @override
  String get backupDirectoryReset => 'Backup directory reset to default';

  @override
  String get restore => 'Restore';
}
