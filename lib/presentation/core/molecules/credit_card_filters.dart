import 'package:flutter/material.dart';
import '../atoms/filter_chip_button.dart';

/// Filtros disponibles para tarjetas de crédito
enum CreditCardFilter {
  all,
  active,
  blocked,
}

/// Widget de filtros para tarjetas de crédito
/// 
/// HTML Reference:
/// ```html
/// <div class="flex gap-2 overflow-x-auto">
///   <button class="flex-shrink-0 h-10 px-4 rounded-full bg-blue-500/10 text-blue-700 border border-blue-200 text-sm font-medium active">
/// ```
class CreditCardFilters extends StatelessWidget {
  const CreditCardFilters({
    Key? key,
    required this.selectedFilter,
    required this.onFilterChanged,
  }) : super(key: key);

  final CreditCardFilter selectedFilter;
  final Function(CreditCardFilter) onFilterChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // HTML: overflow-x-auto
      child: Row(
        children: [
          FilterChipButton(
            label: 'All',
            icon: Icons.credit_card,
            isSelected: selectedFilter == CreditCardFilter.all,
            onPressed: () => onFilterChanged(CreditCardFilter.all),
          ),
          const SizedBox(width: 8), // HTML: gap-2
          FilterChipButton(
            label: 'Active',
            icon: Icons.check_circle,
            isSelected: selectedFilter == CreditCardFilter.active,
            onPressed: () => onFilterChanged(CreditCardFilter.active),
          ),
          const SizedBox(width: 8), // HTML: gap-2
          FilterChipButton(
            label: 'Blocked',
            icon: Icons.block,
            isSelected: selectedFilter == CreditCardFilter.blocked,
            onPressed: () => onFilterChanged(CreditCardFilter.blocked),
          ),
        ],
      ),
    );
  }
}