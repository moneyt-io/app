import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';
import 'dart:ui';

import '../../../domain/entities/contact.dart';
import '../../../domain/entities/loan_entry.dart';
import '../../core/atoms/app_app_bar.dart';
import '../../core/l10n/generated/strings.g.dart';
import '../../navigation/navigation_service.dart';
import 'loan_provider.dart';
import 'widgets/loan_history_item_card.dart';
import 'widgets/loan_history_summary_card.dart';
import '../../core/molecules/filter_chip_group.dart';

enum LoanHistoryFilter { all, lent, borrowed, completed }

class LoanHistoryScreen extends StatefulWidget {
  final Contact contact;

  const LoanHistoryScreen({Key? key, required this.contact}) : super(key: key);

  @override
  _LoanHistoryScreenState createState() => _LoanHistoryScreenState();
}

class _LoanHistoryScreenState extends State<LoanHistoryScreen> {
  LoanHistoryFilter _currentFilter = LoanHistoryFilter.all;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LoanProvider>().loadLoans();
    });
  }

  List<LoanEntry> _getFilteredLoans(List<LoanEntry> allLoans) {
    switch (_currentFilter) {
      case LoanHistoryFilter.lent:
        return allLoans.where((loan) => loan.isLend).toList();
      case LoanHistoryFilter.borrowed:
        return allLoans.where((loan) => loan.isBorrow).toList();
      case LoanHistoryFilter.completed:
        return allLoans.where((loan) => loan.status == LoanStatus.paid).toList();
      case LoanHistoryFilter.all:
        return allLoans;
    }
  }

  @override
  Widget build(BuildContext context) {
    final loanProvider = context.watch<LoanProvider>();
    final allLoans = loanProvider.loans.where((l) => l.contactId == widget.contact.id).toList();
    final filteredLoans = _getFilteredLoans(allLoans);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // slate-50
      appBar: AppAppBar(
        title: t.loans.history.title,
        type: AppAppBarType.blur,
        leading: AppAppBarLeading.back,
      ),
      body: loanProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _SliverFilterHeaderDelegate(
                    height: 64,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Column(
                        children: [
                          FilterChipGroup<LoanHistoryFilter>(
                            selectedValue: _currentFilter,
                            filters: {
                              LoanHistoryFilter.all: t.loans.history.filter.all,
                              LoanHistoryFilter.lent: t.loans.history.filter.lent,
                              LoanHistoryFilter.borrowed: t.loans.history.filter.borrowed,
                              LoanHistoryFilter.completed: t.loans.history.filter.completed,
                            },
                            icons: const {
                              LoanHistoryFilter.all: Icons.history,
                              LoanHistoryFilter.lent: Icons.call_made,
                              LoanHistoryFilter.borrowed: Icons.call_received,
                              LoanHistoryFilter.completed: Icons.check_circle,
                            },
                            onFilterChanged: (value) {
                              setState(() {
                                _currentFilter = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(child: _buildContactHeader(allLoans)),
                _buildLoanList(filteredLoans),
                SliverToBoxAdapter(child: LoanHistorySummaryCard(loans: allLoans)),
              ],
            ),
    );
  }

  Widget _buildContactHeader(List<LoanEntry> allLoans) {
    final totalLoaned = allLoans.where((l) => l.isLend).map((l) => l.amount).sum;
    final currencyFormat = NumberFormat.currency(locale: 'en_US', symbol: '\$', decimalDigits: 2);

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 24, child: Text(widget.contact.name.isNotEmpty ? widget.contact.name[0] : '')),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.contact.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(t.loans.history.section, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(currencyFormat.format(totalLoaned), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(t.loans.history.totalLoaned, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoanList(List<LoanEntry> loans) {
    if (loans.isEmpty) {
      return SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 48.0),
            child: Text(t.loans.history.noLoans, style: const TextStyle(color: Colors.grey)),
          ),
        ),
      );
    }

    final groupedLoans = groupBy(loans, (LoanEntry loan) => loan.status);

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final status = groupedLoans.keys.elementAt(index);
          final loansInGroup = groupedLoans[status]!;
          
          String sectionTitle;
          switch(status) {
            case LoanStatus.active:
              sectionTitle = t.loans.history.headers.active;
              break;
            case LoanStatus.paid:
              sectionTitle = t.loans.history.headers.completed;
              break;
            case LoanStatus.cancelled:
              sectionTitle = t.loans.history.headers.cancelled;
              break;
            case LoanStatus.writtenOff:
              sectionTitle = t.loans.history.headers.writtenOff;
              break;
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text(
                  sectionTitle,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
              ),
              ...loansInGroup.map((loan) => LoanHistoryItemCard(
                    loan: loan,
                    onTap: () => NavigationService.goToLoanDetail(loan.id),
                  )),
            ],
          );
        },
        childCount: groupedLoans.length,
      ),
    );
  }
}

class _SliverFilterHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  _SliverFilterHeaderDelegate({required this.child, required this.height});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.85),
          child: child,
        ),
      ),
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant _SliverFilterHeaderDelegate oldDelegate) {
    return oldDelegate.child != child || oldDelegate.height != height;
  }
}
