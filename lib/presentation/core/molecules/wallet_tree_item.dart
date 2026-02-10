import 'package:flutter/material.dart';
import '../../../domain/entities/wallet.dart';
import '../../../domain/entities/chart_account.dart';
import '../l10n/generated/strings.g.dart';

/// Item de wallet expandible con tree view basado en wallet_list.html
/// 
/// HTML Reference:
/// ```html
/// <div class="bg-white mx-4 mb-3 rounded-xl shadow-sm border border-slate-200 overflow-hidden">
///   <div class="flex items-center px-4 py-4 hover:bg-slate-50">
///     <button onclick="toggleWallet('chase')" class="flex items-center flex-grow text-left">
///       <span id="chase-icon" class="material-symbols-outlined text-slate-600 text-lg mr-3">expand_more</span>
/// ```
class WalletTreeItem extends StatelessWidget {
  const WalletTreeItem({
    Key? key,
    required this.parentWallet,
    required this.childWallets,
    this.chartAccount,
    required this.isExpanded,
    required this.onToggleExpansion,
    required this.onWalletTap,
    required this.onWalletMorePressed,
    this.parentBalance, // ✅ AGREGADO: Balance del wallet padre
    this.childBalances, // ✅ AGREGADO: Balances de wallets hijos
  }) : super(key: key);

  final Wallet parentWallet;
  final List<Wallet> childWallets;
  final ChartAccount? chartAccount;
  final bool isExpanded;
  final VoidCallback onToggleExpansion;
  final Function(Wallet) onWalletTap;
  final Function(Wallet) onWalletMorePressed;
  final double? parentBalance; // ✅ AGREGADO: Balance del wallet padre
  final Map<int, double>? childBalances; // ✅ AGREGADO: Mapa de balances de hijos

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 12), // HTML: mx-4 mb-3
      decoration: BoxDecoration(
        color: Colors.white, // HTML: bg-white
        borderRadius: BorderRadius.circular(12), // HTML: rounded-xl
        border: Border.all(color: const Color(0xFFE2E8F0)), // HTML: border-slate-200
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
          // Parent wallet header
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onToggleExpansion,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Container(
                padding: const EdgeInsets.all(16), // HTML: px-4 py-4
                child: Row(
                  children: [
                    // Expansion icon
                    Icon(
                      isExpanded ? Icons.expand_more : Icons.chevron_right,
                      color: const Color(0xFF64748B), // HTML: text-slate-600
                      size: 18, // HTML: text-lg
                    ),
                    
                    const SizedBox(width: 12), // HTML: mr-3
                    
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
                    
                    const SizedBox(width: 16), // HTML: mr-4
                    
                    // Wallet info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            parentWallet.name,
                            style: const TextStyle(
                              fontSize: 16, // HTML: text-base
                              fontWeight: FontWeight.w600, // HTML: font-semibold
                              color: Color(0xFF1E293B), // HTML: text-slate-800
                            ),
                          ),
                          Text(
                            _getWalletSubtitle(),
                            style: const TextStyle(
                              fontSize: 14, // HTML: text-sm
                              color: Color(0xFF64748B), // HTML: text-slate-500
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '\$${_formatBalance(parentBalance ?? 0.0)}', // ✅ CORREGIDO: Usar balance pasado como parámetro
                            style: const TextStyle(
                              fontSize: 18, // HTML: text-lg
                              fontWeight: FontWeight.bold, // HTML: font-bold
                              color: Color(0xFF0F172A), // HTML: text-slate-900
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // More button
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => onWalletMorePressed(parentWallet),
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: 40, // HTML: h-10 w-10
                          height: 40,
                          child: const Icon(
                            Icons.more_vert,
                            color: Color(0xFF64748B), // HTML: text-slate-500
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Child wallets
          if (isExpanded && childWallets.isNotEmpty)
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color(0xFFF1F5F9), // HTML: border-slate-100
                  ),
                ),
              ),
              child: Column(
                children: childWallets.map((childWallet) {
                  return _buildChildWalletItem(childWallet);
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }

  /// Construye un item de wallet hijo
  Widget _buildChildWalletItem(Wallet childWallet) {
    final childBalance = childBalances?[childWallet.id] ?? 0.0; // ✅ AGREGADO: Obtener balance del hijo

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onWalletTap(childWallet),
        child: Container(
          padding: const EdgeInsets.fromLTRB(64, 12, 16, 12), // HTML: pl-16 px-4 py-3
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color(0xFFF1F5F9), // HTML: border-slate-100
              ),
            ),
          ),
          child: Row(
            children: [
              // Child wallet icon
              Container(
                width: 40, // HTML: h-10 w-10
                height: 40,
                decoration: BoxDecoration(
                  color: _getChildWalletIconBackground(childWallet),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _getChildWalletIcon(childWallet),
                  color: _getChildWalletIconColor(childWallet),
                  size: 20,
                ),
              ),
              
              const SizedBox(width: 16), // HTML: mr-4
              
              // Child wallet info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      childWallet.name,
                      style: const TextStyle(
                        fontSize: 16, // HTML: text-base
                        fontWeight: FontWeight.w500, // HTML: font-medium
                        color: Color(0xFF1E293B), // HTML: text-slate-800
                      ),
                    ),
                    Text(
                      _getChildWalletSubtitle(childWallet),
                      style: const TextStyle(
                        fontSize: 14, // HTML: text-sm
                        color: Color(0xFF64748B), // HTML: text-slate-500
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '\$${_formatBalance(childBalance)}', // ✅ CORREGIDO: Usar balance calculado
                      style: const TextStyle(
                        fontSize: 16, // HTML: text-base
                        fontWeight: FontWeight.w600, // HTML: font-semibold
                        color: Color(0xFF0F172A), // HTML: text-slate-900
                      ),
                    ),
                  ],
                ),
              ),
              
              // Child more button
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => onWalletMorePressed(childWallet),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 40, // HTML: h-10 w-10
                    height: 40,
                    child: const Icon(
                      Icons.more_vert,
                      color: Color(0xFF64748B), // HTML: text-slate-500
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper methods
  IconData _getWalletIcon() {
    final name = parentWallet.name.toLowerCase();
    if (name.contains('chase') || name.contains('bank')) {
      return Icons.account_balance;
    } else if (name.contains('personal') || name.contains('wallet')) {
      return Icons.person;
    }
    return Icons.account_balance_wallet;
  }

  Color _getWalletIconBackground() {
    final name = parentWallet.name.toLowerCase();
    if (name.contains('chase') || name.contains('bank')) {
      return const Color(0xFFDBEAFE); // HTML: bg-blue-100
    } else if (name.contains('personal')) {
      return const Color(0xFFF3E8FF); // HTML: bg-purple-100
    }
    return const Color(0xFFDBEAFE); // Default blue
  }

  Color _getWalletIconColor() {
    final name = parentWallet.name.toLowerCase();
    if (name.contains('chase') || name.contains('bank')) {
      return const Color(0xFF2563EB); // HTML: text-blue-600
    } else if (name.contains('personal')) {
      return const Color(0xFF9333EA); // HTML: text-purple-600
    }
    return const Color(0xFF2563EB); // Default blue
  }

  String _getWalletSubtitle() {
    final childCount = childWallets.length;
    final type = parentWallet.name.toLowerCase().contains('personal') 
        ? t.wallets.subtitle.cashDigital 
        : t.wallets.subtitle.mainAccount;
    return '$type • ${t.wallets.subtitle.count(n: childCount)}';
  }

  // Child wallet helpers
  IconData _getChildWalletIcon(Wallet wallet) {
    final name = wallet.name.toLowerCase();
    if (name.contains('checking') || name.contains('account')) {
      return Icons.account_balance;
    } else if (name.contains('savings') || name.contains('emergency')) {
      return Icons.savings;
    } else if (name.contains('cash')) {
      return Icons.payments;
    } else if (name.contains('paypal') || name.contains('digital')) {
      return Icons.account_balance_wallet;
    }
    return Icons.account_balance_wallet;
  }

  Color _getChildWalletIconBackground(Wallet wallet) {
    final name = wallet.name.toLowerCase();
    if (name.contains('checking') || name.contains('account')) {
      return const Color(0xFFDBEAFE); // HTML: bg-blue-100
    } else if (name.contains('savings') || name.contains('emergency')) {
      return const Color(0xFFDCFCE7); // HTML: bg-green-100
    } else if (name.contains('cash')) {
      return const Color(0xFFDCFCE7); // HTML: bg-green-100
    } else if (name.contains('paypal')) {
      return const Color(0xFFDBEAFE); // HTML: bg-blue-100
    }
    return const Color(0xFFDBEAFE); // Default blue
  }

  Color _getChildWalletIconColor(Wallet wallet) {
    final name = wallet.name.toLowerCase();
    if (name.contains('checking') || name.contains('account')) {
      return const Color(0xFF2563EB); // HTML: text-blue-600
    } else if (name.contains('savings') || name.contains('emergency')) {
      return const Color(0xFF16A34A); // HTML: text-green-600
    } else if (name.contains('cash')) {
      return const Color(0xFF16A34A); // HTML: text-green-600
    } else if (name.contains('paypal')) {
      return const Color(0xFF2563EB); // HTML: text-blue-600
    }
    return const Color(0xFF2563EB); // Default blue
  }

  String _getChildWalletSubtitle(Wallet wallet) {
    final name = wallet.name.toLowerCase();
    if (name.contains('checking')) {
      return '****4567';
    } else if (name.contains('emergency')) {
      return '****8901';
    } else if (name.contains('cash')) {
      return t.wallets.subtitle.physicalCash;
    } else if (name.contains('paypal')) {
      return t.wallets.subtitle.digitalWallet;
    }
    return t.wallets.subtitle.account;
  }

  /// Formatea el balance con comas
  String _formatBalance(double balance) {
    return balance.toStringAsFixed(2).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }
}
