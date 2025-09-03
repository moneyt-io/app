import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/contact.dart';
import '../../../domain/entities/loan_entry.dart';
import '../../core/atoms/app_app_bar.dart';
import '../../core/atoms/expandable_fab.dart';
import '../../navigation/app_routes.dart';
import '../../navigation/navigation_service.dart';
import 'loan_provider.dart';
import 'widgets/contact_summary_card.dart';
import 'widgets/loan_summary_grid_card.dart';
import 'widgets/detailed_loan_card.dart';
import 'widgets/loan_stats_summary_card.dart';
import 'loan_detail_mockup_screen.dart';

class LoanContactDetailScreen extends StatefulWidget {
  final Contact contact;

  const LoanContactDetailScreen({
    Key? key,
    required this.contact,
  }) : super(key: key);

  @override
  State<LoanContactDetailScreen> createState() => _LoanContactDetailScreenState();
}

class _LoanContactDetailScreenState extends State<LoanContactDetailScreen> {

  @override
  void initState() {
    super.initState();
    // Load loans when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LoanProvider>().loadLoans();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // bg-slate-50
      appBar: AppAppBar(
        title: 'Loans with ${widget.contact.name}',
        type: AppAppBarType.blur,
        leading: AppAppBarLeading.back,
        customActions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: _handleShare,
          ),
        ],
      ),
      body: Consumer<LoanProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final contactLoans = provider.loans
              .where((loan) => loan.contactId == widget.contact.id)
              .toList();

          final activeLoans = contactLoans
              .where((loan) => loan.status == LoanStatus.active)
              .toList();

          final lentLoans = activeLoans
              .where((loan) => loan.documentTypeId == 'L')
              .toList();

          final borrowedLoans = activeLoans
              .where((loan) => loan.documentTypeId == 'B')
              .toList();

          final lentAmount = lentLoans.fold<double>(
            0.0, (sum, loan) => sum + loan.amount);
          final borrowedAmount = borrowedLoans.fold<double>(
            0.0, (sum, loan) => sum + loan.amount);
          final netBalance = lentAmount - borrowedAmount;

          final activeLentAmount = lentLoans.fold<double>(
            0.0, (sum, loan) => sum + loan.outstandingBalance);
          final activeBorrowedAmount = borrowedLoans.fold<double>(
            0.0, (sum, loan) => sum + loan.outstandingBalance);
          final netActivePosition = activeLentAmount - activeBorrowedAmount;

          return CustomScrollView(
                slivers: [
                  // Contact Summary Card
                  SliverToBoxAdapter(
                    child: ContactSummaryCard(
                      contact: widget.contact,
                      netBalance: netBalance,
                      activeLoansCount: activeLoans.length,
                      lentCount: lentLoans.length,
                      borrowedCount: borrowedLoans.length,
                    ),
                  ),

                  // Summary Grid Cards
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: LoanSummaryGrid(
                        lentAmount: lentAmount,
                        borrowedAmount: borrowedAmount,
                        lentActiveCount: lentLoans.length,
                        borrowedActiveCount: borrowedLoans.length,
                        onLentTap: () => _filterLoans('L'),
                        onBorrowedTap: () => _filterLoans('B'),
                      ),
                    ),
                  ),

                  // Active Loans Section
                  if (activeLoans.isNotEmpty) ...[
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Active Loans',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1E293B), // text-slate-800
                              ),
                            ),
                            Text(
                              '${activeLoans.length} loans',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF64748B), // text-slate-500
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Active Loans List
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final loan = activeLoans[index];
                          return DetailedLoanCard(
                            loan: loan,
                            onTap: () => _navigateToLoanDetail(loan),
                          );
                        },
                        childCount: activeLoans.length,
                      ),
                    ),
                  ],

                  // Stats Summary Card
                  if (activeLoans.isNotEmpty)
                    SliverToBoxAdapter(
                      child: LoanStatsSummaryCard(
                        activeLentAmount: activeLentAmount,
                        activeBorrowedAmount: activeBorrowedAmount,
                        netActivePosition: netActivePosition,
                        totalActiveLoans: activeLoans.length,
                      ),
                    ),

                  // View Complete History Button
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 24, 16, 48),
                      child: OutlinedButton.icon(
                        onPressed: _viewCompleteHistory,
                        icon: const Icon(Icons.history,
                            color: Color(0xFF64748B), size: 20), // text-slate-500
                        label: const Text(
                          'View Complete Loan History',
                          style: TextStyle(
                              color: Color(0xFF64748B),
                              fontWeight: FontWeight.w500), // text-slate-500
                        ),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50), // Full width
                          side: const BorderSide(
                              color: Color(0xFFE2E8F0)), // border-slate-200
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Bottom padding for FAB
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 100),
                  ),
                ],
              );
        },
      ),
      floatingActionButton: ExpandableFab(
        actions: [
          FabAction(
            label: 'Lend',
            icon: Icons.trending_up,
            backgroundColor: const Color(0xFF22C55E),
            onPressed: () => _navigateToLoanForm('L'),
          ),
          FabAction(
            label: 'Borrow',
            icon: Icons.trending_down,
            backgroundColor: const Color(0xFFEF4444),
            onPressed: () => _navigateToLoanForm('B'),
          ),
        ],
      ),
    );
  }


  void _handleShare() {
    // TODO: Implement share functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Share functionality coming soon')),
    );
  }

  void _filterLoans(String documentType) {
    // TODO: Implement loan filtering
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Filtering ${documentType == 'L' ? 'lent' : 'borrowed'} loans'),
      ),
    );
  }

  void _navigateToLoanDetail(LoanEntry loan) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LoanDetailMockupScreen(loan: loan),
      ),
    );
  }

  void _navigateToLoanForm(String documentType) {
    NavigationService.navigateTo(
      AppRoutes.loanForm,
      arguments: {
        'initialType': documentType,
        'contact': widget.contact,
      },
    );
  }

  void _viewCompleteHistory() {
    // TODO: Navigate to complete loan history screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Complete history view coming soon')),
    );
  }
}
