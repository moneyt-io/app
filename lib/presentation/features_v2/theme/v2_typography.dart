import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class V2Typography {
  V2Typography._();

  static TextTheme get textTheme => GoogleFonts.manropeTextTheme(
        TextTheme(
          displayLarge: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w800,
            height: 1.2, // 48px / 40px
            letterSpacing: -0.02,
          ),
          headlineLarge: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            height: 1.25, // 40px / 32px
            letterSpacing: -0.01,
          ),
          headlineMedium: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            height: 1.4, // 28px / 20px
          ),
          bodyLarge: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            height: 1.55, // 28px / 18px
          ),
          bodyMedium: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            height: 1.5, // 24px / 16px
          ),
          labelLarge: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            height: 1.42, // 20px / 14px
            letterSpacing: 0.01,
          ),
          labelSmall: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            height: 1.33, // 16px / 12px
          ),
        ),
      );
}
