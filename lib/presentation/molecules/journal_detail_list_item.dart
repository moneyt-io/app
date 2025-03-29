import 'package:flutter/material.dart';
import '../../domain/entities/journal_detail.dart';
import '../../domain/entities/chart_account.dart';

class JournalDetailListItem extends StatelessWidget {
  final JournalDetail detail;
  final ChartAccount? account;
  
  const JournalDetailListItem({
    Key? key,
    required this.detail,
    this.account,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    
    final accountName = account != null 
      ? '${account!.code} - ${account!.name}'
      : 'Cuenta #${detail.chartAccountId}';
    
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    accountName,
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Moneda: ${detail.currencyId} (TC: ${detail.rateExchange.toStringAsFixed(4)})',
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: detail.debit > 0 
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'DEBE',
                        style: textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        detail.debit.toStringAsFixed(2),
                        style: textTheme.bodyMedium?.copyWith(
                          color: Colors.blue[800],
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
            ),
            Expanded(
              flex: 2,
              child: detail.credit > 0 
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'HABER',
                        style: textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        detail.credit.toStringAsFixed(2),
                        style: textTheme.bodyMedium?.copyWith(
                          color: Colors.green[800],
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
