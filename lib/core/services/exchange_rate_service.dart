import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ExchangeRateService {
  static const String _cacheKey = 'exchange_rates_cache';
  static const String _timestampKey = 'exchange_rates_timestamp';
  
  Map<String, double> _rates = {};

  Future<void> init() async {
    await _loadFromCache();
    await _fetchIfStale();
  }

  Future<void> _loadFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    final cacheStr = prefs.getString(_cacheKey);
    if (cacheStr != null) {
      try {
        final Map<String, dynamic> decoded = jsonDecode(cacheStr);
        _rates = decoded.map((key, value) => MapEntry(key, (value as num).toDouble()));
      } catch (e) {
        print('Error parsing exchange rates cache: $e');
      }
    }
  }

  Future<void> _fetchIfStale() async {
    final prefs = await SharedPreferences.getInstance();
    final timestamp = prefs.getInt(_timestampKey) ?? 0;
    final now = DateTime.now().millisecondsSinceEpoch;
    
    // 24 hours in milliseconds = 86400000
    if (now - timestamp > 86400000 || _rates.isEmpty) {
      try {
        final response = await http.get(Uri.parse('https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies/usd.json'));
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          if (data['usd'] != null) {
            final ratesData = data['usd'] as Map<String, dynamic>;
            _rates = ratesData.map((key, value) => MapEntry(key, (value as num).toDouble()));
            
            await prefs.setString(_cacheKey, jsonEncode(_rates));
            await prefs.setInt(_timestampKey, now);
            print('Exchange rates successfully updated from API.');
          }
        }
      } catch (e) {
        print('Error fetching exchange rates: $e');
      }
    }
  }

  /// Converts an amount from one currency to another using cached rates
  double convert(double amount, String fromCurrency, String toCurrency) {
    if (fromCurrency == toCurrency) return amount;
    
    final fromLower = fromCurrency.toLowerCase();
    final toLower = toCurrency.toLowerCase();

    // If no rates available, return the original amount to avoid returning 0
    if (_rates.isEmpty) return amount;

    // Rates are relative to USD (1 USD = X Currency)
    double fromRate = fromLower == 'usd' ? 1.0 : (_rates[fromLower] ?? 1.0);
    double toRate = toLower == 'usd' ? 1.0 : (_rates[toLower] ?? 1.0);

    // Convert to base USD first, then to target currency
    double amountInUsd = amount / fromRate;
    return amountInUsd * toRate;
  }
}
