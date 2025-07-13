import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/molecules/form_action_bar.dart';

import '../../../core/organisms/account_selector_modal.dart'
    show SelectableAccount;

// HTML Color Palette
const Color _primaryBlue = Color(0xFF0C7FF2);
const Color _slate50 = Color(0xFFF8FAFC);
const Color _slate100 = Color(0xFFF1F5F9);
const Color _slate200 = Color(0xFFE2E8F0);
const Color _slate300 = Color(0xFFCBD5E1);
const Color _slate500 = Color(0xFF64748B);
const Color _slate600 = Color(0xFF475569);
const Color _slate800 = Color(0xFF1E293B);
const Color _blue100 = Color(0xFFDBEAFE);
const Color _blue600 = Color(0xFF2563EB);
const Color _purple100 = Color(0xFFF3E8FF);
const Color _purple600 = Color(0xFF9333EA);

class AccountSelectionDialog extends StatefulWidget {
  final List<SelectableAccount> accounts;
  final SelectableAccount? initialSelection;

  const AccountSelectionDialog({
    super.key,
    required this.accounts,
    this.initialSelection,
  });

  static Future<SelectableAccount?> show(
    BuildContext context, {
    required List<SelectableAccount> accounts,
    SelectableAccount? initialSelection,
  }) {
    return showModalBottomSheet<SelectableAccount?>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AccountSelectionDialog(
        accounts: accounts,
        initialSelection: initialSelection,
      ),
    );
  }

  @override
  State<AccountSelectionDialog> createState() => _AccountSelectionDialogState();
}

class _AccountSelectionDialogState extends State<AccountSelectionDialog> {
  final _searchController = TextEditingController();
  late SelectableAccount? _selectedAccount;
  List<SelectableAccount> _filteredAccounts = [];

  @override
  void initState() {
    super.initState();
    _selectedAccount = widget.initialSelection;
    _filteredAccounts = widget.accounts;
    _searchController.addListener(_filterAccounts);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterAccounts);
    _searchController.dispose();
    super.dispose();
  }

  void _filterAccounts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredAccounts = widget.accounts.where((account) {
        return account.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      maxChildSize: 0.8,
      minChildSize: 0.5,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drag Handle, Header, Search...
              Center(
                child: Container(
                  height: 24,
                  alignment: Alignment.center,
                  child: Container(
                    height: 6,
                    width: 40,
                    decoration: BoxDecoration(
                      color: _slate300,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Select account',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: _slate800)),
                    SizedBox(height: 4),
                    Text('Choose where this transaction will be recorded',
                        style: TextStyle(fontSize: 14, color: _slate500)),
                  ],
                ),
              ),
              const Divider(height: 1, color: _slate100),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search accounts',
                    hintStyle: const TextStyle(color: _slate500),
                    prefixIcon: const Icon(Icons.search, color: _slate500),
                    filled: true,
                    fillColor: _slate100,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: _slate200),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: _slate200),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: _primaryBlue, width: 1.5),
                    ),
                  ),
                ),
              ),
              const Divider(height: 1, color: _slate100),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: EdgeInsets.zero,
                  children: _buildAccountList(),
                ),
              ),
              FormActionBar(
                onCancel: () => Navigator.of(context).pop(),
                onSave: () => Navigator.of(context).pop(_selectedAccount),
                saveText: 'Select',
                enabled: _selectedAccount != null,
              )
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildAccountList() {
    final List<Widget> listItems = [];
    final wallets = _filteredAccounts.where((a) => !a.isCreditCard).toList();
    final creditCards = _filteredAccounts.where((a) => a.isCreditCard).toList();
    final currencyFormat = NumberFormat.currency(locale: 'es_ES', symbol: '€');

    if (wallets.isNotEmpty) {
      listItems.add(_buildSectionHeader('Wallets'));

      final childrenByParentId = <int, List<SelectableAccount>>{};
      wallets.where((w) => w.parentAccountId != null).forEach((child) {
        childrenByParentId
            .putIfAbsent(child.parentAccountId!, () => [])
            .add(child);
      });

      final rootWallets =
          wallets.where((w) => w.parentAccountId == null).toList();

      for (final rootWallet in rootWallets) {
        final children = childrenByParentId[rootWallet.id] ?? [];
        final isParent = children.isNotEmpty;

        if (isParent) {
          // Render parent account as a non-selectable header
          listItems.add(Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
            child: Text(rootWallet.name.toUpperCase(),
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: _slate600,
                    letterSpacing: 0.5)),
          ));
          // Render children, indented and selectable
          for (final child in children) {
            final details =
                '****${child.last4Digits} • ${currencyFormat.format(child.balance ?? 0.0)}';
            listItems.add(Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: _AccountListItem(
                  icon: Icons.account_balance,
                  iconBgColor: _blue100,
                  iconColor: _blue600,
                  name: child.name,
                  details: details,
                  isSelected: _selectedAccount?.id == child.id &&
                      !(_selectedAccount?.isCreditCard ?? true),
                  onTap: () => setState(() => _selectedAccount = child)),
            ));
          }
        } else {
          // Render standalone account as a selectable item
          final details =
              '****${rootWallet.last4Digits} • ${currencyFormat.format(rootWallet.balance ?? 0.0)}';
          listItems.add(_AccountListItem(
              icon: Icons.account_balance,
              iconBgColor: _blue100,
              iconColor: _blue600,
              name: rootWallet.name,
              details: details,
              isSelected: _selectedAccount?.id == rootWallet.id &&
                  !(_selectedAccount?.isCreditCard ?? true),
              onTap: () => setState(() => _selectedAccount = rootWallet)));
        }
      }
    }

    if (creditCards.isNotEmpty) {
      listItems.add(_buildSectionHeader('Credit Cards'));
      for (final account in creditCards) {
        final details =
            '****${account.last4Digits} • Available: ${currencyFormat.format(account.availableCredit ?? 0.0)}';
        listItems.add(_AccountListItem(
          icon: Icons.credit_card,
          iconBgColor: _purple100,
          iconColor: _purple600,
          name: account.name,
          details: details,
          isSelected: _selectedAccount?.id == account.id &&
              _selectedAccount?.isCreditCard == account.isCreditCard,
          onTap: () => setState(() => _selectedAccount = account),
        ));
      }
    }

    return listItems;
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: _slate50,
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: _slate600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _AccountListItem extends StatelessWidget {
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final String name;
  final String details;
  final bool isSelected;
  final VoidCallback? onTap;

  const _AccountListItem({
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    required this.name,
    required this.details,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: _slate200)),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: _slate800)),
                  const SizedBox(height: 2),
                  Text(details,
                      style: const TextStyle(fontSize: 14, color: _slate600)),
                ],
              ),
            ),
            const SizedBox(width: 12),
            if (isSelected)
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: _primaryBlue,
                  shape: BoxShape.circle,
                  border: Border.all(color: _primaryBlue, width: 2),
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 12),
              )
            else
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: _slate300, width: 2),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
