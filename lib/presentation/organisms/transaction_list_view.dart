import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/transaction_entry.dart';
import '../../core/presentation/app_dimensions.dart';
import '../molecules/confirm_delete_dialog.dart';
import '../molecules/transaction_list_item.dart';

class TransactionListView extends StatefulWidget {
  final List<TransactionEntry> transactions;
  final Map<int, String>? categoriesMap;
  final Map<int, String>? contactsMap;
  final Function(TransactionEntry) onTransactionTap;
  final Function(TransactionEntry) onTransactionDelete;
  final Function(TransactionEntry)? onTransactionEdit;

  const TransactionListView({
    Key? key,
    required this.transactions,
    this.categoriesMap,
    this.contactsMap,
    required this.onTransactionTap,
    required this.onTransactionDelete,
    this.onTransactionEdit,
  }) : super(key: key);

  @override
  State<TransactionListView> createState() => _TransactionListViewState();
}

class _TransactionListViewState extends State<TransactionListView> {
  Future<void> _confirmDeleteTransaction(BuildContext context, TransactionEntry transaction) async {
    final result = await ConfirmDeleteDialog.show(
      context: context,
      title: 'Eliminar transacción',
      message: '¿Estás seguro de que deseas eliminar',
      itemName: transaction.description ?? 'esta transacción',
      icon: Icons.receipt_long_outlined,
      isDestructive: true,
    );
    
    // Si el usuario confirmó, eliminar la transacción
    if (result == true) {
      widget.onTransactionDelete(transaction);
    }
  }

  // Agrupar transacciones por fecha
  Map<String, List<TransactionEntry>> _groupTransactionsByDate() {
    final Map<String, List<TransactionEntry>> groupedTransactions = {};
    
    for (final transaction in widget.transactions) {
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
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.spacing16,
        vertical: AppDimensions.spacing4,
      ),
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
              padding: const EdgeInsets.symmetric(
                vertical: AppDimensions.spacing8, 
                horizontal: AppDimensions.spacing4
              ),
              child: Text(
                displayDate,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            ...transactionsForDate.map((transaction) => TransactionListItem(
              transaction: transaction,
              categoryName: transaction.mainCategoryId != null && widget.categoriesMap != null
                  ? widget.categoriesMap![transaction.mainCategoryId]
                  : null,
              contactName: transaction.contactId != null && widget.contactsMap != null
                  ? widget.contactsMap![transaction.contactId]
                  : null,
              onTap: () => widget.onTransactionTap(transaction),
              onDelete: () => _confirmDeleteTransaction(context, transaction),
              onEdit: widget.onTransactionEdit != null 
                  ? () => widget.onTransactionEdit!(transaction)
                  : null,
            )),
          ],
        );
      },
    );
  }
}
