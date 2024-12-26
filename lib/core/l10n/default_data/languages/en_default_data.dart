import 'package:drift/drift.dart';
import 'package:moneyt_pfm/data/local/database.dart';
import '../base_default_data.dart';

class EnglishDefaultData extends BaseDefaultData {
  @override
  String get languageCode => 'en';

  @override
  List<CategoriesCompanion> getDefaultCategories() {
    return [
      // Expense Categories
      CategoriesCompanion.insert(
        name: 'Food & Dining',
        type: 'E',
        description: const Value('Expenses on food, beverages, and restaurants'),
        status: const Value(true),
      ),
      CategoriesCompanion.insert(
        name: 'Transportation',
        type: 'E',
        description: const Value('Expenses on public transport, fuel, and vehicle maintenance'),
        status: const Value(true),
      ),
      CategoriesCompanion.insert(
        name: 'Utilities',
        type: 'E',
        description: const Value('Payments for basic utilities like electricity, water, gas, and internet'),
        status: const Value(true),
      ),
      CategoriesCompanion.insert(
        name: 'Housing',
        type: 'E',
        description: const Value('Expenses related to rent or mortgage'),
        status: const Value(true),
      ),
      CategoriesCompanion.insert(
        name: 'Healthcare',
        type: 'E',
        description: const Value('Medical expenses, medications, and health insurance'),
        status: const Value(true),
      ),
      CategoriesCompanion.insert(
        name: 'Education',
        type: 'E',
        description: const Value('Expenses on studies, books, and educational materials'),
        status: const Value(true),
      ),
      CategoriesCompanion.insert(
        name: 'Entertainment',
        type: 'E',
        description: const Value('Expenses on leisure, sports, and recreational activities'),
        status: const Value(true),
      ),

      // Income Categories
      CategoriesCompanion.insert(
        name: 'Salary',
        type: 'I',
        description: const Value('Income from employment'),
        status: const Value(true),
      ),
      CategoriesCompanion.insert(
        name: 'Freelance',
        type: 'I',
        description: const Value('Income from freelance work or professional services'),
        status: const Value(true),
      ),
      CategoriesCompanion.insert(
        name: 'Investments',
        type: 'I',
        description: const Value('Income from investment returns'),
        status: const Value(true),
      ),
      CategoriesCompanion.insert(
        name: 'Other Income',
        type: 'I',
        description: const Value('Other types of uncategorized income'),
        status: const Value(true),
      ),
    ];
  }

  @override
  List<AccountsCompanion> getDefaultAccounts() {
    return [
      AccountsCompanion.insert(
        name: 'Cash',
        description: const Value('Physical cash'),
      ),
      AccountsCompanion.insert(
        name: 'Bank Account',
        description: const Value('Main bank account'),
      ),
      AccountsCompanion.insert(
        name: 'Savings',
        description: const Value('Savings account'),
      ),
    ];
  }
}
