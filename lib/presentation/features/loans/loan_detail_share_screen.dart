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
import '../../core/l10n/generated/strings.g.dart';
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
    final locale = TranslationProvider.of(context).flutterLocale.languageCode;
    final currencyFormat =
        NumberFormat.currency(locale: locale, symbol: '\$', decimalDigits: 2);
    final dateFormat = DateFormat.yMMMd(locale);
    final generationTimeFormat = DateFormat.yMMMd(locale).add_jm();

    final details = [
      t.loans.share.loanStatement,
      '',
      widget.loan.description ?? t.loans.share.personalLoan,
      '',
      t.loans.share.remaining(
          amount: currencyFormat.format(widget.loan.outstandingBalance)),
      t.loans.share
          .original(amount: currencyFormat.format(widget.loan.amount)),
      t.loans.share.progress(
          percent: (widget.loan.totalPaid / widget.loan.amount * 100)
              .toStringAsFixed(0)),
      '',
      t.loans.share.date(date: dateFormat.format(widget.loan.date)),
      if (_contact != null) t.loans.share.contact(name: _contact!.name),
      '',
      t.loans.share.generated(
          date: generationTimeFormat.format(DateTime.now())),
      t.loans.share.poweredBy,
    ];

    return details.join('\n');
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: _buildShareText()));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(t.loans.share.copied)),
    );
  }

  Future<void> _shareAsImage() async {
    try {
      if (!mounted) return;
      
      // Capture the screenshot
      final Uint8List? image =
          await _screenshotController.capture(pixelRatio: 3.0);
      
      if (image == null) {
        throw Exception('Could not capture image');
      }

      final directory = await getTemporaryDirectory();
      final imagePath = await File(
              '${directory.path}/loan_statement_${DateTime.now().millisecondsSinceEpoch}.png')
          .create();
      await imagePath.writeAsBytes(image);

      if (!mounted) return;

      final box = context.findRenderObject() as RenderBox?;

      await Share.shareXFiles(
        [XFile(imagePath.path)],
        text: t.loans.share.message,
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
        title: t.loans.share.title,
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
        cancelText: t.loans.share.copy,
        saveText: t.loans.share.button,
      ),
    );
  }
}
