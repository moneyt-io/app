import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../domain/entities/loan_contact_summary.dart';
import '../../../core/atoms/app_avatar.dart';

class LoanContactCard extends StatelessWidget {
  final LoanContactSummary summary;
  final String currencySymbol;
  final VoidCallback onTap;
  final bool isHistoryView;

  const LoanContactCard({
    Key? key,
    required this.summary,
    this.currencySymbol = '\$',
    required this.onTap,
    this.isHistoryView = false,
  }) : super(key: key);

  double get netBalance => summary.netBalance;
  bool get isLent => netBalance > 0;

  @override
  Widget build(BuildContext context) {
    // Colors matching the mockup exactly
    final Color amountColor =
        isLent ? const Color(0xFFEA580C) : const Color(0xFF9333EA);
    final Color chipBgColor =
        isLent ? const Color(0xFFFED7AA) : const Color(0xFFE9D5FF);
    final Color chipFgColor =
        isLent ? const Color(0xFFC2410C) : const Color(0xFF7C3AED);
    final String chipLabel = isLent ? 'You lent' : 'You borrowed';

    return Container(
      margin:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 6), // mx-4 mb-3
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8), // rounded-lg
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
        border: Border.all(
            color: const Color(0xFFE2E8F0), width: 1), // border-slate-200
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          hoverColor: const Color(0xFFF8FAFC), // hover:bg-slate-50
          child: Padding(
            padding: const EdgeInsets.all(16), // px-4 py-4
            child: Row(
              children: [
                // Avatar - 48x48 (h-12 w-12)
                AppAvatar(
                  name: summary.contact.name,
                  imageUrl: null,
                  size: AppAvatarSize.large, // 48x48
                ),
                const SizedBox(width: 12), // mr-3

                // Content area - flex-grow
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top row: Name and Amount + Status
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Contact name
                          Expanded(
                            child: Text(
                              summary.contact.name,
                              style: const TextStyle(
                                color: Color(0xFF1E293B), // text-slate-800
                                fontSize: 16, // text-base
                                fontWeight: FontWeight.w600, // font-semibold
                                height: 1.25,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          // Amount and status chip
                          if (!isHistoryView)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '$currencySymbol${NumberFormat('#,##0.00').format(netBalance.abs())}',
                                  style: TextStyle(
                                    color: amountColor,
                                    fontSize: 18, // text-lg
                                    fontWeight: FontWeight.bold, // font-bold
                                    height: 1.25,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4), // px-2 py-1
                                  decoration: BoxDecoration(
                                    color: chipBgColor,
                                    borderRadius: BorderRadius.circular(
                                        12), // rounded-full
                                  ),
                                  child: Text(
                                    chipLabel,
                                    style: TextStyle(
                                      color: chipFgColor,
                                      fontSize: 12, // text-xs
                                      fontWeight:
                                          FontWeight.w500, // font-medium
                                      height: 1.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),

                      const SizedBox(height: 4), // mb-1 spacing

                      // Bottom row: Loan count and Due date
                      if (isHistoryView)
                        Text(
                          '${summary.totalLoanCount ?? 0} transacciones realizadas',
                          style: const TextStyle(
                            color: Color(0xFF64748B), // text-slate-500
                            fontSize: 14, // text-sm
                            height: 1.25,
                          ),
                        )
                      else
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${summary.activeLoanCount} active loan${summary.activeLoanCount == 1 ? '' : 's'}',
                              style: const TextStyle(
                                color: Color(0xFF64748B), // text-slate-500
                                fontSize: 14, // text-sm
                                height: 1.25,
                              ),
                            ),
                            _buildDueDateStatus(context),
                          ],
                        ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                // Chevron icon - w-6 justify-center
                SizedBox(
                  width: 24,
                  child: Icon(
                    Icons.chevron_right,
                    color: const Color(0xFF94A3B8), // text-slate-400
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDueDateStatus(BuildContext context) {
    if (summary.isOverdue) {
      return Text(
        'Overdue ${summary.overdueDays} days',
        style: const TextStyle(
          color: Color(0xFFEF4444), // text-red-500
          fontSize: 12, // text-xs
          fontWeight: FontWeight.w500, // font-medium
          height: 1.25,
        ),
      );
    }

    if (summary.nextDueDate != null) {
      return Text(
        'Due: ${DateFormat('MMM dd, yyyy').format(summary.nextDueDate!)}',
        style: const TextStyle(
          color: Color(0xFF94A3B8), // text-slate-400
          fontSize: 12, // text-xs
          height: 1.25,
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
