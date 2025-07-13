import 'package:flutter/material.dart';
import '../../../domain/entities/wallet.dart';
import '../atoms/widget_card_header.dart';

/// Widget de wallets para dashboard basado en dashboard_main.html
///
/// HTML Reference:
/// ```html
/// <div class="bg-white rounded-2xl shadow-sm border border-slate-200 widget-card">
///   <div class="flex items-center justify-between p-4 border-b border-slate-100">
/// ```
class WalletsDashboardWidget extends StatelessWidget {
  const WalletsDashboardWidget({
    Key? key,
    required this.wallets,
    required this.totalCount,
    required this.onHeaderTap,
    required this.onWalletTap,
    this.isVisible = true,
  }) : super(key: key);

  final List<WalletDisplayItem> wallets;
  final int totalCount;
  final VoidCallback onHeaderTap;
  final Function(WalletDisplayItem) onWalletTap;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    if (!isVisible) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16), // HTML: mx-4
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16), // HTML: rounded-2xl
        border: Border.all(
          color: const Color(0xFFE2E8F0), // HTML: border-slate-200
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000), // HTML: shadow-sm
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          WidgetCardHeader(
            icon: Icons.account_balance_wallet,
            title: 'Wallets',
            subtitle: '$totalCount accounts',
            onTap: onHeaderTap,
            iconColor: const Color(0xFF2563EB), // HTML: text-blue-600
            iconBackgroundColor: const Color(0xFFDBEAFE), // HTML: bg-blue-100
          ),

          // Wallets list
          Container(
            padding: const EdgeInsets.all(16), // HTML: p-4
            child: Column(
              children: [
                // First 3 wallets
                ...wallets.take(3).map((wallet) => _buildWalletItem(wallet)),

                // More accounts indicator
                if (totalCount > 3) ...[
                  const SizedBox(height: 8), // HTML: pt-2
                  Center(
                    child: Text(
                      '+${totalCount - 3} more accounts',
                      style: const TextStyle(
                        fontSize: 12, // HTML: text-xs
                        color: Color(0xFF64748B), // HTML: text-slate-500
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWalletItem(WalletDisplayItem wallet) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12), // HTML: space-y-3
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onWalletTap(wallet),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                // Wallet icon
                Container(
                  width: 32, // HTML: h-8 w-8
                  height: 32,
                  decoration: BoxDecoration(
                    color: wallet.iconBackgroundColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    wallet.icon,
                    size: 16, // HTML: text-sm
                    color: wallet.iconColor,
                  ),
                ),

                const SizedBox(width: 12), // HTML: gap-3

                // Wallet name
                Expanded(
                  child: Text(
                    wallet.name,
                    style: const TextStyle(
                      fontSize: 14, // HTML: text-sm
                      fontWeight: FontWeight.w500, // HTML: font-medium
                      color: Color(0xFF374151), // HTML: text-slate-700
                    ),
                  ),
                ),

                // Balance
                Text(
                  '\$${_formatAmount(wallet.balance)}',
                  style: const TextStyle(
                    fontSize: 14, // HTML: text-sm
                    fontWeight: FontWeight.bold, // HTML: font-bold
                    color: Color(0xFF0F172A), // HTML: text-slate-900
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Formatea montos con comas
  String _formatAmount(double amount) {
    return amount.toStringAsFixed(2).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }
}

/// Modelo para mostrar wallet en el dashboard
class WalletDisplayItem {
  final int id;
  final String name;
  final double balance;
  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;

  const WalletDisplayItem({
    required this.id,
    required this.name,
    required this.balance,
    required this.icon,
    required this.iconColor,
    required this.iconBackgroundColor,
  });

  /// Factory para crear desde Wallet entity
  factory WalletDisplayItem.fromWallet(Wallet wallet, double balance) {
    final nameAndDesc =
        '${wallet.name} ${wallet.description ?? ''}'.toLowerCase();

    IconData icon;
    Color iconColor;
    Color iconBackgroundColor;

    if (nameAndDesc.contains('checking') || nameAndDesc.contains('chase')) {
      icon = Icons.account_balance;
      iconColor = const Color(0xFF16A34A); // text-green-600
      iconBackgroundColor = const Color(0xFFDCFCE7); // bg-green-100
    } else if (nameAndDesc.contains('savings')) {
      icon = Icons.savings;
      iconColor = const Color(0xFF2563EB); // text-blue-600
      iconBackgroundColor = const Color(0xFFDBEAFE); // bg-blue-100
    } else if (nameAndDesc.contains('cash')) {
      icon = Icons.payments;
      iconColor = const Color(0xFFEA580C); // text-orange-600
      iconBackgroundColor = const Color(0xFFFED7AA); // bg-orange-100
    } else {
      icon = Icons.account_balance_wallet;
      iconColor = const Color(0xFF2563EB); // Default blue
      iconBackgroundColor = const Color(0xFFDBEAFE);
    }

    return WalletDisplayItem(
      id: wallet.id,
      name: wallet.name,
      balance: balance,
      icon: icon,
      iconColor: iconColor,
      iconBackgroundColor: iconBackgroundColor,
    );
  }
}
