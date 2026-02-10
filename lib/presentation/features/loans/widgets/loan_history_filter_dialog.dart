import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/loan_history_filter_model.dart';
import '../../../core/atoms/app_button.dart';
import '../../../core/l10n/generated/strings.g.dart';

class LoanHistoryFilterDialog extends StatefulWidget {
  final LoanHistoryFilterModel initialFilter;

  const LoanHistoryFilterDialog({Key? key, required this.initialFilter}) : super(key: key);

  @override
  _LoanHistoryFilterDialogState createState() => _LoanHistoryFilterDialogState();
}

class _LoanHistoryFilterDialogState extends State<LoanHistoryFilterDialog> {
  late LoanHistoryFilterModel _filter;
  final _minAmountController = TextEditingController();
  final _maxAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filter = widget.initialFilter;
    _minAmountController.text = _filter.minAmount?.toString() ?? '';
    _maxAmountController.text = _filter.maxAmount?.toString() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t.loans.history.filter.title),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _filter = LoanHistoryFilterModel.initial();
                _minAmountController.clear();
                _maxAmountController.clear();
              });
            },
            child: Text(t.loans.history.filter.reset),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildDateFilterSection(),
          const SizedBox(height: 24),
          _buildAmountFilterSection(),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AppButton(
          text: t.loans.history.filter.apply,
          onPressed: () {
            final minAmount = double.tryParse(_minAmountController.text);
            final maxAmount = double.tryParse(_maxAmountController.text);
            Navigator.of(context).pop(_filter.copyWith(
              minAmount: minAmount,
              maxAmount: maxAmount,
            ));
          },
        ),
      ),
    );
  }

  Widget _buildDateFilterSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(t.loans.history.filter.dateRange, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          children: QuickDateFilter.values.map((filter) {
            return ChoiceChip(
              label: Text(filter.displayName),
              selected: _filter.quickDateFilter == filter,
              onSelected: (selected) {
                if (selected) {
                  _onQuickDateFilterChanged(filter);
                }
              },
            );
          }).toList(),
        ),
        if (_filter.quickDateFilter == QuickDateFilter.custom)
          _buildCustomDateRangePicker(),
      ],
    );
  }

  void _onQuickDateFilterChanged(QuickDateFilter filter) {
    final now = DateTime.now();
    DateTime? startDate, endDate;

    switch (filter) {
      case QuickDateFilter.thisMonth:
        startDate = DateTime(now.year, now.month, 1);
        endDate = DateTime(now.year, now.month + 1, 0);
        break;
      case QuickDateFilter.lastMonth:
        startDate = DateTime(now.year, now.month - 1, 1);
        endDate = DateTime(now.year, now.month, 0);
        break;
      case QuickDateFilter.thisYear:
        startDate = DateTime(now.year, 1, 1);
        endDate = DateTime(now.year, 12, 31);
        break;
      case QuickDateFilter.allTime:
        startDate = null;
        endDate = null;
        break;
      case QuickDateFilter.custom:
        // Keep existing custom dates or set to null
        startDate = _filter.startDate;
        endDate = _filter.endDate;
        break;
    }

    setState(() {
      _filter = _filter.copyWith(
        quickDateFilter: filter,
        startDate: startDate,
        endDate: endDate,
        forceDateNull: filter == QuickDateFilter.allTime,
      );
    });
  }

  Widget _buildCustomDateRangePicker() {
    final formatter = DateFormat.yMd();
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _filter.startDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (picked != null) {
                  setState(() {
                    _filter = _filter.copyWith(startDate: picked);
                  });
                }
              },
              child: InputDecorator(
                decoration: InputDecoration(labelText: t.loans.history.filter.startDate),
                child: Text(_filter.startDate != null ? formatter.format(_filter.startDate!) : t.loans.history.filter.select),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: InkWell(
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _filter.endDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (picked != null) {
                  setState(() {
                    _filter = _filter.copyWith(endDate: picked);
                  });
                }
              },
              child: InputDecorator(
                decoration: InputDecoration(labelText: t.loans.history.filter.endDate),
                child: Text(_filter.endDate != null ? formatter.format(_filter.endDate!) : t.loans.history.filter.select),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountFilterSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(t.loans.history.filter.amountRange, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _minAmountController,
                decoration: const InputDecoration(labelText: 'Min Amount', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                controller: _maxAmountController,
                decoration: const InputDecoration(labelText: 'Max Amount', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
