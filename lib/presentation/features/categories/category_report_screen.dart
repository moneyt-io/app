import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/l10n/generated/strings.g.dart';
import '../dashboard/widgets/category_breakdown_widget.dart';
import '../transactions/transaction_provider.dart';

enum TimeFilter { thisMonth, lastMonth, thisYear, allTime, custom }

class CategoryReportScreen extends StatefulWidget {
  const CategoryReportScreen({super.key});

  @override
  State<CategoryReportScreen> createState() => _CategoryReportScreenState();
}

class _CategoryReportScreenState extends State<CategoryReportScreen> {
  TimeFilter _selectedFilter = TimeFilter.thisMonth;
  DateTime? _startDate;
  DateTime? _endDate;
  bool _isExpenseMode = true;
  static const String _prefExpenseModeKey = 'category_breakdown_expense_mode';

  Future<Map<String, dynamic>>? _summaryFuture;
  int _lastTxCount = -1;
  bool _lastMode = false;
  DateTime? _lastStart;
  DateTime? _lastEnd;

  @override
  void initState() {
    super.initState();
    try {
      final prefs = GetIt.instance<SharedPreferences>();
      if (prefs.containsKey(_prefExpenseModeKey)) {
        _isExpenseMode = prefs.getBool(_prefExpenseModeKey) ?? true;
      }
    } catch (_) {}
    _updateDateRange();
  }

  void _updateDateRange() {
    final now = DateTime.now();
    switch (_selectedFilter) {
      case TimeFilter.thisMonth:
        _startDate = DateTime(now.year, now.month, 1);
        _endDate = DateTime(now.year, now.month + 1, 0, 23, 59, 59);
        break;
      case TimeFilter.lastMonth:
        _startDate = DateTime(now.year, now.month - 1, 1);
        _endDate = DateTime(now.year, now.month, 0, 23, 59, 59);
        break;
      case TimeFilter.thisYear:
        _startDate = DateTime(now.year, 1, 1);
        _endDate = DateTime(now.year, 12, 31, 23, 59, 59);
        break;
      case TimeFilter.allTime:
        _startDate = DateTime(1970);
        _endDate = DateTime(2100);
        break;
      case TimeFilter.custom:
        _startDate = DateTime(now.year, now.month, 1);
        _endDate = DateTime(now.year, now.month + 1, 0, 23, 59, 59);
        break;
    }
  }

  String _getFilterLabel(TimeFilter filter) {
    switch (filter) {
      case TimeFilter.thisMonth:
        return t.categories.report.thisMonth;
      case TimeFilter.lastMonth:
        return t.categories.report.lastMonth;
      case TimeFilter.thisYear:
        return t.categories.report.thisYear;
      case TimeFilter.allTime:
        return t.categories.report.allTime;
      case TimeFilter.custom:
        return "Personalizado";
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TransactionProvider>();
    final txCount = provider.transactions.length;
    final categoriesMap = provider.categoriesDataMap;

    final now = DateTime.now();
    final sDate = _startDate ?? DateTime(now.year, now.month, 1);
    final eDate = _endDate ?? DateTime(now.year, now.month + 1, 0, 23, 59, 59);

    if (_summaryFuture == null ||
        _lastTxCount != txCount ||
        _lastMode != _isExpenseMode ||
        _lastStart != sDate ||
        _lastEnd != eDate) {
      _lastTxCount = txCount;
      _lastMode = _isExpenseMode;
      _lastStart = sDate;
      _lastEnd = eDate;
      _summaryFuture =
          provider.getCategorySummary(sDate, eDate, _isExpenseMode);
    }

    final nf = NumberFormat.currency(locale: 'es', symbol: '\$');

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(t.categories.report.title),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    t.categories.report.timeFilter,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Material(
                    color: Colors.blue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                    clipBehavior: Clip.antiAlias,
                    child: PopupMenuButton<TimeFilter>(
                      initialValue: _selectedFilter,
                      position: PopupMenuPosition.under,
                      constraints:
                          const BoxConstraints(minWidth: 160, maxWidth: 160),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 3,
                      color: Colors.white,
                      onSelected: (TimeFilter item) {
                        setState(() {
                          _selectedFilter = item;
                          _updateDateRange();
                        });
                      },
                      itemBuilder: (BuildContext context) => TimeFilter.values
                          .where((f) => f != TimeFilter.custom)
                          .map((TimeFilter filter) {
                        final isSelected = _selectedFilter == filter;
                        return PopupMenuItem<TimeFilter>(
                          value: filter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  _getFilterLabel(filter),
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                                    color: isSelected
                                        ? Colors.blue
                                        : Colors.black87,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (isSelected) ...[
                                const SizedBox(width: 8),
                                const Icon(Icons.check_circle_rounded,
                                    color: Colors.blue, size: 20),
                              ],
                            ],
                          ),
                        );
                      }).toList(),
                      child: Container(
                        width: 140,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                _getFilterLabel(_selectedFilter),
                                style: const TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Icon(Icons.keyboard_arrow_down,
                                size: 20, color: Colors.blue),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            IgnorePointer(
              ignoring: false,
              child: CategoryBreakdownWidget(
                filterStartDate: _startDate,
                filterEndDate: _endDate,
                hideHeader: true,
                onTypeChanged: (val) {
                  setState(() {
                    _isExpenseMode = val;
                  });
                },
              ),
            ),
            const SizedBox(height: 16),
            FutureBuilder<Map<String, dynamic>>(
              future: _summaryFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting &&
                    !snapshot.hasData) {
                  return const Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                Map<int, double> modeTotals =
                    snapshot.data?['modeTotals'] ?? {};
                Map<int, double> parentTotals = {};
                double totalAmountForMode = 0.0;

                for (var entry in modeTotals.entries) {
                  final catId = entry.key;
                  final amount = entry.value;

                  final category = categoriesMap[catId];
                  int parentId = category?.parentId ?? category?.id ?? -1;

                  // Skip loans or unassigned if desired
                  if (parentId != 0) {
                    parentTotals[parentId] =
                        (parentTotals[parentId] ?? 0.0) + amount;
                    totalAmountForMode += amount;
                  }
                }

                var sortedEntries = parentTotals.entries.toList()
                  ..sort((a, b) => b.value.compareTo(a.value));

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.categories.report.details,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        if (sortedEntries.isEmpty)
                          Center(
                              child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(t.categories.report.noTransactions,
                                style: const TextStyle(color: Colors.grey)),
                          )),
                        for (int i = 0; i < sortedEntries.length; i++) ...[
                          Builder(builder: (context) {
                            final entry = sortedEntries[i];
                            final catId = entry.key;
                            final amount = entry.value;
                            final percentage = totalAmountForMode > 0
                                ? (amount / totalAmountForMode) * 100
                                : 0.0;

                            final category = categoriesMap[catId];
                            final title =
                                category?.name ?? "Otros";
                            final List<Color> chartColors = [
                              const Color(0xFF6366F1), // Indigo
                              const Color(0xFF10B981), // Emerald
                              const Color(0xFFF59E0B), // Green-yellow
                              const Color(0xFF3B82F6), // Blue
                              const Color(0xFF8B5CF6), // Light blue
                              const Color(0xFFEC4899), // Pink
                              const Color(0xFFF43F5E), // Rose
                              const Color(0xFF14B8A6), // Teal
                              const Color(0xFF06B6D4), // Cyan
                              const Color(0xFF84CC16), // Light Teal
                            ];
                            final color = category != null
                                ? chartColors[i % chartColors.length]
                                : Colors.grey;

                            return _buildRealCategoryItem(
                              title,
                              nf.format(amount),
                              "${percentage.toStringAsFixed(1)}%",
                              color,
                            );
                          }),
                          if (i < sortedEntries.length - 1) const Divider(),
                        ]
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildRealCategoryItem(
      String title, String amount, String perc, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(shape: BoxShape.circle, color: color),
              ),
              const SizedBox(width: 12),
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(amount, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(perc,
                style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ])
        ],
      ),
    );
  }
}
