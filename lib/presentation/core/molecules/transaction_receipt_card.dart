import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneyt_pfm/domain/entities/category.dart';
import 'package:moneyt_pfm/domain/entities/contact.dart';
import 'package:moneyt_pfm/domain/entities/transaction_entry.dart';
import 'package:moneyt_pfm/domain/entities/wallet.dart';

/// A new, visually rich receipt card that matches the latest design mockup.
class TransactionReceiptCard extends StatelessWidget {
  final TransactionEntry transaction;
  final Category? category;
  final Wallet? wallet;
  final Contact? contact;

  const TransactionReceiptCard({
    Key? key,
    required this.transaction,
    this.category,
    this.wallet,
    this.contact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withOpacity(0.08), // slate-900 with opacity
            blurRadius: 20.0,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            _buildHeader(),
            _buildBody(),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  /// Header with gradient and logo
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF3B82F6), Color(0xFF9333EA)], // blue-500 to purple-600
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Column(
        children: const [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.savings_outlined, color: Colors.white, size: 24),
              SizedBox(width: 8),
              Text(
                'MoneyT',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            'Transaction Receipt',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  /// Body with amount and details
  Widget _buildBody() {
    final amountFormat = NumberFormat.currency(symbol: '\$', decimalDigits: 2);
    String sign = '';
    Color amountColor = const Color(0xFF1E293B); // slate-800
    String typeText = 'Transaction';

    switch (transaction.documentTypeId) {
      case 'I':
        sign = '+';
        amountColor = const Color(0xFF16A34A); // green-600
        typeText = 'Income Transaction';
        break;
      case 'E':
        sign = '-';
        typeText = 'Expense Transaction';
        break;
      case 'T':
        typeText = 'Transfer';
        break;
    }

    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Text(
            '$sign${amountFormat.format(transaction.amount)}',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: amountColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            typeText,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF64748B), // slate-500
            ),
          ),
          const SizedBox(height: 24),
          if (transaction.description?.isNotEmpty ?? false)
            _buildInfoRow('Description', transaction.description!),
          if (category != null)
            _buildInfoRow(
              'Category',
              category!.name,
              leading: const Icon(Icons.fastfood_outlined, size: 16, color: Color(0xFFF59E0B)), // amber-500
            ),
          _buildInfoRow(
            'Date',
            DateFormat('MMM d, yyyy').format(transaction.date),
          ),
          _buildInfoRow(
            'Time',
            DateFormat('h:mm a').format(transaction.date),
          ),
          if (wallet != null)
            _buildInfoRow(
              'Payment Method',
              wallet!.name,
              leading: const Icon(Icons.account_balance_wallet_outlined, size: 16, color: Color(0xFF3B82F6)), // blue-500
            ),
          if (contact != null)
            _buildInfoRow('Contact', contact!.name),
        ],
      ),
    );
  }

  /// Footer with metadata and branding
  Widget _buildFooter() {
    return Column(
      children: [
        const Divider(height: 1, color: Color(0xFFF1F5F9)), // slate-100
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                'Transaction ID: TXN-${transaction.id.toString().padLeft(8, '0')}',
                style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8)), // slate-400
              ),
              const SizedBox(height: 4),
              Text(
                'Generated on ${DateFormat('MMM d, yyyy \'at\' h:mm a').format(DateTime.now())}',
                 style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8)), // slate-400
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12),
          color: const Color(0xFFF8FAFC), // slate-50
          child: const Text(
            'Powered by MoneyT • moneyt.app',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF94A3B8), // slate-400
            ),
          ),
        ),
      ],
    );
  }

  /// Reusable row for details
  Widget _buildInfoRow(String label, String value, {Widget? leading}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Color(0xFF64748B), fontSize: 14), // slate-500
          ),
          Row(
            children: [
              if (leading != null) ...[
                leading,
                const SizedBox(width: 8),
              ],
              Text(
                value,
                style: const TextStyle(
                  color: Color(0xFF1E293B), // slate-800
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
