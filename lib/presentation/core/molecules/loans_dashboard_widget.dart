import 'package:flutter/material.dart';
import '../atoms/widget_card_header.dart';

/// Widget de préstamos para dashboard basado en dashboard_main.html
/// 
/// HTML Reference:
/// ```html
/// <div class="bg-white rounded-2xl shadow-sm border border-slate-200 widget-card">
///   <div class="p-4">
///     <div class="grid grid-cols-2 gap-4 mb-4">
/// ```
class LoansDashboardWidget extends StatelessWidget {
  const LoansDashboardWidget({
    Key? key,
    required this.youLent,
    required this.youBorrowed,
    required this.activeLoansCount,
    required this.onHeaderTap,
    this.isVisible = true,
  }) : super(key: key);

  final double youLent;
  final double youBorrowed;
  final int activeLoansCount;
  final VoidCallback onHeaderTap;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    if (!isVisible) return const SizedBox.shrink();

    final netPosition = youLent - youBorrowed;
    final isPositive = netPosition >= 0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16), // HTML: mx-4
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16), // HTML: rounded-2xl
        border: Border.all(
          color: const Color(0xFFE2E8F0), // HTML: border-slate-200
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000), // HTML: shadow-sm
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          WidgetCardHeader(
            icon: Icons.handshake,
            title: 'Loans',
            subtitle: '$activeLoansCount active',
            onTap: onHeaderTap,
            iconColor: const Color(0xFFEA580C), // HTML: text-orange-600
            iconBackgroundColor: const Color(0xFFFED7AA), // HTML: bg-orange-100
          ),
          
          // Content
          Container(
            padding: const EdgeInsets.all(16), // HTML: p-4
            child: Column(
              children: [
                // Statistics grid
                Row(
                  children: [
                    // You Lent
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            '\$${_formatAmount(youLent)}',
                            style: const TextStyle(
                              fontSize: 18, // HTML: text-lg
                              fontWeight: FontWeight.bold, // HTML: font-bold
                              color: Color(0xFFEA580C), // HTML: text-orange-600
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'You Lent',
                            style: const TextStyle(
                              fontSize: 12, // HTML: text-xs
                              color: Color(0xFF64748B), // HTML: text-slate-500
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // You Borrowed
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            '\$${_formatAmount(youBorrowed)}',
                            style: const TextStyle(
                              fontSize: 18, // HTML: text-lg
                              fontWeight: FontWeight.bold, // HTML: font-bold
                              color: Color(0xFF7C3AED), // HTML: text-purple-600
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'You Borrowed',
                            style: const TextStyle(
                              fontSize: 12, // HTML: text-xs
                              color: Color(0xFF64748B), // HTML: text-slate-500
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16), // HTML: mb-4
                
                // Net Position card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12), // HTML: p-3
                  decoration: BoxDecoration(
                    color: isPositive 
                        ? const Color(0xFFF0FDF4) // HTML: bg-green-50
                        : const Color(0xFFFEF2F2), // bg-red-50
                    borderRadius: BorderRadius.circular(8), // HTML: rounded-lg
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Net Position: ${isPositive ? '+' : ''}\$${_formatAmount(netPosition.abs())}',
                        style: TextStyle(
                          fontSize: 14, // HTML: text-sm
                          fontWeight: FontWeight.w500, // HTML: font-medium
                          color: isPositive 
                              ? const Color(0xFF16A34A) // HTML: text-green-600
                              : const Color(0xFFDC2626), // text-red-600
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        isPositive ? 'You are owed' : 'You owe',
                        style: const TextStyle(
                          fontSize: 12, // HTML: text-xs
                          color: Color(0xFF64748B), // HTML: text-slate-500
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Formatea montos con comas
  String _formatAmount(double amount) {
    return amount.toStringAsFixed(2).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }
}
