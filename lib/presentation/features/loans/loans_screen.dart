import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

import '../../../domain/entities/loan_entry.dart';
import '../../../domain/entities/contact.dart';
import '../../../domain/entities/loan_contact_summary.dart';
import 'loan_provider.dart';
import 'models/loan_filter_model.dart' as filter_model;
import 'widgets/loan_summary_cards.dart';
import 'widgets/active_loans_section.dart';
import '../../core/molecules/empty_state.dart';
import '../../core/molecules/filter_chip_group.dart';
import '../../core/molecules/active_filters_bar.dart';
import '../../core/atoms/app_app_bar.dart';
import '../../core/atoms/expandable_fab.dart';
import '../../core/atoms/app_button.dart';
import '../../core/organisms/app_drawer.dart';
import '../../navigation/app_routes.dart';
import '../../navigation/navigation_service.dart';
import 'loan_contact_detail_screen.dart';
import '../../core/design_system/tokens/app_dimensions.dart';

enum LoanTypeFilter { all, lent, borrowed, pending }

extension LoanTypeFilterExtension on LoanTypeFilter {
  filter_model.LoanType? toLoanType() {
    switch (this) {
      case LoanTypeFilter.lent:
        return filter_model.LoanType.lent;
      case LoanTypeFilter.borrowed:
        return filter_model.LoanType.borrowed;
      default:
        return null;
    }
  }
}

extension LoanTypeExtension on filter_model.LoanType {
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
        // Date filter
        if (_filterModel.startDate != null && loan.date.isBefore(_filterModel.startDate!)) {
          return false;
        }
        if (_filterModel.endDate != null && loan.date.isAfter(_filterModel.endDate!.add(const Duration(days: 1)))) {
          return false;
        }

        // Type filter
        if (_filterModel.loanTypes.isNotEmpty) {
          final isLent = loan.documentTypeId == 'L';
          final matchesType = _filterModel.loanTypes.any((type) {
            return (type == filter_model.LoanType.lent && isLent) || (type == filter_model.LoanType.borrowed && !isLent);
          });
          if (!matchesType) return false;
        }

        // Contact filter
        if (_filterModel.contact != null && loan.contactId != _filterModel.contact!.id) {
          return false;
        }

        // Account filter
        if (_filterModel.account != null) {
          // This would need to be implemented based on loan payment method
          // For now, we'll skip this filter
        }

        // Amount filter
        if (_filterModel.minAmount != null && loan.amount < _filterModel.minAmount!) {
          return false;
        }
        if (_filterModel.maxAmount != null && loan.amount > _filterModel.maxAmount!) {
          return false;
        }

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
    final activeLoans = loans.where((loan) => loan.status == LoanStatus.active).toList();
    debugPrint('   - Active loans (status check): ${activeLoans.length}');
    
    // Check loan types in filter
    debugPrint('   - Filter has loan types: ${_filterModel.loanTypes.isNotEmpty}');
    if (_filterModel.loanTypes.isNotEmpty) {
      debugPrint('   - Filter loan types: ${_filterModel.loanTypes.map((t) => t.name).join(", ")}');
    }
    
    if (loans.isNotEmpty) {
      final firstLoan = loans.first;
      debugPrint('   - First loan: contactId=${firstLoan.contactId}, status=${firstLoan.status.name}, active=${firstLoan.active}');
      debugPrint('   - Contact exists in map: ${contactsMap.containsKey(firstLoan.contactId)}');
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
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  FilterChipGroup<LoanTypeFilter>(
                    selectedValue: _filterModel.loanTypes.isEmpty
                        ? LoanTypeFilter.all
                        : _filterModel.loanTypes.first.toFilterType(),
                    filters: {
                      LoanTypeFilter.all: 'All',
                      LoanTypeFilter.lent: 'Lent',
                      LoanTypeFilter.borrowed: 'Borrowed',
                      LoanTypeFilter.pending: 'Pending',
                    },
                    icons: {
                      LoanTypeFilter.all: Icons.account_balance,
                      LoanTypeFilter.lent: Icons.trending_up,
                      LoanTypeFilter.borrowed: Icons.trending_down,
                      LoanTypeFilter.pending: Icons.schedule,
                    },
                    onFilterChanged: (value) {
                      setState(() {
                        _filterModel = _filterModel.copyWithLoanTypes(
                          value == LoanTypeFilter.all
                              ? {filter_model.LoanType.lent, filter_model.LoanType.borrowed}
                              : value.toLoanType() != null
                                  ? {value.toLoanType()!}
                                  : {},
                        );
                      });
                    },
                  ),
                  const SizedBox(height: 8),
                  ActiveFiltersBar(
                    activeFilters: _filterModel.activeFilters(excludeLoanType: true),
                    onAddFilter: () {
                      // TODO: Implement loan filter dialog
                    },
                    onRemoveFilter: (key) {
                      setState(() {
                        _filterModel = _filterModel.removeFilter(key);
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 12.0),
              child: LoanSummaryCards(
                totalLent: _statistics['totalLent'] ?? 0.0,
                totalBorrowed: _statistics['totalBorrowed'] ?? 0.0,
                lentToPeople: _getLentToPeopleCount(groupedLoans),
                borrowedFromPeople: _getBorrowedFromPeopleCount(groupedLoans),
                isLoading: _statisticsLoading,
              ),
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
                      : SliverToBoxAdapter(
                          child: ActiveLoansSection(
                            contactSummaries: _buildContactSummaries(groupedLoans, contactsMap),
                            totalPendingLoans: _getTotalPendingLoans(filteredLoans),
                            onContactTap: (summary) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => LoanContactDetailScreen(
                                    contact: summary.contact,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
        ],
      ),
      floatingActionButton: ExpandableFab(
        actions: [
          FabAction(
            label: 'Lend Money',
            icon: Icons.trending_up,
            backgroundColor: const Color(0xFF22C55E),
            onPressed: () => NavigationService.navigateTo(
              AppRoutes.loanForm,
              arguments: {'initialType': 'L'},
            ),
          ),
          FabAction(
            label: 'Borrow Money',
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
        currencyId: contactLoans.isNotEmpty ? contactLoans.first.currencyId : 'USD',
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
}
