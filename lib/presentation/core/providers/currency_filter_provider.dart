import 'package:flutter/foundation.dart';

/// Gestiona la divisa activa para el filtro global del dashboard y pantallas de datos.
///
/// Solo se activa visualmente cuando hay 2+ divisas disponibles en las cuentas.
/// Al cambiar la divisa, todos los widgets que consumen este provider se actualizan.
class CurrencyFilterProvider extends ChangeNotifier {
  String _selectedCurrencyId;

  CurrencyFilterProvider(String initialCurrencyId)
      : _selectedCurrencyId = initialCurrencyId;

  String get selectedCurrencyId => _selectedCurrencyId;

  /// Cambia la divisa activa.
  void selectCurrency(String currencyId) {
    if (_selectedCurrencyId == currencyId) return;
    _selectedCurrencyId = currencyId;
    notifyListeners();
  }

  /// Sincroniza la selección con las divisas disponibles.
  /// Si la divisa actual ya no existe en la lista, cambia a la primera disponible.
  void syncWithAvailable(List<String> available) {
    if (available.isEmpty) return;
    if (!available.contains(_selectedCurrencyId)) {
      _selectedCurrencyId = available.first;
      notifyListeners();
    }
  }
}
