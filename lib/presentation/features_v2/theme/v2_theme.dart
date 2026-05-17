import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'v2_colors.dart';
import 'v2_typography.dart';

class V2Theme {
  V2Theme._();

  static ThemeData get lightTheme {
    final colorScheme = V2Colors.lightColorScheme;

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: V2Typography.textTheme,
      scaffoldBackgroundColor: V2Colors.background,
      
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: V2Colors.surface,
        surfaceTintColor: Colors.transparent,
        foregroundColor: V2Colors.onSurface,
        titleTextStyle: V2Typography.textTheme.headlineMedium?.copyWith(
          color: V2Colors.onSurface,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),

      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // 1rem
        ),
        color: V2Colors.pureWhite,
        surfaceTintColor: Colors.transparent,
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: V2Colors.lightGray,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8), // 0.5rem
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: V2Colors.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }
}
