import 'package:flutter/material.dart';
import '../../domain/entities/wallet.dart';
import '../../domain/entities/chart_account.dart';
import '../../core/presentation/app_dimensions.dart';
import '../molecules/wallet_list_item.dart';

class WalletTreeView extends StatefulWidget {
  final Map<Wallet, List<Wallet>> walletTree;
  final Map<int, ChartAccount> chartAccountsMap;
  final Function(Wallet) onWalletTap;
  final Function(Wallet) onWalletDelete;
  final Map<int, double>? balances;

  const WalletTreeView({
    Key? key,
    required this.walletTree,
    required this.chartAccountsMap,
    required this.onWalletTap,
    required this.onWalletDelete,
    this.balances,
  }) : super(key: key);

  @override
  State<WalletTreeView> createState() => _WalletTreeViewState();
}

class _WalletTreeViewState extends State<WalletTreeView> {
  final Set<int> _expandedWallets = {}; // Use Set for efficient lookup

  @override
  void initState() {
    super.initState();
    // Optionally pre-expand root wallets or all wallets
    // Example: Pre-expand root wallets with children
    // for (final wallet in widget.walletTree.keys) {
    //   if (widget.walletTree[wallet]?.isNotEmpty ?? false) {
    //     _expandedWallets.add(wallet.id);
    //   }
    // }
  }

  void _toggleExpanded(Wallet wallet) {
    setState(() {
      if (_expandedWallets.contains(wallet.id)) {
        _expandedWallets.remove(wallet.id);
      } else {
        _expandedWallets.add(wallet.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final rootWallets = widget.walletTree.keys.toList()
      ..sort((a, b) => a.name.compareTo(b.name)); // Sort root wallets

    // Note: WalletListView uses different padding than CategoryTreeView
    return ListView.builder(
      padding: const EdgeInsets.symmetric( // Compare with CategoryTreeView padding
        horizontal: AppDimensions.spacing16,
        vertical: AppDimensions.spacing4,
      ),
      itemCount: rootWallets.length,
      itemBuilder: (context, index) {
        final rootWallet = rootWallets[index];
        final children = widget.walletTree[rootWallet] ?? [];
        return _buildWalletWithChildren(
          context,
          rootWallet,
          children,
          0, // Initial level
        );
      },
    );
  }

  Widget _buildWalletWithChildren(
    BuildContext context,
    Wallet wallet,
    List<Wallet> children,
    int level,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final isExpanded = _expandedWallets.contains(wallet.id);
    final hasChildren = children.isNotEmpty;
    final chartAccount = widget.chartAccountsMap[wallet.chartAccountId];
    // Balance is available but currently not displayed in WalletListItem
    final balance = widget.balances != null ? widget.balances![wallet.id] : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Wallet Item
        WalletListItem(
          wallet: wallet,
          chartAccount: chartAccount,
          balance: balance, // Pass balance even if not displayed
          onTap: () => widget.onWalletTap(wallet),
          onDelete: () => widget.onWalletDelete(wallet),
          onEdit: () => widget.onWalletTap(wallet), // Assuming tap is edit
          // Pass expand/collapse button as trailing widget
          trailing: hasChildren
              ? IconButton(
                  icon: Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: colorScheme.onSurfaceVariant,
                    size: AppDimensions.iconSizeMedium,
                  ),
                  onPressed: () => _toggleExpanded(wallet),
                  padding: EdgeInsets.zero, // Reduce padding around icon
                  constraints: const BoxConstraints(), // Reduce constraints
                )
              : null,
        ),

        // Children (indented) - only show if expanded
        if (hasChildren && isExpanded)
          Padding(
            // Apply indentation for children
            padding: EdgeInsets.only(
              left: AppDimensions.spacing32, // Corrected indentation amount
            ),
            // This part differs significantly from CategoryTreeView's child rendering
            child: Column(
              // WalletTreeView recursively calls _buildWalletWithChildren
              children: children.map((child) {
                // Find grandchildren for the next level (more robust hierarchy)
                // This assumes walletTree might contain nested children, unlike CategoryTreeView's structure
                final grandchildren = widget.walletTree.entries
                    .firstWhere(
                      (entry) => entry.key.id == child.id,
                      // If child is not a key, it means it's a leaf in the *original* list,
                      // but we only care about children present in the current `walletTree` map.
                      // Let's simplify: Assume children passed here are direct children.
                      // We need the children *of the child* from the main map.
                      orElse: () => MapEntry(child, <Wallet>[]), // Fallback if child not found as key
                    )
                    .value;

                // Find the children of the current 'child' from the main tree map
                final grandChildrenFromMap = widget.walletTree[child] ?? [];


                return _buildWalletWithChildren(
                  context,
                  child,
                  // Pass the correct grandchildren list for the next level
                  grandChildrenFromMap,
                  level + 1,
                );
              }).toList(),
            ),
          ),
        // No extra SizedBox here compared to CategoryTreeView
      ],
    );
  }
}
