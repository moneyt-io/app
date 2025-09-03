import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/design_system/tokens/app_dimensions.dart';
import '../../../core/design_system/tokens/app_colors.dart';

class LoanSummaryCards extends StatelessWidget {
  final double? totalLent;
  final double? totalBorrowed;
  final int? lentToPeople;
  final int? borrowedFromPeople;
  final String currencySymbol;
  final bool isLoading;

  const LoanSummaryCards({
    Key? key,
    this.totalLent,
    this.totalBorrowed,
    this.lentToPeople,
    this.borrowedFromPeople,
    this.currencySymbol = '\$',
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      if (totalLent != null && totalBorrowed != null) {
        return const Row(
          children: [
            Expanded(child: ShimmerLoanSummaryCard()),
            SizedBox(width: 16),
            Expanded(child: ShimmerLoanSummaryCard()),
          ],
        );
      }
      return const ShimmerLoanSummaryCard();
    }

    final lentCard = totalLent != null
        ? _LoanSummaryCard(
            title: 'You Lent',
            amount: totalLent!,
            peopleCount: lentToPeople ?? 0,
            icon: Icons.call_made,
            backgroundColor: const Color(0xFFF97316), // Orange
            currencySymbol: currencySymbol,
          )
        : null;

    final borrowedCard = totalBorrowed != null
        ? _LoanSummaryCard(
            title: 'You Borrowed',
            amount: totalBorrowed!,
            peopleCount: borrowedFromPeople ?? 0,
            icon: Icons.call_received,
            backgroundColor: const Color(0xFF8B5CF6), // Violet
            currencySymbol: currencySymbol,
          )
        : null;

    if (lentCard != null && borrowedCard != null) {
      return Row(
        children: [
          Expanded(child: lentCard),
          const SizedBox(width: 16),
          Expanded(child: borrowedCard),
        ],
      );
    } else if (lentCard != null) {
      return lentCard;
    } else if (borrowedCard != null) {
      return borrowedCard;
    } else {
      return const SizedBox.shrink();
    }
  }
}

class _LoanSummaryCard extends StatelessWidget {
  final String title;
  final double amount;
  final int peopleCount;
  final IconData icon;
  final Color backgroundColor;
  final String currencySymbol;

  const _LoanSummaryCard({
    required this.title,
    required this.amount,
    required this.peopleCount,
    required this.icon,
    required this.backgroundColor,
    required this.currencySymbol,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(AppDimensions.spacing16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 18,
              ),
              const SizedBox(width: AppDimensions.spacing8),
              Text(
                title,
                style: textTheme.bodySmall?.copyWith(
                  color: Colors.white.withOpacity(0.9),
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spacing4),
          Text(
            '$currencySymbol${NumberFormat('#,##0.00').format(amount)}',
            style: textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: AppDimensions.spacing2),
          Text(
            '$peopleCount ${peopleCount == 1 ? 'person' : 'people'}',
            style: textTheme.bodySmall?.copyWith(
              color: Colors.white.withOpacity(0.8),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class ShimmerLoanSummaryCard extends StatelessWidget {
  const ShimmerLoanSummaryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 106, // Adjust height to match _LoanSummaryCard
      decoration: BoxDecoration(
        color: AppColors.slate200,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
      ),
    );
  }
}
