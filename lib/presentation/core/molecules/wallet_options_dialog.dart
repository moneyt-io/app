import 'package:flutter/material.dart';
import '../../../domain/entities/wallet.dart';
import '../../../domain/entities/chart_account.dart';
import '../l10n/generated/strings.g.dart';

/// Opciones disponibles en el diálogo de wallet
enum WalletOption {
  editWallet,
  archiveWallet,
  unarchiveWallet,
  deleteWallet,
}

/// Bottom sheet dialog que muestra opciones para un wallet específico
/// Basado en wallet_dialog_options.html
class WalletOptionsDialog extends StatelessWidget {
  const WalletOptionsDialog({
    Key? key,
    required this.wallet,
    this.chartAccount,
    required this.balance,
    required this.onOptionSelected,
    required this.hasTransactions,
  }) : super(key: key);

  final Wallet wallet;
  final ChartAccount? chartAccount;
  final double balance;
  final Function(WalletOption) onOptionSelected;
  final bool hasTransactions;

  /// Método estático para mostrar el diálogo
  static Future<void> show({
    required BuildContext context,
    required Wallet wallet,
    ChartAccount? chartAccount,
    required double balance,
    required Function(WalletOption) onOptionSelected,
    required bool hasTransactions,
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
        hasTransactions: hasTransactions,
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
                  icon: Icons.edit,
                  label: t.wallets.options.editWallet,
                  subtitle: t.wallets.options.editWalletSubtitle,
                  onTap: () => _handleOptionTap(context, WalletOption.editWallet),
                ),
                
                // Lógica de archivo/desarchivo/eliminación
                if (!wallet.active)
                   // Si está archivada (active false), mostrar Desarchivar
                   _buildOptionItem(
                    icon: Icons.unarchive,
                    label: t.wallets.options.unarchiveWallet,
                    subtitle: t.wallets.options.unarchiveWalletSubtitle,
                    onTap: () =>
                        _handleOptionTap(context, WalletOption.unarchiveWallet),
                  )
                else if (hasTransactions)
                  // Si tiene transacciones y está activa, mostrar Archivar
                  ...[
                    const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8), // HTML: my-2
                    child: Divider(
                      color: Color(0xFFE2E8F0), // HTML: border-slate-200
                      height: 1,
                    ),
                  ),
                  _buildOptionItem(
                    icon: Icons.archive,
                    label: t.wallets.options.archiveWallet,
                    subtitle: t.wallets.options.archiveWalletSubtitle,
                    onTap: () =>
                        _handleOptionTap(context, WalletOption.archiveWallet),
                  ),
                  ]
                else
                  // Si no tiene transacciones y está activa, mostrar Eliminar
                  ...[
                    const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8), // HTML: my-2
                    child: Divider(
                      color: Color(0xFFE2E8F0), // HTML: border-slate-200
                      height: 1,
                    ),
                  ),
                  _buildOptionItem(
                    icon: Icons.delete,
                    label: t.wallets.options.deleteWallet,
                    subtitle: t.wallets.options.deleteWalletSubtitle,
                    onTap: () =>
                        _handleOptionTap(context, WalletOption.deleteWallet),
                    isDestructive: true,
                  ),
                  ],
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
    
    // Tipo de cuenta (Simplificado)
    // Se elimina el nombre de la cuenta contable técnica para limpiar la interfaz
    //if (chartAccount != null) {
      // parts.add(chartAccount!.name); 
    //} else {
      parts.add(t.wallets.options.defaultTitle);
    //}
        
    // Balance formateado
    parts.add('\$${balance.toStringAsFixed(2)}');
    
    return parts.join(' • ');
  }
}
