import 'package:flutter/material.dart';
import '../atoms/app_search_field.dart';
import 'dialog_action_bar.dart';

/// Modelo para currency con información completa
class CurrencyData {
  final String id;
  final String name;
  final String symbol;
  final String flag;
  final String country;

  const CurrencyData({
    required this.id,
    required this.name,
    required this.symbol,
    required this.flag,
    required this.country,
  });
}

/// Diálogo de selección de currency basado en currency_dialog.html
/// 
/// HTML Reference:
/// ```html
/// <div class="flex flex-col items-stretch bg-white rounded-t-2xl shadow-lg max-h-[80vh]">
///   <button class="flex items-center gap-3 w-full px-4 py-3 hover:bg-slate-50">
/// ```
class CurrencySelectionDialog extends StatefulWidget {
  const CurrencySelectionDialog({
    Key? key,
    required this.selectedCurrency,
  }) : super(key: key);

  final String selectedCurrency;

  static Future<CurrencyData?> show({
    required BuildContext context,
    required String selectedCurrency,
  }) {
    return showModalBottomSheet<CurrencyData?>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.3),
      isDismissible: true,
      enableDrag: true,
      builder: (context) => CurrencySelectionDialog(
        selectedCurrency: selectedCurrency,
      ),
    );
  }

  @override
  State<CurrencySelectionDialog> createState() => _CurrencySelectionDialogState();
}

class _CurrencySelectionDialogState extends State<CurrencySelectionDialog> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  CurrencyData? _selectedCurrency;

  // Lista de currencies disponibles (basado en el HTML)
  static const List<CurrencyData> _availableCurrencies = [
    CurrencyData(
      id: 'USD',
      name: 'US Dollar',
      symbol: '\$',
      flag: '🇺🇸',
      country: 'United States',
    ),
    CurrencyData(
      id: 'EUR',
      name: 'Euro',
      symbol: '€',
      flag: '🇪🇺',
      country: 'European Union',
    ),
    CurrencyData(
      id: 'COP',
      name: 'Colombian Peso',
      symbol: '\$',
      flag: '🇨🇴',
      country: 'Colombia',
    ),
    CurrencyData(
      id: 'MXN',
      name: 'Mexican Peso',
      symbol: '\$',
      flag: '🇲🇽',
      country: 'Mexico',
    ),
    CurrencyData(
      id: 'GBP',
      name: 'British Pound',
      symbol: '£',
      flag: '🇬🇧',
      country: 'United Kingdom',
    ),
    CurrencyData(
      id: 'JPY',
      name: 'Japanese Yen',
      symbol: '¥',
      flag: '🇯🇵',
      country: 'Japan',
    ),
    CurrencyData(
      id: 'CAD',
      name: 'Canadian Dollar',
      symbol: '\$',
      flag: '🇨🇦',
      country: 'Canada',
    ),
    CurrencyData(
      id: 'AUD',
      name: 'Australian Dollar',
      symbol: '\$',
      flag: '🇦🇺',
      country: 'Australia',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _selectedCurrency = _availableCurrencies.firstWhere(
      (currency) => currency.id == widget.selectedCurrency,
      orElse: () => _availableCurrencies.first,
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<CurrencyData> get _filteredCurrencies {
    if (_searchQuery.isEmpty) return _availableCurrencies;
    
    return _availableCurrencies.where((currency) {
      final query = _searchQuery.toLowerCase();
      return currency.name.toLowerCase().contains(query) ||
             currency.id.toLowerCase().contains(query) ||
             currency.country.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: () {},
          child: DraggableScrollableSheet(
            initialChildSize: 0.7,
            minChildSize: 0.5,
            maxChildSize: 0.9,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x1A000000),
                      blurRadius: 10,
                      offset: Offset(0, -4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Handle bar
                    Container(
                      height: 24,
                      width: double.infinity,
                      child: Center(
                        child: Container(
                          height: 6,
                          width: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFFD1D5DB),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ),
                    
                    // Header
                    Container(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xFFF1F5F9),
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Select currency',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Choose the currency for this wallet',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF64748B),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Search
                    Container(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xFFF1F5F9),
                          ),
                        ),
                      ),
                      child: AppSearchField(
                        controller: _searchController,
                        hintText: 'Search currencies',
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                        },
                        onClear: () {
                          _searchController.clear();
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                      ),
                    ),
                    
                    // Currencies List
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: _filteredCurrencies.length,
                        itemBuilder: (context, index) {
                          final currency = _filteredCurrencies[index];
                          final isSelected = _selectedCurrency?.id == currency.id;
                          
                          return _buildCurrencyOption(
                            currency: currency,
                            isSelected: isSelected,
                            onTap: () {
                              setState(() {
                                _selectedCurrency = currency;
                              });
                            },
                          );
                        },
                      ),
                    ),
                    
                    // Footer
                    DialogActionBar(
                      onCancel: () => Navigator.of(context).pop(),
                      onConfirm: () => Navigator.of(context).pop(_selectedCurrency),
                      cancelText: 'Cancel',
                      confirmText: 'Select',
                      isLoading: false,
                      enabled: true,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCurrencyOption({
    required CurrencyData currency,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color(0xFFF1F5F9),
              ),
            ),
          ),
          child: Row(
            children: [
              // Flag
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFE2E8F0),
                  ),
                ),
                child: Center(
                  child: Text(
                    currency.flag,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
              
              const SizedBox(width: 12),
              
              // Currency info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          currency.id,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getCurrencyColor(currency.id).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            currency.symbol,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: _getCurrencyColor(currency.id),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      currency.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF475569),
                      ),
                    ),
                    Text(
                      currency.country,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Selection indicator
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 2,
                    color: isSelected 
                        ? const Color(0xFF0c7ff2)
                        : const Color(0xFFD1D5DB),
                  ),
                  color: isSelected 
                      ? const Color(0xFF0c7ff2)
                      : Colors.transparent,
                ),
                child: isSelected
                    ? const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 14,
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getCurrencyColor(String currencyId) {
    switch (currencyId) {
      case 'USD':
        return const Color(0xFF16A34A);
      case 'EUR':
        return const Color(0xFF2563EB);
      case 'COP':
        return const Color(0xFFD97706);
      case 'MXN':
        return const Color(0xFF059669);
      case 'GBP':
        return const Color(0xFF7C3AED);
      case 'JPY':
        return const Color(0xFFDC2626);
      case 'CAD':
        return const Color(0xFF0891B2);
      case 'AUD':
        return const Color(0xFFCA8A04);
      default:
        return const Color(0xFF64748B);
    }
  }
}
