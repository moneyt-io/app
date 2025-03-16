import 'package:flutter/material.dart';
import '../../domain/entities/accounting_type.dart';

class ChartAccountTypeFilter extends StatelessWidget {
  final String? selectedType;
  final ValueChanged<String?> onTypeSelected;
  
  const ChartAccountTypeFilter({
    Key? key,
    this.selectedType,
    required this.onTypeSelected,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // Opción para mostrar todos los tipos
          _buildFilterChip(
            context: context,
            label: 'Todos',
            typeId: null,
            color: colorScheme.primary,
          ),
          const SizedBox(width: 8),
          
          // Generar un chip para cada tipo de cuenta
          ...AccountingType.values.map((type) {
            Color color;
            
            switch (type) {
              case AccountingType.assets:
                color = Colors.green.shade700;
                break;
              case AccountingType.liabilities:
                color = Colors.red.shade700;
                break;
              case AccountingType.equity:
                color = Colors.purple.shade700;
                break;
              case AccountingType.income:
                color = Colors.blue.shade700;
                break;
              case AccountingType.expenses:
                color = Colors.orange.shade700;
                break;
            }
            
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: _buildFilterChip(
                context: context,
                label: type.name,
                typeId: type.id,
                color: color,
              ),
            );
          }),
        ],
      ),
    );
  }
  
  Widget _buildFilterChip({
    required BuildContext context,
    required String label,
    required String? typeId,
    required Color color,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final isSelected = selectedType == typeId;
    
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onTypeSelected(typeId),
      selectedColor: color.withOpacity(0.15),
      labelStyle: TextStyle(
        color: isSelected ? color : colorScheme.onSurface,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      checkmarkColor: color,
    );
  }
}
