import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/loan_entry.dart';
import '../../../domain/entities/contact.dart';
import '../../../domain/entities/loan_contact_summary.dart';
import 'loan_provider.dart';
import 'models/loan_filter_model.dart' as filter_model;
import 'widgets/loan_summary_cards.dart';
import 'widgets/active_loans_section.dart';
import '../../core/molecules/empty_state.dart';
import '../../core/molecules/filter_chip_group.dart';
import '../../core/atoms/app_app_bar.dart';
import '../../core/atoms/expandable_fab.dart';
import '../../core/atoms/app_button.dart';
import '../../core/organisms/app_drawer.dart';
import '../../navigation/app_routes.dart';
import '../../navigation/navigation_service.dart';
import 'loan_contact_detail_screen.dart';
import '../../core/design_system/tokens/app_dimensions.dart';

enum LoanTypeFilter { pending, lent, borrowed, all }

extension LoanTypeModelExtension on filter_model.LoanType {
  LoanTypeFilter toFilterType() {
    switch (this) {
      case filter_model.LoanType.lent:
        return LoanTypeFilter.lent;
      case filter_model.LoanType.borrowed:
        return LoanTypeFilter.borrowed;
    }
  }
}

class LoansScreen extends StatefulWidget {
  const LoansScreen({super.key});

  @override
  State<LoansScreen> createState() => _LoansScreenState();
}

class _LoansScreenState extends State<LoansScreen> {
  late filter_model.LoanFilterModel _filterModel;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  LoanTypeFilter _selectedFilter = LoanTypeFilter.pending;
  Map<String, double> _statistics = {};
  bool _statisticsLoading = true;
  bool _initialLoadCompleted = false;

  @override
  void initState() {
    super.initState();
    _filterModel = filter_model.LoanFilterModel.initial();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    final provider = context.read<LoanProvider>();

    // Load loans
    await provider.loadLoans();

    if (mounted) {
      setState(() {
        _initialLoadCompleted = true;
      });
    }

    await _loadStatistics();
  }

  Future<void> _loadStatistics() async {
    final provider = Provider.of<LoanProvider>(context, listen: false);
    try {
      final stats = await provider.getStatistics();
      if (mounted) {
        setState(() {
          _statistics = stats;
          _statisticsLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _statisticsLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LoanProvider>();
    final loans = provider.loans;
    final contactsMap = <int, Contact>{};

    // Build contacts map from loans that have contact objects loaded
    for (final loan in loans) {
      if (loan.contact != null) {
        contactsMap[loan.contact!.id] = loan.contact!;
      }
    }

    // Helper function to get filtered loans
    List<LoanEntry> getFilteredLoans() {
      return loans.where((loan) {
        // Status filter (based on the main chip selection)
        if (_selectedFilter != LoanTypeFilter.all &&
            loan.status != LoanStatus.active) {
          return false;
        }

        // Type filter (for Lent/Borrowed)
        if (_selectedFilter == LoanTypeFilter.lent &&
            loan.documentTypeId != 'L') {
          return false;
        }
        if (_selectedFilter == LoanTypeFilter.borrowed &&
            loan.documentTypeId != 'B') {
          return false;
        }

        // The rest of the filters from the dialog can be added here in the future

        return true;
      }).toList();
    }

    // Group loans by contact
    Map<int, List<LoanEntry>> groupLoansByContact(List<LoanEntry> loans) {
      final Map<int, List<LoanEntry>> grouped = {};
      for (var loan in loans) {
        // Use contactId directly instead of requiring contact object
        if (loan.contactId > 0) {
          final contactId = loan.contactId;
          if (grouped[contactId] == null) {
            grouped[contactId] = [];
          }
          grouped[contactId]!.add(loan);
        }
      }
      return grouped;
    }

    final filteredLoans = getFilteredLoans();
    final groupedLoans = groupLoansByContact(filteredLoans);

    // Debug logging
    debugPrint('🔍 Debug Active Loans:');
    debugPrint('   - Total loans: ${loans.length}');
    debugPrint('   - Contacts map size: ${contactsMap.length}');
    debugPrint('   - Filtered loans: ${filteredLoans.length}');
    debugPrint('   - Grouped contacts: ${groupedLoans.length}');

    // Check if the issue is in filtering
    final activeLoans =
        loans.where((loan) => loan.status == LoanStatus.active).toList();
    debugPrint('   - Active loans (status check): ${activeLoans.length}');

    // Check loan types in filter
    debugPrint(
        '   - Filter has loan types: ${_filterModel.loanTypes.isNotEmpty}');
    if (_filterModel.loanTypes.isNotEmpty) {
      debugPrint(
          '   - Filter loan types: ${_filterModel.loanTypes.map((t) => t.name).join(", ")}');
    }

    if (loans.isNotEmpty) {
      final firstLoan = loans.first;
      debugPrint(
          '   - First loan: contactId=${firstLoan.contactId}, status=${firstLoan.status.name}, active=${firstLoan.active}');
      debugPrint(
          '   - Contact exists in map: ${contactsMap.containsKey(firstLoan.contactId)}');
    }

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppAppBar(
        title: 'Loans',
        type: AppAppBarType.blur,
        leading: AppAppBarLeading.drawer,
        onLeadingPressed: () => _scaffoldKey.currentState?.openDrawer(),
        actions: const [AppAppBarAction.search],
        onActionsPressed: [() {}],
      ),
      drawer: const AppDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverFilterHeaderDelegate(
              height: 64,
              blur: true,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: [
                    FilterChipGroup<LoanTypeFilter>(
                      selectedValue: _selectedFilter,
                      filters: const {
                        LoanTypeFilter.pending: 'Pending',
                        LoanTypeFilter.lent: 'Lent',
                        LoanTypeFilter.borrowed: 'Borrowed',
                        LoanTypeFilter.all: 'All',
                      },
                      icons: const {
                        LoanTypeFilter.pending: Icons.hourglass_top_outlined,
                        LoanTypeFilter.lent: Icons.trending_up,
                        LoanTypeFilter.borrowed: Icons.trending_down,
                        LoanTypeFilter.all: Icons.list_alt_outlined,
                      },
                      onFilterChanged: (value) {
                        setState(() {
                          _selectedFilter = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 12.0),
              child: _buildSummaryCards(groupedLoans),
            ),
          ),
          provider.isLoading && !_initialLoadCompleted
              ? const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()))
              : provider.errorMessage != null
                  ? SliverFillRemaining(
                      child: _buildErrorState(context, provider.errorMessage!))
                  : filteredLoans.isEmpty
                      ? SliverFillRemaining(child: _buildEmptyState())
                      : SliverList(
                          delegate: SliverChildListDelegate([
                            ActiveLoansSection(
                              contactSummaries: _buildContactSummaries(
                                  groupedLoans, contactsMap),
                              totalPendingLoans:
                                  _getTotalPendingLoans(filteredLoans),
                              onContactTap: (summary) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        LoanContactDetailScreen(
                                      contact: summary.contact,
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 85), // For FAB
                          ]),
                        ),
        ],
      ),
      floatingActionButton: ExpandableFab(
        actions: [
          FabAction(
            label: 'Lend',
            icon: Icons.trending_up,
            backgroundColor: const Color(0xFF22C55E),
            onPressed: () => NavigationService.navigateTo(
              AppRoutes.loanForm,
              arguments: {'initialType': 'L'},
            ),
          ),
          FabAction(
            label: 'Borrow',
            icon: Icons.trending_down,
            backgroundColor: const Color(0xFFEF4444),
            onPressed: () => NavigationService.navigateTo(
              AppRoutes.loanForm,
              arguments: {'initialType': 'B'},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String error) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.spacing16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline,
                size: AppDimensions.spacing48,
                color: Theme.of(context).colorScheme.error),
            SizedBox(height: AppDimensions.spacing16),
            Text('Error loading loans',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: AppDimensions.spacing8),
            Text(error),
            SizedBox(height: AppDimensions.spacing24),
            ElevatedButton(
              onPressed: _loadData,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return EmptyState(
      icon: Icons.account_balance_outlined,
      title: 'No loans found',
      message: 'No loans match the applied filters',
      action: AppButton(
        text: 'Clear filters',
        onPressed: () {
          setState(() {
            _filterModel = filter_model.LoanFilterModel.initial();
          });
        },
        type: AppButtonType.text,
      ),
    );
  }

  List<LoanContactSummary> _buildContactSummaries(
      Map<int, List<LoanEntry>> groupedLoans, Map<int, Contact> contactsMap) {
    return groupedLoans.entries.where((entry) {
      // Only include contacts that exist in the contacts map
      return contactsMap.containsKey(entry.key);
    }).map((entry) {
      final contactId = entry.key;
      final contactLoans = entry.value;
      final contact = contactsMap[contactId]!;

      double totalLent = 0;
      double totalBorrowed = 0;
      int activeCount = 0;
      DateTime? nextDueDate;
      bool isOverdue = false;

      for (final loan in contactLoans) {
        if (loan.documentTypeId == 'L') {
          totalLent += loan.amount;
        } else {
          totalBorrowed += loan.amount;
        }
        if (loan.status.name == 'active') {
          activeCount++;
        }
        // TODO: Add due date and overdue logic when available in LoanEntry
      }

      return LoanContactSummary(
        contact: contact,
        totalLent: totalLent,
        totalBorrowed: totalBorrowed,
        activeLoanCount: activeCount,
        nextDueDate: nextDueDate,
        isOverdue: isOverdue,
        currencyId:
            contactLoans.isNotEmpty ? contactLoans.first.currencyId : 'USD',
      );
    }).toList();
  }

  int _getLentToPeopleCount(Map<int, List<LoanEntry>> groupedLoans) {
    return groupedLoans.values
        .where((loans) => loans.any((loan) => loan.documentTypeId == 'L'))
        .length;
  }

  int _getBorrowedFromPeopleCount(Map<int, List<LoanEntry>> groupedLoans) {
    return groupedLoans.values
        .where((loans) => loans.any((loan) => loan.documentTypeId == 'B'))
        .length;
  }

  int _getTotalPendingLoans(List<LoanEntry> loans) {
    return loans.where((loan) => loan.status.name == 'active').length;
  }

  Widget _buildSummaryCards(Map<int, List<LoanEntry>> groupedLoans) {
    final isLentActive =
        _filterModel.loanTypes.contains(filter_model.LoanType.lent);
    final isBorrowedActive =
        _filterModel.loanTypes.contains(filter_model.LoanType.borrowed);
    final isAllActive = _filterModel.loanTypes.isEmpty;

    double? totalLent;
    int? lentToPeople;
    double? totalBorrowed;
    int? borrowedFromPeople;

    if (isAllActive || isLentActive) {
      totalLent = _statistics['totalLent'] ?? 0.0;
      lentToPeople = _getLentToPeopleCount(groupedLoans);
    }

    if (isAllActive || isBorrowedActive) {
      totalBorrowed = _statistics['totalBorrowed'] ?? 0.0;
      borrowedFromPeople = _getBorrowedFromPeopleCount(groupedLoans);
    }

    return LoanSummaryCards(
      totalLent: totalLent,
      lentToPeople: lentToPeople,
      totalBorrowed: totalBorrowed,
      borrowedFromPeople: borrowedFromPeople,
      isLoading: _statisticsLoading,
    );
  }
}

class _SliverFilterHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;
  final bool blur;

  _SliverFilterHeaderDelegate({
    required this.child,
    required this.height,
    this.blur = false,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final backgroundColor = blur
        ? Theme.of(context).scaffoldBackgroundColor.withOpacity(0.85)
        : Theme.of(context).scaffoldBackgroundColor;

    final content = Container(
      color: backgroundColor,
      child: child,
    );

    if (blur) {
      return ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: content,
        ),
      );
    }

    return content;
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant _SliverFilterHeaderDelegate oldDelegate) {
    return oldDelegate.child != child ||
        oldDelegate.height != height ||
        oldDelegate.blur != blur;
  }
}
