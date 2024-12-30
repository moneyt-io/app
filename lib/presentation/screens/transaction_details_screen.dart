import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import '../../core/l10n/language_manager.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/account.dart';
import '../../domain/usecases/account_usecases.dart';
import '../../domain/usecases/category_usecases.dart';
import '../../domain/usecases/transaction_usecases.dart';
import '../../routes/app_routes.dart';

class TransactionDetailsScreen extends StatelessWidget {
  final TransactionEntity transaction;
  final ScreenshotController _screenshotController = ScreenshotController();

  TransactionDetailsScreen({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  Future<void> _shareScreenshot() async {
    final image = await _screenshotController.capture();
    if (image == null) return;

    final directory = await getApplicationDocumentsDirectory();
    final imagePath = '${directory.path}/transaction_${transaction.id}.png';
    final imageFile = File(imagePath);
    await imageFile.writeAsBytes(image);

    await Share.shareXFiles(
      [XFile(imagePath)],
      text: 'Transaction Details',
    );
  }

  Future<void> _deleteTransaction(BuildContext context) async {
    final translations = Provider.of<LanguageManager>(context, listen: false).translations;
    final transactionUseCases = Provider.of<TransactionUseCases>(context, listen: false);

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(translations.deleteConfirmation),
        content: Text(translations.deleteTransactionConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(translations.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: Text(translations.delete),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await transactionUseCases.deleteTransaction(transaction.id!);
      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }

  void _editTransaction(BuildContext context) {
    Navigator.pushNamed(
      context,
      AppRoutes.transactionForm,
      arguments: {
        'type': transaction.type,
        'transaction': transaction,
      },
    );
  }

  Color _getTypeColor() {
    switch (transaction.type) {
      case 'I':
        return Colors.green;
      case 'E':
        return Colors.red;
      case 'T':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  IconData _getTypeIcon() {
    switch (transaction.type) {
      case 'I':
        return Icons.arrow_upward;
      case 'E':
        return Icons.arrow_downward;
      case 'T':
        return Icons.swap_horiz;
      default:
        return Icons.attach_money;
    }
  }

  String _getTypeText(BuildContext context) {
    final translations = Provider.of<LanguageManager>(context).translations;
    switch (transaction.type) {
      case 'I':
        return translations.filterIncome;
      case 'E':
        return translations.filterExpense;
      case 'T':
        return translations.filterTransfer;
      default:
        return '';
    }
  }

  Widget _buildDetailItem({
    required BuildContext context,
    required String label,
    required Widget content,
    IconData? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 24,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
            ),
            const SizedBox(width: 16),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                const SizedBox(height: 4),
                DefaultTextStyle(
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                  child: content,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final translations = Provider.of<LanguageManager>(context).translations;
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');
    final color = _getTypeColor();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(translations.transactionDetails),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: _shareScreenshot,
            tooltip: translations.share,
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _editTransaction(context),
            tooltip: translations.edit,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _deleteTransaction(context),
            tooltip: translations.delete,
          ),
        ],
      ),
      body: Screenshot(
        controller: _screenshotController,
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Header with type and amount
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 32,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        color.withOpacity(0.2),
                        color.withOpacity(0.05),
                      ],
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _getTypeIcon(),
                          size: 48,
                          color: color,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _getTypeText(context),
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: color,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '\$${transaction.amount.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                              color: color,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
                // Transaction details
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        color: colorScheme.outline.withOpacity(0.2),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (transaction.description?.isNotEmpty ?? false)
                            _buildDetailItem(
                              context: context,
                              label: translations.descriptionDetails,
                              icon: Icons.description_outlined,
                              content: Text(transaction.description ?? ''),
                            ),
                          _buildDetailItem(
                            context: context,
                            label: translations.dateDetails,
                            icon: Icons.calendar_today_outlined,
                            content: Text(
                              dateFormat.format(transaction.transactionDate),
                            ),
                          ),
                          if (transaction.categoryId != null)
                            _buildDetailItem(
                              context: context,
                              label: translations.categoryDetails,
                              icon: Icons.category_outlined,
                              content: StreamBuilder<List<CategoryEntity>>(
                                stream: Provider.of<GetCategories>(context).call(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    final categories = snapshot.data!;
                                    final categoryName = categories
                                        .where((c) => c.id == transaction.categoryId)
                                        .map((c) => c.name)
                                        .firstOrNull ?? translations.notFound;
                                    return Text(categoryName);
                                  }
                                  return const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  );
                                },
                              ),
                            ),
                          _buildDetailItem(
                            context: context,
                            label: translations.accountDetails,
                            icon: Icons.account_balance_outlined,
                            content: StreamBuilder<List<AccountEntity>>(
                              stream: Provider.of<GetAccounts>(context).call(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final accounts = snapshot.data!;
                                  final accountName = accounts
                                      .where((a) => a.id == transaction.accountId)
                                      .map((a) => a.name)
                                      .firstOrNull ?? translations.notFound;
                                  return Text(accountName);
                                }
                                return const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                );
                              },
                            ),
                          ),
                          if (transaction.contact?.isNotEmpty ?? false)
                            _buildDetailItem(
                              context: context,
                              label: translations.contactDetails,
                              icon: Icons.person_outline,
                              content: Text(transaction.contact ?? ''),
                            ),
                          if (transaction.reference?.isNotEmpty ?? false)
                            _buildDetailItem(
                              context: context,
                              label: translations.referenceDetails,
                              icon: Icons.tag_outlined,
                              content: Text(transaction.reference ?? ''),
                            ),
                          if (transaction.type == 'T')
                            _buildDetailItem(
                              context: context,
                              label: '${translations.accountDetails} 2',
                              icon: Icons.account_balance_outlined,
                              content: StreamBuilder<List<AccountEntity>>(
                                stream: Provider.of<GetAccounts>(context).call(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    // TODO: Agregar accountId2 a la entidad de transacción
                                    return Text('-');
                                  }
                                  return const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  );
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
