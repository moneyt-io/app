import 'package:flutter/material.dart';

/// Clase que define todas las rutas disponibles en la aplicación.
/// 
/// Esta clase contiene únicamente constantes que identifican las rutas,
/// sin lógica de navegación.
class AppRoutes {
  // Rutas principales
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String home = '/';
  
  // Rutas de gestión
  static const String contacts = '/contacts';
  static const String contactForm = '/contact-form';
  
  static const String categories = '/categories';
  static const String categoryForm = '/category-form';
  
  static const String accounts = '/accounts';
  static const String accountForm = '/account-form';

  static const String transactions = '/transactions';
  static const String transactionForm = '/transaction-form';
  static const String transactionDetails = '/transaction-details';
  
  // Rutas de configuración
  static const String settings = '/settings';
  static const String backup = '/backup';

  // Rutas de plan de cuentas
  static const String chartAccounts = '/chart-accounts';
  static const String chartAccountForm = '/chart-account-form';
}
