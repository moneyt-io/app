import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'presentation/providers/theme_provider.dart';
import 'presentation/routes/navigation_service.dart';
import 'presentation/routes/route_generator.dart';
import 'presentation/routes/app_routes.dart';

class MoneyTApp extends StatelessWidget {
  const MoneyTApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'MoneyT',
          debugShowCheckedModeBanner: false,
          
          // Configuración de navegación
          navigatorKey: NavigationService.navigatorKey,
          onGenerateRoute: RouteGenerator.generateRoute,
          initialRoute: AppRoutes.home, // Cambiar a home
          
          // Configuración de tema
          theme: themeProvider.lightTheme,
          darkTheme: themeProvider.darkTheme,
          themeMode: themeProvider.themeMode,
        );
      },
    );
  }
}
