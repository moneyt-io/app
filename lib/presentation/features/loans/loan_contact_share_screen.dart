import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../../domain/entities/contact.dart';
import '../../../domain/entities/loan_entry.dart';
import '../../../domain/usecases/loan_usecases.dart';
import '../../core/atoms/app_app_bar.dart';
import '../../core/molecules/form_action_bar.dart';
import '../../core/molecules/contact_loan_summary_card.dart';

class LoanContactShareScreen extends StatefulWidget {
  final Contact contact;

  const LoanContactShareScreen({Key? key, required this.contact})
      : super(key: key);

  @override
  State<LoanContactShareScreen> createState() => _LoanContactShareScreenState();
}

class _LoanContactShareScreenState extends State<LoanContactShareScreen> {
  final ScreenshotController _screenshotController = ScreenshotController();
  final LoanUseCases _loanUseCases = GetIt.I<LoanUseCases>();

  List<LoanEntry> _activeLoans = [];
  double _netBalance = 0;
  double _totalLent = 0;
  double _totalBorrowed = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      final allLoans = await _loanUseCases.getLoansByContact(widget.contact.id);
      final activeLoans =
          allLoans.where((l) => l.status == LoanStatus.active).toList();

      double totalLent = 0;
      double totalBorrowed = 0;

      for (var loan in activeLoans) {
        if (loan.documentTypeId == 'L') {
          totalLent += loan.outstandingBalance;
        } else {
          totalBorrowed += loan.outstandingBalance;
        }
      }

      if (mounted) {
        setState(() {
          _activeLoans = activeLoans;
          _totalLent = totalLent;
          _totalBorrowed = totalBorrowed;
          _netBalance = totalLent - totalBorrowed;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Error loading data: ${e.toString()}'),
              backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  String _buildShareText() {
    final currencyFormat =
        NumberFormat.currency(locale: 'en_US', symbol: '\$', decimalDigits: 2);
    final dateFormat = DateFormat('MMM dd, yyyy');

    final details = [
      'MoneyT - Loan Summary',
      '',
      '${widget.contact.name} - Loan Summary',
      '',
      'Net Balance: ${_netBalance >= 0 ? "+" : ""}${currencyFormat.format(_netBalance)} (${_netBalance >= 0 ? "You are owed" : "You owe"})',
      '',
      'You Lent: ${currencyFormat.format(_totalLent)}',
      'You Borrowed: ${currencyFormat.format(_totalBorrowed)}',
      '',
      'Active Loans (${_activeLoans.length}):',
      ..._activeLoans.map((loan) {
        final percentPaid = (loan.totalPaid / loan.amount * 100).clamp(0, 100);
        return '• ${loan.description ?? 'Loan'}: ${currencyFormat.format(loan.amount)} (Date: ${dateFormat.format(loan.date)}) - ${percentPaid.toStringAsFixed(0)}% paid';
      }),
      '',
      'Generated on ${dateFormat.format(DateTime.now())}',
      'Powered by MoneyT • moneyt.io',
    ];

    return details.join('\n');
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: _buildShareText()));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Loan summary copied to clipboard!')),
    );
  }

  Future<void> _shareAsImage() async {
    try {
      final Uint8List? image = await _screenshotController.capture();
      if (image == null) return;

      final directory = await getApplicationDocumentsDirectory();
      final imagePath =
          await File('${directory.path}/contact_loan_summary.png').create();
      await imagePath.writeAsBytes(image);

      await Share.shareXFiles(
        [XFile(imagePath.path)],
        text: 'Loan Summary with ${widget.contact.name}:',
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error sharing image: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // slate-50
      appBar: AppAppBar(
        title: 'Share Contact Loans',
        type: AppAppBarType.blur,
        onLeadingPressed: () => Navigator.of(context).pop(),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Screenshot(
                controller: _screenshotController,
                child: ContactLoanSummaryCard(
                  contact: widget.contact,
                  activeLoans: _activeLoans,
                  netBalance: _netBalance,
                  totalLent: _totalLent,
                  totalBorrowed: _totalBorrowed,
                  generationDate: DateTime.now(),
                ),
              ),
            ),
      bottomNavigationBar: FormActionBar(
        onCancel: _copyToClipboard,
        onSave: _shareAsImage,
        cancelText: 'Copy Text',
        saveText: 'Share',
      ),
    );
  }
}
