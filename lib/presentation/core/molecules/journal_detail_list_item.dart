import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../domain/entities/chart_account.dart';
import '../../../domain/entities/journal_detail.dart';
import '../theme/app_dimensions.dart';

class JournalDetailListItem extends StatelessWidget {
  final JournalDetail detail;
  final ChartAccount? account;

  const JournalDetailListItem({
    Key? key,
    required this.detail,
    required this.account,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    
    final hasDebit = detail.debit > 0;
    final hasCredit = detail.credit > 0;
    
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppDimensions.spacing4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Cuenta contable con sangría si es crédito
          Expanded(
            flex: 6,
            child: Padding(
              padding: EdgeInsets.only(left: hasCredit ? AppDimensions.spacing16 : 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    account?.name ?? 'Cuenta desconocida',
                    style: textTheme.bodyMedium,
                  ),
                  if (account != null)
                    Text(
                      account!.code,
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                ],
              ),
            ),
          ),
          
          // Monto débito
          Expanded(
            flex: 2,
            child: Text(
              hasDebit ? NumberFormat.currency(symbol: '\$').format(detail.debit) : '',
              style: textTheme.bodyMedium,
              textAlign: TextAlign.end,
            ),
          ),
          
          // Monto crédito
          Expanded(
            flex: 2,
            child: Text(
              hasCredit ? NumberFormat.currency(symbol: '\$').format(detail.credit) : '',
              style: textTheme.bodyMedium,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
