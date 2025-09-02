import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/design_system/tokens/app_dimensions.dart';
import '../../../core/design_system/tokens/app_colors.dart';

class LoanSummaryCards extends StatelessWidget {
  final double totalLent;
  final double totalBorrowed;
  final int lentToPeople;
  final int borrowedFromPeople;
  final String currencySymbol;
  final bool isLoading;

  const LoanSummaryCards({
    Key? key,
    required this.totalLent,
    required this.totalBorrowed,
    required this.lentToPeople,
    required this.borrowedFromPeople,
    this.currencySymbol = '\$',
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: AppDimensions.spacing16),
        child: Row(
          children: [
            Expanded(child: _buildLoadingCard()),
            SizedBox(width: AppDimensions.spacing12),
            Expanded(child: _buildLoadingCard()),
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.spacing16),
      child: Row(
        children: [
          Expanded(
            child: _LoanSummaryCard(
              title: 'Lent Out',
              amount: totalLent,
              peopleCount: lentToPeople,
              icon: Icons.call_made,
              backgroundColor: const Color(0xFFF97316), // Orange-500
              currencySymbol: currencySymbol,
            ),
          ),
          SizedBox(width: AppDimensions.spacing12),
          Expanded(
            child: _LoanSummaryCard(
              title: 'Borrowed',
              amount: totalBorrowed,
              peopleCount: borrowedFromPeople,
              icon: Icons.call_received,
              backgroundColor: const Color(0xFF9333EA), // Purple-500
              currencySymbol: currencySymbol,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingCard() {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: AppColors.slate200,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
      ),
      child: const Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
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
      padding: EdgeInsets.all(AppDimensions.spacing16),
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
              SizedBox(width: AppDimensions.spacing8),
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
          SizedBox(height: AppDimensions.spacing4),
          Text(
            '$currencySymbol${NumberFormat('#,##0.00').format(amount)}',
            style: textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(height: AppDimensions.spacing2),
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
