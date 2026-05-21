import 'package:flutter/material.dart';
import '../../../../core/utils/number_formatter.dart';

class V2RecentTransactions extends StatelessWidget {
  final String currencySymbol;

  const V2RecentTransactions({
    super.key,
    this.currencySymbol = '\$',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Recent Transactions",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF131B2E),
                fontFamily: 'Manrope',
              ),
            ),
            TextButton(
              onPressed: () {}, // TODO: Navigate to full list
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF004AC6), // Brand Blue
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Manrope',
                ),
              ),
              child: const Text("See All"),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(24),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0D0F172A),
                blurRadius: 20,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildTransactionItem(
                title: "Starbucks",
                category: "Food & Drinks",
                date: "Today, 09:41 AM",
                amount: -5.40,
                icon: Icons.coffee,
                color: const Color(0xFFF97316), // Orange
              ),
              const Divider(color: Color(0xFFF1F5F9), height: 32), // Slate-100
              _buildTransactionItem(
                title: "Salary",
                category: "Income",
                date: "Yesterday, 04:00 PM",
                amount: 3250.00,
                icon: Icons.work,
                color: const Color(0xFF006C49), // Emerald
              ),
              const Divider(color: Color(0xFFF1F5F9), height: 32),
              _buildTransactionItem(
                title: "Netflix",
                category: "Entertainment",
                date: "Aug 15, 10:20 AM",
                amount: -15.99,
                icon: Icons.movie,
                color: const Color(0xFFBA1A1A), // Red
              ),
              const Divider(color: Color(0xFFF1F5F9), height: 32),
              _buildTransactionItem(
                title: "Spotify",
                category: "Entertainment",
                date: "Aug 14, 08:15 AM",
                amount: -9.99,
                icon: Icons.music_note,
                color: const Color(0xFF004AC6), // Brand Blue
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionItem({
    required String title,
    required String category,
    required String date,
    required double amount,
    required IconData icon,
    required Color color,
  }) {
    final isIncome = amount > 0;
    
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF131B2E),
                  fontFamily: 'Manrope',
                ),
              ),
              const SizedBox(height: 2),
              Text(
                "$category • $date",
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF64748B),
                  fontFamily: 'Manrope',
                ),
              ),
            ],
          ),
        ),
        Text(
          "${isIncome ? '+' : ''}${NumberFormatter.formatCurrency(amount.abs())}",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: isIncome ? const Color(0xFF006C49) : const Color(0xFF131B2E),
            fontFamily: 'Manrope',
          ),
        ),
      ],
    );
  }
}
