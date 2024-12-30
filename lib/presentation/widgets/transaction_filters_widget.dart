// lib/presentation/widgets/transaction_filters_widget.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/l10n/language_manager.dart';
import 'package:intl/intl.dart';

class TransactionFiltersWidget extends StatelessWidget {
  final String selectedType;
  final String selectedDateRange;
  final DateTime? startDate;
  final DateTime? endDate;
  final Function(String) onTypeChanged;
  final Function(String) onDateRangeChanged;
  final Function(DateTime?, DateTime?) onCustomDateRangeChanged;

  const TransactionFiltersWidget({
    Key? key,
    required this.selectedType,
    required this.selectedDateRange,
    required this.startDate,
    required this.endDate,
    required this.onTypeChanged,
    required this.onDateRangeChanged,
    required this.onCustomDateRangeChanged,
  }) : super(key: key);

  String _getDateRangeText(BuildContext context) {
    final translations = context.watch<LanguageManager>().translations;
    if (selectedDateRange == 'custom') {
      if (startDate == null || endDate == null) {
        return translations.custom;
      }
      final dateFormat = DateFormat('dd/MM/yyyy');
      return '${dateFormat.format(startDate!)} - ${dateFormat.format(endDate!)}';
    }
    switch (selectedDateRange) {
      case 'today':
        return translations.today;
      case 'yesterday':
        return translations.yesterday;
      case 'lastWeek':
        return translations.lastWeek;
      case 'lastMonth':
        return translations.lastMonth;
      case 'lastThreeMonths':
        return translations.lastThreeMonths;
      case 'thisYear':
        return translations.thisYear;
      default:
        return translations.custom;
    }
  }

  Future<void> _selectCustomDateRange(BuildContext context) async {
    final initialDateRange = DateTimeRange(
      start: startDate ?? DateTime.now().subtract(const Duration(days: 30)),
      end: endDate ?? DateTime.now(),
    );

    final pickedDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDateRange: initialDateRange,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: Theme.of(context).primaryColor,
              onPrimary: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDateRange != null) {
      onCustomDateRangeChanged(pickedDateRange.start, pickedDateRange.end);
    }
  }

  @override
  Widget build(BuildContext context) {
    final translations = context.watch<LanguageManager>().translations;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          // Filtro de tipo
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.35,
            child: PopupMenuButton<String>(
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'all',
                  child: Text(translations.filterAll),
                ),
                PopupMenuItem(
                  value: 'I',
                  child: Text(translations.filterIncome),
                ),
                PopupMenuItem(
                  value: 'E',
                  child: Text(translations.filterExpense),
                ),
                PopupMenuItem(
                  value: 'T',
                  child: Text(translations.filterTransfer),
                ),
              ],
              onSelected: onTypeChanged,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedType == 'all'
                          ? translations.filterAll
                          : selectedType == 'I'
                              ? translations.filterIncome
                              : selectedType == 'E'
                                  ? translations.filterExpense
                                  : translations.filterTransfer,
                    ),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Filtro de fecha
          Expanded(
            child: PopupMenuButton<String>(
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'today',
                  child: Text(translations.today),
                ),
                PopupMenuItem(
                  value: 'yesterday',
                  child: Text(translations.yesterday),
                ),
                PopupMenuItem(
                  value: 'lastWeek',
                  child: Text(translations.lastWeek),
                ),
                PopupMenuItem(
                  value: 'lastMonth',
                  child: Text(translations.lastMonth),
                ),
                PopupMenuItem(
                  value: 'lastThreeMonths',
                  child: Text(translations.lastThreeMonths),
                ),
                PopupMenuItem(
                  value: 'thisYear',
                  child: Text(translations.thisYear),
                ),
                PopupMenuItem(
                  value: 'custom',
                  child: Text(translations.custom),
                ),
              ],
              onSelected: (range) {
                onDateRangeChanged(range);
                if (range == 'custom') {
                  _selectCustomDateRange(context);
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        _getDateRangeText(context),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
