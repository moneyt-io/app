import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../domain/entities/contact.dart';
import '../../../core/atoms/app_avatar.dart';

class ContactSummaryCard extends StatelessWidget {
  final Contact contact;
  final double netBalance;
  final int activeLoansCount;
  final int lentCount;
  final int borrowedCount;
  final String currencySymbol;

  const ContactSummaryCard({
    Key? key,
    required this.contact,
    required this.netBalance,
    required this.activeLoansCount,
    required this.lentCount,
    required this.borrowedCount,
    this.currencySymbol = '\$',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isOwed = netBalance > 0;
    final balanceText = isOwed ? 'You are owed' : 'You owe';
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF475569), // from-slate-600
            Color(0xFF374151), // to-slate-700
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Contact Info Row
            Row(
              children: [
                // Avatar
                AppAvatar(
                  name: contact.name,
                  size: AppAvatarSize.large,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  textColor: Colors.white,
                ),
                const SizedBox(width: 12),
                
                // Contact Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        contact.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      if (contact.phone != null && contact.phone!.isNotEmpty)
                        Text(
                          contact.phone!,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFFCBD5E1), // text-slate-200
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Statistics Grid
            Row(
              children: [
                // Net Balance
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'NET BALANCE',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFCBD5E1), // text-slate-200
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${isOwed ? '+' : '-'}$currencySymbol${NumberFormat('#,##0.00').format(netBalance.abs())}',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: isOwed 
                              ? const Color(0xFFFDBA74) // text-orange-300
                              : const Color(0xFFC084FC), // text-purple-300
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        balanceText,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFFD1D5DB), // text-slate-300
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Active Loans
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'ACTIVE LOANS',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFCBD5E1), // text-slate-200
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        activeLoansCount.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _buildLoansBreakdown(),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFFD1D5DB), // text-slate-300
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _buildLoansBreakdown() {
    if (lentCount == 0 && borrowedCount == 0) {
      return 'No active loans';
    }
    
    final parts = <String>[];
    if (lentCount > 0) {
      parts.add('$lentCount lent');
    }
    if (borrowedCount > 0) {
      parts.add('$borrowedCount borrowed');
    }
    
    return parts.join(' • ');
  }
}
