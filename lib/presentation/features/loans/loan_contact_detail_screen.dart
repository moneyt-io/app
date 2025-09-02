import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/contact.dart';
import '../../../domain/entities/loan_entry.dart';
import '../../core/atoms/app_app_bar.dart';
import 'loan_provider.dart';
import 'widgets/contact_summary_card.dart';
import 'widgets/loan_summary_grid_card.dart';
import 'widgets/detailed_loan_card.dart';
import 'widgets/loan_stats_summary_card.dart';
import 'loan_form_screen.dart';
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
  bool _fabExpanded = false;

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

          return Stack(
            children: [
              CustomScrollView(
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
                      padding: const EdgeInsets.all(16),
                      child: OutlinedButton(
                        onPressed: _viewCompleteHistory,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                          side: const BorderSide(
                            color: Color(0xFFE2E8F0), // border-slate-200
                          ),
                          backgroundColor: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.history,
                              color: Color(0xFF64748B), // text-slate-600
                            ),
                            const SizedBox(width: 12),
                            const Column(
                              children: [
                                Text(
                                  'View Complete History',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF64748B), // text-slate-600
                                  ),
                                ),
                                Text(
                                  'See all loans and detailed summary',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF64748B), // text-slate-500
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 12),
                            const Icon(
                              Icons.chevron_right,
                              color: Color(0xFF64748B), // text-slate-600
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Bottom padding for FAB
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 100),
                  ),
                ],
              ),

              // FAB with Expandable Actions
              _buildExpandableFAB(),

              // Overlay for FAB Actions
              if (_fabExpanded)
                GestureDetector(
                  onTap: _closeFabActions,
                  child: Container(
                    color: Colors.black.withOpacity(0.2),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildExpandableFAB() {
    return Positioned(
      bottom: 24,
      right: 24,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Action Buttons
          if (_fabExpanded) ...[
            // Lend Money Action
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Lend Money',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                FloatingActionButton(
                  heroTag: 'lend',
                  onPressed: () => _navigateToLoanForm('L'),
                  backgroundColor: const Color(0xFFF97316), // bg-orange-500
                  child: const Icon(Icons.call_made, color: Colors.white),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Borrow Money Action
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Borrow Money',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                FloatingActionButton(
                  heroTag: 'borrow',
                  onPressed: () => _navigateToLoanForm('B'),
                  backgroundColor: const Color(0xFF8B5CF6), // bg-purple-500
                  child: const Icon(Icons.call_received, color: Colors.white),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
          ],

          // Main FAB
          FloatingActionButton(
            heroTag: 'main',
            onPressed: _toggleFabActions,
            backgroundColor: const Color(0xFF0C7FF2), // bg-blue-600
            child: AnimatedRotation(
              turns: _fabExpanded ? 0.125 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: Icon(
                _fabExpanded ? Icons.close : Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _toggleFabActions() {
    setState(() {
      _fabExpanded = !_fabExpanded;
    });
  }

  void _closeFabActions() {
    setState(() {
      _fabExpanded = false;
    });
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
    _closeFabActions();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LoanFormScreen(),
      ),
    );
  }

  void _viewCompleteHistory() {
    // TODO: Navigate to complete loan history screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Complete history view coming soon')),
    );
  }
}
