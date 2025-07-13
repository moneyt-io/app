import 'package:flutter/material.dart';

/// Enum para tipos de filtro de tarjetas de crédito.
enum CreditCardFilter { all, active, blocked }

/// Widget de filtros para tarjetas de crédito, rediseñado para ocupar el ancho completo.
class CreditCardFilters extends StatelessWidget {
  const CreditCardFilters({
    Key? key,
    required this.selectedFilter,
    required this.onFilterChanged,
  }) : super(key: key);

  final CreditCardFilter selectedFilter;
  final ValueChanged<CreditCardFilter> onFilterChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildFilterButton(
            type: CreditCardFilter.all,
            icon: Icons.credit_card,
            label: 'All',
            isActive: selectedFilter == CreditCardFilter.all,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildFilterButton(
            type: CreditCardFilter.active,
            icon: Icons.check_circle,
            label: 'Active',
            isActive: selectedFilter == CreditCardFilter.active,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildFilterButton(
            type: CreditCardFilter.blocked,
            icon: Icons.block,
            label: 'Blocked',
            isActive: selectedFilter == CreditCardFilter.blocked,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterButton({
    required CreditCardFilter type,
    required IconData icon,
    required String label,
    required bool isActive,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onFilterChanged(type),
        borderRadius: BorderRadius.circular(20), // rounded-full
        child: Container(
          height: 40, // h-10
          decoration: BoxDecoration(
            color: isActive
                ? const Color(0xFF3B82F6).withOpacity(0.1) // bg-blue-500/10
                : const Color(0xFFF1F5F9), // bg-slate-100
            border: Border.all(
              color: isActive
                  ? const Color(0xFF93C5FD) // border-blue-200
                  : const Color(0xFFE2E8F0), // border-slate-200
            ),
            borderRadius: BorderRadius.circular(20), // rounded-full
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18, // text-lg
                color: isActive
                    ? const Color(0xFF1D4ED8) // text-blue-700
                    : const Color(0xFF64748B), // text-slate-600
              ),
              const SizedBox(width: 8), // mr-2
              Text(
                label,
                style: TextStyle(
                  fontSize: 14, // text-sm
                  fontWeight: FontWeight.w500, // font-medium
                  color: isActive
                      ? const Color(0xFF1D4ED8) // text-blue-700
                      : const Color(0xFF64748B), // text-slate-600
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}