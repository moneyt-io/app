import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../domain/entities/transaction_entry.dart';

class TransactionListItem extends StatelessWidget {
  final TransactionEntry transaction;
  final String? categoryName;
  final String? contactName;
  final String? accountName;
  final String? targetAccountName;
  final VoidCallback onTap;

  const TransactionListItem({
    Key? key,
    required this.transaction,
    this.categoryName,
    this.contactName,
    this.accountName,
    this.targetAccountName,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isTransfer = transaction.documentTypeId == 'T';

    final Color iconColor, iconBgColor, amountColor;
    final IconData iconData;
    final String sign;

    switch (transaction.documentTypeId) {
      case 'I':
        iconColor = const Color(0xFF16A34A); // green-600
        iconBgColor = const Color(0xFFDCFCE7); // green-100
        amountColor = const Color(0xFF16A34A); // green-600
        iconData = Icons.trending_up;
        sign = '+';
        break;
      case 'T':
        iconColor = const Color(0xFF2563EB); // blue-600
        iconBgColor = const Color(0xFFDBEAFE); // blue-100
        amountColor = const Color(0xFF2563EB); // blue-600
        iconData = Icons.swap_horiz;
        sign = '';
        break;
      case 'E':
      default:
        iconColor = const Color(0xFFDC2626); // red-600
        iconBgColor = const Color(0xFFFEE2E2); // red-100
        amountColor = const Color(0xFFDC2626); // red-600
        iconData = Icons.trending_down;
        sign = '-';
        break;
    }

    final amountString = sign +
        NumberFormat.currency(locale: 'es_MX', symbol: r'$')
            .format(transaction.amount.abs());

    final title = transaction.description?.isNotEmpty == true
        ? transaction.description!
        : (categoryName ?? 'Transaction');

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF1F5F9)), // slate-100
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              children: [
                // Icon
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(iconData, color: iconColor, size: 28),
                ),
                const SizedBox(width: 12),
                // Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top Row: Description and Amount
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: const TextStyle(
                                color: Color(0xFF1E293B), // slate-800
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            amountString,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: amountColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      // Bottom Row: Category/Account info
                      _buildSubtitle(context, isTransfer),
                      if (contactName != null && contactName!.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        _buildContactRow(context),
                      ]
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubtitle(BuildContext context, bool isTransfer) {
    final subtitleStyle = TextStyle(
      fontSize: 14,
      color: const Color(0xFF64748B), // slate-500
    );

    List<Widget> children = [];

    if (isTransfer) {
      children.add(Icon(Icons.account_balance, size: 16, color: subtitleStyle.color));
      children.add(const SizedBox(width: 4));
      children.add(Expanded(
        child: Text(
          '${accountName ?? 'Origen'} → ${targetAccountName ?? 'Destino'}',
          style: subtitleStyle,
          overflow: TextOverflow.ellipsis,
        ),
      ));
    } else {
      if (categoryName != null) {
        children.add(Icon(Icons.category_outlined, size: 16, color: subtitleStyle.color));
        children.add(const SizedBox(width: 4));
        children.add(Text(categoryName!, style: subtitleStyle));
      }
      if (accountName != null) {
        if (children.isNotEmpty) {
          children.add(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Text('•', style: subtitleStyle),
          ));
        }
        children.add(Icon(Icons.account_balance_wallet_outlined, size: 16, color: subtitleStyle.color));
        children.add(const SizedBox(width: 4));
        children.add(Expanded(
          child: Text(
            accountName!,
            style: subtitleStyle,
            overflow: TextOverflow.ellipsis,
          ),
        ));
      }
    }

    return Row(children: children);
  }

  Widget _buildContactRow(BuildContext context) {
    final subtitleStyle = TextStyle(
      fontSize: 14,
      color: const Color(0xFF64748B), // slate-500
    );

    return Row(
      children: [
        Icon(Icons.person_outline, size: 16, color: subtitleStyle.color),
        const SizedBox(width: 4),
        Text(contactName!, style: subtitleStyle),
        const Spacer(),
        Text(
          DateFormat('h:mm a', 'es_MX').format(transaction.date),
          style: subtitleStyle,
        ),
      ],
    );
  }
}
