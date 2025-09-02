import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class QuickAmountButtons extends StatelessWidget {
  final double remainingAmount;
  final String currencySymbol;
  final Function(double) onAmountSelected;

  const QuickAmountButtons({
    Key? key,
    required this.remainingAmount,
    required this.onAmountSelected,
    this.currencySymbol = '\$',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fullAmount = remainingAmount;
    final halfAmount = remainingAmount / 2;

    return Row(
      children: [
        _buildQuickButton(
          label: 'Full Payment ($currencySymbol${NumberFormat('#,##0.00').format(fullAmount)})',
          amount: fullAmount,
          color: const Color(0xFF16A34A), // green-600
          backgroundColor: const Color(0xFFDCFCE7), // green-100
        ),
        const SizedBox(width: 8),
        _buildQuickButton(
          label: 'Half ($currencySymbol${NumberFormat('#,##0.00').format(halfAmount)})',
          amount: halfAmount,
          color: const Color(0xFF2563EB), // blue-600
          backgroundColor: const Color(0xFFDBEAFE), // blue-100
        ),
      ],
    );
  }

  Widget _buildQuickButton({
    required String label,
    required double amount,
    required Color color,
    required Color backgroundColor,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onAmountSelected(amount),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
