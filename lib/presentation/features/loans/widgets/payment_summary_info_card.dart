import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentSummaryInfoCard extends StatelessWidget {
  final double paymentAmount;
  final double remainingBalance;
  final double newProgressPercentage;
  final String currencySymbol;

  const PaymentSummaryInfoCard({
    Key? key,
    required this.paymentAmount,
    required this.remainingBalance,
    required this.newProgressPercentage,
    this.currencySymbol = '\$',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)), // border-slate-200
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Payment summary',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF374151), // text-slate-700
            ),
          ),
          const SizedBox(height: 12),
          Column(
            children: [
              _buildSummaryRow(
                'Payment amount',
                '$currencySymbol${NumberFormat('#,##0.00').format(paymentAmount)}',
                const Color(0xFF111827), // text-slate-900
              ),
              const SizedBox(height: 8),
              _buildSummaryRow(
                'Remaining balance',
                '$currencySymbol${NumberFormat('#,##0.00').format(remainingBalance)}',
                const Color(0xFFEA580C), // text-orange-600
              ),
              const SizedBox(height: 8),
              _buildSummaryRow(
                'New progress',
                '${newProgressPercentage.toStringAsFixed(0)}%',
                const Color(0xFF16A34A), // text-green-600
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, Color valueColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF64748B), // text-slate-600
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}
