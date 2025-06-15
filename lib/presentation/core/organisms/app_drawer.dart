import 'package:flutter/material.dart';
import '../../navigation/navigation_service.dart';
import '../../navigation/app_routes.dart';
import '../design_system/theme/app_dimensions.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  void _navigateToScreen(BuildContext context, String routeName) {
    // Cerrar el drawer primero
    Navigator.of(context).pop();
    
    // Navegar usando context en lugar de NavigationService
    Navigator.of(context).pushNamed(routeName);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Header del drawer
          DrawerHeader(
            decoration: BoxDecoration(
              color: colorScheme.primary,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.account_balance_wallet,
                  size: 48,
                  color: colorScheme.onPrimary,
                ),
                const SizedBox(height: AppDimensions.spacing16),
                Text(
                  'MoneyT',
                  style: textTheme.headlineSmall?.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Gestor Financiero',
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onPrimary.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),

          // Dashboard/Home
          DrawerListTile(
            icon: Icons.dashboard,
            title: 'Dashboard',
            onTap: () => _navigateToScreen(context, AppRoutes.home),
          ),

          const DrawerDivider(),

          // Sección de Transacciones
          DrawerSectionHeader(title: 'TRANSACCIONES'),

          DrawerListTile(
            icon: Icons.receipt_long,
            title: 'Transacciones',
            onTap: () => _navigateToScreen(context, AppRoutes.transactions),
          ),

          DrawerListTile(
            icon: Icons.trending_up,
            title: 'Préstamos',
            onTap: () => _navigateToScreen(context, AppRoutes.loans),
          ),

          const DrawerDivider(),

          // Sección de Cuentas
          DrawerSectionHeader(title: 'CUENTAS'),

          DrawerListTile(
            icon: Icons.account_balance_wallet_outlined,
            title: 'Billeteras',
            onTap: () => _navigateToScreen(context, AppRoutes.wallets),
          ),

          DrawerListTile(
            icon: Icons.credit_card,
            title: 'Tarjetas de Crédito',
            onTap: () => _navigateToScreen(context, AppRoutes.creditCards),
          ),

          const DrawerDivider(),

          // Sección de Configuración
          DrawerSectionHeader(title: 'CONFIGURACIÓN'),

          DrawerListTile(
            icon: Icons.category,
            title: 'Categorías',
            onTap: () => _navigateToScreen(context, AppRoutes.categories),
          ),

          DrawerListTile(
            icon: Icons.people,
            title: 'Contactos',
            onTap: () => _navigateToScreen(context, AppRoutes.contacts),
          ),

          DrawerListTile(
            icon: Icons.account_tree,
            title: 'Plan de Cuentas',
            onTap: () => _navigateToScreen(context, AppRoutes.chartAccounts),
          ),

          DrawerListTile(
            icon: Icons.book,
            title: 'Diarios Contables',
            onTap: () => _navigateToScreen(context, AppRoutes.journals),
          ),

          const DrawerDivider(),

          // Sección de Sistema
          DrawerSectionHeader(title: 'SISTEMA'),

          DrawerListTile(
            icon: Icons.backup,
            title: 'Respaldos',
            onTap: () => _navigateToScreen(context, AppRoutes.backups),
          ),

          DrawerListTile(
            icon: Icons.settings,
            title: 'Configuración',
            onTap: () => _navigateToScreen(context, AppRoutes.settings),
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const DrawerListTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: AppDimensions.iconSizeMedium,
      ),
      title: Text(title),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacing24,
        vertical: AppDimensions.spacing4,
      ),
    );
  }
}

class DrawerSectionHeader extends StatelessWidget {
  final String title;

  const DrawerSectionHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.spacing24,
        AppDimensions.spacing16,
        AppDimensions.spacing24,
        AppDimensions.spacing8,
      ),
      child: Text(
        title,
        style: textTheme.labelSmall?.copyWith(
          color: colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class DrawerDivider extends StatelessWidget {
  const DrawerDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacing16,
        vertical: AppDimensions.spacing8,
      ),
      child: Divider(
        height: 1,
        color: Theme.of(context).colorScheme.outlineVariant,
      ),
    );
  }
}
