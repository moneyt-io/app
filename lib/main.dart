import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/utils/icon_to_emoji_mapper.dart';
import 'core/services/ai_transaction_service.dart';
import 'domain/usecases/transaction_usecases.dart';
import 'domain/usecases/wallet_usecases.dart';
import 'domain/usecases/category_usecases.dart';
import 'domain/entities/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:get_it/get_it.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'presentation/core/providers/theme_provider.dart';
import 'presentation/core/providers/language_provider.dart';
import 'presentation/core/providers/currency_provider.dart';
import 'presentation/core/providers/currency_filter_provider.dart';
import 'presentation/core/providers/background_provider.dart';
import 'presentation/core/l10n/generated/strings.g.dart';
import 'presentation/features/backup/backup_provider.dart';
import 'presentation/features/loans/loan_provider.dart';
import 'presentation/features/contacts/contact_provider.dart';
import 'presentation/features/transactions/transaction_provider.dart';
import 'presentation/features/wallets/wallet_provider.dart';
import 'presentation/features/auth/auth_provider.dart' as app_auth;
import 'core/services/data_seed_service.dart';
import 'core/constants/app_storage_keys.dart';
import 'app.dart';
import 'core/di/injection_container.dart';
import 'core/services/paywall_service.dart';
import 'core/services/analytics_service.dart';
import 'core/services/tiktok_service.dart';
import 'core/services/facebook_service.dart';
import 'core/utils/icon_to_emoji_mapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  await initializeDateFormatting('es_ES', null);

  // Inicialización inteligente del idioma
  // Se maneja mas abajo usando SharedPreferences
  // LocaleSettings.useDeviceLocale();

  await initializeDependencies();

  try {
    await GetIt.instance<PaywallService>().init();
  } catch (e) {
    debugPrint('PaywallService initialization failed: $e');
  }

  await AnalyticsService().init();

  // Solicitar ATT en iOS antes de inicializar TikTok SDK (requiere IDFA)
  if (Platform.isIOS) {
    final status = await AppTrackingTransparency.trackingAuthorizationStatus;
    if (status == TrackingStatus.notDetermined) {
      // Pequeño delay para evitar crash si la app aún no terminó de presentar su ventana
      await Future.delayed(const Duration(milliseconds: 300));
      await AppTrackingTransparency.requestTrackingAuthorization();
    }
  }

  await TikTokService().init();
  await FacebookService().init();

  final prefs = await SharedPreferences.getInstance();

  // ✅ CORREGIDO: Cargar idioma guardado o del dispositivo ANTES de inicializar los datos base
  // Esto asegura que los seeds (ej. billeteras, categorías) se creen en el idioma correcto
  final savedLanguage = prefs.getString('selected_language');
  if (savedLanguage != null) {
    try {
      final locale = AppLocale.values.firstWhere(
        (l) => l.languageCode == savedLanguage,
        orElse: () => AppLocale.es,
      );
      LocaleSettings.setLocale(locale);
    } catch (_) {
      LocaleSettings.useDeviceLocale();
    }
  } else {
    // Si no hay preferencia guardada, usar idioma del dispositivo
    LocaleSettings.useDeviceLocale();
  }

  await _initializeCriticalData();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(prefs),
        ),
        ChangeNotifierProvider(
          create: (_) => BackgroundProvider(prefs),
        ),
        ChangeNotifierProvider(
          create: (_) => LanguageProvider(prefs),
        ),
        ChangeNotifierProvider(
          create: (_) => CurrencyProvider(prefs),
        ),
        ChangeNotifierProvider(
          create: (context) => CurrencyFilterProvider(
            context.read<CurrencyProvider>().currencyId,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => GetIt.instance<app_auth.AuthProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => GetIt.instance<BackupProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => LoanProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ContactProvider(GetIt.instance()),
        ),
        ChangeNotifierProxyProvider<LoanProvider, TransactionProvider>(
          create: (context) => TransactionProvider(),
          update: (context, loanProvider, transactionProvider) {
            transactionProvider?.refreshTransactions();
            return transactionProvider!;
          },
        ),
        ChangeNotifierProxyProvider<TransactionProvider, WalletProvider>(
          create: (context) => WalletProvider(
            GetIt.instance(), // WalletUseCases
            GetIt.instance(), // BalanceCalculationService
          ),
          update: (context, transactionProvider, walletProvider) {
            walletProvider?.recalculateBalances();
            return walletProvider!;
          },
        ),
      ],
      child: const MoneyTApp(),
    ),
  );
}

/// Ensures essential data is available before the app starts.
Future<void> _initializeCriticalData() async {
  try {
    final seedsCompleted = await DataSeedService.areSeedsCompleted();

    if (!seedsCompleted) {
      await DataSeedService.runSeedsIfNeeded();
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      AppStorageKeys.lastAppOpen,
      DateTime.now().toIso8601String(),
    );
  } catch (e) {
    debugPrint('Error during critical data initialization: $e');
  }
}

@pragma('vm:entry-point')
void backgroundMain() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 1. Cargar dependencias críticas
  await dotenv.load(fileName: ".env");
  await initializeDependencies();
  
  // Configurar Slang
  final prefs = await SharedPreferences.getInstance();
  final savedLanguage = prefs.getString('selected_language');
  if (savedLanguage != null) {
    try {
      final locale = AppLocale.values.firstWhere(
        (l) => l.languageCode == savedLanguage,
        orElse: () => AppLocale.es,
      );
      LocaleSettings.setLocale(locale);
    } catch (_) {
      LocaleSettings.useDeviceLocale();
    }
  } else {
    LocaleSettings.useDeviceLocale();
  }

  const channel = MethodChannel('com.moneyt.app/background_intent');
  
  channel.setMethodCallHandler((call) async {
    try {
      final walletUseCases = GetIt.instance<WalletUseCases>();
      final categoryUseCases = GetIt.instance<CategoryUseCases>();
      final transactionUseCases = GetIt.instance<TransactionUseCases>();

      if (call.method == 'parseTransaction') {
        final String? text = call.arguments as String?;
        if (text == null || text.isEmpty) {
          return {"success": false, "message": t.intents.emptyText};
        }

        final wallets = await walletUseCases.getAllWallets();
        final categories = await categoryUseCases.getAllCategories();
        final childCategories = categories.where((c) => c.parentId != null).toList();

        final service = AITransactionService();
        final result = await service.parseTransaction(text, childCategories, wallets);

        if (result != null) {
          final wallet = wallets.firstWhere((w) => w.id == result.walletId, orElse: () => wallets.first);
          
          List<Map<String, dynamic>> suggestions = [];
          for (var sugg in result.categorySuggestions) {
            if (sugg.categoryId != null) {
              final cat = childCategories.firstWhere((c) => c.id == sugg.categoryId, orElse: () => childCategories.first);
              suggestions.add({"id": cat.id, "name": cat.name, "icon": IconToEmojiMapper.getEmoji(cat.icon)});
            } else if (sugg.newCategoryName != null) {
              suggestions.add({"id": null, "name": sugg.newCategoryName, "icon": sugg.newCategoryIcon ?? "✨"});
            }
          }

          if (suggestions.isEmpty) {
            suggestions.add({"id": childCategories.first.id, "name": childCategories.first.name, "icon": IconToEmojiMapper.getEmoji(childCategories.first.icon)});
          }

          final prefs = await SharedPreferences.getInstance();
          final globalCurrencyId = prefs.getString('default_currency') ?? 'USD';
          final globalSymbol = CurrencyProvider.availableCurrencies.firstWhere((c) => c.id == globalCurrencyId, orElse: () => CurrencyProvider.availableCurrencies.first).symbol;

          return {
            "success": true,
            "transaction": {
              "type": result.type,
              "amount": result.amount,
              "walletId": wallet.id,
              "currencyId": wallet.currencyId,
              "currencySymbol": globalSymbol,
              "description": result.description,
              "date": result.date?.toIso8601String() ?? DateTime.now().toIso8601String(),
            },
            "suggestedCategories": suggestions
          };
        } else {
          return {"success": false, "message": t.intents.cannotUnderstand};
        }
      } 
      else if (call.method == 'saveTransaction') {
        final Map<dynamic, dynamic>? args = call.arguments as Map<dynamic, dynamic>?;
        if (args == null) return {"success": false, "message": t.intents.emptyData};

        final type = args['type'] as String? ?? 'E';
        final amount = (args['amount'] as num?)?.toDouble() ?? 0.0;
        final walletId = args['walletId'] as int?;
        final currencyIdRaw = args['currencyId'];
        final currencyId = currencyIdRaw != null ? currencyIdRaw.toString() : '1';
        final description = args['description'] as String? ?? '';
        final dateStr = args['date'] as String?;
        final date = dateStr != null ? DateTime.parse(dateStr) : DateTime.now();
        
        final categoryId = args['categoryId'] as int?;
        final newCategoryName = args['newCategoryName'] as String?;
        final newCategoryIcon = args['newCategoryIcon'] as String? ?? '🏷️';

        int finalCategoryId;
        if (categoryId != null) {
          finalCategoryId = categoryId;
        } else if (newCategoryName != null) {
          // Buscar o crear el padre raíz (Expense o Income)
          final allCats = await categoryUseCases.getAllCategories();
          final rootName = type == 'E' ? 'Expense' : 'Income';
          Category? root = allCats.where((c) => c.parentId == null && c.name == rootName && c.documentTypeId == type).firstOrNull;
          
          if (root == null) {
            final newRoot = Category(
              id: 0,
              name: rootName,
              documentTypeId: type,
              chartAccountId: 0,
              icon: Icons.folder.codePoint.toString(),
              active: true,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            );
            root = await categoryUseCases.createCategory(newRoot);
          }

          // Crear nueva categoría hijo
          final newCat = await categoryUseCases.createCategory(Category(
            id: 0,
            name: newCategoryName,
            icon: newCategoryIcon,
            documentTypeId: type,
            chartAccountId: 0, // se autogenerará en el usecase
            active: true,
            createdAt: DateTime.now(),
            parentId: root.id
          ));
          finalCategoryId = newCat.id;
        } else {
          final categories = await categoryUseCases.getAllCategories();
          final childCategories = categories.where((c) => c.parentId != null).toList();
          finalCategoryId = childCategories.first.id;
        }

        if (type == 'E') {
          await transactionUseCases.createExpense(
            amount: amount,
            categoryId: finalCategoryId,
            paymentId: walletId ?? 1,
            paymentTypeId: 'W',
            currencyId: currencyId,
            description: description,
            date: date,
          );
        } else {
          await transactionUseCases.createIncome(
            amount: amount,
            categoryId: finalCategoryId,
            walletId: walletId ?? 1,
            currencyId: currencyId,
            description: description,
            date: date,
          );
        }
        
        return {"success": true, "message": t.intents.transactionSavedTitle};
      }
      else if (call.method == 'getManualData') {
        final prefs = await SharedPreferences.getInstance();
        final globalCurrencyId = prefs.getString('default_currency') ?? 'USD';
        final globalSymbol = CurrencyProvider.availableCurrencies.firstWhere((c) => c.id == globalCurrencyId, orElse: () => CurrencyProvider.availableCurrencies.first).symbol;

        final wallets = await walletUseCases.getAllWallets();
        final categories = await categoryUseCases.getAllCategories();
        
        return {
          "success": true,
          "globalCurrencySymbol": globalSymbol,
          "categories": categories.where((c) => c.parentId != null).map((cat) => {
            "id": cat.id,
            "name": cat.name,
            "icon": IconToEmojiMapper.getEmoji(cat.icon),
          }).toList(),
          "wallets": wallets.where((w) => w.parentId != null).map((w) => {
            "id": w.id,
            "name": w.name,
            "currencyId": w.currencyId,
            "currencySymbol": CurrencyProvider.availableCurrencies.firstWhere((c) => c.id == w.currencyId, orElse: () => CurrencyProvider.availableCurrencies.first).symbol
          }).toList()
        };
      }
      
      return {"success": false, "message": "Método no encontrado"};
    } catch (e) {
      return {"success": false, "message": "Error interno: ${e.toString()}"};
    }
  });
}
