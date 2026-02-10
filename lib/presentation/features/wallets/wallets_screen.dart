import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

import '../../../domain/entities/wallet.dart';
import '../../../domain/entities/chart_account.dart';
import '../../../domain/usecases/chart_account_usecases.dart';
import '../../core/atoms/app_app_bar.dart';
import '../../core/atoms/app_button.dart';
import '../../core/atoms/app_floating_action_button.dart';
import '../../core/design_system/theme/app_dimensions.dart';
import '../../core/molecules/empty_state.dart';
import '../../core/molecules/total_balance_card.dart';
import '../../core/molecules/wallet_options_dialog.dart';
import '../../core/molecules/wallet_tree_item.dart';
import '../../core/molecules/wallet_type_filter.dart';
import '../../core/organisms/app_drawer.dart';
import '../../navigation/app_routes.dart';
import '../../navigation/navigation_service.dart';
import '../../core/l10n/generated/strings.g.dart';
import '../../core/organisms/sliver_filter_header_delegate.dart';
import 'wallet_provider.dart';

class WalletsScreen extends StatefulWidget {
  const WalletsScreen({Key? key}) : super(key: key);

  @override
  State<WalletsScreen> createState() => _WalletsScreenState();
}

class _WalletsScreenState extends State<WalletsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // Local UI state
  WalletFilterType _selectedFilter = WalletFilterType.all;
  bool _isBalanceVisible = true;
  final Map<int, bool> _expandedWallets = {};
  // TODO: This should come from a ChartAccountProvider
  final ChartAccountUseCases _chartAccountUseCases =
      GetIt.instance<ChartAccountUseCases>();
  Map<int, ChartAccount> _chartAccountsMap = {};

  @override
  void initState() {
    super.initState();
    _loadInitialChartAccounts();
  }

  // Temporary method to load chart accounts until a provider is created
  Future<void> _loadInitialChartAccounts() async {
    final accounts = await _chartAccountUseCases.getAllChartAccounts();
    setState(() {
      _chartAccountsMap = {for (var acc in accounts) acc.id: acc};
    });
  }

  void _navigateToWalletForm({Wallet? wallet}) {
    NavigationService.navigateTo(AppRoutes.walletForm, arguments: wallet);
  }

  Future<void> _deleteWallet(BuildContext context, Wallet wallet) async {
    final walletProvider = Provider.of<WalletProvider>(context, listen: false);

    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(t.wallets.delete.dialogTitle),
        content: Text(t.wallets.delete.dialogMessage(name: wallet.name)),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(t.wallets.delete.cancel)),
          TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(t.wallets.delete.confirm)),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await walletProvider.deleteWallet(wallet.id);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(t.wallets.delete.success)),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(t.wallets.delete.error(error: e.toString())),
                backgroundColor: Theme.of(context).colorScheme.error),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletProvider>(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppAppBar(
        title: t.wallets.title,
        type: AppAppBarType.blur,
        leading: AppAppBarLeading.drawer,
        onLeadingPressed: () => _scaffoldKey.currentState?.openDrawer(),
        actions: const [AppAppBarAction.search],
        onActionsPressed: [() {}], // TODO: Implement search functionality
      ),
      drawer: const AppDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverFilterHeaderDelegate(
              height: 72, // 40 (filter) + 16*2 (padding)
              blur: true,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: WalletTypeFilter(
                  selectedType: _selectedFilter,
                  onTypeChanged: (type) => setState(() => _selectedFilter = type),
                ),
              ),
            ),
          ),
          walletProvider.isLoading
              ? const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()))
              : walletProvider.error != null
                  ? SliverFillRemaining(
                      child: _buildErrorState(context, walletProvider.error!))
                  : _buildWalletsSlivers(context, walletProvider),
        ],
      ),
      floatingActionButton: AppFloatingActionButton(
        onPressed: () => _navigateToWalletForm(),
        icon: Icons.add,
      ),
    );
  }

  Widget _buildWalletsSlivers(BuildContext context, WalletProvider provider) {
    final filteredWallets = provider.wallets.where((w) {
      switch (_selectedFilter) {
        case WalletFilterType.active:
          return w.active;
        case WalletFilterType.archived:
          return !w.active;
        default:
          return true;
      }
    }).toList();

    if (filteredWallets.isEmpty) {
      return SliverFillRemaining(child: _buildEmptyState());
    }

    final walletTree = _buildWalletTree(filteredWallets);

    return SliverList(delegate: SliverChildListDelegate([
        TotalBalanceCard(
          totalBalance: provider.totalBalance,
          monthlyGrowth: 0, // TODO: Implement monthly growth
          isBalanceVisible: _isBalanceVisible,
          onVisibilityToggle: () =>
              setState(() => _isBalanceVisible = !_isBalanceVisible),
        ),
        const SizedBox(height: 24),
        ...walletTree.entries.map((entry) {
          final parentWallet = entry.key;
          final childWallets = entry.value;
          return WalletTreeItem(
            parentWallet: parentWallet,
            childWallets: childWallets,
            chartAccount: _chartAccountsMap[parentWallet.chartAccountId],
            isExpanded: _expandedWallets[parentWallet.id] ?? true,
            parentBalance: provider.walletBalances[parentWallet.id] ?? 0.0,
            childBalances: {
              for (var child in childWallets)
                child.id: provider.walletBalances[child.id] ?? 0.0
            },
            onToggleExpansion: () => setState(() =>
                _expandedWallets[parentWallet.id] =
                    !(_expandedWallets[parentWallet.id] ?? true)),
            onWalletTap: (wallet) => _navigateToWalletForm(wallet: wallet),
            onWalletMorePressed: (wallet) =>
                _showWalletOptions(context, wallet, provider),
          );
        }),
        const SizedBox(height: 80), // For FAB
      ]),
    );
  }

  Map<Wallet, List<Wallet>> _buildWalletTree(List<Wallet> wallets) {
    final Map<Wallet, List<Wallet>> walletTree = {};
    final rootWallets = wallets.where((w) => w.parentId == null).toList();

    for (var rootWallet in rootWallets) {
      final children =
          wallets.where((w) => w.parentId == rootWallet.id).toList();
      children.sort((a, b) => a.name.compareTo(b.name));
      walletTree[rootWallet] = children;
    }

    rootWallets.sort((a, b) => a.name.compareTo(b.name));
    return {for (var root in rootWallets) root: walletTree[root]!};
  }

  void _showWalletOptions(
      BuildContext context, Wallet wallet, WalletProvider provider) {
    WalletOptionsDialog.show(
      context: context,
      wallet: wallet,
      chartAccount: _chartAccountsMap[wallet.chartAccountId],
      balance: provider.walletBalances[wallet.id] ?? 0.0,
      onOptionSelected: (option) {
        Navigator.pop(context); // Close the dialog
        _handleWalletOption(context, wallet, option, provider);
      },
    );
  }

  void _handleWalletOption(BuildContext context, Wallet wallet,
      WalletOption option, WalletProvider provider) {
    switch (option) {
      case WalletOption.editWallet:
        _navigateToWalletForm(wallet: wallet);
        break;
      case WalletOption.deleteWallet:
        _deleteWallet(context, wallet);
        break;
      // TODO: Implement other options
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(t.wallets.errors.comingSoon(name: option.name))),
        );
    }
  }

  Widget _buildEmptyState() {
    return EmptyState(
      icon: Icons.account_balance_wallet_outlined,
      title: t.wallets.empty.title,
      message: t.wallets.empty.message,
      action: AppButton(
        text: t.wallets.empty.action,
        onPressed: () => _navigateToWalletForm(),
        type: AppButtonType.filled,
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacing16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(t.wallets.errors.load,
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text(error, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            AppButton(
              text: t.wallets.errors.retry,
              onPressed: () =>
                  Provider.of<WalletProvider>(context, listen: false)
                      .loadInitialData(),
              type: AppButtonType.filled,
            ),
          ],
        ),
      ),
    );
  }
}

