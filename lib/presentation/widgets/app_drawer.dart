// lib/presentation/widgets/app_drawer.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../routes/app_routes.dart';
import '../../core/l10n/language_manager.dart';
import '../../core/navigation/navigation_service.dart';
import '../providers/drawer_provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final translations = context.watch<LanguageManager>().translations;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final provider = context.watch<DrawerProvider>();

    return Drawer(
      backgroundColor: colorScheme.surface,
      elevation: 0,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.account_balance_wallet,
                    size: 48,
                    color: colorScheme.onPrimaryContainer,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    translations.appName,
                    style: textTheme.headlineSmall?.copyWith(
                      color: colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                _buildSection(
                  context,
                  title: translations.main,
                  items: [
                    _DrawerItem(
                      icon: Icons.dashboard_outlined,
                      selectedIcon: Icons.dashboard,
                      label: translations.home,
                      route: AppRoutes.home,
                    ),
                    _DrawerItem(
                      icon: Icons.receipt_long_outlined,
                      selectedIcon: Icons.receipt_long,
                      label: translations.transactions,
                      route: AppRoutes.transactions,
                      arguments: {
                        'transactionUseCases': provider.transactionUseCases,
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildSection(
                  context,
                  title: translations.management,
                  items: [
                    _DrawerItem(
                      icon: Icons.contacts,
                      selectedIcon: Icons.contacts,
                      label: translations.contacts,
                      route: AppRoutes.contacts,
                      arguments: {
                        'getContacts': provider.getContacts,
                        'createContact': provider.createContact,
                        'updateContact': provider.updateContact,
                        'deleteContact': provider.deleteContact,
                      },
                    ),
                    _DrawerItem(
                      icon: Icons.account_balance_outlined,
                      selectedIcon: Icons.account_balance,
                      label: translations.accounts,
                      route: AppRoutes.accounts,
                      arguments: {
                        'getAccounts': provider.getAccounts,
                        'createAccount': provider.createAccount,
                        'updateAccount': provider.updateAccount,
                        'deleteAccount': provider.deleteAccount,
                      },
                    ),
                    _DrawerItem(
                      icon: Icons.category_outlined,
                      selectedIcon: Icons.category,
                      label: translations.categories,
                      route: AppRoutes.categories,
                      arguments: {
                        'getCategories': provider.getCategories,
                        'createCategory': provider.createCategory,
                        'updateCategory': provider.updateCategory,
                        'deleteCategory': provider.deleteCategory,
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildSection(
                  context,
                  title: translations.preferences,
                  items: [
                    _DrawerItem(
                      icon: Icons.settings_outlined,
                      selectedIcon: Icons.settings,
                      label: translations.settings,
                      route: AppRoutes.settings,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Container(
            padding: const EdgeInsets.all(12),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.info_outline,
                      color: colorScheme.onPrimaryContainer,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'MoneyT',
                          style: textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'v1.0.0',
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required List<_DrawerItem> items,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final currentRoute = ModalRoute.of(context)?.settings.name;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: textTheme.titleSmall?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...items.map((item) {
          final isSelected = currentRoute == item.route;
          return ListTile(
            leading: Icon(
              isSelected ? item.selectedIcon : item.icon,
              color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
            ),
            title: Text(
              item.label,
              style: textTheme.bodyLarge?.copyWith(
                color: isSelected ? colorScheme.primary : colorScheme.onSurface,
                fontWeight: isSelected ? FontWeight.bold : null,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
            selected: isSelected,
            selectedTileColor: colorScheme.primaryContainer.withOpacity(0.3),
            onTap: () => NavigationService.navigateToScreen(
              context,
              item.route,
              arguments: item.arguments,
            ),
          );
        }),
      ],
    );
  }
}

class _DrawerItem {
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final String route;
  final Map<String, dynamic>? arguments;

  const _DrawerItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.route,
    this.arguments,
  });
}