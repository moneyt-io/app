import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateFilterSelector extends StatelessWidget {
  final String selectedFilter;
  final DateTime? startDate;
  final DateTime? endDate;
  final Function(String) onFilterChanged;
  final VoidCallback onCustomDateSelected;

  const DateFilterSelector({
    Key? key,
    required this.selectedFilter,
    this.startDate,
    this.endDate,
    required this.onFilterChanged,
    required this.onCustomDateSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // Texto que muestra el rango de fechas seleccionado
    String dateRangeText = 'Todos';
    if (startDate != null && endDate != null) {
      final dateFormat = DateFormat('dd/MM/yyyy');
      if (selectedFilter == 'custom') {
        dateRangeText = '${dateFormat.format(startDate!)} - ${dateFormat.format(endDate!)}';
      } else if (selectedFilter == 'month') {
        dateRangeText = 'Este mes';
      } else if (selectedFilter == 'week') {
        dateRangeText = 'Esta semana';
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outline.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.date_range,
            size: 20,
            color: colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              dateRangeText,
              style: textTheme.bodyMedium,
            ),
          ),
          Wrap(
            spacing: 8,
            children: [
              _buildFilterChip(context, 'all', 'Todos'),
              _buildFilterChip(context, 'month', 'Mes'),
              _buildFilterChip(context, 'week', 'Semana'),
              TextButton(
                onPressed: onCustomDateSelected,
                style: TextButton.styleFrom(
                  minimumSize: const Size(0, 32),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text('Personalizado'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(BuildContext context, String filter, String label) {
    final colorScheme = Theme.of(context).colorScheme;
    final isSelected = selectedFilter == filter;

    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (value) {
        if (value) onFilterChanged(filter);
      },
      backgroundColor: colorScheme.surfaceVariant,
      selectedColor: colorScheme.primaryContainer,
      labelStyle: TextStyle(
        color: isSelected ? colorScheme.onPrimaryContainer : colorScheme.onSurfaceVariant,
        fontSize: 12,
      ),
      padding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
    );
  }
}
