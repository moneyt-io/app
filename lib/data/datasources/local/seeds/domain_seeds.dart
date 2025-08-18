import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

import '../../../../domain/entities/category.dart';
import '../../../../domain/usecases/category_usecases.dart';
import '../../../../domain/usecases/wallet_usecases.dart';
import '../../../../presentation/core/l10n/generated/strings.g.dart';

/// Handles seeding data that requires business logic from UseCases.
class DomainSeeds {
  static Future<void> seedAll() async {
    final lang = LocaleSettings.currentLocale.languageCode;

    await _seedWallets(lang);
    await _seedCategories(lang);
  }

  /// Seeds wallets from a JSON file, creating parent-child relationships.
  static Future<void> _seedWallets(String lang) async {
    final walletUseCases = GetIt.instance<WalletUseCases>();
    final existingWallets = await walletUseCases.getAllWallets();
    final existingWalletNames = existingWallets.map((w) => w.name).toSet();

    final String jsonString = await rootBundle.loadString('assets/seeds/$lang/wallets.json');
    final List<dynamic> walletsJson = json.decode(jsonString);

    for (var walletData in walletsJson) {
      // Create parent wallet if it doesn't exist
      if (!existingWalletNames.contains(walletData['name'])) {
        final parentWallet = await walletUseCases.createWalletWithAccount(
          name: walletData['name'],
          currencyId: 'USD', // Default currency
        );
        existingWalletNames.add(parentWallet.name);

        // Create children wallets
        if (walletData['children'] != null) {
          for (var childData in walletData['children']) {
            if (!existingWalletNames.contains(childData['name'])) {
              await walletUseCases.createWalletWithAccount(
                name: childData['name'],
                currencyId: 'USD',
                parentId: parentWallet.id,
              );
              existingWalletNames.add(childData['name']);
            }
          }
        }
      }
    }
  }

  /// Seeds categories from a JSON file, creating parent-child relationships.
  static Future<void> _seedCategories(String lang) async {
    final categoryUseCases = GetIt.instance<CategoryUseCases>();
    final existingCategories = await categoryUseCases.getAllCategories();
    final existingCategoryNames = existingCategories.map((c) => c.name).toSet();

    final String jsonString = await rootBundle.loadString('assets/seeds/$lang/categories.json');
    final Map<String, dynamic> categoriesJson = json.decode(jsonString);

    await _processCategoryType(categoriesJson['income'], 'I', existingCategoryNames, categoryUseCases);
    await _processCategoryType(categoriesJson['expense'], 'E', existingCategoryNames, categoryUseCases);
  }

  static Future<void> _processCategoryType(
    List<dynamic> categoryList,
    String docType,
    Set<String> existingNames,
    CategoryUseCases useCases,
  ) async {
    for (var catData in categoryList) {
      // Create parent category if it doesn't exist
      if (!existingNames.contains(catData['name'])) {
        final parentCategoryEntity = Category(
          id: 0,
          name: catData['name'],
          icon: catData['icon'],
          documentTypeId: docType,
          chartAccountId: 0,
          active: true,
          createdAt: DateTime.now(),
        );
        final createdParent = await useCases.createCategory(parentCategoryEntity);
        existingNames.add(createdParent.name);

        // Create children categories
        if (catData['children'] != null) {
          for (var childData in catData['children']) {
            if (!existingNames.contains(childData['name'])) {
              final childCategoryEntity = Category(
                id: 0,
                name: childData['name'],
                icon: childData['icon'],
                parentId: createdParent.id,
                documentTypeId: docType,
                chartAccountId: 0,
                active: true,
                createdAt: DateTime.now(),
              );
              final createdChild = await useCases.createCategory(childCategoryEntity);
              existingNames.add(createdChild.name);
            }
          }
        }
      }
    }
  }
}
