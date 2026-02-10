import 'package:flutter/material.dart';
import '../l10n/generated/strings.g.dart';

/// Enum para tipos de filtro de wallets basado en wallet_list.html
enum WalletFilterType { all, active, archived }

/// Filtros horizontales para tipos de wallets basado en wallet_list.html
/// 
/// HTML Reference:
/// ```html
/// <div class="flex gap-2">
///   <button class="flex-1 h-10 rounded-full bg-blue-500/10 text-blue-700 border border-blue-200 text-sm font-medium active">
///     <span class="material-symbols-outlined text-lg mr-2">account_balance_wallet</span>
///     All
///   </button>
/// ```
class WalletTypeFilter extends StatelessWidget {
  const WalletTypeFilter({
    Key? key,
    required this.selectedType,
    required this.onTypeChanged,
  }) : super(key: key);

  final WalletFilterType selectedType;
  final ValueChanged<WalletFilterType> onTypeChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildFilterButton(
            type: WalletFilterType.active,
            icon: Icons.visibility,
            label: t.wallets.filter.active,
            isActive: selectedType == WalletFilterType.active,
          ),
        ),
        const SizedBox(width: 8), // HTML: gap-2
        Expanded(
          child: _buildFilterButton(
            type: WalletFilterType.archived,
            icon: Icons.archive,
            label: t.wallets.filter.archived,
            isActive: selectedType == WalletFilterType.archived,
          ),
        ),
        const SizedBox(width: 8), // HTML: gap-2
        Expanded(
          child: _buildFilterButton(
            type: WalletFilterType.all,
            icon: Icons.account_balance_wallet,
            label: t.wallets.filter.all,
            isActive: selectedType == WalletFilterType.all,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterButton({
    required WalletFilterType type,
    required IconData icon,
    required String label,
    required bool isActive,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onTypeChanged(type),
        borderRadius: BorderRadius.circular(20), // HTML: rounded-full
        child: Container(
          height: 40, // HTML: h-10
          decoration: BoxDecoration(
            color: isActive 
                ? const Color(0xFF3B82F6).withOpacity(0.1) // HTML: bg-blue-500/10
                : const Color(0xFFF1F5F9), // HTML: bg-slate-100
            border: Border.all(
              color: isActive 
                  ? const Color(0xFF93C5FD) // HTML: border-blue-200
                  : const Color(0xFFE2E8F0), // HTML: border-slate-200
            ),
            borderRadius: BorderRadius.circular(20), // HTML: rounded-full
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18, // HTML: text-lg
                color: isActive 
                    ? const Color(0xFF1D4ED8) // HTML: text-blue-700
                    : const Color(0xFF64748B), // HTML: text-slate-600
              ),
              const SizedBox(width: 8), // HTML: mr-2
              Text(
                label,
                style: TextStyle(
                  fontSize: 14, // HTML: text-sm
                  fontWeight: FontWeight.w500, // HTML: font-medium
                  color: isActive 
                      ? const Color(0xFF1D4ED8) // HTML: text-blue-700
                      : const Color(0xFF64748B), // HTML: text-slate-600
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
