import 'package:flutter/material.dart';
import '../../../domain/entities/wallet.dart';
import '../../../domain/entities/chart_account.dart';

/// Opciones disponibles en el diálogo de wallet
enum WalletOption {
  viewTransactions,
  transferFunds,
  editWallet,
  duplicateWallet,
  archiveWallet,
  deleteWallet,
}

/// Bottom sheet dialog que muestra opciones para un wallet específico
/// Basado en wallet_dialog_options.html
/// 
/// HTML Reference:
/// ```html
/// <div class="flex absolute top-0 left-0 h-full w-full flex-col justify-end items-stretch bg-black/30">
///   <div class="flex flex-col items-stretch bg-white rounded-t-2xl shadow-lg">
/// ```
class WalletOptionsDialog extends StatelessWidget {
  const WalletOptionsDialog({
    Key? key,
    required this.wallet,
    this.chartAccount,
    required this.balance,
    required this.onOptionSelected,
  }) : super(key: key);

  final Wallet wallet;
  final ChartAccount? chartAccount;
  final double balance;
  final Function(WalletOption) onOptionSelected;

  /// Método estático para mostrar el diálogo
  static Future<void> show({
    required BuildContext context,
    required Wallet wallet,
    ChartAccount? chartAccount,
    required double balance,
    required Function(WalletOption) onOptionSelected,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.3), // HTML: bg-black/30
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => WalletOptionsDialog(
        wallet: wallet,
        chartAccount: chartAccount,
        balance: balance,
        onOptionSelected: onOptionSelected,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16), // HTML: rounded-t-2xl
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000), // HTML: shadow-lg
            blurRadius: 10,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: double.infinity,
            height: 24,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Center(
              child: Container(
                width: 40,
                height: 6,
                decoration: BoxDecoration(
                  color: const Color(0xFFCBD5E1), // HTML: bg-slate-300
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),

          // Wallet header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFF1F5F9), // HTML: border-slate-100
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                // Wallet icon
                Container(
                  width: 48, // HTML: h-12 w-12
                  height: 48,
                  decoration: BoxDecoration(
                    color: _getWalletIconBackground(),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _getWalletIcon(),
                    color: _getWalletIconColor(),
                    size: 24,
                  ),
                ),
                
                const SizedBox(width: 12), // HTML: gap-3
                
                // Wallet info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        wallet.name,
                        style: const TextStyle(
                          fontSize: 16, // HTML: text-base
                          fontWeight: FontWeight.w600, // HTML: font-semibold
                          color: Color(0xFF1E293B), // HTML: text-slate-800
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _getWalletSubtitle(),
                        style: const TextStyle(
                          fontSize: 14, // HTML: text-sm
                          color: Color(0xFF64748B), // HTML: text-slate-500
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Options list
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8), // HTML: px-2 pb-2
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildOptionItem(
                  icon: Icons.receipt_long,
                  label: 'View transactions',
                  subtitle: 'See all transactions for this wallet',
                  onTap: () => _handleOptionTap(context, WalletOption.viewTransactions),
                ),
                _buildOptionItem(
                  icon: Icons.swap_horiz,
                  label: 'Transfer funds',
                  subtitle: 'Move money between wallets',
                  onTap: () => _handleOptionTap(context, WalletOption.transferFunds),
                ),
                _buildOptionItem(
                  icon: Icons.edit,
                  label: 'Edit wallet',
                  subtitle: 'Modify wallet details',
                  onTap: () => _handleOptionTap(context, WalletOption.editWallet),
                ),
                _buildOptionItem(
                  icon: Icons.content_copy,
                  label: 'Duplicate wallet',
                  subtitle: 'Create a copy of this wallet',
                  onTap: () => _handleOptionTap(context, WalletOption.duplicateWallet),
                ),
                _buildOptionItem(
                  icon: Icons.archive,
                  label: 'Archive wallet',
                  subtitle: 'Hide wallet from main view',
                  onTap: () => _handleOptionTap(context, WalletOption.archiveWallet),
                ),
                
                // Separator line
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8), // HTML: my-2
                  height: 1,
                  color: const Color(0xFFE2E8F0), // HTML: border-slate-200
                ),
                
                // Delete option (destructive)
                _buildOptionItem(
                  icon: Icons.delete,
                  label: 'Delete wallet',
                  subtitle: 'Permanently remove this wallet',
                  onTap: () => _handleOptionTap(context, WalletOption.deleteWallet),
                  isDestructive: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Construye un item de opción en la lista
  Widget _buildOptionItem({
    required IconData icon,
    required String label,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    final iconColor = isDestructive 
        ? const Color(0xFFDC2626) // HTML: text-red-600
        : const Color(0xFF374151); // HTML: text-slate-700

    final textColor = isDestructive 
        ? const Color(0xFFDC2626) // HTML: text-red-600
        : const Color(0xFF1E293B); // HTML: text-slate-800

    final subtitleColor = isDestructive
        ? const Color(0xFFEF4444) // HTML: text-red-500
        : const Color(0xFF64748B); // HTML: text-slate-500

    final hoverColor = isDestructive
        ? const Color(0xFFFEF2F2) // HTML: hover:bg-red-50
        : const Color(0xFFF8FAFC); // HTML: hover:bg-slate-100

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        splashColor: hoverColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // HTML: px-4 py-3
          child: Row(
            children: [
              Icon(
                icon,
                size: 24, // Material icons outlined
                color: iconColor,
              ),
              const SizedBox(width: 16), // HTML: gap-4
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 16, // HTML: text-base
                        fontWeight: FontWeight.w500, // HTML: font-medium
                        color: textColor,
                        height: 1.25, // HTML: leading-normal
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14, // HTML: text-sm
                        color: subtitleColor,
                        height: 1.25,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Maneja el tap en una opción y cierra el diálogo
  void _handleOptionTap(BuildContext context, WalletOption option) {
    Navigator.of(context).pop();
    onOptionSelected(option);
  }

  /// Obtiene el ícono del wallet según su tipo
  IconData _getWalletIcon() {
    // Determinar por el nombre o descripción del wallet
    final nameAndDesc = '${wallet.name} ${wallet.description ?? ''}'.toLowerCase();
    
    if (nameAndDesc.contains('bank') || nameAndDesc.contains('checking') || nameAndDesc.contains('chase')) {
      return Icons.account_balance;
    } else if (nameAndDesc.contains('savings') || nameAndDesc.contains('emergency')) {
      return Icons.savings;
    } else if (nameAndDesc.contains('cash') || nameAndDesc.contains('wallet')) {
      return Icons.account_balance_wallet;
    } else if (nameAndDesc.contains('card') || nameAndDesc.contains('credit')) {
      return Icons.credit_card;
    } else if (nameAndDesc.contains('paypal') || nameAndDesc.contains('digital')) {
      return Icons.payment;
    }
    
    return Icons.account_balance_wallet; // Default
  }

  /// Obtiene el color del ícono del wallet
  Color _getWalletIconColor() {
    final nameAndDesc = '${wallet.name} ${wallet.description ?? ''}'.toLowerCase();
    
    if (nameAndDesc.contains('bank') || nameAndDesc.contains('checking') || nameAndDesc.contains('chase')) {
      return const Color(0xFF2563EB); // HTML: text-blue-600
    } else if (nameAndDesc.contains('savings') || nameAndDesc.contains('emergency')) {
      return const Color(0xFF16A34A); // text-green-600
    } else if (nameAndDesc.contains('cash')) {
      return const Color(0xFF16A34A); // text-green-600
    } else if (nameAndDesc.contains('paypal') || nameAndDesc.contains('digital')) {
      return const Color(0xFF2563EB); // text-blue-600
    }
    
    return const Color(0xFF2563EB); // Default blue
  }

  /// Obtiene el color de fondo del ícono del wallet
  Color _getWalletIconBackground() {
    final nameAndDesc = '${wallet.name} ${wallet.description ?? ''}'.toLowerCase();
    
    if (nameAndDesc.contains('bank') || nameAndDesc.contains('checking') || nameAndDesc.contains('chase')) {
      return const Color(0xFFDBEAFE); // HTML: bg-blue-100
    } else if (nameAndDesc.contains('savings') || nameAndDesc.contains('emergency')) {
      return const Color(0xFFDCFCE7); // bg-green-100
    } else if (nameAndDesc.contains('cash')) {
      return const Color(0xFFDCFCE7); // bg-green-100
    } else if (nameAndDesc.contains('paypal') || nameAndDesc.contains('digital')) {
      return const Color(0xFFDBEAFE); // bg-blue-100
    }
    
    return const Color(0xFFDBEAFE); // Default blue
  }

  /// Obtiene el subtítulo del wallet mostrando tipo, número de cuenta y balance
  String _getWalletSubtitle() {
    final List<String> parts = [];
    
    // Tipo de cuenta
    if (chartAccount != null) {
      parts.add(chartAccount!.name);
    } else {
      parts.add('Wallet');
    }
    
    // Placeholder para número de cuenta (basado en el nombre)
    final name = wallet.name.toLowerCase();
    if (name.contains('checking')) {
      parts.add('****4567');
    } else if (name.contains('savings') || name.contains('emergency')) {
      parts.add('****8901');
    } else if (name.contains('cash')) {
      parts.add('Physical cash');
    } else if (name.contains('paypal')) {
      parts.add('Digital wallet');
    } else {
      parts.add('Account');
    }
    
    // Balance formateado
    parts.add('\$${balance.toStringAsFixed(2)}');
    
    return parts.join(' • ');
  }
}
