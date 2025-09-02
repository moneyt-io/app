import 'package:flutter/material.dart';

import '../../../../domain/entities/loan_contact_summary.dart';
import '../../../core/design_system/tokens/app_dimensions.dart';
import '../../../core/design_system/tokens/app_colors.dart';
import 'loan_contact_card.dart';

class ActiveLoansSection extends StatelessWidget {
  final List<LoanContactSummary> contactSummaries;
  final int totalPendingLoans;
  final Function(LoanContactSummary)? onContactTap;

  const ActiveLoansSection({
    Key? key,
    required this.contactSummaries,
    required this.totalPendingLoans,
    this.onContactTap,
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
                'Active Loans',
                style: textTheme.titleMedium?.copyWith(
                  color: AppColors.slate800,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '$totalPendingLoans pending',
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
        )),
      ],
    );
  }
}
