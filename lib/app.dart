import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'presentation/core/providers/theme_provider.dart';
import 'presentation/navigation/navigation_service.dart';
import 'presentation/navigation/app_router.dart';
import 'presentation/navigation/app_routes.dart';

class MoneyTApp extends StatelessWidget {
  const MoneyTApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MoneyT',
          navigatorKey: NavigationService.navigatorKey,
          initialRoute: AppRoutes.splash,
          onGenerateRoute: AppRouter.generateRoute,
          locale: const Locale('es', 'ES'),
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('es', 'ES'),
          ],
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: themeProvider.lightTheme,
          darkTheme: themeProvider.darkTheme,
          themeMode: themeProvider.themeMode,
        );
      },
    );
  }
}
