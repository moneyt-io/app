import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../domain/entities/category.dart';
import '../../../core/atoms/widget_card_header.dart';
import '../../transactions/transaction_provider.dart';
import '../../../core/l10n/generated/strings.g.dart';
import '../../../navigation/app_routes.dart';

class CategoryBreakdownWidget extends StatefulWidget {
  final DateTime? filterStartDate;
  final DateTime? filterEndDate;
  final bool hideHeader;
  final ValueChanged<bool>? onTypeChanged;

  const CategoryBreakdownWidget({
    super.key,
    this.filterStartDate,
    this.filterEndDate,
    this.hideHeader = false,
    this.onTypeChanged,
  });

  @override
  State<CategoryBreakdownWidget> createState() =>
      _CategoryBreakdownWidgetState();
}

class _CategoryBreakdownWidgetState extends State<CategoryBreakdownWidget> {
  bool _isExpenseMode = true;
  int? _selectedParentCategoryId;
  static const String _prefExpenseModeKey = 'category_breakdown_expense_mode';

  Future<Map<String, dynamic>>? _summaryFuture;
  int _lastTxCount = -1;
  bool _lastMode = false;
  DateTime? _lastStart;
  DateTime? _lastEnd;

  @override
  void initState() {
    super.initState();
    _loadPreference();
  }

  void _loadPreference() {
    try {
      final prefs = GetIt.instance<SharedPreferences>();
      if (prefs.containsKey(_prefExpenseModeKey)) {
        _isExpenseMode = prefs.getBool(_prefExpenseModeKey) ?? true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            widget.onTypeChanged?.call(_isExpenseMode);
          }
        });
      }
    } catch (e) {
      debugPrint('Error loading prefs: $e');
    }
  }

  Future<void> _savePreference(bool isExpense) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_prefExpenseModeKey, isExpense);
    } catch (e) {
      debugPrint('Error saving prefs: $e');
    }
  }

  final List<Color> _chartColors = [
    const Color(0xFF6366F1),
    const Color(0xFF10B981),
    const Color(0xFFF59E0B),
    const Color(0xFF3B82F6),
    const Color(0xFF8B5CF6),
    const Color(0xFFEC4899),
    const Color(0xFFF43F5E),
    const Color(0xFF14B8A6),
    const Color(0xFF06B6D4),
    const Color(0xFF84CC16),
  ];

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TransactionProvider>();
    final txCount = provider.transactions.length;
    final categoriesMap = provider.categoriesDataMap;

    final now = DateTime.now();
    final start = widget.filterStartDate ?? DateTime(now.year, now.month, 1);
    final end = widget.filterEndDate ??
        DateTime(now.year, now.month + 1, 0, 23, 59, 59);

    if (_summaryFuture == null ||
        _lastTxCount != txCount ||
        _lastMode != _isExpenseMode ||
        _lastStart != start ||
        _lastEnd != end) {
      _lastTxCount = txCount;
      _lastMode = _isExpenseMode;
      _lastStart = start;
      _lastEnd = end;
      _summaryFuture = provider.getCategorySummary(start, end, _isExpenseMode);
    }

    return FutureBuilder<Map<String, dynamic>>(
      future: _summaryFuture,
      builder: (context, snapshot) {
        Map<int, double> modeTotals = snapshot.data?['modeTotals'] ?? {};

        Map<int, double> parentTotals = {};
        Map<int, Map<int, double>> subcategoryTotals = {};

        for (var entry in modeTotals.entries) {
          final catId = entry.key;
          final amount = entry.value;

          final category = categoriesMap[catId];
          int parentId = category?.parentId ?? category?.id ?? -1;

          if (parentId != 0) {
            parentTotals[parentId] = (parentTotals[parentId] ?? 0.0) + amount;
            subcategoryTotals[parentId] ??= {};
            subcategoryTotals[parentId]![catId] =
                (subcategoryTotals[parentId]![catId] ?? 0.0) + amount;
          }
        }

        if (snapshot.connectionState == ConnectionState.waiting &&
            !snapshot.hasData) {
          return Container(
            height: 300,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        if (parentTotals.isEmpty) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              children: [
                if (!widget.hideHeader) ...[
                  WidgetCardHeader(
                    icon: Icons.pie_chart_rounded,
                    title: t.dashboard.widgets.categoryBreakdown.title,
                    subtitle: t.dashboard.widgets.categoryBreakdown.description,
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.categoryReport);
                    },
                  ),
                  const SizedBox(height: 8),
                ] else ...[
                  const SizedBox(height: 16),
                ],
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: CupertinoSlidingSegmentedControl<bool>(
                      groupValue: _isExpenseMode,
                      children: {
                        false: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(t.transactions.types.income,
                              style: const TextStyle(fontSize: 13)),
                        ),
                        true: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(t.transactions.types.expense,
                              style: const TextStyle(fontSize: 13)),
                        ),
                      },
                      onValueChanged: (val) {
                        if (val != null) {
                          HapticFeedback.selectionClick();
                          widget.onTypeChanged?.call(val);
                          _savePreference(val);
                          if (mounted) {
                            setState(() {
                              _isExpenseMode = val;
                              _selectedParentCategoryId = null;
                            });
                          }
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Center(
                    child: Text(
                      t.dashboard.widgets.categoryBreakdown.empty_message,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0A000000),
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            children: [
              if (!widget.hideHeader) ...[
                WidgetCardHeader(
                  icon: Icons.pie_chart_rounded,
                  title: t.dashboard.widgets.categoryBreakdown.title,
                  subtitle: t.dashboard.widgets.categoryBreakdown.description,
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.categoryReport);
                  },
                ),
                const SizedBox(height: 12),
              ] else ...[
                const SizedBox(height: 16),
              ],
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: CupertinoSlidingSegmentedControl<bool>(
                    groupValue: _isExpenseMode,
                    children: {
                      false: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(t.transactions.types.income,
                            style: const TextStyle(fontSize: 13)),
                      ),
                      true: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(t.transactions.types.expense,
                            style: const TextStyle(fontSize: 13)),
                      ),
                    },
                    onValueChanged: (val) {
                      if (val != null) {
                        HapticFeedback.selectionClick();
                        widget.onTypeChanged?.call(val);
                        _savePreference(val);
                        if (mounted) {
                          setState(() {
                            _isExpenseMode = val;
                            _selectedParentCategoryId = null;
                          });
                        }
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, bottom: 16.0, top: 4.0),
                child: SizedBox(
                  height: 170,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: _buildChart(parentTotals, categoriesMap),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 1,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return FadeTransition(
                                opacity: animation, child: child);
                          },
                          child: _selectedParentCategoryId == null
                              ? _buildParentLegend(parentTotals, categoriesMap)
                              : _buildSubcategoryLegend(
                                  _selectedParentCategoryId!,
                                  subcategoryTotals[
                                          _selectedParentCategoryId!] ??
                                      {},
                                  categoriesMap),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildChart(
      Map<int, double> parentTotals, Map<int, Category> categoriesMap) {
    if (parentTotals.isEmpty) return const SizedBox();

    double totalExpenses =
        parentTotals.values.fold(0.0, (sum, val) => sum + val);

    // Sort by values descending to generate segments
    final sortedEntries = parentTotals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    List<PieChartSectionData> sections = [];

    for (int i = 0; i < sortedEntries.length; i++) {
      final isSelected = _selectedParentCategoryId == sortedEntries[i].key;
      final val = sortedEntries[i].value;

      // Ensure very small expenses have a minimum size (e.g., 5%) so they are clickable
      final percentage = (val / totalExpenses) * 100;
      final renderValue = percentage < 5.0 ? totalExpenses * 0.05 : val;

      final section = PieChartSectionData(
        color: _chartColors[i % _chartColors.length],
        value: renderValue,
        title: "", // Hiding titles to make it clean
        radius: isSelected ? 28.0 : 20.0,
      );
      sections.add(section);
    }

    final formatCurrency = NumberFormat.simpleCurrency(decimalDigits: 2);

    return Stack(
      alignment: Alignment.center,
      children: [
        PieChart(
          PieChartData(
            pieTouchData: PieTouchData(
              touchCallback: (FlTouchEvent event, pieTouchResponse) {
                if (event is FlTapUpEvent &&
                    pieTouchResponse != null &&
                    pieTouchResponse.touchedSection != null) {
                  final sectionIndex =
                      pieTouchResponse.touchedSection!.touchedSectionIndex;
                  if (sectionIndex == -1) return;

                  HapticFeedback.selectionClick();
                  if (mounted) {
                    setState(() {
                      if (_selectedParentCategoryId ==
                          sortedEntries[sectionIndex].key) {
                        _selectedParentCategoryId = null; // Toggle off
                      } else {
                        _selectedParentCategoryId =
                            sortedEntries[sectionIndex].key;
                      }
                    });
                  }
                }
              },
            ),
            borderData: FlBorderData(show: false),
            sectionsSpace: 2,
            centerSpaceRadius: 40,
            sections: sections,
          ),
        ),
        // Center text (Total or Parent Total)
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _selectedParentCategoryId == null
                  ? "Total"
                  : (_selectedParentCategoryId == -1
                      ? t.dashboard.widgets.categoryBreakdown.others
                      : (categoriesMap[_selectedParentCategoryId!]?.name ??
                          t.dashboard.widgets.categoryBreakdown.others)),
              style: const TextStyle(
                fontSize: 10,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              formatCurrency.format(_selectedParentCategoryId == null
                  ? totalExpenses
                  : parentTotals[_selectedParentCategoryId]),
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )
      ],
    );
  }

  // Shows Top 4 Parent Categories and sums up the rest into "Otros"
  Widget _buildParentLegend(
      Map<int, double> parentTotals, Map<int, Category> categoriesMap) {
    if (parentTotals.isEmpty) return const SizedBox();

    double totalExpenses =
        parentTotals.values.fold(0.0, (sum, val) => sum + val);

    final sortedEntries = parentTotals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Column(
      key: const ValueKey('parent_legend'),
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
          sortedEntries.length > 4 ? 4 : sortedEntries.length, (i) {
        final isOther = i == 3 && sortedEntries.length > 4;
        double val = isOther
            ? sortedEntries.sublist(3).fold(0.0, (sum, e) => sum + e.value)
            : sortedEntries[i].value;

        final name = isOther || sortedEntries[i].key == -1
            ? t.dashboard.widgets.categoryBreakdown.others
            : (categoriesMap[sortedEntries[i].key]?.name ??
                t.dashboard.widgets.categoryBreakdown.others);

        final percentage = (val / totalExpenses) * 100;
        final color =
            isOther ? Colors.grey : _chartColors[i % _chartColors.length];

        return _buildLegendRow(name, percentage, val, color);
      }),
    );
  }

  // Shows details for a selected Category and its subcategories, includes "Back" button
  Widget _buildSubcategoryLegend(int parentId,
      Map<int, double> subcategoryTotals, Map<int, Category> categoriesMap) {
    final sortedEntries = subcategoryTotals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    double parentTotal =
        subcategoryTotals.values.fold(0.0, (sum, val) => sum + val);

    return Column(
      key: const ValueKey('subcategory_legend'),
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            HapticFeedback.lightImpact();
            if (mounted) {
              setState(() {
                _selectedParentCategoryId = null; // Back
              });
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.arrow_back_ios_new,
                  size: 14, color: Colors.blue),
              const SizedBox(width: 4),
              Text(t.dashboard.widgets.categoryBreakdown.back,
                  style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 13,
                      fontWeight: FontWeight.w600)),
            ],
          ),
        ),
        const SizedBox(height: 12),
        ...List.generate(sortedEntries.length > 3 ? 3 : sortedEntries.length,
            (i) {
          final isOther = i == 2 && sortedEntries.length > 3;
          double val = isOther
              ? sortedEntries.sublist(2).fold(0.0, (sum, e) => sum + e.value)
              : sortedEntries[i].value;

          final name = isOther || sortedEntries[i].key == -1
              ? t.dashboard.widgets.categoryBreakdown.others
              : (categoriesMap[sortedEntries[i].key]?.name ??
                  t.dashboard.widgets.categoryBreakdown.others);

          final percentage = (val / parentTotal) * 100;

          return _buildLegendRow(name, percentage, val, Colors.blueGrey);
        })
      ],
    );
  }

  Widget _buildLegendRow(
      String name, double percentage, double amount, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(fontSize: 12, color: Colors.black87),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            "${percentage.toStringAsFixed(1)}%",
            style: const TextStyle(
                fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
