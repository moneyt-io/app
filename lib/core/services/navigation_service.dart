import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NavigationService {
  static Future<void> navigateToScreen(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) async {
    // Cerrar el drawer si está abierto
    if (Scaffold.of(context).isDrawerOpen) {
      Navigator.of(context).pop();
    }

    // Si vamos al home o estamos intentando navegar a la misma pantalla
    if (routeName == '/' || ModalRoute.of(context)?.settings.name == routeName) {
      Navigator.of(context).popUntil((route) => route.isFirst);
      return;
    }

    // Para cualquier otra pantalla, navegamos asegurándonos que solo el home esté en el stack
    Navigator.of(context).popUntil((route) => route.isFirst);
    await Navigator.of(context).pushNamed(routeName, arguments: arguments);
  }

  static void goBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pushReplacementNamed('/');
    }
  }

  static Future<bool> handleWillPop(BuildContext context) async {
    final currentRoute = ModalRoute.of(context);
    
    // Si estamos en el home
    if (currentRoute?.settings.name == '/') {
      try {
        await SystemNavigator.pop();
        return false;
      } catch (e) {
        debugPrint('Error al minimizar la app: $e');
        return true;
      }
    }
    
    // Para otras pantallas, volvemos al home
    Navigator.of(context).popUntil((route) => route.isFirst);
    return false;
  }
}
