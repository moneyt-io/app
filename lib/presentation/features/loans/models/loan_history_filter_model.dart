import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/molecules/active_filters_bar.dart';

enum QuickDateFilter {
  thisMonth,
  lastMonth,
  thisYear,
  allTime,
  custom,
}

extension QuickDateFilterExtension on QuickDateFilter {
  String get displayName {
    switch (this) {
      case QuickDateFilter.thisMonth:
        return 'This Month';
      case QuickDateFilter.lastMonth:
        return 'Last Month';
      case QuickDateFilter.thisYear:
        return 'This Year';
      case QuickDateFilter.allTime:
        return 'All Time';
      case QuickDateFilter.custom:
        return 'Custom Range';
    }
  }
}

class LoanHistoryFilterModel extends Equatable {
  final QuickDateFilter quickDateFilter;
  final DateTime? startDate;
  final DateTime? endDate;
  final double? minAmount;
  final double? maxAmount;

  const LoanHistoryFilterModel({
    this.quickDateFilter = QuickDateFilter.allTime,
    this.startDate,
    this.endDate,
    this.minAmount,
    this.maxAmount,
  });

  factory LoanHistoryFilterModel.initial() {
    return const LoanHistoryFilterModel(
      quickDateFilter: QuickDateFilter.allTime,
    );
  }

  LoanHistoryFilterModel copyWith({
    QuickDateFilter? quickDateFilter,
    DateTime? startDate,
    DateTime? endDate,
    double? minAmount,
    double? maxAmount,
    bool forceDateNull = false,
    bool forceAmountNull = false,
  }) {
    return LoanHistoryFilterModel(
      quickDateFilter: quickDateFilter ?? this.quickDateFilter,
      startDate: forceDateNull ? null : startDate ?? this.startDate,
      endDate: forceDateNull ? null : endDate ?? this.endDate,
      minAmount: forceAmountNull ? null : minAmount ?? this.minAmount,
      maxAmount: forceAmountNull ? null : maxAmount ?? this.maxAmount,
    );
  }

  List<ActiveFilter> get activeFilters {
    final filters = <ActiveFilter>[];
    final formatter = DateFormat.yMd();

    if (startDate != null && endDate != null) {
      String label;
      if (quickDateFilter != QuickDateFilter.custom) {
        label = quickDateFilter.displayName;
      } else {
        label = '${formatter.format(startDate!)} - ${formatter.format(endDate!)}';
      }

      filters.add(ActiveFilter(
        key: 'date',
        label: label,
        icon: Icons.calendar_today,
        color: Colors.blue.shade700,
      ));
    }

    if (minAmount != null || maxAmount != null) {
      String label;
      final currencyFormat = NumberFormat.currency(locale: 'es_PE', symbol: 'S/', decimalDigits: 0);
      if (minAmount != null && maxAmount != null) {
        label = '${currencyFormat.format(minAmount)} - ${currencyFormat.format(maxAmount)}';
      } else if (minAmount != null) {
        label = '> ${currencyFormat.format(minAmount)}';
      } else {
        label = '< ${currencyFormat.format(maxAmount)}';
      }
      filters.add(ActiveFilter(
        key: 'amount',
        label: label,
        icon: Icons.attach_money,
        color: Colors.red.shade700,
      ));
    }

    return filters;
  }

  LoanHistoryFilterModel removeFilter(String key) {
    switch (key) {
      case 'date':
        return copyWith(forceDateNull: true, quickDateFilter: QuickDateFilter.allTime);
      case 'amount':
        return copyWith(forceAmountNull: true);
      default:
        return this;
    }
  }

  @override
  List<Object?> get props => [
        quickDateFilter,
        startDate,
        endDate,
        minAmount,
        maxAmount,
      ];
}
