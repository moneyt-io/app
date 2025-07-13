import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../domain/entities/transaction_entry.dart';
import '../design_system/theme/app_dimensions.dart';
import '../molecules/transaction_list_item.dart';

class TransactionListView extends StatelessWidget {
  final List<TransactionEntry> transactions;
  final Map<int, String>? categoriesMap;
  final Map<int, String>? contactsMap;
  final Function(TransactionEntry) onTransactionTap;

  const TransactionListView({
    Key? key,
    required this.transactions,
    this.categoriesMap,
    this.contactsMap,
    required this.onTransactionTap,
  }) : super(key: key);

  // Agrupar transacciones por fecha
  Map<String, List<TransactionEntry>> _groupTransactionsByDate() {
    final Map<String, List<TransactionEntry>> groupedTransactions = {};
    
    for (final transaction in transactions) {
      final dateKey = DateFormat('yyyy-MM-dd').format(transaction.date);
      
      if (!groupedTransactions.containsKey(dateKey)) {
        groupedTransactions[dateKey] = [];
      }
      
      groupedTransactions[dateKey]!.add(transaction);
    }
    
    return groupedTransactions;
  }

  @override
  Widget build(BuildContext context) {
    final groupedTransactions = _groupTransactionsByDate();
    final dateKeys = groupedTransactions.keys.toList()
      ..sort((a, b) => b.compareTo(a)); // Ordenar por fecha descendente

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 80), // Space for FAB
      itemCount: dateKeys.length,
      itemBuilder: (context, index) {
        final dateKey = dateKeys[index];
        final transactionsForDate = groupedTransactions[dateKey]!;
        final displayDate = DateFormat('EEEE, d MMMM yyyy', 'es_ES')
          .format(DateTime.parse(dateKey));
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    displayDate,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Text(
                    '${transactionsForDate.length} transactions',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
            ...transactionsForDate.map((transaction) => TransactionListItem(
                  transaction: transaction,
                  categoryName: transaction.mainCategoryId != null && categoriesMap != null
                      ? categoriesMap![transaction.mainCategoryId]
                      : null,
                  contactName: transaction.contactId != null && contactsMap != null
                      ? contactsMap![transaction.contactId]
                      : null,
                  accountName: "Chase Checking", // Mock data
                  targetAccountName: "Emergency Fund", // Mock data
                  onTap: () => onTransactionTap(transaction),
                )),
          ],
        );
      },
    );
  }
}
     