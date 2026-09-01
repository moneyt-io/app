import 'package:flutter/material.dart';
import '../../../../domain/entities/wallet.dart';
import '../../../../core/utils/icon_to_emoji_mapper.dart';
import '../../../core/l10n/generated/strings.g.dart';
import '../../theme/v2_colors.dart';

class V2WalletFilterSheet extends StatefulWidget {
  final List<Wallet> wallets;
  final List<Wallet>? allWallets;
  final int? currentWalletId;

  const V2WalletFilterSheet({
    super.key,
    required this.wallets,
    this.allWallets,
    this.currentWalletId,
  });

  static Future<int?> show(
    BuildContext context, {
    required List<Wallet> wallets,
    List<Wallet>? allWallets,
    int? currentWalletId,
  }) {
    return showModalBottomSheet<int?>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => V2WalletFilterSheet(
        wallets: wallets,
        allWallets: allWallets,
        currentWalletId: currentWalletId,
      ),
    );
  }

  @override
  State<V2WalletFilterSheet> createState() => _V2WalletFilterSheetState();
}

class _V2WalletFilterSheetState extends State<V2WalletFilterSheet> {
  late List<Wallet> _filteredWallets;
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _filteredWallets = widget.wallets;
  }

  void _onSearch(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredWallets = widget.wallets;
      } else {
        final q = query.toLowerCase();
        _filteredWallets = widget.wallets.where((w) {
          final nameMatch = w.name.toLowerCase().contains(q);
          final currMatch = w.currencyId.toLowerCase().contains(q);
          final descMatch = w.description?.toLowerCase().contains(q) ?? false;
          return nameMatch || currMatch || descMatch;
        }).toList();
      }
    });
  }

  Map<String?, List<Wallet>> _getGroupedWallets() {
    final Map<String?, List<Wallet>> groups = {};
    for (final wallet in _filteredWallets) {
      String? groupName;
      if (widget.allWallets != null && wallet.parentId != null) {
        final parent = widget.allWallets!
            .where((p) => p.id == wallet.parentId)
            .firstOrNull;
        if (parent != null) {
          groupName = parent.name;
        }
      } else if (wallet.name.contains(' - ')) {
        final parts = wallet.name.split(' - ');
        if (parts.length > 1 && parts.first.trim().isNotEmpty) {
          groupName = parts.first.trim();
        }
      }
      groups.putIfAbsent(groupName, () => []).add(wallet);
    }
    return groups;
  }

  List<MapEntry<String?, List<Wallet>>> _getSortedGroupEntries() {
    final groups = _getGroupedWallets();
    final entries = groups.entries.toList();
    entries.sort((a, b) {
      if (a.key == null && b.key == null) return 0;
      if (a.key == null) return -1; // Ungrouped wallets first without header text
      if (b.key == null) return 1;
      return a.key!.compareTo(b.key!);
    });
    return entries;
  }

  String _getDisplayName(Wallet wallet) {
    if (wallet.name.contains(' - ')) {
      final parts = wallet.name.split(' - ');
      if (parts.length > 1 && parts.first.trim().isNotEmpty) {
        return parts.sublist(1).join(' - ').trim();
      }
    }
    return wallet.name;
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final showAllOption = _searchQuery.isEmpty ||
        t.v2.dashboard.walletFilters.allWallets
            .toLowerCase()
            .contains(_searchQuery.toLowerCase()) ||
        'todas'.contains(_searchQuery.toLowerCase()) ||
        'all'.contains(_searchQuery.toLowerCase());
    final groupEntries = _getSortedGroupEntries();

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: bottomInset > 0 ? bottomInset + 24 : 32,
      ),
      decoration: const BoxDecoration(
        color: V2Colors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Handle
          Center(
            child: Container(
              width: 48,
              height: 4,
              decoration: BoxDecoration(
                color: V2Colors.outlineVariant.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                t.components.accountSelection.selectAccount,
                style: const TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: V2Colors.onSurface,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: V2Colors.onSurfaceVariant),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Search Field
          TextField(
            controller: _searchController,
            onChanged: _onSearch,
            decoration: InputDecoration(
              hintText: t.components.accountSelection.searchPlaceholder,
              hintStyle: const TextStyle(
                fontFamily: 'Manrope',
                color: V2Colors.outlineVariant,
              ),
              prefixIcon: const Icon(Icons.search, color: V2Colors.outlineVariant),
              filled: true,
              fillColor: V2Colors.surfaceContainerLowest,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: V2Colors.primary, width: 2),
              ),
            ),
            style: const TextStyle(
              fontFamily: 'Manrope',
              fontSize: 16,
              color: V2Colors.onSurface,
            ),
          ),
          const SizedBox(height: 16),

          // List of wallets
          Expanded(
            child: _filteredWallets.isEmpty && !showAllOption
                ? Center(
                    child: Text(
                      t.v2.transactions.noCategoriesAvailable,
                      style: const TextStyle(
                        fontFamily: 'Manrope',
                        color: V2Colors.outlineVariant,
                      ),
                    ),
                  )
                : ListView(
                    padding: const EdgeInsets.only(top: 8, bottom: 24),
                    children: [
                      // Todas las billeteras (Vista Global)
                      if (showAllOption)
                        _buildCell(
                          onTap: () => Navigator.pop(context, -1),
                          isSelected: widget.currentWalletId == null ||
                              widget.currentWalletId == -1,
                          emoji: '✨',
                          title: t.v2.dashboard.walletFilters.allWallets,
                          subtitle: 'Vista Global de todos los saldos',
                          currencyId: '',
                          isSpecial: true,
                        ),

                      // Grouped and ungrouped wallets
                      for (final entry in groupEntries)
                        if (entry.value.isNotEmpty) ...[
                          // Validated: if entry.key == null or empty, DO NOT show grouping header text!
                          if (entry.key != null && entry.key!.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, top: 12, bottom: 8),
                              child: Text(
                                entry.key!,
                                style: const TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800,
                                  color: V2Colors.primary,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          for (final wallet in entry.value)
                            _buildCell(
                              onTap: () => Navigator.pop(context, wallet.id),
                              isSelected: widget.currentWalletId == wallet.id,
                              emoji: IconToEmojiMapper.getEmoji(
                                  wallet.icon ?? ''),
                              title: _getDisplayName(wallet),
                              subtitle: wallet.description,
                              currencyId: wallet.currencyId,
                            ),
                        ],
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCell({
    required VoidCallback onTap,
    required bool isSelected,
    required String emoji,
    required String title,
    String? subtitle,
    required String currencyId,
    bool isSpecial = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: V2Colors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? V2Colors.primary : Colors.transparent,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isSpecial
                    ? V2Colors.primary.withValues(alpha: 0.15)
                    : V2Colors.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Text(emoji, style: const TextStyle(fontSize: 24)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: isSpecial ? FontWeight.w800 : FontWeight.w600,
                      color: V2Colors.onSurface,
                      fontFamily: 'Manrope',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (subtitle != null && subtitle.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: V2Colors.onSurfaceVariant,
                        fontFamily: 'Manrope',
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            if (currencyId.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: V2Colors.surfaceVariant.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  currencyId,
                  style: const TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: V2Colors.onSurfaceVariant,
                  ),
                ),
              ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: V2Colors.primary,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}
