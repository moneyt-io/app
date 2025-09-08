import 'package:flutter/material.dart';

/// Material Design 3 Color Tokens
/// Define el sistema de colores base para light y dark themes
class AppColors {
  AppColors._();

  // --- Semantic Colors for Loans --- 
  static const Color lendColor1 = Color(0xFFF97316); // Orange 500
  static const Color lendColor2 = Color(0xFFEA580C); // Orange 600
  static const Color borrowColor1 = Color(0xFF8B5CF6); // Purple 500
  static const Color borrowColor2 = Color(0xFF7C3AED); // Purple 600

  // --- Primary Brand Color ---
  static const Color primaryBlue = Color(0xFF0c7ff2);

  // --- Slate Color Palette (del diseño HTML) ---
  static const Color slate50 = Color(0xfff8fafc);
  static const Color slate100 = Color(0xfff1f5f9);
  static const Color slate200 = Color(0xffe2e8f0);
  static const Color slate300 = Color(0xffcbd5e1);
  static const Color slate400 = Color(0xff94a3b8);
  static const Color slate500 = Color(0xff64748b);
  static const Color slate600 = Color(0xff475569);
  static const Color slate700 = Color(0xff334155);
  static const Color slate800 = Color(0xff1e293b);
  static const Color slate900 = Color(0xff0f172a);

  // --- Design System Color Roles ---
  
  /// Colores de texto basados en el diseño
  static const Color textPrimary = slate800;     // Nombres de contactos
  static const Color textSecondary = slate500;   // Info secundaria
  static const Color textTertiary = slate400;    // Placeholders
  
  /// Colores de superficie y bordes
  static const Color surfaceWhite = Color(0xffffffff);
  static const Color surfaceHover = slate50;
  static const Color borderLight = slate100;
  static const Color borderFocus = primaryBlue;
  
  /// Colores de estado (conservar existentes)
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);

  // --- Color Schemes M3 ---
  static ColorScheme get lightColorScheme => ColorScheme.fromSeed(
    seedColor: primaryBlue,
    brightness: Brightness.light,
  ).copyWith(
    // Override específicos para match del diseño
    surface: surfaceWhite,
    onSurface: textPrimary,
    onSurfaceVariant: textSecondary,
    outline: borderLight,
    primary: primaryBlue,
  );

  static ColorScheme get darkColorScheme => ColorScheme.fromSeed(
    seedColor: primaryBlue,
    brightness: Brightness.dark,
  ).copyWith(
    // Override específicos para match del diseño
    surface: slate900,
    onSurface: slate50,
    onSurfaceVariant: slate400,
    outline: slate600,
    primary: primaryBlue,
  );
}
