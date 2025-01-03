// lib/presentation/providers/drawer_provider.dart
import 'package:flutter/material.dart';
import '../../domain/usecases/category_usecases.dart';
import '../../domain/usecases/account_usecases.dart';
import '../../domain/usecases/transaction_usecases.dart';
import '../../domain/usecases/contact_usecases.dart';

class DrawerProvider extends ChangeNotifier {
  // Categories
  final GetCategories getCategories;
  final CreateCategory createCategory;
  final UpdateCategory updateCategory;
  final DeleteCategory deleteCategory;

  // Accounts
  final GetAccounts getAccounts;
  final CreateAccount createAccount;
  final UpdateAccount updateAccount;
  final DeleteAccount deleteAccount;

  // Contacts
  final GetContacts getContacts;
  final CreateContact createContact;
  final UpdateContact updateContact;
  final DeleteContact deleteContact;

  // Transactions
  final TransactionUseCases transactionUseCases;

  DrawerProvider({
    // Categories
    required this.getCategories,
    required this.createCategory,
    required this.updateCategory,
    required this.deleteCategory,
    // Accounts
    required this.getAccounts,
    required this.createAccount,
    required this.updateAccount,
    required this.deleteAccount,
    // Contacts
    required this.getContacts,
    required this.createContact,
    required this.updateContact,
    required this.deleteContact,
    // Transactions
    required this.transactionUseCases,
  });
}
