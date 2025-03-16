import 'package:flutter/material.dart';
import '../../domain/entities/transaction.dart';
import '../molecules/transaction_list_item.dart';

/// Componente que muestra una sección de transacciones agrupadas
/// por una fecha específica u otro criterio de agrupación.
class TransactionListSection extends StatelessWidget {
  /// Título de la sección (por ejemplo, la fecha formateada)
  final String title;
  
  /// Lista de transacciones para esta sección
  final List<TransactionEntity> transactions;
  
  /// Mapa opcional de nombres de categorías
  final Map<int, String>? categoriesMap;
  
  /// Mapa opcional de nombres de contactos
  final Map<int, String>? contactsMap;
  
  /// Función a ejecutar al tocar una transacción
  final Function(TransactionEntity) onTransactionTap;
  
  /// Función a ejecutar al eliminar una transacción
  final Function(TransactionEntity) onTransactionDelete;

  const TransactionListSection({
    Key? key,
    required this.title,
    required this.transactions,
    this.categoriesMap,
    this.contactsMap,
    required this.onTransactionTap,
    required this.onTransactionDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            title,
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.primary,
            ),
          ),
        ),
        ...transactions.map((transaction) => Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: TransactionListItem(
            transaction: transaction,
            categoryName: transaction.categoryId != null && categoriesMap != null
                ? categoriesMap![transaction.categoryId]
                : null,
            contactName: transaction.contactId != null && contactsMap != null
                ? contactsMap![transaction.contactId]
                : null,
            onTap: () => onTransactionTap(transaction),
            onDelete: () => onTransactionDelete(transaction),
          ),
        )),
      ],
    );
  }
}

class TransactionData {
  final String title;
  final String date;
  final double amount;
  final IconData icon;
  final Color iconBackgroundColor;
  
  const TransactionData({
    required this.title,
    required this.date,
    required this.amount,
    required this.icon,
    required this.iconBackgroundColor,
  });
}
