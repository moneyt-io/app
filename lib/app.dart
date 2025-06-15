import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'presentation/core/providers/theme_provider.dart';
import 'presentation/core/providers/language_provider.dart'; // AGREGADO: import faltante
import 'presentation/navigation/navigation_service.dart'; // AGREGADO
import 'presentation/navigation/route_generator.dart';
import 'presentation/navigation/app_routes.dart';
import 'presentation/core/l10n/generated/strings.g.dart';

class MoneyTApp extends StatelessWidget {
  const MoneyTApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>( // SIMPLIFICADO: solo ThemeProvider por ahora
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MoneyT',
          
          // AGREGADO: Configurar navigatorKey
          navigatorKey: NavigationService.navigatorKey,
          
          // Configuración de rutas
          initialRoute: AppRoutes.home,
          onGenerateRoute: RouteGenerator.generateRoute,
          
          // Configuración de localización básica
          locale: const Locale('es', 'ES'), // SIMPLIFICADO: español por defecto
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('es', 'ES'),
          ], // SIMPLIFICADO: locales básicos
          
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
