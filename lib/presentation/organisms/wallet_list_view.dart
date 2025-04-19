import 'package:flutter/material.dart';
import '../../domain/entities/wallet.dart';
import '../../domain/entities/chart_account.dart';
import '../../core/presentation/app_dimensions.dart';
import '../molecules/wallet_list_item.dart';
import '../molecules/confirm_delete_dialog.dart';

class WalletListView extends StatefulWidget {
  final List<Wallet> wallets;
  final Map<int, ChartAccount> chartAccountsMap;
  final Function(Wallet) onWalletTap;
  final Function(Wallet) onWalletDelete;
  final Map<int, double>? balances;

  const WalletListView({
    Key? key,
    required this.wallets,
    required this.chartAccountsMap,
    required this.onWalletTap,
    required this.onWalletDelete,
    this.balances,
  }) : super(key: key);

  @override
  State<WalletListView> createState() => _WalletListViewState();
}

class _WalletListViewState extends State<WalletListView> {
  Future<void> _confirmDeleteWallet(BuildContext context, Wallet wallet) async {
    final result = await ConfirmDeleteDialog.show(
      context: context,
      title: 'Eliminar billetera',
      message: '¿Estás seguro de que deseas eliminar',
      itemName: wallet.name,
      icon: Icons.account_balance_wallet_outlined,
      isDestructive: true,
    );
    
    // Si el usuario confirmó, eliminar la billetera
    if (result == true) {
      widget.onWalletDelete(wallet);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // Reducir el padding vertical para mejorar consistencia con CategoryListView
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.spacing16,
        vertical: AppDimensions.spacing4,
      ),
      itemCount: widget.wallets.length,
      itemBuilder: (context, index) {
        final wallet = widget.wallets[index];
        final chartAccount = widget.chartAccountsMap[wallet.chartAccountId];
        final balance = widget.balances != null ? widget.balances![wallet.id] : 0.0;
        
        return WalletListItem(
          wallet: wallet,
          chartAccount: chartAccount,
          balance: balance,
          onTap: () => widget.onWalletTap(wallet),
          onDelete: () => _confirmDeleteWallet(context, wallet),
          onEdit: () => widget.onWalletTap(wallet),
        );
      },
    );
  }
}
