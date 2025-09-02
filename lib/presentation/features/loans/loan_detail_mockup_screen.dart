import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';

import '../../../domain/entities/loan_entry.dart';
import '../../../domain/entities/contact.dart';
import '../../../domain/usecases/contact_usecases.dart';
import '../../core/atoms/app_app_bar.dart';
import 'loan_provider.dart';
import 'loan_payment_form_screen.dart';
import 'widgets/loan_detail_summary_card.dart';
import 'widgets/loan_progress_card.dart';
import 'widgets/loan_payment_info_card.dart';
import 'widgets/loan_lender_info_card.dart';
import 'widgets/loan_details_info_card.dart';

class LoanDetailMockupScreen extends StatefulWidget {
  final LoanEntry loan;

  const LoanDetailMockupScreen({
    Key? key,
    required this.loan,
  }) : super(key: key);

  @override
  State<LoanDetailMockupScreen> createState() => _LoanDetailMockupScreenState();
}

class _LoanDetailMockupScreenState extends State<LoanDetailMockupScreen> {
  final _contactUseCases = GetIt.instance<ContactUseCases>();

  Contact? _contact;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRelatedData();
  }

  Future<void> _loadRelatedData() async {
    setState(() => _isLoading = true);

    try {
      if (widget.loan.contactId > 0) {
        _contact = await _contactUseCases.getContactById(widget.loan.contactId);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al cargar datos: ${e.toString()}'),
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

  Future<void> _navigateToEdit() async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LoanPaymentFormScreen(loan: widget.loan),
      ),
    );
  }

  Future<void> _shareLoan() async {
    // TODO: Implement share functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Share functionality coming soon')),
    );
  }

  Future<void> _makePayment() async {
    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (context) => LoanPaymentFormScreen(loan: widget.loan),
      ),
    );

    if (result == true && mounted) {
      // Refresh loan data after successful payment
      await context.read<LoanProvider>().loadLoans();
    }
  }

  Future<void> _deleteLoan() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Loan'),
        content: const Text('Are you sure you want to delete this loan? This action cannot be undone.'),
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
        await context.read<LoanProvider>().deleteLoan(widget.loan.id);
        
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
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // bg-slate-50
      appBar: AppAppBar(
        title: 'Loan Details',
        type: AppAppBarType.blur,
        leading: AppAppBarLeading.back,
        customActions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: _shareLoan,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: EdgeInsets.zero,
              children: [
                // Loan Summary Card
                LoanDetailSummaryCard(loan: widget.loan),
                
                // Progress Card
                LoanProgressCard(loan: widget.loan),
                
                // Quick Actions
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      _buildActionChip(
                        label: 'Edit',
                        icon: Icons.edit,
                        onTap: _navigateToEdit,
                        backgroundColor: const Color(0xFFDBEAFE), // blue-100
                        textColor: const Color(0xFF2563EB), // blue-600
                        iconColor: const Color(0xFF2563EB), // blue-600
                      ),
                      const SizedBox(width: 8),
                      _buildActionChip(
                        label: 'Pay',
                        icon: Icons.payment,
                        onTap: _makePayment,
                        backgroundColor: const Color(0xFFDCFCE7), // green-100
                        textColor: const Color(0xFF16A34A), // green-600
                        iconColor: const Color(0xFF16A34A), // green-600
                      ),
                    ],
                  ),
                ),
                
                // Payment Information
                LoanPaymentInfoCard(loan: widget.loan),
                
                // Lender Information
                LoanLenderInfoCard(lender: _contact),
                
                // Loan Details
                LoanDetailsInfoCard(loan: widget.loan),
                
                // Delete Button
                _buildDeleteButton(),
                
                const SizedBox(height: 32),
              ],
            ),
    );
  }

  Widget _buildQuickActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          _buildActionChip(
            label: 'Edit',
            icon: Icons.edit,
            onTap: _navigateToEdit,
            backgroundColor: const Color(0xFFDBEAFE), // blue-100
            textColor: const Color(0xFF2563EB), // blue-600
            iconColor: const Color(0xFF2563EB), // blue-600
          ),
          const SizedBox(width: 8),
          _buildActionChip(
            label: 'Pay',
            icon: Icons.payment,
            onTap: _makePayment,
            backgroundColor: const Color(0xFFDCFCE7), // green-100
            textColor: const Color(0xFF16A34A), // green-600
            iconColor: const Color(0xFF16A34A), // green-600
          ),
        ],
      ),
    );
  }

  Widget _buildDeleteButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: TextButton.icon(
        icon: const Icon(Icons.delete_outline),
        label: const Text('Delete Loan'),
        onPressed: _deleteLoan,
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFFDC2626), // text-red-600
          backgroundColor: const Color(0xFFFEF2F2), // bg-red-50
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildActionChip({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
    required Color backgroundColor,
    required Color textColor,
    required Color iconColor,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: iconColor, size: 16),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  color: textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
