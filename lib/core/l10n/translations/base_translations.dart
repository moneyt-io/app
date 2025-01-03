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

  // Login
  String get signInWithGoogle => 'Sign in with Google';
  String get skipSignIn => 'Skip Sign In';
  String get termsAndConditions => 'Terms and Conditions';
  String get acceptTerms => 'I accept the Terms and Conditions';
  String get acceptTermsAndConditions => 'I accept the Terms and Conditions';
  String get acceptMarketing => 'I would like to receive marketing emails';
  String get termsText => 'By using this app, you agree to our Terms of Service and Privacy Policy...';
  String get readTerms => 'Read Terms and Conditions';

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
  String get darkTheme => 'Dark Theme';
  String get darkThemeDescription => 'Enable dark mode for a better night experience';

  // Settings
  String get appearance => 'Appearance';
  String get about => 'About';
  String get language => 'Language';
  String get english => 'English';
  String get spanish => 'Spanish';

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
  String get newContact => 'New Contact';
  String get editContact => 'Edit Contact';
  String get deleteContact => 'Delete Contact';
  String get deleteContactTitle => 'Delete Contact';
  String deleteContactMessage(String name) => 'Are you sure you want to delete $name?';
  String get contactDeleted => 'Contact deleted successfully';
  String get noContactsMessage => 'No contacts yet. Add your first contact!';
  String get searchContacts => 'Search contacts...';
  String get allContacts => 'All';
  String get addContact => 'Add Contact';
  String get contactName => 'Name';
  String get contactEmail => 'Email';
  String get contactPhone => 'Phone';
  String get contactNotes => 'Notes';
  String get contactSaved => 'Contact saved successfully';
  String get contactNameRequired => 'Contact name is required';
  String get contactInformation => 'Contact Information';
  
  // Method to get text by key dynamically
  String getText(String key);

  // Method to validate all translations are present
  bool validateTranslations() {
    try {
      // App general
      appName;
      welcome;
      welcomeTitle;
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
      darkTheme;
      darkThemeDescription;

      // Settings
      appearance;
      about;
      language;
      english;
      spanish;

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
      newContact;
      editContact;
      deleteContact;
      deleteContactTitle;
      deleteContactMessage('');
      contactDeleted;
      addContact;
      contactName;
      contactEmail;
      contactPhone;
      contactNotes;
      contactSaved;
      contactNameRequired;
      searchContacts;
      allContacts;
      contactInformation;
      additionalInformation;

      return true;
    } catch (e) {
      return false;
    }
  }
}
