import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../domain/entities/transaction_entry.dart';
import '../../../../domain/entities/category.dart';
import '../../../../core/utils/icon_to_emoji_mapper.dart';
import '../../core/providers/currency_filter_provider.dart';
import '../../features/transactions/transaction_provider.dart';
import 'new_transaction_screen.dart';
import '../theme/v2_colors.dart';
import '../../../core/utils/number_formatter.dart';
import '../../core/l10n/generated/strings.g.dart';
import 'widgets/v2_category_selection_sheet.dart';
import 'widgets/v2_account_selection_sheet.dart';
import '../shared/widgets/v2_date_selection_sheet.dart';
import '../../core/organisms/account_selector_modal.dart'
    show SelectableAccount;
import '../../../domain/usecases/wallet_usecases.dart';
import '../../../domain/usecases/credit_card_usecases.dart';
import 'package:get_it/get_it.dart';
import '../../features/wallets/wallet_provider.dart';

class NewTransactionsScreen extends StatefulWidget {
  final bool autoOpenSearch;

  const NewTransactionsScreen({
    super.key,
    this.autoOpenSearch = false,
  });

  @override
  State<NewTransactionsScreen> createState() => _NewTransactionsScreenState();
}

class _NewTransactionsScreenState extends State<NewTransactionsScreen> {
  int? _selectedCategoryId;
  int? _selectedWalletId;
  DateTimeRange? _selectedDateRange;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  late bool _isSearchExpanded;

  @override
  void initState() {
    super.initState();
    _isSearchExpanded = widget.autoOpenSearch;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String _formatDateHeader(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0 && now.day == date.day) {
      return t.v2.transactions.today;
    } else if (difference.inDays == 1 ||
        (difference.inDays == 0 && now.day != date.day)) {
      return t.v2.transactions.yesterday;
    } else {
      return DateFormat('d \'de\' MMMM', 'es').format(date);
    }
  }

  Map<String, List<TransactionEntry>> _groupTransactions(
      List<TransactionEntry> transactions) {
    final grouped = <String, List<TransactionEntry>>{};
    for (final tx in transactions) {
      final dateStr = _formatDateHeader(tx.date);
      if (grouped[dateStr] == null) {
        grouped[dateStr] = [];
      }
      grouped[dateStr]!.add(tx);
    }
    return grouped;
  }

  List<Category> _getTopCategories(
      List<TransactionEntry> transactions, Map<int, Category> categoryMap) {
    final counts = <int, int>{};
    for (final tx in transactions) {
      if (tx.mainCategoryId != null) {
        counts[tx.mainCategoryId!] = (counts[tx.mainCategoryId!] ?? 0) + 1;
      }
    }

    final sortedIds = counts.keys.toList()
      ..sort((a, b) => counts[b]!.compareTo(counts[a]!));

    return sortedIds
        .take(10)
        .map((id) => categoryMap[id])
        .where((c) => c != null)
        .cast<Category>()
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: V2Colors.background,
        body: Consumer2<TransactionProvider, CurrencyFilterProvider>(
          builder: (context, transactionProvider, currencyFilter, child) {
            final selectedCurrency = currencyFilter.selectedCurrencyId;

            // Filtro base: moneda
            var transactions = transactionProvider.transactions
                .where((tx) => tx.currencyId == selectedCurrency)
                .toList()
              ..sort((a, b) => b.date.compareTo(a.date));

            // Extraer el top de categorías SIEMPRE en base a todas las transacciones (para que los chips no desaparezcan al filtrar)
            final topCategories = _getTopCategories(
                transactions, transactionProvider.categoriesDataMap);

            // Aplicar filtro de categoría seleccionada
            if (_selectedCategoryId != null) {
              transactions = transactions
                  .where((tx) => tx.mainCategoryId == _selectedCategoryId)
                  .toList();
            }

            // Aplicar filtro de billetera seleccionada
            if (_selectedWalletId != null) {
              transactions = transactions
                  .where((tx) =>
                      tx.details.any((d) => d.paymentId == _selectedWalletId))
                  .toList();
            }

            // Aplicar filtro de fecha
            if (_selectedDateRange != null) {
              transactions = transactions.where((tx) {
                final isAfterOrSame =
                    tx.date.isAfter(_selectedDateRange!.start) ||
                        tx.date.isAtSameMomentAs(_selectedDateRange!.start);
                final isBeforeOrSame =
                    tx.date.isBefore(_selectedDateRange!.end) ||
                        tx.date.isAtSameMomentAs(_selectedDateRange!.end);
                return isAfterOrSame && isBeforeOrSame;
              }).toList();
            }

            // Aplicar filtro de búsqueda
            if (_searchQuery.isNotEmpty) {
              transactions = transactions.where((tx) {
                final q = _searchQuery.toLowerCase();
                final catName = tx.category?.name.toLowerCase() ??
                    (tx.mainCategoryId != null
                        ? transactionProvider
                            .categoriesDataMap[tx.mainCategoryId!]?.name
                            .toLowerCase()
                        : '') ??
                    '';
                final contactName = tx.contact?.name.toLowerCase() ?? '';
                final desc = tx.description?.toLowerCase() ?? '';
                return catName.contains(q) ||
                    contactName.contains(q) ||
                    desc.contains(q);
              }).toList();
            }

            final groupedTransactions = _groupTransactions(transactions);

            return Stack(
              children: [
                // Scrollable Content
                CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    // Espacio para la cabecera fija (aumentado para evitar solapamiento)
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 160),
                    ),

                    // Categorías Utilizadas (Filtro Visual Mantenido)
                    if (topCategories.isNotEmpty) ...[
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 16, bottom: 8, left: 24),
                          child: Text(
                            t.v2.transactions.usedCategories,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: V2Colors.outline,
                              letterSpacing: 1.2,
                              fontFamily: 'Manrope',
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: 64,
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount: topCategories.length,
                            itemBuilder: (context, index) {
                              final cat = topCategories[index];

                              final isIncome = cat.documentTypeId == 'I';
                              final bgColor = isIncome
                                  ? V2Colors.secondaryContainer
                                      .withValues(alpha: 0.3)
                                  : V2Colors.errorContainer
                                      .withValues(alpha: 0.3);

                              final isSelected = _selectedCategoryId == cat.id;

                              String emoji =
                                  IconToEmojiMapper.getEmoji(cat.icon);

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (_selectedCategoryId == cat.id) {
                                      _selectedCategoryId = null; // Toggle off
                                    } else {
                                      _selectedCategoryId = cat.id; // Toggle on
                                    }
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  width: 56,
                                  height: 56,
                                  margin: const EdgeInsets.only(right: 8),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? bgColor.withValues(alpha: 0.5)
                                        : bgColor,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: isSelected
                                          ? V2Colors.primary
                                              .withValues(alpha: 0.4)
                                          : Colors.white.withValues(alpha: 0.5),
                                      width: isSelected ? 1.5 : 1,
                                    ),
                                    boxShadow: [
                                      if (isSelected)
                                        BoxShadow(
                                          color: Colors.black
                                              .withValues(alpha: 0.06),
                                          blurRadius: 12,
                                          offset: const Offset(0, 4),
                                        )
                                      else
                                        BoxShadow(
                                          color: Colors.black
                                              .withValues(alpha: 0.02),
                                          blurRadius: 4,
                                          offset: const Offset(0, 2),
                                        ),
                                    ],
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    emoji,
                                    style: TextStyle(
                                      fontSize: isSelected ? 30 : 28,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(height: 16),
                      ),
                    ],

                    // Transacciones agrupadas
                    if (transactions.isEmpty)
                      SliverFillRemaining(
                        child: Center(
                          child: Text(
                            t.v2.transactions.noTransactions,
                            style: TextStyle(
                              color: V2Colors.outline,
                              fontFamily: 'Manrope',
                              fontSize: 16,
                            ),
                          ),
                        ),
                      )
                    else
                      ...groupedTransactions.entries.map((entry) {
                        return SliverPadding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                if (index == 0) {
                                  // Cabecera del grupo (Fecha)
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 12, top: 16, left: 4),
                                    child: Text(
                                      entry.key.toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: V2Colors.outline,
                                        letterSpacing: 1.2,
                                        fontFamily: 'Manrope',
                                      ),
                                    ),
                                  );
                                }

                                final tx = entry.value[index - 1];
                                final category = tx.category ??
                                    (tx.mainCategoryId != null
                                        ? transactionProvider.categoriesDataMap[
                                            tx.mainCategoryId!]
                                        : null);
                                return _buildTransactionCard(
                                    tx, category, context);
                              },
                              childCount:
                                  entry.value.length + 1, // +1 for the header
                            ),
                          ),
                        );
                      }),

                    // Espacio inferior
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 80),
                    ),
                  ],
                ),

                // Sticky Header with Glassmorphism
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                      child: Container(
                        color: V2Colors.surface.withValues(alpha: 0.8),
                        child: SafeArea(
                          bottom: false,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.arrow_back,
                                            color: V2Colors.onSurface),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        t.v2.transactions.recentActivity,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: V2Colors.onSurface,
                                          fontFamily: 'Manrope',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 12),
                                // Barra de Búsqueda y Filtros
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Row(
                                    children: [
                                      _buildAnimatedSearchBar(context),
                                      const SizedBox(width: 8),
                                      // Chips de filtros desplazables siempre visibles
                                      Expanded(
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          child: Row(
                                            children: [
                                              _buildDateChip(),
                                              _buildWalletChip(),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildAnimatedSearchBar(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final expandedWidth = screenWidth * 0.55; // 55% of screen width

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOutCubic,
      width: _isSearchExpanded ? expandedWidth : 36.0,
      height: 36.0,
      decoration: BoxDecoration(
        color: V2Colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: _isSearchExpanded
              ? V2Colors.primary.withValues(alpha: 0.15)
              : V2Colors.outlineVariant.withValues(alpha: 0.3),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                if (!_isSearchExpanded) {
                  setState(() => _isSearchExpanded = true);
                }
              },
              borderRadius: BorderRadius.circular(18),
              child: SizedBox(
                width: 34, // fits inside the 36px border area
                height: 34,
                child: Center(
                  child: Icon(
                    Icons.search,
                    size: 18,
                    color: _isSearchExpanded
                        ? V2Colors.primary
                        : V2Colors.onSurfaceVariant,
                  ),
                ),
              ),
            ),
            if (_isSearchExpanded)
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: TextField(
                          controller: _searchController,
                          autofocus: true,
                          textAlignVertical: TextAlignVertical.center,
                          style: const TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 13,
                              color: V2Colors.onSurface),
                          decoration: InputDecoration(
                            hintText: t.v2.transactions.searchTransaction,
                            hintStyle: const TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 13,
                                color: V2Colors.outline),
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                          onChanged: (val) {
                            setState(() => _searchQuery = val);
                          },
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 16),
                      color: V2Colors.primary,
                      padding: EdgeInsets.zero,
                      splashRadius: 16,
                      constraints:
                          const BoxConstraints(minWidth: 32, minHeight: 32),
                      onPressed: () {
                        if (_searchController.text.isNotEmpty) {
                          setState(() {
                            _searchController.clear();
                            _searchQuery = '';
                          });
                        } else {
                          setState(() {
                            _isSearchExpanded = false;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateChip() {
    final isActive = _selectedDateRange != null;
    String label = t.v2.transactions.date;
    if (isActive) {
      final start = DateFormat('dd MMM').format(_selectedDateRange!.start);
      final end = DateFormat('dd MMM').format(_selectedDateRange!.end);
      label = start == end ? start : "$start - $end";
    }

    return _buildFilterChip(
      label: label,
      icon: Icons.calendar_today,
      isActive: isActive,
      onTap: () async {
        if (isActive) {
          setState(() => _selectedDateRange = null);
          return;
        }
        final picked = await V2DateSelectionSheet.showRange(context,
            initialRange: _selectedDateRange);
        if (picked != null) {
          setState(() => _selectedDateRange = picked);
        }
      },
    );
  }

  Widget _buildWalletChip() {
    final isActive = _selectedWalletId != null;
    String label = t.v2.transactions.wallet;
    // Si quisieramos mostrar el nombre de la billetera, tendríamos que buscarla en WalletProvider.
    // Por simplicidad en este widget, lo dejamos como "Billetera (Activo)" si no tenemos acceso rápido al nombre,
    // pero podemos obtenerlo del provider.
    final walletProvider = context.read<WalletProvider>();
    if (isActive) {
      final wallet = walletProvider.wallets
          .where((w) => w.id == _selectedWalletId)
          .firstOrNull;
      if (wallet != null) label = wallet.name;
    }

    return _buildFilterChip(
      label: label,
      icon: Icons.account_balance_wallet_outlined,
      isActive: isActive,
      onTap: () async {
        if (isActive) {
          setState(() => _selectedWalletId = null);
          return;
        }

        final wallets = await GetIt.instance<WalletUseCases>().getAllWallets();
        final cards =
            await GetIt.instance<CreditCardUseCases>().getAllCreditCards();

        final accounts = <SelectableAccount>[];
        for (final w in wallets) {
          if (w.active && w.parentId != null)
            accounts.add(SelectableAccount.fromWallet(w,
                balance: 0, accountNumber: '1234'));
        }
        for (final c in cards) {
          accounts.add(SelectableAccount.fromCreditCard(c,
              balance: 0, availableCredit: 0, cardNumber: '5678'));
        }

        final selected = await V2AccountSelectionSheet.show(
          context,
          accounts: accounts,
          initialSelection: _selectedWalletId != null
              ? accounts.where((a) => a.id == _selectedWalletId).firstOrNull
              : null,
        );

        if (selected != null) {
          setState(() => _selectedWalletId = selected.id);
        }
      },
    );
  }

  Widget _buildFilterChip({
    required String label,
    required IconData icon,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isActive
              ? V2Colors.primary.withValues(alpha: 0.15)
              : V2Colors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isActive
                ? V2Colors.primary
                : V2Colors.outlineVariant.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isActive) ...[
              Icon(icon, size: 16, color: V2Colors.onSurfaceVariant),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isActive ? V2Colors.primary : V2Colors.onSurface,
                fontFamily: 'Manrope',
              ),
            ),
            if (isActive) ...[
              const SizedBox(width: 4),
              const Icon(Icons.close, size: 14, color: V2Colors.primary),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionCard(
      TransactionEntry tx, Category? category, BuildContext context) {
    final isIncome = tx.isIncome;

    // Asignar color consistente: rojo para gastos, verde para ingresos
    final avatarBgColor = isIncome
        ? V2Colors.secondaryContainer.withValues(alpha: 0.3)
        : V2Colors.errorContainer.withValues(alpha: 0.3);

    String emoji = (isIncome ? '💰' : '🏷️');
    if (category != null && category.icon.isNotEmpty) {
      emoji = IconToEmojiMapper.getEmoji(category.icon);
    }

    final title = tx.description?.isNotEmpty == true
        ? tx.description!
        : (tx.contact?.name ?? category?.name ?? 'Transacción');

    final subtitle =
        "${category?.name ?? 'Otros'} • ${DateFormat('HH:mm').format(tx.date)}";

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: V2Colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            // TODO: Navigate to detail
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: avatarBgColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: Text(emoji, style: const TextStyle(fontSize: 26)),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: V2Colors.onSurface,
                          fontFamily: 'Manrope',
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: V2Colors.onSurfaceVariant,
                          fontFamily: 'Manrope',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${isIncome ? '+' : '-'}${NumberFormatter.formatCurrency(tx.amount.abs())}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color:
                                isIncome ? V2Colors.secondary : V2Colors.error,
                            fontFamily: 'Manrope',
                            letterSpacing: -0.5,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => NewTransactionScreen(
                                  transactionIdToEdit: tx.id,
                                  initialType: tx.documentTypeId,
                                  initialAmount: tx.amount.abs(),
                                  initialDescription: tx.description,
                                  initialCategoryId: tx.mainCategoryId,
                                  initialWalletId: tx.details.isNotEmpty
                                      ? (tx.details.first.paymentTypeId == 'C'
                                          ? -tx.details.first.paymentId
                                          : tx.details.first.paymentId)
                                      : null,
                                  initialDate: tx.date,
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Icon(Icons.edit_outlined,
                                size: 16, color: V2Colors.onSurfaceVariant),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                title: Text(t.v2.transactions.deleteTransaction,
                                    style: TextStyle(
                                        fontFamily: 'Manrope',
                                        fontWeight: FontWeight.w700)),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(ctx),
                                    child: Text(t.v2.transactions.cancel,
                                        style: TextStyle(
                                            color: V2Colors.onSurfaceVariant,
                                            fontFamily: 'Manrope',
                                            fontWeight: FontWeight.w600)),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(ctx);
                                      context
                                          .read<TransactionProvider>()
                                          .deleteTransaction(tx.id);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  t.v2.transactions.transactionDeleted)));
                                    },
                                    child: Text(t.v2.transactions.delete,
                                        style: TextStyle(
                                            color: V2Colors.error,
                                            fontFamily: 'Manrope',
                                            fontWeight: FontWeight.w700)),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Icon(Icons.delete_outline,
                                size: 16, color: V2Colors.error),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
