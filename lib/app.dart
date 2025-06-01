import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'presentation/core/providers/theme_provider.dart';
import 'presentation/core/providers/language_provider.dart';
import 'presentation/core/l10n/generated/strings.g.dart';
import 'presentation/navigation/navigation_service.dart';
import 'presentation/navigation/route_generator.dart';
import 'presentation/navigation/app_routes.dart';

class MoneyTApp extends StatelessWidget {
  const MoneyTApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, LanguageProvider>(
      builder: (context, themeProvider, languageProvider, child) {
        return MaterialApp(
          title: 'MoneyT',
          debugShowCheckedModeBanner: false,
          
          // Configuración de navegación
          navigatorKey: NavigationService.navigatorKey,
          onGenerateRoute: RouteGenerator.generateRoute,
          initialRoute: AppRoutes.home,
          
          // Configuración de idioma MANUAL (sin TranslationProvider)
          locale: languageProvider.currentLocale.flutterLocale,
          supportedLocales: [
            const Locale('es'),
            const Locale('en'),
          ],
          
          // Delegados de localización MANUALES
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          
          // Configuración de tema
          theme: themeProvider.lightTheme,
          darkTheme: themeProvider.darkTheme,
          themeMode: themeProvider.themeMode,
        );
      },
    );
  }
}
