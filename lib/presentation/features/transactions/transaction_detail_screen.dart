import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui';

import '../../../domain/entities/category.dart';
import '../../../domain/entities/contact.dart';
import '../../../domain/entities/transaction.dart';
import '../../../domain/entities/transaction_entry.dart';
import '../../../domain/entities/wallet.dart';
import '../../../domain/usecases/category_usecases.dart';
import '../../../domain/usecases/contact_usecases.dart';
import '../../../domain/usecases/transaction_usecases.dart';
import '../../../domain/usecases/wallet_usecases.dart';
import '../../core/atoms/app_app_bar.dart';
import '../../core/atoms/detail_action_chip.dart';
import '../../core/molecules/info_card.dart';
import '../../core/molecules/info_row.dart';
import '../../navigation/app_routes.dart';
import '../../navigation/navigation_service.dart';
import 'transaction_provider.dart';
import 'transaction_share_screen.dart';

class TransactionDetailScreen extends StatefulWidget {
  final TransactionEntry transaction;

  const TransactionDetailScreen({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  @override
  State<TransactionDetailScreen> createState() =>
      _TransactionDetailScreenState();
}

class _TransactionDetailScreenState extends State<TransactionDetailScreen> {
  final _categoryUseCases = GetIt.instance<CategoryUseCases>();
  final _walletUseCases = GetIt.instance<WalletUseCases>();
  final _contactUseCases = GetIt.instance<ContactUseCases>();
  final _transactionUseCases = GetIt.instance<TransactionUseCases>();

  Category? _category;
  Wallet? _wallet;
  Wallet? _targetWallet;
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
      final transaction = widget.transaction;
      final mainDetail = transaction.mainDetail;

      if (mainDetail != null &&
          !transaction.isTransfer &&
          mainDetail.categoryId > 0) {
        _category =
            await _categoryUseCases.getCategoryById(mainDetail.categoryId);
      }

      if (mainDetail != null && mainDetail.paymentId > 0) {
        _wallet = await _walletUseCases.getWalletById(mainDetail.paymentId);
      }

      if (transaction.isTransfer &&
          transaction.targetDetail?.paymentId != null) {
        _targetWallet = await _walletUseCases
            .getWalletById(transaction.targetDetail!.paymentId);
      }

      if (transaction.contactId != null) {
        _contact =
            await _contactUseCases.getContactById(transaction.contactId!);
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

  Future<void> _navigateToEdit() async {
    // Set loading state to give user feedback
    setState(() => _isLoading = true);

    try {
      // 1. Fetch the full TransactionEntity using its ID
      final TransactionEntity? transactionEntity = await _transactionUseCases
          .getTransactionEntityById(widget.transaction.id);

      if (!mounted) return;

      // Handle case where transaction is not found
      if (transactionEntity == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  'Error: No se pudieron cargar los detalles de la transacción.'),
              backgroundColor: Colors.red),
        );
        return;
      }

      // 2. Navigate to the form with the correct entity and argument keys
      // No need to await a result, as the provider will handle UI updates.
      NavigationService.navigateTo(
        AppRoutes.transactionForm,
        arguments: {
          'transaction': transactionEntity, // This is now a TransactionEntity
          'initialType': transactionEntity.type, // Correct key
        },
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Error al preparar la edición: ${e.toString()}'),
              backgroundColor: Colors.red),
        );
      }
    } finally {
      // Unset loading state
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _shareTransaction(TransactionEntry transaction) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TransactionShareScreen(transaction: transaction),
      ),
    );
  }

  Future<void> _duplicateTransaction() async {
    // Lógica para duplicar - Placeholder
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Duplicar no implementado')));
  }

  Future<void> _deleteTransaction() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Transacción'),
        content: const Text('¿Estás seguro? Esta acción no se puede deshacer.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancelar')),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        // Use the provider to delete the transaction and notify listeners
        await context
            .read<TransactionProvider>()
            .deleteTransaction(widget.transaction.id);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Transacción eliminada')),
          );
          // Go back without returning a value, UI will update via provider
          NavigationService.goBack();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al eliminar: ${e.toString()}')),
          );
        }
      }
    }
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('No se pudo abrir $url')));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Watch the provider to get the latest transaction data.
    final provider = context.watch<TransactionProvider>();
    // Find the most up-to-date version of the transaction.
    final transaction = provider.transactions.firstWhere(
      (t) => t.id == widget.transaction.id,
      orElse: () =>
          widget.transaction, // Fallback to the initial data if not found
    );

    // When the transaction data changes, we might need to re-fetch related data
    // if it's not already loaded or if critical IDs have changed.
    // This is a simple check; more complex logic could be added if needed.
    if (transaction.mainCategoryId != null &&
        transaction.mainCategoryId! > 0 &&
        transaction.mainCategoryId != _category?.id) {
      _categoryUseCases
          .getCategoryById(transaction.mainCategoryId!)
          .then((cat) {
        if (mounted) setState(() => _category = cat);
      });
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // slate-50
      appBar: AppAppBar(
        title: 'Transaction Details',
        type: AppAppBarType.blur,
        leading: AppAppBarLeading.back,
        onLeadingPressed: () => NavigationService.goBack(),
        customActions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _shareTransaction(transaction),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildSummaryCard(transaction),
                _buildQuickActions(),
                if (_category != null) _buildCategoryInfo(),
                _buildAccountInfo(transaction),
                if (_contact != null) _buildContactInfo(),
                if (transaction.description?.isNotEmpty ?? false)
                  _buildDescriptionInfo(transaction),
                _buildDeleteButton(),
                const SizedBox(height: 32),
              ],
            ),
    );
  }

  Widget _buildSummaryCard(TransactionEntry transaction) {
    final isIncome = transaction.documentTypeId == 'I';
    final amountPrefix = isIncome ? '+' : (transaction.isTransfer ? '' : '-');

    final Map<String, dynamic> typeStyles = {
          'I': {
            'colors': [const Color(0xFF22C55E), const Color(0xFF16A34A)],
            'icon': Icons.trending_up
          },
          'E': {
            'colors': [const Color(0xFFEF4444), const Color(0xFFDC2626)],
            'icon': Icons.trending_down
          },
          'T': {
            'colors': [const Color(0xFF3B82F6), const Color(0xFF2563EB)],
            'icon': Icons.swap_horiz
          },
        }[transaction.documentTypeId] ??
        {
          'colors': [Colors.grey, Colors.grey],
          'icon': Icons.receipt
        };

    final amount = NumberFormat.currency(locale: 'es_MX', symbol: r'$')
        .format(transaction.amount);

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: typeStyles['colors'],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle),
                child: Icon(typeStyles['icon'], color: Colors.white, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$amountPrefix$amount',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold)),
                    if (transaction.description?.isNotEmpty ?? false)
                      Text(transaction.description!,
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 16),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: Colors.white24),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  DateFormat('MMMM d, yyyy • h:mm a', 'es_MX')
                      .format(transaction.date),
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.8), fontSize: 12)),
              Text('#TXN-${transaction.id.toString().padLeft(6, '0')}',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.8), fontSize: 12)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
              child: DetailActionChip(
                  icon: Icons.edit, label: 'Edit', onTap: _navigateToEdit)),
          const SizedBox(width: 12),
          Expanded(
              child: DetailActionChip(
                  icon: Icons.content_copy,
                  label: 'Duplicate',
                  onTap: _duplicateTransaction)),
        ],
      ),
    );
  }

  Widget _buildCategoryInfo() {
    return InfoCard(
      title: 'Category',
      child: InfoRow(
        icon: Icons.work_outline, // Placeholder icon
        iconBackgroundColor: const Color(0xFFDBEAFE), // blue-100
        iconColor: const Color(0xFF2563EB), // blue-600
        title: _category!.name,
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _category!.documentTypeId == 'I'
                ? const Color(0xFFDCFCE7)
                : const Color(0xFFFEE2E2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            _category!.documentTypeId == 'I' ? 'Income' : 'Expense',
            style: TextStyle(
                color: _category!.documentTypeId == 'I'
                    ? const Color(0xFF16A34A)
                    : const Color(0xFFDC2626),
                fontSize: 12,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  Widget _buildAccountInfo(TransactionEntry transaction) {
    final isTransfer = transaction.isTransfer;
    if (isTransfer) {
      return InfoCard(
        title: 'Transfer Details',
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          children: [
            InfoRow(
                icon: Icons.north_east,
                iconBackgroundColor: const Color(0xFFFEE2E2),
                iconColor: const Color(0xFFDC2626),
                title: _wallet?.name ?? 'Unknown Account',
                subtitle: 'From'),
            const Divider(height: 1, indent: 56, endIndent: 16),
            InfoRow(
                icon: Icons.south_west,
                iconBackgroundColor: const Color(0xFFDCFCE7),
                iconColor: const Color(0xFF16A34A),
                title: _targetWallet?.name ?? 'Unknown Account',
                subtitle: 'To'),
          ],
        ),
      );
    }
    return InfoCard(
      title: 'Account',
      child: InfoRow(
        icon: Icons.account_balance_wallet_outlined,
        iconBackgroundColor: const Color(0xFFDBEAFE),
        iconColor: const Color(0xFF2563EB),
        title: _wallet?.name ?? 'Unknown Account',
        subtitle: _wallet?.description ?? 'Account',
      ),
    );
  }

  Widget _buildContactInfo() {
    return InfoCard(
      title: 'Contact',
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            child: Text(_contact!.name.substring(0, 1)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_contact!.name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600)),
                if (_contact!.note?.isNotEmpty ?? false)
                  Text(_contact!.note!,
                      style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          if (_contact!.phone?.isNotEmpty ?? false)
            IconButton(
                icon: const Icon(Icons.phone, color: Color(0xFF2563EB)),
                onPressed: () => _launchUrl('tel:${_contact!.phone!}')),
          if (_contact!.email?.isNotEmpty ?? false)
            IconButton(
                icon: const Icon(Icons.email, color: Color(0xFF16A3A)),
                onPressed: () => _launchUrl('mailto:${_contact!.email!}')),
        ],
      ),
    );
  }

  Widget _buildDescriptionInfo(TransactionEntry transaction) {
    return InfoCard(
      title: 'Description',
      child: Text(transaction.description!,
          style: const TextStyle(
              fontSize: 14, color: Color(0xFF475569), height: 1.5)),
    );
  }

  Widget _buildDeleteButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: TextButton.icon(
        icon: const Icon(Icons.delete_outline),
        label: const Text('Delete Transaction'),
        onPressed: _deleteTransaction,
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFFDC2626),
          backgroundColor: const Color(0xFFFEE2E2),
          minimumSize: const Size(double.infinity, 50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
