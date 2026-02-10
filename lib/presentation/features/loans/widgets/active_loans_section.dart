import 'package:flutter/material.dart';

import '../../../../domain/entities/loan_contact_summary.dart';
import '../../../core/design_system/tokens/app_dimensions.dart';
import '../../../core/design_system/tokens/app_colors.dart';
import '../../../core/l10n/generated/strings.g.dart';
import 'loan_contact_card.dart';

class ActiveLoansSection extends StatelessWidget {
  final List<LoanContactSummary> contactSummaries;
  final int totalPendingLoans;
  final Function(LoanContactSummary)? onContactTap;
  final bool isHistoryView;

  const ActiveLoansSection({
    Key? key,
    required this.contactSummaries,
    required this.totalPendingLoans,
    this.onContactTap,
    this.isHistoryView = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.spacing16,
            vertical: AppDimensions.spacing12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isHistoryView ? t.loans.filter.history : t.loans.filter.active,
                style: textTheme.titleMedium?.copyWith(
                  color: AppColors.slate800,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (!isHistoryView)
                Text(
                  t.loans.summary.pending(n: totalPendingLoans),
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.slate500,
                  ),
                ),
            ],
          ),
        ),

        // Contact Cards List
        ...contactSummaries.map((summary) => LoanContactCard(
              summary: summary,
              onTap: () => onContactTap?.call(summary),
              isHistoryView: isHistoryView,
            )),
      ],
    );
  }
}
