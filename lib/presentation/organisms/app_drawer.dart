import 'package:flutter/material.dart';
import '../atoms/drawer_header_logo.dart';
import '../molecules/drawer_footer.dart';
import '../organisms/drawer_section.dart';
import '../routes/app_routes.dart';
import '../routes/navigation_service.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final currentRoute = ModalRoute.of(context)?.settings.name;
    
    // Mock data - esto se reemplazará con datos reales posteriormente
    final mainItems = [
      DrawerItemData(
        icon: Icons.dashboard_outlined,
        selectedIcon: Icons.dashboard,
        label: 'Inicio',
        route: AppRoutes.home,
      ),
      DrawerItemData(
        icon: Icons.receipt_long_outlined,
        selectedIcon: Icons.receipt_long,
        label: 'Transacciones',
        route: AppRoutes.transactions,
      ),
    ];
    
    final managementItems = [
      DrawerItemData(
        icon: Icons.contacts,
        selectedIcon: Icons.contacts,
        label: 'Contactos',
        route: AppRoutes.contacts,
      ),
      DrawerItemData(
        icon: Icons.account_balance_outlined,
        selectedIcon: Icons.account_balance,
        label: 'Cuentas',
        route: AppRoutes.accounts,
      ),
      DrawerItemData(
        icon: Icons.category_outlined,
        selectedIcon: Icons.category,
        label: 'Categorías',
        route: AppRoutes.categories,
      ),
    ];
    
    final preferenceItems = [
      DrawerItemData(
        icon: Icons.settings_outlined,
        selectedIcon: Icons.settings,
        label: 'Configuración',
        route: AppRoutes.settings,
      ),
    ];

    void _navigateTo(String route, Map<String, dynamic>? arguments) {
      Navigator.pop(context); // Cerrar drawer
      NavigationService.navigateTo(route, arguments: arguments);
    }

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
              child: DrawerHeaderLogo(
                title: 'MoneyT',
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                DrawerSection(
                  title: 'Principal',
                  items: mainItems,
                  currentRoute: currentRoute,
                  onNavigate: _navigateTo,
                ),
                const SizedBox(height: 16),
                DrawerSection(
                  title: 'Gestión',
                  items: managementItems,
                  currentRoute: currentRoute,
                  onNavigate: _navigateTo,
                ),
                const SizedBox(height: 16),
                DrawerSection(
                  title: 'Preferencias',
                  items: preferenceItems,
                  currentRoute: currentRoute,
                  onNavigate: _navigateTo,
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Container(
            padding: const EdgeInsets.all(12),
            child: SafeArea(
              top: false,
              child: DrawerFooter(
                title: 'MoneyT',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
