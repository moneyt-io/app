import 'package:flutter/material.dart';

/// Servicio de navegación que permite navegar entre pantallas desde cualquier parte de la app
/// sin necesidad de un BuildContext.
class NavigationService {
  // Clave global para acceder al estado del navegador desde cualquier lugar
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  
  /// Navega a una ruta específica
  static Future<T?> navigateTo<T>(
    String routeName, {
    Object? arguments,
  }) {
    return navigatorKey.currentState!.pushNamed(
      routeName,
      arguments: arguments,
    );
  }
  
  /// Reemplaza la ruta actual por una nueva
  static Future<T?> replaceTo<T>(
    String routeName, {
    Object? arguments,
  }) {
    return navigatorKey.currentState!.pushReplacementNamed(
      routeName,
      arguments: arguments,
    );
  }
  
  /// Navega al inicio y elimina todas las rutas anteriores
  static void navigateToHomeAndClear() {
    navigatorKey.currentState!.pushNamedAndRemoveUntil(
      '/',
      (route) => false,
    );
  }
  
  /// Vuelve a la pantalla anterior
  static void goBack<T>([T? result]) {
    return navigatorKey.currentState!.pop(result);
  }
  
  /// Maneja la operación de retroceso (botón atrás)
  static Future<bool> handleWillPop(BuildContext context) async {
    if (navigatorKey.currentState!.canPop()) {
      navigatorKey.currentState!.pop();
      return false;
    }
    return true;
  }
}
