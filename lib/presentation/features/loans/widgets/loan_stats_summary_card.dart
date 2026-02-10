import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/l10n/generated/strings.g.dart';

class LoanStatsSummaryCard extends StatelessWidget {
  final double activeLentAmount;
  final double activeBorrowedAmount;
  final double netActivePosition;
  final int totalActiveLoans;
  final String currencySymbol;

  const LoanStatsSummaryCard({
    Key? key,
    required this.activeLentAmount,
    required this.activeBorrowedAmount,
    required this.netActivePosition,
    required this.totalActiveLoans,
    this.currencySymbol = '\$',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isPositive = netActivePosition >= 0;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFF1F5F9), // border-slate-100
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Text(
                  t.loans.detail.activeSummary,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E293B), // text-slate-800
                  ),
                ),
              ],
            ),
          ),
          
          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // You Lent (Active)
                _buildStatRow(
                  t.loans.detail.activeLent,
                  activeLentAmount,
                  const Color(0xFFEA580C), // text-orange-600
                ),
                
                const SizedBox(height: 12),
                
                // You Borrowed (Active)
                _buildStatRow(
                  t.loans.detail.activeBorrowed,
                  activeBorrowedAmount,
                  const Color(0xFF9333EA), // text-purple-600
                ),
                
                const SizedBox(height: 16),
                
                // Divider
                Container(
                  height: 1,
                  color: const Color(0xFFE2E8F0), // border-slate-200
                ),
                
                const SizedBox(height: 16),
                
                // Net Position (Active)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      t.loans.detail.activeNet,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF374151), // text-slate-700
                      ),
                    ),
                    Text(
                      '${isPositive ? '+' : '-'}$currencySymbol${NumberFormat('#,##0.00').format(netActivePosition.abs())}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isPositive 
                            ? const Color(0xFFEA580C) // text-orange-600
                            : const Color(0xFF9333EA), // text-purple-600
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 12),
                
                // Total Active Loans
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      t.loans.detail.activeTotal,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF64748B), // text-slate-600
                      ),
                    ),
                    Text(
                      totalActiveLoans.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF0F172A), // text-slate-900
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, double amount, Color amountColor) {
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
          '$currencySymbol${NumberFormat('#,##0.00').format(amount)}',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: amountColor,
          ),
        ),
      ],
    );
  }
}
