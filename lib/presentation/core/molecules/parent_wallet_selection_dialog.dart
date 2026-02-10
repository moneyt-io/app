import 'package:flutter/material.dart';
import '../../../domain/entities/wallet.dart';
import '../atoms/app_search_field.dart';
import '../l10n/generated/strings.g.dart';
import 'dialog_action_bar.dart';

/// Diálogo de selección de parent wallet basado en wallet_dialog_parent.html
/// 
/// HTML Reference:
/// ```html
/// <button class="flex items-center gap-3 w-full px-4 py-3 hover:bg-slate-50">
///   <div class="flex items-center justify-center h-8 w-8 rounded-full bg-slate-100 text-slate-500">
///     <span class="material-symbols-outlined text-sm">account_balance_wallet</span>
///   </div>
/// ```
class ParentWalletSelectionDialog extends StatefulWidget {
  const ParentWalletSelectionDialog({
    Key? key,
    required this.availableWallets,
    required this.selectedWalletId,
  }) : super(key: key);

  final List<Wallet> availableWallets;
  final int? selectedWalletId;

  static Future<Wallet?> show({
    required BuildContext context,
    required List<Wallet> availableWallets,
    int? selectedWalletId,
  }) {
    return showModalBottomSheet<Wallet?>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.3),
      isDismissible: true,
      enableDrag: true,
      builder: (context) => ParentWalletSelectionDialog(
        availableWallets: availableWallets,
        selectedWalletId: selectedWalletId,
      ),
    );
  }

  @override
  State<ParentWalletSelectionDialog> createState() => _ParentWalletSelectionDialogState();
}

class _ParentWalletSelectionDialogState extends State<ParentWalletSelectionDialog> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  Wallet? _selectedWallet;

  @override
  void initState() {
    super.initState();
    if (widget.selectedWalletId != null) {
      _selectedWallet = widget.availableWallets.firstWhere(
        (wallet) => wallet.id == widget.selectedWalletId,
        orElse: () => widget.availableWallets.first,
      );
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Wallet> get _filteredWallets {
    if (_searchQuery.isEmpty) return widget.availableWallets;
    
    return widget.availableWallets.where((wallet) {
      final query = _searchQuery.toLowerCase();
      return wallet.name.toLowerCase().contains(query) ||
             (wallet.description?.toLowerCase().contains(query) ?? false);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: () {},
          child: DraggableScrollableSheet(
            initialChildSize: 0.6,
            minChildSize: 0.4,
            maxChildSize: 0.8,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x1A000000),
                      blurRadius: 10,
                      offset: Offset(0, -4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Handle bar
                    Container(
                      height: 24,
                      width: double.infinity,
                      child: Center(
                        child: Container(
                          height: 6,
                          width: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFFD1D5DB),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ),
                    
                    // Header
                    Container(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xFFF1F5F9),
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              t.components.parentWalletSelection.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              t.components.parentWalletSelection.subtitle,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF64748B),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Search
                    Container(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xFFF1F5F9),
                          ),
                        ),
                      ),
                      child: AppSearchField(
                        controller: _searchController,
                        hintText: t.components.parentWalletSelection.searchPlaceholder,
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                        },
                        onClear: () {
                          _searchController.clear();
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                      ),
                    ),
                    
                    // Wallets List
                    Expanded(
                      child: ListView(
                        controller: scrollController,
                        children: [
                          // No Parent Option
                          _buildWalletOption(
                            icon: Icons.folder_open,
                            iconColor: const Color(0xFF64748B),
                            backgroundColor: const Color(0xFFF1F5F9),
                            title: t.components.parentWalletSelection.noParent,
                            subtitle: t.components.parentWalletSelection.createRoot,
                            isSelected: _selectedWallet == null,
                            onTap: () {
                              setState(() {
                                _selectedWallet = null;
                              });
                            },
                          ),
                          
                          // Available Wallets Section
                          if (_filteredWallets.isNotEmpty) ...[
                            Container(
                              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                              color: const Color(0xFFF8FAFC),
                              child: Text(
                                t.components.parentWalletSelection.available,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF475569),
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                            
                            ..._filteredWallets.map((wallet) {
                              return _buildWalletOption(
                                icon: Icons.account_balance_wallet,
                                iconColor: const Color(0xFF2563EB),
                                backgroundColor: const Color(0xFFDBEAFE),
                                title: wallet.name,
                                subtitle: wallet.description ?? 'Wallet • ${wallet.currencyId}',
                                isSelected: _selectedWallet?.id == wallet.id,
                                onTap: () {
                                  setState(() {
                                    _selectedWallet = wallet;
                                  });
                                },
                              );
                            }),
                          ],
                        ],
                      ),
                    ),
                    
                    // Footer
                    DialogActionBar(
                      onCancel: () => Navigator.of(context).pop(),
                      onConfirm: () => Navigator.of(context).pop(_selectedWallet),
                      cancelText: t.common.cancel,
                      confirmText: t.components.selection.select,
                      isLoading: false,
                      enabled: true,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildWalletOption({
    required IconData icon,
    required Color iconColor,
    required Color backgroundColor,
    required String title,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color(0xFFF1F5F9),
              ),
            ),
          ),
          child: Row(
            children: [
              // Icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 20,
                ),
              ),
              
              const SizedBox(width: 12),
              
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Selection indicator
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 2,
                    color: isSelected 
                        ? const Color(0xFF0c7ff2)
                        : const Color(0xFFD1D5DB),
                  ),
                  color: isSelected 
                      ? const Color(0xFF0c7ff2)
                      : Colors.transparent,
                ),
                child: isSelected
                    ? const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 14,
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
