import 'package:intl/intl.dart';

/// Metadatos de una moneda: locale, símbolo y decimales estándar.
class _CurrencyMeta {
  final String locale;
  final String symbol;
  final int decimals; // Decimales estándar de la moneda

  const _CurrencyMeta(this.locale, this.symbol, this.decimals);
}

/// Utilidad para formatear números respetando la moneda del contexto.
///
/// Uso básico (usa la moneda por defecto del usuario):
///   NumberFormatter.formatCurrency(1500.0)
///
/// Uso con moneda explícita (preferido en pantallas con contexto de wallet):
///   NumberFormatter.formatCurrency(1500.0, currencyId: wallet.currencyId)
///
/// Cambiar la moneda por defecto (llamado desde CurrencyProvider):
///   NumberFormatter.setDefaultCurrency('COP')
class NumberFormatter {
  NumberFormatter._();

  // Moneda por defecto — actualizada por CurrencyProvider al iniciar y al cambiar
  static String _defaultCurrency = 'USD';

  // Cache de formatters por clave "CURRENCYID_DECIMALS"
  static final Map<String, NumberFormat> _cache = {};

  // Tabla de monedas soportadas
  static const Map<String, _CurrencyMeta> _meta = {
    'USD': _CurrencyMeta('en_US', r'$',   2),
    'EUR': _CurrencyMeta('en_US', '€',    2),
    'GBP': _CurrencyMeta('en_US', '£',    2),
    'COP': _CurrencyMeta('en_US', r'$',   0),
    'MXN': _CurrencyMeta('en_US', r'$',   2),
    'ARS': _CurrencyMeta('en_US', r'$',   2),
    'BRL': _CurrencyMeta('en_US', r'R$',  2),
    'PEN': _CurrencyMeta('en_US', 'S/',   2),
    'CLP': _CurrencyMeta('en_US', r'$',   0),
    'CAD': _CurrencyMeta('en_US', r'CA$', 2),
    'AUD': _CurrencyMeta('en_US', r'A$',  2),
    'JPY': _CurrencyMeta('en_US', '¥',    0),
    'VES': _CurrencyMeta('en_US', 'Bs',   2),
  };

  // ─── API pública ──────────────────────────────────────────────────────────

  /// Establece la moneda por defecto. Llamado por CurrencyProvider.
  static void setDefaultCurrency(String currencyId) {
    _defaultCurrency = currencyId;
    _cache.clear(); // Invalidar cache al cambiar moneda
  }

  /// Retorna el símbolo de una moneda (p. ej. 'COP' → '$', 'EUR' → '€').
  static String getSymbol(String currencyId) {
    return _meta[currencyId]?.symbol ?? r'$';
  }

  /// Retorna el locale de una moneda (p. ej. 'COP' → 'es_CO').
  static String getLocale(String currencyId) {
    return _meta[currencyId]?.locale ?? 'en_US';
  }

  /// Retorna true si la moneda está registrada.
  static bool isSupported(String currencyId) => _meta.containsKey(currencyId);

  /// Formatea un monto respetando los decimales estándar de la moneda.
  ///
  /// Ejemplo: formatCurrency(1500000, currencyId: 'COP') → "$1.500.000"
  /// Ejemplo: formatCurrency(1500.50, currencyId: 'USD') → "$1,500.50"
  static String formatCurrency(double amount, {String? currencyId}) {
    final cid = currencyId ?? _defaultCurrency;
    final decimals = _meta[cid]?.decimals ?? 2;
    return _format(amount, cid, decimals);
  }

  /// Devuelve true siempre — el código ISO se muestra junto al monto en todos los casos
  /// para mantener consistencia visual entre monedas.
  static bool needsCode(String currencyId) => true;

  /// Formatea un monto añadiendo el código ISO cuando el símbolo es ambiguo.
  ///
  /// Ejemplo: formatCurrencyWithCode(1500, currencyId: 'COP') → "$1.500.000 COP"
  /// Ejemplo: formatCurrencyWithCode(1500, currencyId: 'EUR') → "€1.500 EUR"
  /// Ejemplo: formatCurrencyWithCode(1500.50, currencyId: 'USD') → "$1,500.50 USD"
  static String formatCurrencyWithCode(double amount, {String? currencyId}) {
    final cid = currencyId ?? _defaultCurrency;
    final decimals = _meta[cid]?.decimals ?? 2;
    final base = _format(amount, cid, decimals);
    return needsCode(cid) ? '$base $cid' : base;
  }

  /// Formatea un monto con los decimales estándar de la moneda.
  ///
  /// Ejemplo: formatCurrencyWithDecimals(1500.50, currencyId: 'USD') → "$1,500.50"
  /// Ejemplo: formatCurrencyWithDecimals(1500000, currencyId: 'COP') → "$1.500.000"
  static String formatCurrencyWithDecimals(double amount, {String? currencyId}) {
    final cid = currencyId ?? _defaultCurrency;
    final decimals = _meta[cid]?.decimals ?? 2;
    return _format(amount, cid, decimals);
  }

  /// Formatea un número como porcentaje.
  static String formatPercentage(double value) {
    final locale = _meta[_defaultCurrency]?.locale ?? 'en_US';
    final key = 'pct_$locale';
    _cache[key] ??= NumberFormat.percentPattern(locale);
    return _cache[key]!.format(_sanitize(value));
  }

  /// Formatea un número con separadores de miles (sin símbolo).
  static String formatNumber(double number) {
    final locale = _meta[_defaultCurrency]?.locale ?? 'en_US';
    final key = 'num_$locale';
    _cache[key] ??= NumberFormat.decimalPattern(locale);
    return _cache[key]!.format(_sanitize(number));
  }

  /// Formatea un entero con separadores de miles.
  static String formatInteger(int number) {
    final locale = _meta[_defaultCurrency]?.locale ?? 'en_US';
    final key = 'num_$locale';
    _cache[key] ??= NumberFormat.decimalPattern(locale);
    return _cache[key]!.format(number);
  }

  /// Convierte un string de moneda a double (best-effort).
  static double? parseCurrency(String currencyText) {
    try {
      final clean = currencyText
          .replaceAll(RegExp(r'[^\d.,-]'), '')
          .trim();

      // Intentar parsear usando el locale de la moneda activa
      final locale = _meta[_defaultCurrency]?.locale ?? 'en_US';
      try {
        final fmt = NumberFormat.currency(locale: locale, symbol: '');
        return fmt.parse(clean).toDouble();
      } catch (_) {
        // Fallback: limpiar manualmente
        final normalized = clean.replaceAll(',', '');
        return double.tryParse(normalized);
      }
    } catch (_) {
      return null;
    }
  }

  /// Determina si un monto es positivo, negativo o neutro.
  static AmountDisplayInfo getAmountDisplayInfo(double amount) {
    final clean = _sanitize(amount);
    if (clean > 0) return const AmountDisplayInfo(isPositive: true, isNegative: false, isNeutral: false);
    if (clean < 0) return const AmountDisplayInfo(isPositive: false, isNegative: true, isNeutral: false);
    return const AmountDisplayInfo(isPositive: false, isNegative: false, isNeutral: true);
  }

  // ─── Privados ─────────────────────────────────────────────────────────────

  static String _format(double amount, String currencyId, int decimals) {
    final meta = _meta[currencyId] ?? _meta['USD']!;
    final key = '${currencyId}_$decimals';
    _cache[key] ??= NumberFormat.currency(
      locale: meta.locale,
      symbol: meta.symbol,
      decimalDigits: decimals,
    );
    return _cache[key]!.format(_sanitize(amount));
  }

  static double _sanitize(double value) {
    return double.parse(value.toStringAsFixed(2)) + 0.0;
  }
}

/// Información sobre cómo mostrar un monto.
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
