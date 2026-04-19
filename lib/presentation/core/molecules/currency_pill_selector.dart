import 'package:flutter/material.dart';
import '../../../core/utils/number_formatter.dart';

/// Selector de divisa en formato pills horizontal.
///
/// Solo se renderiza cuando hay 2 o más divisas disponibles.
/// Al seleccionar una pill, notifica al padre para actualizar el filtro global.
class CurrencyPillSelector extends StatelessWidget {
  const CurrencyPillSelector({
    Key? key,
    required this.availableCurrencies,
    required this.selectedCurrencyId,
    required this.onCurrencySelected,
  }) : super(key: key);

  final List<String> availableCurrencies;
  final String selectedCurrencyId;
  final ValueChanged<String> onCurrencySelected;

  @override
  Widget build(BuildContext context) {
    if (availableCurrencies.length <= 1) return const SizedBox.shrink();

    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: availableCurrencies.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final currencyId = availableCurrencies[index];
          final isSelected = currencyId == selectedCurrencyId;
          final symbol = NumberFormatter.getSymbol(currencyId);

          return _CurrencyPill(
            label: '$symbol $currencyId',
            isSelected: isSelected,
            onTap: () => onCurrencySelected(currencyId),
          );
        },
      ),
    );
  }
}

class _CurrencyPill extends StatelessWidget {
  const _CurrencyPill({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF2563EB)           // blue-600 seleccionado
              : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF2563EB)
                : const Color(0xFFCBD5E1),        // slate-300
            width: 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF2563EB).withValues(alpha: 0.25),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  )
                ]
              : null,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : const Color(0xFF475569), // slate-600
              letterSpacing: 0.2,
            ),
          ),
        ),
      ),
    );
  }
}
