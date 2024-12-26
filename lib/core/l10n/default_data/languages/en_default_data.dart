import 'package:drift/drift.dart';
import 'package:moneyt_pfm/data/local/database.dart';
import '../base_default_data.dart';

class EnglishDefaultData extends BaseDefaultData {
  @override
  String get languageCode => 'en';

  @override
  List<CategoriesCompanion> getDefaultCategories() {
    final List<CategoriesCompanion> categories = [];
    int id = 1;

    // Helper function to add categories
    void addCategory(String name, String type, {int? parentId, String? icon}) {
      categories.add(
        CategoriesCompanion.insert(
          id: Value(id++),
          name: name,
          type: type,
          parentId: Value(parentId),
        ),
      );
    }

    // INCOME
    // 1. Active Income
    addCategory('Active Income', 'I', icon: 'work');
    addCategory('Salary', 'I', parentId: 1, icon: 'payments');
    addCategory('Extra Work', 'I', parentId: 1, icon: 'work_history');

    // 2. Passive Income
    addCategory('Passive Income', 'I', icon: 'account_balance');
    addCategory('Bank Interest', 'I', parentId: 4, icon: 'savings');
    addCategory('Rental Income', 'I', parentId: 4, icon: 'house');
    addCategory('Dividends', 'I', parentId: 4, icon: 'trending_up');

    // 3. Other Income
    addCategory('Other Income', 'I', icon: 'more_horiz');
    addCategory('Gambling', 'I', parentId: 8, icon: 'casino');
    addCategory('Inheritance', 'I', parentId: 8, icon: 'real_estate_agent');

    // EXPENSES
    // 1. Fixed Expenses
    addCategory('Fixed Expenses', 'E', icon: 'calendar_today');
    addCategory('Rent', 'E', parentId: 11, icon: 'house');
    addCategory('Mortgage', 'E', parentId: 11, icon: 'account_balance');
    addCategory('Water', 'E', parentId: 11, icon: 'water_drop');
    addCategory('Electricity', 'E', parentId: 11, icon: 'bolt');
    addCategory('Internet', 'E', parentId: 11, icon: 'wifi');
    addCategory('Phone', 'E', parentId: 11, icon: 'phone');
    addCategory('Insurance', 'E', parentId: 11, icon: 'security');

    // 2. Variable Expenses
    addCategory('Variable Expenses', 'E', icon: 'moving');
    addCategory('Restaurants', 'E', parentId: 19, icon: 'restaurant');
    addCategory('Transportation', 'E', parentId: 19, icon: 'directions_car');
    addCategory('Clothing & Shoes', 'E', parentId: 19, icon: 'checkroom');
    addCategory('Entertainment', 'E', parentId: 19, icon: 'sports_esports');

    // 3. Health Expenses
    addCategory('Health Expenses', 'E', icon: 'medical_services');
    addCategory('Medicine', 'E', parentId: 24, icon: 'medication');
    addCategory('Medical Appointments', 'E', parentId: 24, icon: 'healing');

    // 4. Education
    addCategory('Education', 'E', icon: 'school');
    addCategory('Courses', 'E', parentId: 27, icon: 'menu_book');
    addCategory('University', 'E', parentId: 27, icon: 'account_balance');

    // 5. Home
    addCategory('Home', 'E', icon: 'home');
    addCategory('Furniture & Decor', 'E', parentId: 30, icon: 'chair');
    addCategory('Maintenance', 'E', parentId: 30, icon: 'build');

    // 6. Other Expenses
    addCategory('Other Expenses', 'E', icon: 'more_horiz');
    addCategory('Donations', 'E', parentId: 33, icon: 'volunteer_activism');
    addCategory('Gifts', 'E', parentId: 33, icon: 'card_giftcard');
    addCategory('Unexpected', 'E', parentId: 33, icon: 'warning');
    addCategory('Travel', 'E', parentId: 33, icon: 'flight');

    return categories;
  }

  @override
  List<AccountsCompanion> getDefaultAccounts() {
    return [
      AccountsCompanion.insert(
        id: const Value(1),
        name: 'Cash',
        description: const Value('Cash money'),
      ),
      AccountsCompanion.insert(
        id: const Value(2),
        name: 'Bank Account',
        description: const Value('Main bank account'),
      ),
    ];
  }
}
