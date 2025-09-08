import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import 'package:collection/collection.dart';

import '../../../domain/entities/loan_entry.dart';
import '../../../domain/entities/contact.dart';
import '../../../domain/usecases/contact_usecases.dart';
import '../../core/atoms/app_app_bar.dart';
import 'loan_provider.dart';
import 'loan_payment_form_screen.dart';
import 'widgets/loan_detail_summary_card.dart';
import 'widgets/loan_progress_card.dart';
import 'widgets/loan_lender_info_card.dart';
import 'widgets/loan_details_info_card.dart';
import 'widgets/loan_payment_history_card.dart';
import '../../navigation/app_routes.dart';
import '../../navigation/navigation_service.dart';

class LoanDetailScreen extends StatefulWidget {
  final int loanId;

  const LoanDetailScreen({
    Key? key,
    required this.loanId,
  }) : super(key: key);

  @override
  State<LoanDetailScreen> createState() => _LoanDetailScreenState();
}

class _LoanDetailScreenState extends State<LoanDetailScreen> {
  Future<void> _navigateToEdit(LoanEntry loan) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Próximamente'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> _shareLoan(LoanEntry loan) async {
    NavigationService.navigateTo(
      AppRoutes.loanDetailShare,
      arguments: loan,
    );
  }

  Future<void> _makePayment(LoanEntry loan) async {
    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (context) => LoanPaymentFormScreen(loan: loan),
      ),
    );

    if (result == true && mounted) {
      await context.read<LoanProvider>().loadLoans();
    }
  }

  Future<void> _deleteLoan(LoanEntry loan) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Loan'),
        content: const Text(
            'Are you sure you want to delete this loan? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await context.read<LoanProvider>().deleteLoan(loan.id);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Loan deleted successfully')),
          );
          Navigator.of(context).pop();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error deleting loan: ${e.toString()}')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LoanProvider>();
    final loan = provider.loans.firstWhereOrNull((l) => l.id == widget.loanId);

    if (provider.isLoading) {
      return Scaffold(
        appBar: AppAppBar(title: 'Loading...'),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (loan == null) {
      return Scaffold(
        appBar: AppAppBar(title: 'Error'),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              const Text('Loan not found'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.read<LoanProvider>().loadLoans(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // bg-slate-50
      appBar: AppAppBar(
        title: 'Loan Details',
        type: AppAppBarType.blur,
        leading: AppAppBarLeading.back,
        customActions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _shareLoan(loan),
          ),
        ],
      ),
      body: _LoanDetailContent(loan: loan, onAction: _handleAction),
    );
  }

  void _handleAction(String action, LoanEntry loan) {
    switch (action) {
      case 'edit':
        _navigateToEdit(loan);
        break;
      case 'pay':
        _makePayment(loan);
        break;
      case 'delete':
        _deleteLoan(loan);
        break;
    }
  }
}

class _LoanDetailContent extends StatefulWidget {
  final LoanEntry loan;
  final void Function(String, LoanEntry) onAction;

  const _LoanDetailContent({required this.loan, required this.onAction});

  @override
  State<_LoanDetailContent> createState() => _LoanDetailContentState();
}

class _LoanDetailContentState extends State<_LoanDetailContent> {
  final _contactUseCases = GetIt.instance<ContactUseCases>();
  Contact? _contact;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRelatedData();
  }

  @override
  void didUpdateWidget(covariant _LoanDetailContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.loan.contactId != widget.loan.contactId) {
      _loadRelatedData();
    }
  }

  Future<void> _loadRelatedData() async {
    setState(() => _isLoading = true);
    try {
      if (widget.loan.contactId > 0) {
        final contact =
            await _contactUseCases.getContactById(widget.loan.contactId);
        if (mounted) {
          setState(() {
            _contact = contact;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading contact: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        LoanDetailSummaryCard(loan: widget.loan),
        LoanProgressCard(loan: widget.loan),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              _buildActionChip(
                label: 'Edit',
                icon: Icons.edit,
                onTap: () => widget.onAction('edit', widget.loan),
              ),
              const SizedBox(width: 8),
              _buildActionChip(
                label: 'Pay',
                icon: Icons.payment,
                onTap: () => widget.onAction('pay', widget.loan),
              ),
            ],
          ),
        ),
        if (_isLoading)
          const Center(
              child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator()))
        else
          LoanLenderInfoCard(lender: _contact),
        if (widget.loan.details.length > 1)
          LoanPaymentHistoryCard(payments: widget.loan.details.sublist(1)),
        LoanDetailsInfoCard(loan: widget.loan),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: TextButton.icon(
            icon: const Icon(Icons.delete_outline),
            label: const Text('Delete Loan'),
            onPressed: () => widget.onAction('delete', widget.loan),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFFDC2626),
              backgroundColor: const Color(0xFFFEF2F2),
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildActionChip({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    final isEdit = label == 'Edit';
    final backgroundColor =
        isEdit ? const Color(0xFFDBEAFE) : const Color(0xFFDCFCE7);
    final textColor =
        isEdit ? const Color(0xFF2563EB) : const Color(0xFF16A34A);

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: textColor, size: 16),
              const SizedBox(width: 4),
              Text(label,
                  style: TextStyle(
                      color: textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }
}
