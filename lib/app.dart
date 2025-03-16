import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'presentation/providers/theme_provider.dart';
import 'presentation/routes/route_generator.dart';
import 'presentation/routes/navigation_service.dart';
import 'presentation/routes/app_routes.dart';

class MoneyTApp extends StatelessWidget {
  const MoneyTApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'MoneyT',
      theme: themeProvider.lightTheme,
      darkTheme: themeProvider.darkTheme,
      themeMode: themeProvider.themeMode,
      
      // Configuración del sistema de navegación
      navigatorKey: NavigationService.navigatorKey,
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: AppRoutes.home, // Puedes cambiarlo a welcome si tienes esa pantalla
    );
  }
}
