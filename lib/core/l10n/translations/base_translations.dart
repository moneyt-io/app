abstract class BaseTranslations {
  String get languageCode;

  // App general
  String get appName;
  String get welcome;
  String get welcomeTitle;
  String get selectLanguage;
  String get continue_;
  String get cancel => 'Cancel';
  String get save;
  String get delete => 'Delete';
  String get edit => 'Edit';
  String get add;
  String get error;
  String get noDescription;
  String get unknown;
  String get notFound => 'Not Found';
  String get required => 'This field is required';
  String get invalidAmount => 'Invalid amount';
  String get restore => 'Restore';

  // Login
  String get signIn => 'Sign In';
  String get signUp => 'Sign Up';
  String get signOut => 'Sign Out';
  String get signInWithGoogle => 'Sign in with Google';
  String get signInWithEmail => 'Sign in with Email';
  String get skipSignIn => 'Skip Sign In';
  String get termsAndConditions => 'Terms and Conditions';
  String get acceptTerms => 'I accept the Terms and Conditions';
  String get acceptTermsAndConditions => 'I accept the Terms and Conditions';
  String get acceptMarketing => 'I would like to receive marketing emails';
  String get termsText => 'By using this app, you agree to our Terms of Service and Privacy Policy...';
  String get readTerms => 'Read Terms and Conditions';
  String get emailRequired => 'Email is required';
  String get invalidEmail => 'Please enter a valid email';
  String get password => 'Password';
  String get passwordRequired => 'Password is required';
  String get passwordTooShort => 'Password must be at least 6 characters';
  String get forgotPassword => 'Forgot Password?';
  String get passwordResetEmailSent => 'Password reset email sent successfully';
  String get alreadyHaveAccount => 'Already have an account? Sign in';
  String get dontHaveAccount => "Don't have an account? Sign up";

  // Auth errors
  String get invalidCredentials => 'Invalid email or password';
  String get emailAlreadyInUse => 'This email is already registered';
  String get weakPassword => 'Password is too weak';
  String get networkError => 'Network error. Please check your connection';
  String get unknownError => 'An unknown error occurred';

  // Navigation
  String get home;
  String get accounts;
  String get categories;
  String get transactions;
  String get settings => 'Settings';

  // Account related
  String get account;
  String get accountName;
  String get accountDescription;
  String get balance;
  String get availableBalance;
  String get selectAccount;
  String get toAccount;
  String get newAccount;
  String get editAccount;
  String get deleteAccount;
  String get deleteAccountConfirmation => 'Are you sure you want to delete this account?';
  String get noAccounts;
  String get accountDeleted => 'Account deleted successfully';

  // Category related
  String get category;
  String get categoryName;
  String get categoryDescription;
  String get selectCategory;
  String get categoryType;
  String get newCategory;
  String get editCategory;
  String get deleteCategory;
  String get deleteCategoryConfirmation => 'Are you sure you want to delete this category?';
  String get income;
  String get expense;
  String get noCategories;
  String get basicInformation;
  String get categoryHierarchy;
  String get mainCategory;
  String get mainCategoryDescription;
  String get subcategory;
  String get subcategoryDescription;
  String get parentCategory;
  String get selectParentCategory;
  String noMainCategoriesAvailable(String type);
  String get errorLoadingCategories;
  String get categoryDeleted => 'Category deleted successfully';

  // Transaction related
  String get transaction;
  String get amount;
  String get details;
  String get additionalInformation;
  String get date;
  String get contact;
  String get description;
  String get reference;
  String get create;
  String get update;
  String get newTransaction;
  String get newIncome;
  String get newExpense;
  String get newTransfer;
  String get editTransaction;
  String get deleteTransaction;
  String get deleteTransactionConfirmation => 'Are you sure you want to delete this transaction?';
  String get transfer;
  String get from;
  String get to;
  String get noTransactions;
  String get recentTransactions;
  String get viewAll;
  String get noRecentTransactions;

  // Transaction Details
  String get transactionDetails => 'Transaction Details';
  String get descriptionDetails => 'Description';
  String get dateDetails => 'Date';
  String get categoryDetails => 'Category';
  String get accountDetails => 'Account';
  String get contactDetails => 'Contact';
  String get referenceDetails => 'Reference';

  // Actions
  String get share => 'Share';
  String get deleteConfirmation => 'Delete Confirmation';

  // Sorting and filtering
  String get sortDateAsc;
  String get sortDateDesc;
  String get sortAmountAsc;
  String get sortAmountDesc;
  String get all;
  String get filters;
  String get apply;

  // Date Ranges
  String get today => 'Today';
  String get yesterday => 'Yesterday';
  String get lastWeek => 'Last Week';
  String get lastMonth => 'Last Month';
  String get lastThreeMonths => 'Last 3 Months';
  String get thisYear => 'This Year';
  String get custom => 'Custom';

  // Filter Labels
  String get filterAll => 'All';
  String get filterIncome => 'Income';
  String get filterExpense => 'Expense';
  String get filterTransfer => 'Transfer';

  // Validation messages
  String get fieldRequired;
  // Theme
  String get appearance => 'Appearance';
  String get darkMode => 'Dark Mode';
  String get darkModeDescription => 'Enable dark mode for better night viewing';

  // Settings
  String get about => 'About';
  String get language => 'Language';
  String get english => 'English';
  String get spanish => 'Spanish';

  // About and Social
  String get webSite => 'Web Site';
  String get linkedIn => 'LinkedIn';
  String get gitHub => 'GitHub';
  String get reddit => 'Reddit';
  String get discord => 'Discord';
  String get email => 'Email';
  String get joinOurCommunity => 'Join our community';

  // Drawer Sections
  String get main => 'Main';
  String get management => 'Management';
  String get preferences => 'Preferences';

  // Balance y Estadísticas
  String get totalBalance => throw UnimplementedError();
  String get monthlyStats => throw UnimplementedError();
  String get expenses => throw UnimplementedError();
  String get monthlyBalance => throw UnimplementedError();

  // Form Fields and Sections
  String get name => 'Name';
  String get nameRequired => 'Name is required';
  String get mainCategoryRequired => 'Please select a main category';
  String get incomeDescription => 'Money coming into your accounts';
  String get expenseDescription => 'Money going out of your accounts';

  // Contacts
  String get contacts;
  String get selectContact => throw UnimplementedError();
  String get searchOrCreateContact => throw UnimplementedError();
  String get newContact;
  String get editContact;
  String get deleteContact;
  String get deleteContactTitle;
  String get deleteContactMessage;
  String get deleteContactSuccess;
  String get noContacts;
  String get noContactsDescription;
  String get contactDeleted => 'Contact deleted successfully';
  String get noContactsMessage => 'No contacts yet. Add your first contact!';
  String get searchContacts => 'Search contacts...';
  String get allContacts;  
  String get addContact => 'Add Contact';
  String get contactName => 'Name';
  String get contactEmail => 'Email';
  String get contactPhone => 'Phone';
  String get contactNotes => 'Notes';
  String get contactUpdated => 'Contact updated successfully';
  String get contactCreated => 'Contact created successfully';
  String get requiredField => 'This field is required';
  String get contactSaved => 'Contact saved successfully';
  String get contactNameRequired;
  String get contactInformation;
  String get createContact;
  String get importContacts;
  String get contactsError;
  String get noContactsFound;
  String get contactsPermissionDenied;
  String contactsImported(int count);
  String contactsImportedMessage(int count);
  String get pickContact;
  String get selectFromContacts;
  String get search;

  // Backup
  String get backups => 'Backups';
  String get backup => 'Backup';
  String get createBackup => 'Create Backup';
  String get restoreBackup => 'Restore Backup';
  String get deleteBackup => 'Delete Backup';
  String get backupSettings => 'Backup Settings';
  String get backupDirectory => 'Backup Directory';
  String get changeDirectory => 'Change Directory';
  String get resetDirectory => 'Reset Directory';
  String get selectBackupDirectory => 'Select Backup Directory';
  String get selectExportDirectory => 'Select Export Directory';
  String get backupDirectoryUpdated => 'Backup directory updated';
  String get backupDirectoryReset => 'Backup directory reset to default';
  String get backupCreated => 'Backup created successfully';
  String get backupRestored => 'Backup restored successfully';
  String get backupDeleted => 'Backup deleted successfully';
  String get backupExported => 'Backup exported successfully';
  String get backupError => 'Error during backup operation';
  String get noBackups => 'No backups available';
  String get restoreBackupConfirmation => 'Are you sure you want to restore this backup? Current data will be replaced.';
  String get deleteBackupConfirmation => 'Are you sure you want to delete this backup?';

  // Database and Settings
  String get data => 'Database';
  String get manageBackups => 'Manage Backups';

  // Sync related
  String get sync => 'Sync';
  String get syncing => 'Syncing...';
  String get syncSuccess => 'Sync successful';
  String get syncError => 'Sync error';
  String get lastSync => 'Last sync';
  String get syncNever => 'Never';

  // Method to get text by key dynamically
  String getText(String key);

  // Method to validate all translations are present
  bool validateTranslations() {
    try {
      // App general
      appName;
      welcome;
      welcomeTitle;
      signIn;
      signUp;
      signInWithEmail;
      emailRequired;
      invalidEmail;
      password;
      passwordRequired;
      passwordTooShort;
      forgotPassword;
      passwordResetEmailSent;
      alreadyHaveAccount;
      dontHaveAccount;
      selectLanguage;
      continue_;
      cancel;
      save;
      delete;
      edit;
      add;
      error;
      noDescription;
      unknown;
      notFound;
      required;
      invalidAmount;
      restore;

      // Auth errors
      invalidCredentials;
      emailAlreadyInUse;
      weakPassword;
      networkError;
      unknownError;

      // Navigation
      home;
      accounts;
      categories;
      transactions;
      settings;

      // Account related
      account;
      accountName;
      accountDescription;
      balance;
      availableBalance;
      selectAccount;
      toAccount;
      newAccount;
      editAccount;
      deleteAccount;
      deleteAccountConfirmation;
      noAccounts;
      accountDeleted;

      // Category related
      category;
      categoryName;
      categoryDescription;
      selectCategory;
      categoryType;
      newCategory;
      editCategory;
      deleteCategory;
      deleteCategoryConfirmation;
      income;
      expense;
      noCategories;
      basicInformation;
      categoryHierarchy;
      mainCategory;
      mainCategoryDescription;
      subcategory;
      subcategoryDescription;
      parentCategory;
      selectParentCategory;
      errorLoadingCategories;
      categoryDeleted;

      // Transaction related
      transaction;
      amount;
      invalidAmount;
      details;
      additionalInformation;
      date;
      contact;
      description;
      reference;
      create;
      update;
      newTransaction;
      newIncome;
      newExpense;
      newTransfer;
      editTransaction;
      deleteTransaction;
      deleteTransactionConfirmation;
      transfer;
      from;
      to;
      noTransactions;
      recentTransactions;
      viewAll;
      noRecentTransactions;

      // Transaction Details
      transactionDetails;
      descriptionDetails;
      dateDetails;
      categoryDetails;
      accountDetails;
      contactDetails;
      referenceDetails;

      // Actions
      share;
      deleteConfirmation;

      // Sorting and filtering
      sortDateAsc;
      sortDateDesc;
      sortAmountAsc;
      sortAmountDesc;
      all;
      filters;
      apply;

      // Date Ranges
      today;
      yesterday;
      lastWeek;
      lastMonth;
      lastThreeMonths;
      thisYear;
      custom;

      // Filter Labels
      filterAll;
      filterIncome;
      filterExpense;
      filterTransfer;

      // Validation messages
      fieldRequired;

      // Theme
      appearance;
      darkMode;
      darkModeDescription;

      // Settings
      about;
      language;
      english;
      spanish;

      // About and Social
      webSite;
      linkedIn;
      gitHub;
      reddit;
      discord;
      email;
      joinOurCommunity;

      // Drawer Sections
      main;
      management;
      preferences;

      // Form Fields and Sections
      name;
      nameRequired;
      mainCategoryRequired;
      incomeDescription;
      expenseDescription;

      // Contacts
      contacts;
      selectContact;
      searchOrCreateContact;
      newContact;
      editContact;
      deleteContact;
      deleteContactTitle;
      deleteContactMessage;
      deleteContactSuccess;
      noContacts;
      noContactsDescription;
      contactDeleted;
      addContact;
      contactName;
      contactEmail;
      contactPhone;
      contactNotes;
      contactUpdated;
      contactCreated;
      contactSaved;
      contactNameRequired;
      searchContacts;
      allContacts;
      contactInformation;
      additionalInformation;
      createContact;
      importContacts;
      contactsError;
      noContactsFound;
      contactsPermissionDenied;
      contactsImported(0);
      contactsImportedMessage(0);
      pickContact;
      selectFromContacts;
      search;

      // Backup
      backups;
      backup;
      createBackup;
      restoreBackup;
      deleteBackup;
      backupSettings;
      backupDirectory;
      changeDirectory;
      resetDirectory;
      selectBackupDirectory;
      selectExportDirectory;
      backupDirectoryUpdated;
      backupDirectoryReset;
      backupCreated;
      backupRestored;
      backupDeleted;
      backupExported;
      backupError;
      noBackups;
      restoreBackupConfirmation;
      deleteBackupConfirmation;

      // Database and Settings
      data;
      manageBackups;

      // Sync related
      sync;
      syncing;
      syncSuccess;
      syncError;
      lastSync;
      syncNever;

      return true;
    } catch (e) {
      return false;
    }
  }
}
