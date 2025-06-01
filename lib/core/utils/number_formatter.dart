import 'package:intl/intl.dart';

/// Utilidad para formatear números siguiendo las convenciones locales
/// 
/// Proporciona métodos estáticos para formatear moneda, porcentajes y números
/// de manera consistente en toda la aplicación.
class NumberFormatter {
  NumberFormatter._(); // Constructor privado para clase estática

  // Formateadores reutilizables (singleton pattern para performance)
  static final NumberFormat _currencyFormatter = NumberFormat.currency(
    locale: 'es_CO',
    symbol: '\$',
    decimalDigits: 0,
  );

  static final NumberFormat _currencyWithDecimalsFormatter = NumberFormat.currency(
    locale: 'es_CO',
    symbol: '\$',
    decimalDigits: 2,
  );

  static final NumberFormat _percentFormatter = NumberFormat.percentPattern('es_CO');

  static final NumberFormat _numberFormatter = NumberFormat.decimalPattern('es_CO');

  /// Formatea un número como moneda sin decimales
  /// 
  /// Ejemplo: 1500000 -> "$1.500.000"
  static String formatCurrency(double amount) {
    return _currencyFormatter.format(amount);
  }

  /// Formatea un número como moneda con decimales
  /// 
  /// Ejemplo: 1500000.50 -> "$1.500.000,50"
  static String formatCurrencyWithDecimals(double amount) {
    return _currencyWithDecimalsFormatter.format(amount);
  }

  /// Formatea un número como porcentaje
  /// 
  /// Ejemplo: 0.15 -> "15%"
  static String formatPercentage(double value) {
    return _percentFormatter.format(value);
  }

  /// Formatea un número con separadores de miles
  /// 
  /// Ejemplo: 1500000 -> "1.500.000"
  static String formatNumber(double number) {
    return _numberFormatter.format(number);
  }

  /// Formatea un número entero con separadores de miles
  /// 
  /// Ejemplo: 1500000 -> "1.500.000"
  static String formatInteger(int number) {
    return _numberFormatter.format(number);
  }

  /// Convierte un string de moneda a double
  /// 
  /// Ejemplo: "$1.500.000" -> 1500000.0
  static double? parseCurrency(String currencyText) {
    try {
      // Remover símbolo de moneda y separadores
      final cleanText = currencyText
          .replaceAll('\$', '')
          .replaceAll('.', '')
          .replaceAll(',', '.')
          .trim();
      
      return double.tryParse(cleanText);
    } catch (e) {
      return null;
    }
  }

  /// Determina el color apropiado para mostrar un monto
  /// 
  /// Retorna información sobre si el monto es positivo, negativo o neutro
  static AmountDisplayInfo getAmountDisplayInfo(double amount) {
    if (amount > 0) {
      return AmountDisplayInfo(
        isPositive: true,
        isNegative: false,
        isNeutral: false,
      );
    } else if (amount < 0) {
      return AmountDisplayInfo(
        isPositive: false,
        isNegative: true,
        isNeutral: false,
      );
    } else {
      return AmountDisplayInfo(
        isPositive: false,
        isNegative: false,
        isNeutral: true,
      );
    }
  }
}

/// Información sobre cómo mostrar un monto
class AmountDisplayInfo {
  final bool isPositive;
  final bool isNegative;
  final bool isNeutral;

  const AmountDisplayInfo({
    required this.isPositive,
    required this.isNegative,
    required this.isNeutral,
  });
}
