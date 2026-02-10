import 'package:flutter/material.dart';
import '../l10n/generated/strings.g.dart';

class TransactionTypeSelector extends StatelessWidget {
  final String selectedType;
  final ValueChanged<String> onTypeSelected;

  const TransactionTypeSelector({
    Key? key,
    required this.selectedType,
    required this.onTypeSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildTypeButton(
          context,
          type: 'I',
          label: t.transactions.types.income,
          icon: Icons.trending_up,
        ),
        const SizedBox(width: 8),
        _buildTypeButton(
          context,
          type: 'E',
          label: t.transactions.types.expense,
          icon: Icons.trending_down,
        ),
        const SizedBox(width: 8),
        _buildTypeButton(
          context,
          type: 'T',
          label: t.transactions.types.transfer,
          icon: Icons.swap_horiz,
        ),
      ],
    );
  }

  Widget _buildTypeButton(
    BuildContext context, {
    required String type,
    required String label,
    required IconData icon,
  }) {
    final bool isActive = selectedType == type;

    Color bgColor, fgColor, borderColor;

    if (isActive) {
      switch (type) {
        case 'I':
          bgColor = const Color(0xFF22C55E).withOpacity(0.1); // bg-green-500/10
          fgColor = const Color(0xFF15803D); // text-green-700
          borderColor = const Color(0xFF86EFAC); // border-green-200
          break;
        case 'E':
          bgColor = const Color(0xFFEF4444).withOpacity(0.1); // bg-red-500/10
          fgColor = const Color(0xFFB91C1C); // text-red-700
          borderColor = const Color(0xFFFCA5A5); // border-red-200
          break;
        case 'T':
          bgColor = const Color(0xFF3B82F6).withOpacity(0.1); // bg-blue-500/10
          fgColor = const Color(0xFF1D4ED8); // text-blue-700
          borderColor = const Color(0xFFBFDBFE); // border-blue-200
          break;
        default:
          bgColor = const Color(0xFFF1F5F9);
          fgColor = const Color(0xFF475569);
          borderColor = const Color(0xFFE2E8F0);
      }
    } else {
      bgColor = const Color(0xFFF1F5F9); // bg-slate-100
      fgColor = const Color(0xFF475569); // text-slate-600
      borderColor = const Color(0xFFE2E8F0); // border-slate-200
    }

    return Expanded(
      child: SizedBox(
        height: 48, // h-12
        child: OutlinedButton.icon(
          onPressed: () => onTypeSelected(type),
          icon: Icon(icon, size: 18),
          label: Text(label),
          style: OutlinedButton.styleFrom(
            backgroundColor: bgColor,
            foregroundColor: fgColor,
            side: BorderSide(color: borderColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // rounded-lg
            ),
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
   