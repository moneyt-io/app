import 'package:flutter/material.dart';

/// Material Design 3 Color Tokens
/// Define el sistema de colores base para light y dark themes
class AppColors {
  AppColors._();

  // --- Seed Color (Color principal de la marca) ---
  static const Color _seedColor = Color(0xFF6750A4); // Purple base M3

  // --- Light Theme Color Scheme ---
  static final ColorScheme lightColorScheme = ColorScheme.fromSeed(
    seedColor: _seedColor,
    brightness: Brightness.light,
  );

  // --- Dark Theme Color Scheme ---
  static final ColorScheme darkColorScheme = ColorScheme.fromSeed(
    seedColor: _seedColor,
    brightness: Brightness.dark,
  );

  // --- Custom Colors (Extensión del sistema M3) ---
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);

  // Versiones para dark theme
  static const Color successDark = Color(0xFF81C784);
  static const Color warningDark = Color(0xFFFFB74D);
  static const Color infoDark = Color(0xFF64B5F6);

  // --- Color Roles Específicos de la App ---
  
  /// Colors para transacciones financieras
  static const Color income = Color(0xFF4CAF50);   // Verde para ingresos
  static const Color expense = Color(0xFFF44336);  // Rojo para gastos
  static const Color transfer = Color(0xFF2196F3); // Azul para transferencias
  
  /// Colors para transacciones en dark theme
  static const Color incomeDark = Color(0xFF81C784);
  static const Color expenseDark = Color(0xFFEF5350);
  static const Color transferDark = Color(0xFF64B5F6);

  /// Helper para obtener color de transacción según tipo
  static Color getTransactionColor(String type, bool isDark) {
    switch (type.toUpperCase()) {
      case 'I': // Income
        return isDark ? incomeDark : income;
      case 'E': // Expense
        return isDark ? expenseDark : expense;
      case 'T': // Transfer
        return isDark ? transferDark : transfer;
      default:
        return isDark ? darkColorScheme.primary : lightColorScheme.primary;
    }
  }
}
