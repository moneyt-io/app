import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:posthog_flutter/posthog_flutter.dart';
import 'package:app_links/app_links.dart';
import 'presentation/core/providers/theme_provider.dart';
import 'presentation/core/l10n/generated/strings.g.dart';
import 'presentation/navigation/navigation_service.dart';
import 'presentation/navigation/app_router.dart';
import 'presentation/navigation/app_routes.dart';
import 'presentation/features_v2/voice/voice_command_screen.dart';
import 'presentation/features/transactions/transaction_provider.dart';
import 'presentation/features/wallets/wallet_provider.dart';

class MoneyTApp extends StatefulWidget {
  const MoneyTApp({Key? key}) : super(key: key);

  @override
  State<MoneyTApp> createState() => _MoneyTAppState();
}

class _MoneyTAppState extends State<MoneyTApp> with WidgetsBindingObserver {
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initDeepLinks();
  }

  Future<void> _initDeepLinks() async {
    _appLinks = AppLinks();

    try {
      final initialUri = await _appLinks.getInitialLink();
      if (initialUri != null) {
        _handleDeepLink(initialUri);
      }
    } catch (e) {
      debugPrint("Error reading initial deep link: $e");
    }

    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      _handleDeepLink(uri);
    }, onError: (err) {
      debugPrint("Error listening to deep links: $err");
    });
  }

  void _handleDeepLink(Uri uri) {
    if (uri.scheme == 'moneyt' && uri.host == 'procesar') {
      final text = uri.queryParameters['texto'];
      if (text != null && text.isNotEmpty) {
        Future.delayed(const Duration(milliseconds: 500), () {
          NavigationService.navigatorKey.currentState?.push(
            MaterialPageRoute(
              builder: (_) => VoiceCommandScreen(initialText: text),
            ),
          );
        });
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Al volver del fondo (ej. Atajo de iOS), refrescamos los datos nativos
      if (mounted) {
        try {
          // Importa features/transactions/transaction_provider.dart arriba si no lo reconoce,
          // pero como usas app.dart, TransactionProvider ya debe estar accesible
          final txProvider = Provider.of<TransactionProvider>(NavigationService.navigatorKey.currentContext ?? context, listen: false);
          txProvider.refreshTransactions();
          txProvider.refreshCategories();
          
          final walletProvider = Provider.of<WalletProvider>(NavigationService.navigatorKey.currentContext ?? context, listen: false);
          walletProvider.recalculateBalances();
        } catch (e) {
          debugPrint("Error refreshing on resume: $e");
        }
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _linkSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TranslationProvider(
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return PostHogWidget(
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'MoneyT',
              navigatorKey: NavigationService.navigatorKey,
              initialRoute: AppRoutes.splash,
              onGenerateRoute: AppRouter.generateRoute,
              navigatorObservers: [PosthogObserver()],
              locale: TranslationProvider.of(context).flutterLocale,
              supportedLocales: AppLocaleUtils.supportedLocales,
              localizationsDelegates: GlobalMaterialLocalizations.delegates,
              theme: themeProvider.lightTheme,
              darkTheme: themeProvider.darkTheme,
              themeMode: themeProvider.themeMode,
            ),
          );
        },
      ),
    );
  }
}
