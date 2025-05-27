import 'package:flutter/material.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static NavigatorState? get navigator => navigatorKey.currentState;

  static Future<T?> navigateTo<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return navigator!.pushNamed<T>(routeName, arguments: arguments);
  }

  static Future<T?> navigateToAndReplace<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) async {
    final result = await navigator!.pushReplacementNamed(routeName, arguments: arguments);
    return result as T?;
  }

  static Future<T?> navigateToAndClearStack<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) async {
    final result = await navigator!.pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: arguments,
    );
    return result as T?;
  }

  static void goBack<T extends Object?>([T? result]) {
    return navigator!.pop<T>(result);
  }

  static bool canGoBack() {
    return navigator!.canPop();
  }

  static Future<bool> maybePop<T extends Object?>([T? result]) {
    return navigator!.maybePop<T>(result);
  }

  // Métodos de conveniencia para las rutas más comunes
  static Future<void> goToHome() {
    return navigateToAndClearStack('/');
  }

  static Future<void> goToDashboard() {
    return navigateToAndClearStack('/dashboard');
  }

  static Future<void> goToLoans() {
    return navigateTo('/loans');
  }

  static Future<void> goToLoanDetail(int loanId) {
    return navigateTo('/loans/detail', arguments: loanId);
  }

  static Future<void> goToCreateLoan(String loanType) {
    return navigateTo('/loans/form', arguments: {'loanType': loanType});
  }

  static Future<void> goToEditLoan(dynamic loan) {
    return navigateTo('/loans/form', arguments: {
      'loanType': loan.documentTypeId,
      'editingLoan': loan,
    });
  }
}
