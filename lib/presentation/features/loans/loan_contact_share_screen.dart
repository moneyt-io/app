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
import '../../core/l10n/generated/strings.g.dart';
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
    final locale = TranslationProvider.of(context).flutterLocale.languageCode;
    final currencyFormat =
        NumberFormat.currency(locale: locale, symbol: '\$', decimalDigits: 2);
    final dateFormat = DateFormat.yMMMd(locale);

    final netStatus = _netBalance >= 0
        ? t.loans.share.owed
        : t.loans.share.owe;

    final details = [
      t.loans.share.loanSummary,
      '',
      t.loans.share.contactSummary(name: widget.contact.name),
      '',
      t.loans.share.netBalance(
          amount:
              "${_netBalance >= 0 ? "+" : ""}${currencyFormat.format(_netBalance)}",
          status: netStatus),
      '',
      t.loans.share.lent(amount: currencyFormat.format(_totalLent)),
      t.loans.share.borrowed(amount: currencyFormat.format(_totalBorrowed)),
      '',
      t.loans.share.activeLoans(n: _activeLoans.length),
      ..._activeLoans.map((loan) {
        final percentPaid = (loan.totalPaid / loan.amount * 100).clamp(0, 100);
        return t.loans.share.loanItem(
            description: loan.description ?? t.loans.share.personalLoan,
            amount: currencyFormat.format(loan.amount),
            date: dateFormat.format(loan.date),
            percent: percentPaid.toStringAsFixed(0));
      }),
      '',
      t.loans.share.generated(date: dateFormat.format(DateTime.now())),
      t.loans.share.poweredBy,
    ];

    return details.join('\n');
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: _buildShareText()));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(t.loans.share.contactCopied)),
    );
  }

  Future<void> _shareAsImage() async {
    try {
      if (!mounted) return;

      final Uint8List? image =
          await _screenshotController.capture(pixelRatio: 3.0);
      if (image == null) {
        throw Exception('Could not capture image');
      }

      final directory = await getTemporaryDirectory();
      final imagePath = await File(
              '${directory.path}/contact_loan_summary_${DateTime.now().millisecondsSinceEpoch}.png')
          .create();
      await imagePath.writeAsBytes(image);

      if (!mounted) return;

      final box = context.findRenderObject() as RenderBox?;

      await Share.shareXFiles(
        [XFile(imagePath.path)],
        text: t.loans.share.contactMessage(name: widget.contact.name),
        sharePositionOrigin: box != null
            ? box.localToGlobal(Offset.zero) & box.size
            : null,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(t.loans.share.error(error: e.toString()))),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // slate-50
      appBar: AppAppBar(
        title: t.loans.share.contactTitle,
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
        cancelText: t.loans.share.copy,
        saveText: t.loans.share.button,
      ),
    );
  }
}
