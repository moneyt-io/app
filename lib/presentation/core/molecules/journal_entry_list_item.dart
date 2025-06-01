import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../domain/entities/journal_entry.dart';

class JournalEntryListItem extends StatelessWidget {
  final JournalEntry journal;
  final VoidCallback onTap;
  
  const JournalEntryListItem({
    Key? key,
    required this.journal,
    required this.onTap,
  }) : super(key: key);

  String _getDocumentTypeLabel() {
    switch (journal.documentTypeId) {
      case 'I': return 'Ingreso';
      case 'E': return 'Gasto';
      case 'T': return 'Transferencia';
      case 'L': return 'Préstamo Otorgado';
      case 'B': return 'Préstamo Recibido';
      default: return 'Otro';
    }
  }

  Color _getDocumentTypeColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    switch (journal.documentTypeId) {
      case 'I': return Colors.green;
      case 'E': return Colors.red;
      case 'T': return Colors.blue;
      case 'L': return Colors.orange;
      case 'B': return Colors.purple;
      default: return colorScheme.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8, 
                          vertical: 4
                        ),
                        decoration: BoxDecoration(
                          color: _getDocumentTypeColor(context).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _getDocumentTypeLabel(),
                          style: textTheme.bodySmall?.copyWith(
                            color: _getDocumentTypeColor(context),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'N° ${journal.secuencial}',
                        style: textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    DateFormat('dd/MM/yyyy').format(journal.date),
                    style: textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                journal.description ?? 'Sin descripción',
                style: textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    journal.isBalanced ? 'Balanceado' : 'Desbalanceado',
                    style: TextStyle(
                      color: journal.isBalanced 
                          ? Colors.green 
                          : Colors.red,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    DateFormat('dd/MM/yyyy HH:mm').format(journal.createdAt),
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
