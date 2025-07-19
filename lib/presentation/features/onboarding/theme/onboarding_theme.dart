import 'package:flutter/material.dart';

/// Sistema de design específico para onboarding
class OnboardingTheme {
  /// Gradientes por pantalla para mejor experiencia visual
  static const Map<String, List<Color>> gradients = {
    'welcome': [
      Color(0xFF2DD4BF), // Turquesa brillante
      Color(0xFF047857), // Verde bosque oscuro
    ],
    'problem': [
      Color(0xFFFF6B6B), // Coral suave
      Color(0xFFFF8E8E), // Rosa coral
    ],
    'solution': [
      Color(0xFF3B82F6), // Blue
      Color(0xFF1D4ED8), // Blue dark
    ],
    'features': [
      Color(0xFF8B5CF6), // Purple
      Color(0xFF7C3AED), // Purple dark
    ],
    'trust': [
      Color(0xFF10B981), // Green
      Color(0xFF059669), // Green dark
    ],
    'completion': [
      Color(0xFFEAB308), // Yellow
      Color(0xFFD97706), // Orange
    ],
  };

  /// Duraciones de animación
  static const Duration pageTransition = Duration(milliseconds: 350);
  static const Duration elementEntrance = Duration(milliseconds: 250);
  static const Duration iconAnimation = Duration(milliseconds: 600);
  static const Duration progressUpdate = Duration(milliseconds: 200);

  /// Curves de animación
  static const Curve defaultCurve = Curves.easeInOutCubic;
  static const Curve bounceCurve = Curves.elasticOut;
  static const Curve slideCurve = Curves.easeOutQuart;

  /// Colores específicos
  static const Color progressColor = Color(0xFF14B8A6);
  static const Color progressBackground = Color(0xFFE2E8F0);
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF475569);
  static const Color textAccent = Color(0xFF14B8A6);

  /// Spacing
  static const double spacing8 = 8.0;
  static const double spacing16 = 16.0;
  static const double spacing24 = 24.0;
  static const double spacing32 = 32.0;
  static const double spacing48 = 48.0;
  static const double spacing64 = 64.0;
}
