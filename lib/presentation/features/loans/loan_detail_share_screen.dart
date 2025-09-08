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
import '../../../domain/usecases/contact_usecases.dart';
import '../../core/atoms/app_app_bar.dart';
import '../../core/molecules/form_action_bar.dart';
import '../../core/molecules/loan_statement_card.dart';

class LoanDetailShareScreen extends StatefulWidget {
  final LoanEntry loan;

  const LoanDetailShareScreen({Key? key, required this.loan}) : super(key: key);

  @override
  State<LoanDetailShareScreen> createState() => _LoanDetailShareScreenState();
}

class _LoanDetailShareScreenState extends State<LoanDetailShareScreen> {
  final ScreenshotController _screenshotController = ScreenshotController();
  final ContactUseCases _contactUseCases = GetIt.I<ContactUseCases>();

  Contact? _contact;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      Contact? contact;
      contact = await _contactUseCases.getContactById(widget.loan.contactId);
      if (mounted) {
        setState(() {
          _contact = contact;
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
    final generationTimeFormat = DateFormat('MMM dd, yyyy \'at\' hh:mm a');

    final details = [
      'MoneyT - Loan Statement',
      '',
      widget.loan.description ?? 'Personal Loan',
      '',
      'Remaining Balance: ${currencyFormat.format(widget.loan.outstandingBalance)}',
      'of ${currencyFormat.format(widget.loan.amount)} original',
      'Payment Progress: ${(widget.loan.totalPaid / widget.loan.amount * 100).toStringAsFixed(0)}% Paid',
      '',
      'Loan Date: ${dateFormat.format(widget.loan.date)}',
      if (_contact != null) 'Contact: ${_contact!.name}',
      '',
      'Generated on ${generationTimeFormat.format(DateTime.now())}',
      'Powered by MoneyT • moneyt.io',
    ];

    return details.join('\n');
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: _buildShareText()));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Loan details copied to clipboard!')),
    );
  }

  Future<void> _shareAsImage() async {
    try {
      final Uint8List? image = await _screenshotController.capture();
      if (image == null) return;

      final directory = await getApplicationDocumentsDirectory();
      final imagePath =
          await File('${directory.path}/loan_statement.png').create();
      await imagePath.writeAsBytes(image);

      await Share.shareXFiles(
        [XFile(imagePath.path)],
        text: 'Here is my loan statement:',
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
        title: 'Share Loan',
        type: AppAppBarType.blur,
        onLeadingPressed: () => Navigator.of(context).pop(),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Screenshot(
                controller: _screenshotController,
                child: LoanStatementCard(
                  loanDescription: widget.loan.description ?? 'Personal Loan',
                  remainingBalance: widget.loan.outstandingBalance,
                  originalAmount: widget.loan.amount,
                  percentPaid: widget.loan.totalPaid / widget.loan.amount,
                  loanDate: widget.loan.date,
                  contactName: _contact?.name ?? 'N/A',
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
