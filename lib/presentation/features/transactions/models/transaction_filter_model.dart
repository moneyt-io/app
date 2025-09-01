import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/molecules/active_filters_bar.dart';

import '../../../../domain/entities/category.dart';
import '../../../../domain/entities/contact.dart';
import '../../../../domain/entities/wallet.dart';

enum QuickDateFilter {
  thisMonth,
  lastMonth,
  thisYear,
  lastYear,
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
      case QuickDateFilter.lastYear:
        return 'Last Year';
      case QuickDateFilter.custom:
        return 'Custom';
    }
  }
}

enum TransactionType {
  income,
  expense,
  transfer,
}

class TransactionFilterModel extends Equatable {
  final QuickDateFilter quickDateFilter;
  final DateTime? startDate;
  final DateTime? endDate;
  final Category? category;
  final Wallet? account;
  final Contact? contact;
  final double? minAmount;
  final double? maxAmount;
  final Set<TransactionType> transactionTypes;

  const TransactionFilterModel({
    this.quickDateFilter = QuickDateFilter.thisMonth,
    this.startDate,
    this.endDate,
    this.category,
    this.account,
    this.contact,
    this.minAmount,
    this.maxAmount,
    this.transactionTypes = const {
      TransactionType.income,
      TransactionType.expense,
      TransactionType.transfer,
    },
  });

  factory TransactionFilterModel.initial() {
    final now = DateTime.now();
    return TransactionFilterModel(
      quickDateFilter: QuickDateFilter.thisMonth,
      startDate: DateTime(now.year, now.month, 1),
      endDate: DateTime(now.year, now.month + 1, 0),
    );
  }

  TransactionFilterModel copyWith({
    QuickDateFilter? quickDateFilter,
    DateTime? startDate,
    DateTime? endDate,
    Category? category,
    Wallet? account,
    Contact? contact,
    double? minAmount,
    double? maxAmount,
    Set<TransactionType>? transactionTypes,
    bool forceCategoryNull = false,
    bool forceAccountNull = false,
    bool forceContactNull = false,
    bool forceDateNull = false,
    bool forceAmountNull = false,
  }) {
    return TransactionFilterModel(
      quickDateFilter: quickDateFilter ?? this.quickDateFilter,
      startDate: forceDateNull ? null : startDate ?? this.startDate,
      endDate: forceDateNull ? null : endDate ?? this.endDate,
      category: forceCategoryNull ? null : category ?? this.category,
      account: forceAccountNull ? null : account ?? this.account,
      contact: forceContactNull ? null : contact ?? this.contact,
      minAmount: forceAmountNull ? null : minAmount ?? this.minAmount,
      maxAmount: forceAmountNull ? null : maxAmount ?? this.maxAmount,
      transactionTypes: transactionTypes ?? this.transactionTypes,
    );
  }

  List<ActiveFilter> activeFilters({bool excludeTransactionType = false}) {
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
        color: Colors.blue,
      ));
    }

    if (category != null) {
      filters.add(ActiveFilter(
        key: 'category',
        label: category!.name,
        icon: Icons.category,
        color: Colors.orange,
      ));
    }

    if (account != null) {
      filters.add(ActiveFilter(
        key: 'account',
        label: account!.name,
        icon: Icons.account_balance_wallet,
        color: Colors.green,
      ));
    }

    if (contact != null) {
      filters.add(ActiveFilter(
        key: 'contact',
        label: contact!.name,
        icon: Icons.person,
        color: Colors.purple,
      ));
    }

    if (minAmount != null || maxAmount != null) {
      if (minAmount != null && maxAmount != null) {
        filters.add(ActiveFilter(
          key: 'amount',
          label: '\$${minAmount!} - \$${maxAmount!}',
          icon: Icons.attach_money,
          color: Colors.red,
        ));
      } else if (minAmount != null) {
        filters.add(ActiveFilter(
          key: 'amount',
          label: '> \$${minAmount!}',
          icon: Icons.attach_money,
          color: Colors.red,
        ));
      } else {
        filters.add(ActiveFilter(
          key: 'amount',
          label: '< \$${maxAmount!}',
          icon: Icons.attach_money,
          color: Colors.red,
        ));
      }
    }

    if (!excludeTransactionType && transactionTypes.length < 3) {
      filters.add(ActiveFilter(
        key: 'type',
        label: transactionTypes.map((t) => t.name).join(', '),
        icon: Icons.swap_horiz,
        color: Colors.teal,
      ));
    }

    return filters;
  }

  TransactionFilterModel copyWithTransactionTypes(
      Set<TransactionType> transactionTypes) {
    return TransactionFilterModel(
      transactionTypes: transactionTypes,
      startDate: startDate,
      endDate: endDate,
      category: category,
      account: account,
      contact: contact,
      minAmount: minAmount,
      maxAmount: maxAmount,
    );
  }

  TransactionFilterModel removeFilter(String key) {
    switch (key) {
      case 'date':
        return copyWith(forceDateNull: true);
      case 'category':
        return copyWith(forceCategoryNull: true);
      case 'account':
        return copyWith(forceAccountNull: true);
      case 'contact':
        return copyWith(forceContactNull: true);
      case 'amount':
        return copyWith(forceAmountNull: true);
      case 'type':
        return copyWith(transactionTypes: {
          TransactionType.income,
          TransactionType.expense,
          TransactionType.transfer,
        });
      default:
        return this;
    }
  }

  @override
  List<Object?> get props => [
        quickDateFilter,
        startDate,
        endDate,
        category,
        account,
        contact,
        minAmount,
        maxAmount,
        transactionTypes,
      ];
}
