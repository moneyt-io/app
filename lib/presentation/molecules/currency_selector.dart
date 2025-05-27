import 'package:flutter/material.dart';
import '../../core/presentation/app_dimensions.dart';

class CurrencySelector extends StatelessWidget {
  final String selectedCurrencyId;
  final Function(String) onCurrencyChanged;
  
  // Por ahora usamos una lista estática, después se puede conectar a un provider
  static const List<Map<String, String>> _currencies = [
    {'id': 'USD', 'name': 'Dólar', 'symbol': '\$'},
    {'id': 'EUR', 'name': 'Euro', 'symbol': '€'},
    {'id': 'CRC', 'name': 'Colón', 'symbol': '₡'},
    {'id': 'BTC', 'name': 'Bitcoin', 'symbol': '₿'},
  ];

  const CurrencySelector({
    super.key,
    required this.selectedCurrencyId,
    required this.onCurrencyChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedCurrencyId,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Moneda',
      ),
      items: _currencies.map((currency) {
        return DropdownMenuItem<String>(
          value: currency['id'],
          child: Row(
            children: [
              Text(
                currency['symbol']!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: AppDimensions.spacing8),
              Text(currency['id']!),
            ],
          ),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          onCurrencyChanged(value);
        }
      },
    );
  }
}
