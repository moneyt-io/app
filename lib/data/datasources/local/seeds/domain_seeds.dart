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

    final jsonString = await _loadSeedJsonSafely(lang, 'wallets.json');
    if (jsonString == null) return;

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

    final jsonString = await _loadSeedJsonSafely(lang, 'categories.json');
    if (jsonString == null) return;

    final Map<String, dynamic> categoriesJson = json.decode(jsonString);

    await _processCategoryType(
        categoriesJson['income'], 'I', existingCategoryNames, categoryUseCases);
    await _processCategoryType(categoriesJson['expense'], 'E',
        existingCategoryNames, categoryUseCases);
  }

  /// Carga de forma segura un JSON de los seeds verificando si el lenguaje está soportado.
  /// En caso de no existir traducción para el idioma actual, hace fallback al idioma base ('en').
  static Future<String?> _loadSeedJsonSafely(
      String lang, String fileName) async {
    try {
      // Intentar cargar la ruta específica del idioma local
      final String path = 'assets/seeds/$lang/$fileName';
      return await rootBundle.loadString(path);
    } catch (e) {
      // Fallback a inglés por defecto si no existe la carpeta/archivo
      try {
        final String fallbackPath = 'assets/seeds/en/$fileName';
        return await rootBundle.loadString(fallbackPath);
      } catch (eError) {
        print('Error loading seeds fallback: $eError');
        return null; // El archivo tampoco está en inglés (podría ser un missing asset)
      }
    }
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
        final createdParent =
            await useCases.createCategory(parentCategoryEntity);
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
              final createdChild =
                  await useCases.createCategory(childCategoryEntity);
              existingNames.add(createdChild.name);
            }
          }
        }
      }
    }
  }
}
