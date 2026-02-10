import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:moneyt_pfm/domain/entities/category.dart';
import 'package:moneyt_pfm/domain/entities/contact.dart';
import 'package:moneyt_pfm/domain/entities/transaction_entry.dart';
import 'package:moneyt_pfm/domain/entities/wallet.dart';
import 'package:moneyt_pfm/domain/usecases/category_usecases.dart';
import 'package:moneyt_pfm/domain/usecases/contact_usecases.dart';
import 'package:moneyt_pfm/domain/usecases/wallet_usecases.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/atoms/app_app_bar.dart';
import '../../core/molecules/form_action_bar.dart';
import '../../core/molecules/transaction_receipt_card.dart';
import '../../core/l10n/generated/strings.g.dart';

class TransactionShareScreen extends StatefulWidget {
  final TransactionEntry transaction;

  const TransactionShareScreen({Key? key, required this.transaction})
      : super(key: key);

  @override
  State<TransactionShareScreen> createState() => _TransactionShareScreenState();
}

class _TransactionShareScreenState extends State<TransactionShareScreen> {
  final ScreenshotController _screenshotController = ScreenshotController();
  final CategoryUseCases _categoryUseCases = GetIt.I<CategoryUseCases>();
  final WalletUseCases _walletUseCases = GetIt.I<WalletUseCases>();
  final ContactUseCases _contactUseCases = GetIt.I<ContactUseCases>();

  final DateFormat _dateFormat = DateFormat('yMMMd');
  final DateFormat _timeFormat = DateFormat('HH:mm a');
  final NumberFormat _amountFormat =
      NumberFormat.currency(symbol: 'S/', decimalDigits: 2);

  Category? _category;
  Wallet? _wallet;
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
      Category? category;
      Wallet? wallet;
      Contact? contact;

      if (widget.transaction.mainCategoryId != null) {
        category = await _categoryUseCases
            .getCategoryById(widget.transaction.mainCategoryId!);
      }
      if (widget.transaction.mainWalletId != null) {
        wallet = await _walletUseCases
            .getWalletById(widget.transaction.mainWalletId!);
      }
      if (widget.transaction.contactId != null) {
        contact = await _contactUseCases
            .getContactById(widget.transaction.contactId!);
      }

      if (mounted) {
        setState(() {
          _category = category;
          _wallet = wallet;
          _contact = contact;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Error al cargar datos: ${e.toString()}'),
              backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _copyToClipboard() {
    final description = widget.transaction.description ?? '';
    final details = [
      t.transactions.share.receipt.title,
      t.transactions.share.receipt.amount(amount: _amountFormat.format(widget.transaction.amount)),
      if (description.isNotEmpty) t.transactions.share.receipt.description(description: description),
      if (_category != null) t.transactions.share.receipt.category(category: _category!.name),
      t.transactions.share.receipt.date(date: _dateFormat.format(widget.transaction.date)),
      t.transactions.share.receipt.time(time: _timeFormat.format(widget.transaction.date)),
      if (_wallet != null) t.transactions.share.receipt.wallet(wallet: _wallet!.name),
      if (_contact != null) t.transactions.share.receipt.contact(contact: _contact!.name),
      t.transactions.share.receipt.id(id: widget.transaction.id.toString()),
      t.transactions.share.receipt.separator,
    ];

    Clipboard.setData(ClipboardData(text: details.join('\n')));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(t.transactions.share.copied)),
    );
  }

  Future<void> _shareAsImage() async {
    try {
      final image = await _screenshotController.capture();
      if (image == null) return;

      final directory = await getApplicationDocumentsDirectory();
      final imagePath =
          await File('${directory.path}/transaction.png').create();
      await imagePath.writeAsBytes(image);

      await Share.shareXFiles([XFile(imagePath.path)],
          text: t.transactions.share.shareMessage);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t.transactions.share.errorImage(error: e.toString()))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // slate-50
      appBar: AppAppBar(
        title: t.transactions.share.title,
        type: AppAppBarType.blur,
        onLeadingPressed: () => Navigator.of(context).pop(),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Screenshot(
                controller: _screenshotController,
                child: TransactionReceiptCard(
                  transaction: widget.transaction,
                  category: _category,
                  wallet: _wallet,
                  contact: _contact,
                ),
              ),
            ),
      bottomNavigationBar: FormActionBar(
        onCancel: _copyToClipboard,
        onSave: _shareAsImage,
        cancelText: t.transactions.share.copyText,
        saveText: t.transactions.share.shareButton,
      ),
    );
  }
}
