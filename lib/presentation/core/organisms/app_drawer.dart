import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../design_system/tokens/app_dimensions.dart';
import '../design_system/tokens/app_colors.dart';
import '../l10n/l10n_helper.dart';
import '../../navigation/app_routes.dart';

/// AppDrawer que replica exactamente el diseño HTML
///
/// Estructura del HTML:
/// - Header: User Profile con avatar y dropdown
/// - Dashboard: Item individual
/// - Operations: Transactions, Loans
/// - Financial Tools: Wallets, Credit Cards
/// - Management: Contacts, Categories
/// - Advanced: Accounting (expandible) con Chart of Accounts, Journal Entries
/// - Footer: Settings + App Info
class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool _isAccountingExpanded = false; // Por defecto minimizada
  String _appVersion = ''; // ✅ AGREGADO: Variable para almacenar la versión

  @override
  void initState() {
    super.initState();
    _loadAppVersion(); // ✅ AGREGADO: Cargar versión al inicializar
  }

  /// ✅ NUEVO: Método para cargar la versión real de la app
  Future<void> _loadAppVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        _appVersion = 'v${packageInfo.version}';
      });
    } catch (e) {
      // En caso de error, usar versión por defecto
      setState(() {
        _appVersion = 'v1.0.0';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name ?? '';

    return Drawer(
      backgroundColor: Colors.white,
      width: 320, // HTML: w-80 (320px)
      child: Column(
        children: [
          // ✅ Header Section - App Branding (Replaces User Profile for now)
          _buildAppHeader(context),

          // ✅ Navigation Section - Scrollable
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(AppDimensions.spacing16),
              child: Column(
                children: [
                  // Dashboard (individual)
                  _buildNavSection(context, currentRoute),

                  SizedBox(height: AppDimensions.spacing24),

                  // Operations Section
                  _buildOperationsSection(context, currentRoute),

                  SizedBox(height: AppDimensions.spacing24),

                  // Financial Tools Section
                  _buildFinancialToolsSection(context, currentRoute),

                  SizedBox(height: AppDimensions.spacing24),

                  // Management Section
                  _buildManagementSection(context, currentRoute),

                  SizedBox(height: AppDimensions.spacing24),

                  // Advanced Section (con subnav expandible)
                  //_buildAdvancedSection(context, currentRoute),
                ],
              ),
            ),
          ),

          // ✅ Footer Section
          _buildFooterSection(context, currentRoute),
        ],
      ),
    );
  }

  /// Header con branding de la App (reemplaza User Profile por ahora)
  Widget _buildAppHeader(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFF1F5F9), // border-slate-100
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.spacing24),
          child: Row(
            children: [
              // App Logo/Icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x1A3B82F6), // blue shadow
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.savings_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),

              SizedBox(width: AppDimensions.spacing12),

              // App Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'MoneyT', // App Name
                      style: TextStyle(
                        color: Color(0xFF1E293B), // text-slate-800
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                    Text(
                      t.app.description, // Branding Slogan
                      style: const TextStyle(
                        color: Color(0xFF64748B), // text-slate-500
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
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

  /// Dashboard (item individual)
  Widget _buildNavSection(BuildContext context, String currentRoute) {
    return _buildNavItem(
      context: context,
      icon: Icons.dashboard_outlined,
      activeIcon: Icons.dashboard,
      title: t.navigation.home, // ✅ TRADUCIDO
      route: AppRoutes.home,
      currentRoute: currentRoute,
    );
  }

  /// Operations Section
  Widget _buildOperationsSection(BuildContext context, String currentRoute) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(t.navigation.sections.operations),
        SizedBox(height: AppDimensions.spacing4),
        _buildNavItem(
          context: context,
          icon: Icons.receipt_long_outlined,
          activeIcon: Icons.receipt_long,
          title: t.navigation.transactions, // ✅ TRADUCIDO
          route: AppRoutes.transactions,
          currentRoute: currentRoute,
        ),
        SizedBox(height: AppDimensions.spacing4),
        _buildNavItem(
          context: context,
          icon: Icons.handshake_outlined,
          activeIcon: Icons.handshake,
          title: t.navigation.loans, // ✅ TRADUCIDO
          route: AppRoutes.loans,
          currentRoute: currentRoute,
        ),
      ],
    );
  }

  /// Financial Tools Section
  Widget _buildFinancialToolsSection(
      BuildContext context, String currentRoute) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(t.navigation.sections.financialTools),
        SizedBox(height: AppDimensions.spacing4),
        _buildNavItem(
          context: context,
          icon: Icons.account_balance_wallet_outlined,
          activeIcon: Icons.account_balance_wallet,
          title: t.navigation.wallets, // ✅ TRADUCIDO
          route: AppRoutes.wallets,
          currentRoute: currentRoute,
        ),
        // Hidden until feature is ready
        /*
        SizedBox(height: AppDimensions.spacing4),
        _buildNavItem(
          context: context,
          icon: Icons.credit_card_outlined,
          activeIcon: Icons.credit_card,
          title: t.navigation.creditCards,
          route: AppRoutes.creditCards,
          currentRoute: currentRoute,
        ),
        */
      ],
    );
  }

  /// Management Section
  Widget _buildManagementSection(BuildContext context, String currentRoute) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(t.navigation.sections.management),
        SizedBox(height: AppDimensions.spacing4),
        _buildNavItem(
          context: context,
          icon: Icons.contacts_outlined,
          activeIcon: Icons.contacts,
          title: t.navigation.contacts, // ✅ TRADUCIDO
          route: AppRoutes.contacts,
          currentRoute: currentRoute,
        ),
        SizedBox(height: AppDimensions.spacing4),
        _buildNavItem(
          context: context,
          icon: Icons.category_outlined,
          activeIcon: Icons.category,
          title: t.navigation.categories, // ✅ TRADUCIDO
          route: AppRoutes.categories,
          currentRoute: currentRoute,
        ),
      ],
    );
  }

  /// Advanced Section (con subnav expandible)
  Widget _buildAdvancedSection(BuildContext context, String currentRoute) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(t.navigation.sections.advanced),
        SizedBox(height: AppDimensions.spacing4),

        // Botón expandible de Accounting
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              setState(() {
                _isAccountingExpanded = !_isAccountingExpanded;
              });
            },
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.spacing12,
                vertical: 10, // py-2.5 (10px)
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: _isAccountingExpanded
                    ? const Color(0xFFEFF6FF) // bg-blue-50
                    : Colors.transparent,
              ),
              child: Row(
                children: [
                  Icon(
                    _isAccountingExpanded
                        ? Icons.analytics
                        : Icons.analytics_outlined,
                    color: _isAccountingExpanded
                        ? const Color(0xFF1D4ED8) // text-blue-700
                        : const Color(0xFF374151), // text-slate-700
                    size: 20,
                  ),
                  SizedBox(width: AppDimensions.spacing12),
                  Expanded(
                    child: Text(
                      'Contabilidad', // ✅ TRADUCIDO
                      style: TextStyle(
                        color: _isAccountingExpanded
                            ? const Color(0xFF1D4ED8)
                            : const Color(0xFF374151),
                        fontSize: 16, // ✅ AUMENTADO: de 15 a 16
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Icon(
                    _isAccountingExpanded
                        ? Icons.expand_less
                        : Icons.expand_more,
                    color: const Color(0xFF94A3B8), // text-slate-400
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
        ),

        // Subnav items (cuando está expandido)
        if (_isAccountingExpanded) ...[
          Container(
            margin: EdgeInsets.only(left: AppDimensions.spacing24),
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: Color(0xFFF1F5F9), // border-slate-100
                  width: 2,
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: AppDimensions.spacing16),
              child: Column(
                children: [
                  SizedBox(height: AppDimensions.spacing4),
                  _buildSubNavItem(
                    context: context,
                    icon: Icons.account_tree_outlined,
                    activeIcon: Icons.account_tree,
                    title: t.navigation.charts, // ✅ TRADUCIDO
                    route: AppRoutes.chartAccounts,
                    currentRoute: currentRoute,
                  ),
                  SizedBox(height: AppDimensions.spacing4),
                  _buildSubNavItem(
                    context: context,
                    icon: Icons.book_outlined,
                    activeIcon: Icons.book,
                    title:
                        'Diarios Contables', // ✅ TRADUCIDO (journals no existe en navegación)
                    route: AppRoutes.journals,
                    currentRoute: currentRoute,
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  /// Footer Section
  Widget _buildFooterSection(BuildContext context, String currentRoute) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color(0xFFF1F5F9), // border-slate-100
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.spacing16),
        child: Column(
          children: [
            // Settings
            _buildNavItem(
              context: context,
              icon: Icons.settings_outlined,
              activeIcon: Icons.settings,
              title: t.navigation.settings,
              route: AppRoutes.settings,
              currentRoute: currentRoute,
            ),

            SizedBox(height: AppDimensions.spacing12),

            // App Info con versión real
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.spacing12,
                vertical: AppDimensions.spacing8,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC), // bg-slate-50
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: Color(0xFF94A3B8), // text-slate-400
                    size: 14,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _appVersion.isEmpty
                        ? 'v1.0.0'
                        : _appVersion, // ✅ MODIFICADO: Usar versión real
                    style: const TextStyle(
                      color: Color(0xFF64748B), // text-slate-500
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Header de sección
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.spacing12,
        vertical: AppDimensions.spacing8,
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF64748B), // text-slate-500
          fontSize: 14, // ✅ AUMENTADO: de 13 a 14
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  /// Item de navegación principal
  Widget _buildNavItem({
    required BuildContext context,
    required IconData icon,
    required IconData activeIcon,
    required String title,
    required String route,
    required String currentRoute,
  }) {
    final isActive =
        currentRoute == route || currentRoute.startsWith('$route/');

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
          if (currentRoute != route) {
            Navigator.of(context).pushReplacementNamed(route);
          }
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.spacing12,
            vertical: 10, // py-2.5 (10px)
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: isActive
                ? const Color(0xFFEFF6FF) // bg-blue-50
                : Colors.transparent,
          ),
          child: Row(
            children: [
              Icon(
                isActive ? activeIcon : icon,
                color: isActive
                    ? const Color(0xFF1D4ED8) // text-blue-700
                    : const Color(0xFF374151), // text-slate-700
                size: 20,
              ),
              SizedBox(width: AppDimensions.spacing12),
              Text(
                title,
                style: TextStyle(
                  color: isActive
                      ? const Color(0xFF1D4ED8)
                      : const Color(0xFF374151),
                  fontSize: 16, // ✅ AUMENTADO: de 15 a 16
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Item de sub-navegación
  Widget _buildSubNavItem({
    required BuildContext context,
    required IconData icon,
    required IconData activeIcon,
    required String title,
    required String route,
    required String currentRoute,
  }) {
    final isActive =
        currentRoute == route || currentRoute.startsWith('$route/');

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
          if (currentRoute != route) {
            Navigator.of(context).pushReplacementNamed(route);
          }
        },
        borderRadius: BorderRadius.circular(6),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.spacing12,
            vertical: AppDimensions.spacing8,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: isActive
                ? const Color(0xFFEFF6FF) // bg-blue-50
                : Colors.transparent,
          ),
          child: Row(
            children: [
              Icon(
                isActive ? activeIcon : icon,
                color: isActive
                    ? const Color(0xFF1D4ED8) // text-blue-700
                    : const Color(0xFF64748B), // text-slate-600
                size: 16,
              ),
              SizedBox(width: AppDimensions.spacing12),
              Text(
                title,
                style: TextStyle(
                  color: isActive
                      ? const Color(0xFF1D4ED8)
                      : const Color(0xFF64748B),
                  fontSize: 16, // ✅ AUMENTADO: de 15 a 16
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
