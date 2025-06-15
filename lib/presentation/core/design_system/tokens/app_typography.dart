import 'package:flutter/material.dart';

/// Material Design 3 Typography Tokens
/// Define el sistema tipográfico siguiendo M3 guidelines
class AppTypography {
  AppTypography._();

  // Font family base
  static const String _fontFamily = 'Public Sans';

  /// Text Theme específico para match del diseño HTML
  static TextTheme get textTheme => const TextTheme(
    // Headers y títulos
    headlineLarge: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 32,
      fontWeight: FontWeight.w600,
      height: 1.25,
    ),
    headlineMedium: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 28,
      fontWeight: FontWeight.w600,
      height: 1.3,
    ),
    headlineSmall: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 24,
      fontWeight: FontWeight.w600,
      height: 1.3,
    ),

    // Títulos de pantalla (match "Contacts")
    titleLarge: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 20,           // Match del diseño HTML
      fontWeight: FontWeight.w600,
      height: 1.2,
      letterSpacing: -0.3,
    ),
    titleMedium: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 16,           // Nombres de contactos
      fontWeight: FontWeight.w500,
      height: 1.25,
    ),
    titleSmall: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 1.25,
    ),

    // Body text (información de contactos)
    bodyLarge: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 16,           // Search placeholder
      fontWeight: FontWeight.w400,
      height: 1.25,
    ),
    bodyMedium: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 14,           // Info secundaria contactos
      fontWeight: FontWeight.w400,
      height: 1.25,
    ),
    bodySmall: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      height: 1.25,
    ),

    // Labels y captions
    labelLarge: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 1.25,
    ),
    labelMedium: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 1.25,
    ),
    labelSmall: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 11,
      fontWeight: FontWeight.w500,
      height: 1.25,
    ),
  );

  // --- Custom Typography para la App ---
  
  /// Typography específica para montos financieros
  static const TextStyle currencyLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.25,
  );

  static const TextStyle currencyMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.33,
  );

  static const TextStyle currencySmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.44,
  );
}
