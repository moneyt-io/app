import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/utils/number_formatter.dart';

/// Datos de una moneda para mostrar en UI.
class CurrencyInfo {
  final String id;
  final String name;
  final String symbol;
  final String flag;
  final Color backgroundColor;

  const CurrencyInfo({
    required this.id,
    required this.name,
    required this.symbol,
    required this.flag,
    required this.backgroundColor,
  });
}

/// Provider que gestiona la moneda por defecto del usuario.
///
/// - Persiste en SharedPreferences ('default_currency')
/// - Auto-detecta desde el locale del dispositivo en el primer launch
/// - Sincroniza NumberFormatter para que todos los formateos usen la moneda correcta
class CurrencyProvider extends ChangeNotifier {
  static const String _key = 'default_currency';
  final SharedPreferences _prefs;

  String _currencyId = 'USD';

  CurrencyProvider(this._prefs) {
    _load();
  }

  String get currencyId => _currencyId;

  CurrencyInfo get currentCurrency =>
      availableCurrencies.firstWhere(
        (c) => c.id == _currencyId,
        orElse: () => availableCurrencies.first,
      );

  /// Lista de monedas disponibles en la app.
  static const List<CurrencyInfo> availableCurrencies = [
    CurrencyInfo(id: 'USD', name: 'US Dollar',         symbol: r'$',   flag: '🇺🇸', backgroundColor: Color(0xFFDBEAFE)),
    CurrencyInfo(id: 'EUR', name: 'Euro',               symbol: '€',    flag: '🇪🇺', backgroundColor: Color(0xFFDDD6FE)),
    CurrencyInfo(id: 'GBP', name: 'British Pound',      symbol: '£',    flag: '🇬🇧', backgroundColor: Color(0xFFFECDD3)),
    CurrencyInfo(id: 'COP', name: 'Colombian Peso',     symbol: r'$',   flag: '🇨🇴', backgroundColor: Color(0xFFFEF3C7)),
    CurrencyInfo(id: 'MXN', name: 'Mexican Peso',       symbol: r'$',   flag: '🇲🇽', backgroundColor: Color(0xFFD1FAE5)),
    CurrencyInfo(id: 'ARS', name: 'Argentine Peso',     symbol: r'$',   flag: '🇦🇷', backgroundColor: Color(0xFFE0F2FE)),
    CurrencyInfo(id: 'BRL', name: 'Brazilian Real',     symbol: r'R$',  flag: '🇧🇷', backgroundColor: Color(0xFFDCFCE7)),
    CurrencyInfo(id: 'PEN', name: 'Peruvian Sol',       symbol: 'S/',   flag: '🇵🇪', backgroundColor: Color(0xFFF1F5F9)),
    CurrencyInfo(id: 'CLP', name: 'Chilean Peso',       symbol: r'$',   flag: '🇨🇱', backgroundColor: Color(0xFFFCE7F3)),
    CurrencyInfo(id: 'CAD', name: 'Canadian Dollar',    symbol: r'CA$', flag: '🇨🇦', backgroundColor: Color(0xFFECFDF5)),
    CurrencyInfo(id: 'AUD', name: 'Australian Dollar',  symbol: r'A$',  flag: '🇦🇺', backgroundColor: Color(0xFFFFF7ED)),
    CurrencyInfo(id: 'JPY', name: 'Japanese Yen',       symbol: '¥',    flag: '🇯🇵', backgroundColor: Color(0xFFFEF2F2)),
  ];

  /// Cambia la moneda por defecto, persiste y actualiza el formatter.
  Future<void> setCurrency(String currencyId) async {
    try {
      _currencyId = currencyId;
      NumberFormatter.setDefaultCurrency(currencyId);
      await _prefs.setString(_key, currencyId);
      notifyListeners();
      debugPrint('✅ CurrencyProvider: currency changed to $currencyId');
    } catch (e) {
      debugPrint('❌ CurrencyProvider: error setting currency: $e');
      rethrow;
    }
  }

  // ─── Privados ─────────────────────────────────────────────────────────────

  void _load() {
    final saved = _prefs.getString(_key);
    if (saved != null && NumberFormatter.isSupported(saved)) {
      _currencyId = saved;
    } else {
      _currencyId = _detectFromLocale();
      _prefs.setString(_key, _currencyId);
    }
    NumberFormatter.setDefaultCurrency(_currencyId);
    debugPrint('✅ CurrencyProvider: loaded currency $_currencyId');
  }

  /// Detecta la moneda más probable según el locale del dispositivo.
  static String _detectFromLocale() {
    try {
      final locale = Platform.localeName;
      if (locale.contains('CO')) return 'COP';
      if (locale.contains('MX')) return 'MXN';
      if (locale.contains('AR')) return 'ARS';
      if (locale.contains('PE')) return 'PEN';
      if (locale.contains('CL')) return 'CLP';
      if (locale.contains('BR')) return 'BRL';
      if (locale.contains('GB')) return 'GBP';
      if (locale.contains('JP')) return 'JPY';
      if (locale.contains('CA')) return 'CAD';
      if (locale.contains('AU')) return 'AUD';
    } catch (_) {}
    return 'USD';
  }
}
