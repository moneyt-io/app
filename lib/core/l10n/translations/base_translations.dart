abstract class BaseTranslations {
  String get languageCode;

  // App general
  String get appName;
  String get welcome;
  String get welcomeTitle;
  String get selectLanguage;
  String get continue_;
  String get cancel;
  String get save;
  String get delete;
  String get edit;
  String get add;
  String get error;
  String get noDescription;
  String get unknown;

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
  String get settings;

  // Account related
  String get account;
  String get accountName;
  String get accountDescription;
  String get balance;
  String get newAccount;
  String get editAccount;
  String get deleteAccount;
  String get deleteAccountConfirmation;
  String get noAccounts;

  // Category related
  String get category;
  String get categoryName;
  String get categoryDescription;
  String get categoryType;
  String get newCategory;
  String get editCategory;
  String get deleteCategory;
  String get deleteCategoryConfirmation;
  String get income;
  String get expense;
  String get noCategories;

  // Transaction related
  String get transaction;
  String get amount;
  String get date;
  String get description;
  String get reference;
  String get newTransaction;
  String get editTransaction;
  String get deleteTransaction;
  String get deleteTransactionConfirmation;
  String get transfer;
  String get from;
  String get to;
  String get noTransactions;
  String get recentTransactions;
  String get viewAll;
  String get noRecentTransactions;

  // Sorting and filtering
  String get sortDateAsc;
  String get sortDateDesc;
  String get sortAmountAsc;
  String get sortAmountDesc;
  String get all;
  String get filters;
  String get apply;

  // Validation messages
  String get fieldRequired;
  String get invalidAmount;
  String get selectCategory;
  String get selectAccount;

  // Theme
  String get darkTheme;
  String get darkThemeDescription;

  // Balance y Estadísticas
  String get totalBalance => throw UnimplementedError();
  String get monthlyStats => throw UnimplementedError();
  String get expenses => throw UnimplementedError();
  String get monthlyBalance => throw UnimplementedError();

  // Method to get text by key dynamically
  String getText(String key);

  // Method to validate all translations are present
  bool validateTranslations() {
    try {
      // Call all getters to verify they return non-null values
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
      signInWithGoogle;
      skipSignIn;
      termsAndConditions;
      acceptTerms;
      acceptTermsAndConditions;
      acceptMarketing;
      termsText;
      readTerms;
      home;
      accounts;
      categories;
      transactions;
      settings;
      account;
      accountName;
      accountDescription;
      balance;
      newAccount;
      editAccount;
      deleteAccount;
      deleteAccountConfirmation;
      noAccounts;
      category;
      categoryName;
      categoryDescription;
      categoryType;
      newCategory;
      editCategory;
      deleteCategory;
      deleteCategoryConfirmation;
      income;
      expense;
      noCategories;
      transaction;
      amount;
      date;
      description;
      reference;
      newTransaction;
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
      sortDateAsc;
      sortDateDesc;
      sortAmountAsc;
      sortAmountDesc;
      all;
      filters;
      apply;
      fieldRequired;
      invalidAmount;
      selectCategory;
      selectAccount;
      darkTheme;
      darkThemeDescription;
      totalBalance;
      monthlyStats;
      income;
      expenses;
      monthlyBalance;
      return true;
    } catch (e) {
      return false;
    }
  }
}
