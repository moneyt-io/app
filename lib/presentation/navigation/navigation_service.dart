import 'package:flutter/material.dart';
import '../../domain/entities/loan_entry.dart';
import 'app_routes.dart';

/// Servicio de navegación que permite navegar entre pantallas desde cualquier parte de la app
/// sin necesidad de un BuildContext.
class NavigationService {
  // Clave global para acceder al estado del navegador desde cualquier lugar
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static NavigatorState? get navigator => navigatorKey.currentState;

  /// Navega a una ruta específica
  static Future<T?> navigateTo<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) async {
    if (navigator == null) {
      debugPrint('NavigationService: Navigator is null');
      return null;
    }
    
    try {
      final result = await navigator!.pushNamed(
        routeName,
        arguments: arguments,
      );
      return result as T?;
    } catch (e) {
      debugPrint('NavigationService error: $e');
      return null;
    }
  }

  /// Reemplaza la ruta actual por una nueva
  static Future<T?> navigateToAndReplace<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) async {
    if (navigator == null) return null;
    
    try {
      final result = await navigator!.pushReplacementNamed(routeName, arguments: arguments);
      return result as T?;
    } catch (e) {
      debugPrint('NavigationService error: $e');
      return null;
    }
  }

  /// Navega al inicio y elimina todas las rutas anteriores
  static Future<T?> navigateToAndClearStack<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) async {
    if (navigator == null) return null;
    
    try {
      final result = await navigator!.pushNamedAndRemoveUntil(
        routeName,
        (route) => false,
        arguments: arguments,
      );
      return result as T?;
    } catch (e) {
      debugPrint('NavigationService error: $e');
      return null;
    }
  }

  /// Vuelve a la pantalla anterior
  static void goBack<T extends Object?>([T? result]) {
    if (navigator != null) {
      navigator!.pop<T>(result);
    }
  }

  static bool canGoBack() {
    return navigator?.canPop() ?? false;
  }

  static Future<bool> maybePop<T extends Object?>([T? result]) async {
    if (navigator == null) return false;
    return navigator!.maybePop<T>(result);
  }

  // Métodos de conveniencia para las rutas más comunes
  static Future<void> goToHome() {
    return navigateToAndClearStack(AppRoutes.home); // CORREGIDO: usar AppRoutes.home
  }

  static Future<void> goToDashboard() {
    return navigateToAndClearStack(AppRoutes.home); // CORREGIDO: usar AppRoutes.home
  }

  static Future<void> goToLoans() {
    return navigateTo(AppRoutes.loans);
  }

  static Future<void> goToLoanForm({LoanEntry? loan}) {
    return navigateTo(AppRoutes.loanForm, arguments: {'loan': loan});
  }

  static Future<void> goToLoanDetail(int loanId) {
    return navigateTo(AppRoutes.loanDetail, arguments: {'loanId': loanId});
  }
}
