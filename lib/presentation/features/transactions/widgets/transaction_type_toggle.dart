import 'package:flutter/material.dart';
import '../../../core/l10n/generated/strings.g.dart';

enum TransactionToggleType { income, expense, transfer }

class TransactionTypeToggle extends StatelessWidget {
  final TransactionToggleType selectedType;
  final ValueChanged<TransactionToggleType> onTypeChanged;

  const TransactionTypeToggle({
    Key? key,
    required this.selectedType,
    required this.onTypeChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildButton(
          context,
          type: TransactionToggleType.income,
          label: t.transactions.types.income,
          icon: Icons.trending_up,
          activeColor: const Color(0xFF22C55E), // green-500
          activeBgColor: const Color(0xFFF0FDF4), // green-50
          activeBorderColor: const Color(0xFFBBF7D0), // green-200
        ),
        const SizedBox(width: 8),
        _buildButton(
          context,
          type: TransactionToggleType.expense,
          label: t.transactions.types.expense,
          icon: Icons.trending_down,
          activeColor: const Color(0xFFEF4444), // red-500
          activeBgColor: const Color(0xFFFEF2F2), // red-50
          activeBorderColor: const Color(0xFFFECACA), // red-200
        ),
        const SizedBox(width: 8),
        _buildButton(
          context,
          type: TransactionToggleType.transfer,
          label: t.transactions.types.transfer,
          icon: Icons.swap_horiz,
          activeColor: const Color(0xFF3B82F6), // blue-500
          activeBgColor: const Color(0xFFEFF6FF), // blue-50
          activeBorderColor: const Color(0xFFBFDBFE), // blue-200
        ),
      ],
    );
  }

  Widget _buildButton(
    BuildContext context, {
    required TransactionToggleType type,
    required String label,
    required IconData icon,
    required Color activeColor,
    required Color activeBgColor,
    required Color activeBorderColor,
  }) {
    final bool isActive = selectedType == type;
    final theme = Theme.of(context);

    // Define inactive colors based on the design system
    const inactiveColor = Color(0xFF475569); // slate-600
    const inactiveBgColor = Color(0xFFF1F5F9); // slate-100
    const inactiveBorderColor = Color(0xFFE2E8F0); // slate-200

    return Expanded(
      child: GestureDetector(
        onTap: () => onTypeChanged(type),
        child: Container(
          height: 48, // h-12
          decoration: BoxDecoration(
            color: isActive ? activeBgColor : inactiveBgColor,
            border: Border.all(
              color: isActive ? activeBorderColor : inactiveBorderColor,
            ),
            borderRadius: BorderRadius.circular(8), // rounded-lg
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20,
                color: isActive ? activeColor : inactiveColor,
                // Apply fill and weight based on active state, as per the design
                fill: isActive ? 1.0 : 0.0,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: isActive ? activeColor : inactiveColor,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

