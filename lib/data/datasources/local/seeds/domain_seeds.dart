import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    // Leer moneda guardada o detectar desde el locale del dispositivo.
    // CurrencyProvider aún no existe en este punto del startup, así que
    // replicamos su lógica leyendo directamente de SharedPreferences.
    final prefs = await SharedPreferences.getInstance();
    final currencyId = prefs.getString('default_currency') ?? _detectCurrencyFromLocale();

    final List<dynamic> walletsJson = json.decode(jsonString);

    for (var walletData in walletsJson) {
      // Create parent wallet if it doesn't exist
      if (!existingWalletNames.contains(walletData['name'])) {
        final parentWallet = await walletUseCases.createWalletWithAccount(
          name: walletData['name'],
          currencyId: currencyId,
        );
        existingWalletNames.add(parentWallet.name);

        // Create children wallets
        if (walletData['children'] != null) {
          for (var childData in walletData['children']) {
            if (!existingWalletNames.contains(childData['name'])) {
              await walletUseCases.createWalletWithAccount(
                name: childData['name'],
                currencyId: currencyId,
                parentId: parentWallet.id,
              );
              existingWalletNames.add(childData['name']);
            }
          }
        }
      }
    }
  }

  /// Detecta la moneda más probable según el locale del dispositivo.
  /// Misma lógica que CurrencyProvider._detectFromLocale().
  static String _detectCurrencyFromLocale() {
    try {
      final locale = Platform.localeName;
      if (locale.contains('CO')) return 'COP';
      if (locale.contains('MX')) return 'MXN';
      if (locale.contains('AR')) return 'ARS';
      if (locale.contains('PE')) return 'PEN';
      if (locale.contains('CL')) return 'CLP';
      if (locale.contains('BR')) return 'BRL';
      if (locale.contains('GB')) return 'GBP';
      if (locale.contains('JP')) return 'JPY';
      if (locale.contains('CA')) return 'CAD';
      if (locale.contains('AU')) return 'AUD';
    } catch (_) {}
    return 'USD';
  }

  /// Seeds categories from a JSON file, creating parent-child relationships.
  static Future<void> _seedCategories(String lang) async {
    final categoryUseCases = GetIt.instance<CategoryUseCases>();
    final existingCategories = await categoryUseCases.getAllCategories();
    // Guardamos la combinación de name_docType para evitar colisiones 
    // (ej. "Base" en Ingresos y "Base" en Gastos)
    final existingCategoryKeys = existingCategories.map((c) => '${c.name}_${c.documentTypeId}').toSet();

    final jsonString = await _loadSeedJsonSafely(lang, 'categories.json');
    if (jsonString == null) return;

    final Map<String, dynamic> categoriesJson = json.decode(jsonString);

    await _processCategoryType(
        categoriesJson['income'], 'I', existingCategoryKeys, categoryUseCases);
    await _processCategoryType(categoriesJson['expense'], 'E',
        existingCategoryKeys, categoryUseCases);
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
    Set<String> existingCategoryKeys,
    CategoryUseCases useCases,
  ) async {
    for (var catData in categoryList) {
      final parentKey = '${catData['name']}_$docType';
      
      // Create parent category if it doesn't exist
      if (!existingCategoryKeys.contains(parentKey)) {
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
        existingCategoryKeys.add('${createdParent.name}_$docType');

        // Create children categories
        if (catData['children'] != null) {
          for (var childData in catData['children']) {
            final childKey = '${childData['name']}_$docType';
            if (!existingCategoryKeys.contains(childKey)) {
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
              existingCategoryKeys.add('${createdChild.name}_$docType');
            }
          }
        }
      }
    }
  }
}
