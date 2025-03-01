import 'package:moneyt_pfm/data/datasources/local/database.dart';

abstract class BaseDefaultData {
  String get languageCode;
  
  // Default data methods
  List<CategoriesCompanion> getDefaultCategories();
  List<AccountsCompanion> getDefaultAccounts();
  
  // Validation method
  bool validateDefaultData() {
    try {
      final categories = getDefaultCategories();
      final accounts = getDefaultAccounts();
      
      return categories.isNotEmpty && accounts.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}
