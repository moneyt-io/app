import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/molecules/active_filters_bar.dart';
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

enum LoanType {
  lent,
  borrowed,
}

enum LoanStatus {
  active,
  completed,
  cancelled,
}

class LoanFilterModel extends Equatable {
  final QuickDateFilter quickDateFilter;
  final DateTime? startDate;
  final DateTime? endDate;
  final Contact? contact;
  final Wallet? account;
  final double? minAmount;
  final double? maxAmount;
  final Set<LoanType> loanTypes;
  final Set<LoanStatus> loanStatuses;
  final bool? isOverdue;

  const LoanFilterModel({
    this.quickDateFilter = QuickDateFilter.thisMonth,
    this.startDate,
    this.endDate,
    this.contact,
    this.account,
    this.minAmount,
    this.maxAmount,
    this.loanTypes = const {LoanType.lent, LoanType.borrowed},
    this.loanStatuses = const {LoanStatus.active},
    this.isOverdue,
  });

  factory LoanFilterModel.initial() {
    final now = DateTime.now();
    return LoanFilterModel(
      quickDateFilter: QuickDateFilter.thisMonth,
      startDate: DateTime(now.year, now.month, 1),
      endDate: DateTime(now.year, now.month + 1, 0),
      loanTypes: const {LoanType.lent, LoanType.borrowed},
      loanStatuses: const {LoanStatus.active},
    );
  }

  LoanFilterModel copyWith({
    QuickDateFilter? quickDateFilter,
    DateTime? startDate,
    DateTime? endDate,
    Contact? contact,
    Wallet? account,
    double? minAmount,
    double? maxAmount,
    Set<LoanType>? loanTypes,
    Set<LoanStatus>? loanStatuses,
    bool? isOverdue,
    bool forceContactNull = false,
    bool forceAccountNull = false,
    bool forceDateNull = false,
    bool forceAmountNull = false,
    bool forceOverdueNull = false,
  }) {
    return LoanFilterModel(
      quickDateFilter: quickDateFilter ?? this.quickDateFilter,
      startDate: forceDateNull ? null : startDate ?? this.startDate,
      endDate: forceDateNull ? null : endDate ?? this.endDate,
      contact: forceContactNull ? null : contact ?? this.contact,
      account: forceAccountNull ? null : account ?? this.account,
      minAmount: forceAmountNull ? null : minAmount ?? this.minAmount,
      maxAmount: forceAmountNull ? null : maxAmount ?? this.maxAmount,
      loanTypes: loanTypes ?? this.loanTypes,
      loanStatuses: loanStatuses ?? this.loanStatuses,
      isOverdue: forceOverdueNull ? null : isOverdue ?? this.isOverdue,
    );
  }

  List<ActiveFilter> activeFilters({bool excludeLoanType = false}) {
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

    if (contact != null) {
      filters.add(ActiveFilter(
        key: 'contact',
        label: contact!.name,
        icon: Icons.person,
        color: Colors.purple,
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

    if (isOverdue == true) {
      filters.add(ActiveFilter(
        key: 'overdue',
        label: 'Overdue',
        icon: Icons.warning,
        color: Colors.red,
      ));
    }

    if (!excludeLoanType && loanTypes.length < 2) {
      filters.add(ActiveFilter(
        key: 'type',
        label: loanTypes.map((t) => t.name).join(', '),
        icon: Icons.account_balance,
        color: Colors.teal,
      ));
    }

    if (loanStatuses.length < 3) {
      filters.add(ActiveFilter(
        key: 'status',
        label: loanStatuses.map((s) => s.name).join(', '),
        icon: Icons.check_circle,
        color: Colors.orange,
      ));
    }

    return filters;
  }

  LoanFilterModel copyWithLoanTypes(Set<LoanType> loanTypes) {
    return LoanFilterModel(
      loanTypes: loanTypes,
      startDate: startDate,
      endDate: endDate,
      contact: contact,
      account: account,
      minAmount: minAmount,
      maxAmount: maxAmount,
      loanStatuses: loanStatuses,
      isOverdue: isOverdue,
    );
  }

  LoanFilterModel removeFilter(String key) {
    switch (key) {
      case 'date':
        return copyWith(forceDateNull: true);
      case 'contact':
        return copyWith(forceContactNull: true);
      case 'account':
        return copyWith(forceAccountNull: true);
      case 'amount':
        return copyWith(forceAmountNull: true);
      case 'overdue':
        return copyWith(forceOverdueNull: true);
      case 'type':
        return copyWith(loanTypes: {LoanType.lent, LoanType.borrowed});
      case 'status':
        return copyWith(loanStatuses: {LoanStatus.active});
      default:
        return this;
    }
  }

  @override
  List<Object?> get props => [
        quickDateFilter,
        startDate,
        endDate,
        contact,
        account,
        minAmount,
        maxAmount,
        loanTypes,
        loanStatuses,
        isOverdue,
      ];
}
