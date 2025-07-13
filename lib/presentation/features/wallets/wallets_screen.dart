import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:moneyt_pfm/presentation/core/atoms/app_button.dart';
import '../../../domain/entities/wallet.dart';
import '../../../domain/entities/chart_account.dart';
import '../../../domain/usecases/wallet_usecases.dart';
import '../../../domain/usecases/chart_account_usecases.dart';
import '../../core/atoms/app_app_bar.dart'; // ✅ AGREGADO
import '../../core/atoms/app_floating_action_button.dart'; // ✅ AGREGADO
import '../../core/design_system/theme/app_dimensions.dart';
import '../../core/molecules/wallet_tree_item.dart';
import '../../core/molecules/wallet_type_filter.dart'; // ✅ NUEVO
import '../../core/molecules/total_balance_card.dart'; // ✅ NUEVO
import '../../core/molecules/empty_state.dart';
import '../../core/organisms/app_drawer.dart';
import '../../navigation/navigation_service.dart';
import '../../navigation/app_routes.dart';
import '../../core/molecules/add_wallet_inline_button.dart'; // ✅ AGREGADO: Import de AddWalletInlineButton
import '../../../domain/services/balance_calculation_service.dart'; // ✅ AGREGADO: Import del servicio de balance
import '../../core/molecules/wallet_options_dialog.dart'; // ✅ AGREGADO: Import del diálogo de opciones

class WalletsScreen extends StatefulWidget {
  const WalletsScreen({Key? key}) : super(key: key);

  @override
  State<WalletsScreen> createState() => _WalletsScreenState();
}

class _WalletsScreenState extends State<WalletsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final WalletUseCases _walletUseCases = GetIt.instance<WalletUseCases>();
  final ChartAccountUseCases _chartAccountUseCases = GetIt.instance<ChartAccountUseCases>();

  List<Wallet> _wallets = [];
  Map<int, ChartAccount> _chartAccountsMap = {};
  WalletFilterType _selectedFilter = WalletFilterType.all; // ✅ NUEVO
  bool _isLoading = true;
  String? _error;
  bool _isBalanceVisible = true; // ✅ NUEVO
  final Map<int, bool> _expandedWallets = {}; // ✅ NUEVO: Track expansion state
  final BalanceCalculationService _balanceService = GetIt.instance<BalanceCalculationService>(); // ✅ AGREGADO: Servicio de balance
  Map<int, double> _walletBalances = {}; // ✅ AGREGADO: Cache de balances por wallet
  double _monthlyIncome = 0.0; // ✅ AGREGADO: Para guardar los ingresos del mes

  @override
  void initState() {
    super.initState();
    _loadWallets();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _loadWallets() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
        _error = null;
      });
    }

    try {
      final wallets = await _walletUseCases.getAllWallets();
      final chartAccountIds = wallets.map((w) => w.chartAccountId).toSet();
      final chartAccounts = await _chartAccountUseCases.getAllChartAccounts();

      final chartAccountsMap = <int, ChartAccount>{};
      for (final account in chartAccounts) {
        if (chartAccountIds.contains(account.id)) {
          chartAccountsMap[account.id] = account;
        }
      }

      // ✅ AGREGADO: Cargar balances para todas las wallets
      await _loadWalletBalances(wallets);

      // ✅ AGREGADO: Cargar ingresos del mes
      final monthlyIncome = await _balanceService.calculateMonthlyIncome();

      if (mounted) {
        setState(() {
          _wallets = wallets;
          _chartAccountsMap = chartAccountsMap;
          _monthlyIncome = monthlyIncome; // ✅ AGREGADO: Guardar ingresos
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  /// ✅ CORREGIDO: Cargar y consolidar balances para wallets padre e hijas.
  Future<void> _loadWalletBalances(List<Wallet> wallets) async {
    try {
      final Map<int, double> individualBalances = {};
      // 1. Calcular el balance individual de CADA wallet (padres y hijas).
      for (final wallet in wallets) {
        final balance = await _balanceService.calculateWalletBalance(wallet.id);
        individualBalances[wallet.id] = balance;
      }

      final Map<int, double> consolidatedBalances = Map.from(individualBalances);

      // 2. Consolidar balances para las wallets padre.
      for (final parentWallet in wallets) {
        final children = wallets.where((w) => w.parentId == parentWallet.id).toList();
        if (children.isNotEmpty) {
          double parentTotal = 0.0;
          for (final child in children) {
            parentTotal += individualBalances[child.id] ?? 0.0;
          }
          consolidatedBalances[parentWallet.id] = parentTotal;
        }
      }
      
      if (mounted) {
        setState(() {
          _walletBalances = consolidatedBalances;
        });
      }
    } catch (e) {
      print('Error loading wallet balances: $e');
      if (mounted) {
        setState(() {
          _walletBalances = {for (var wallet in wallets) wallet.id: 0.0};
        });
      }
    }
  }

  void _navigateToWalletForm({Wallet? wallet}) async {
    final result = await NavigationService.navigateTo(
      AppRoutes.walletForm,
      arguments: wallet,
    );

    if (result != null) {
      _loadWallets();
    }
  }

  Future<void> _deleteWallet(Wallet wallet) async {
    try {
      final children = await _walletUseCases.getWalletsByParent(wallet.id);
      if (children.isNotEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No se puede eliminar una billetera que tiene sub-billeteras.'),
              backgroundColor: Colors.orange,
            ),
          );
        }
        return;
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al verificar sub-billeteras: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
      return;
    }

    // ✅ CORREGIDO: Usar AlertDialog estándar en lugar de ConfirmDeleteDialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.account_balance_wallet_outlined,
              color: Theme.of(context).colorScheme.error,
              size: 24,
            ),
            const SizedBox(width: 12),
            const Text('Eliminar billetera'),
          ],
        ),
        content: RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyMedium,
            children: [
              const TextSpan(text: '¿Estás seguro de eliminar '),
              TextSpan(
                text: wallet.name,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const TextSpan(text: '?'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Confirmar eliminación'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await _walletUseCases.deleteWallet(wallet.id);
        _loadWallets();

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Billetera eliminada con éxito'),
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error al eliminar: $e'),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      }
    }
  }

  // ✅ CORREGIDO: Usar balance calculado en lugar de propiedad inexistente
  double get _totalBalance {
    // Para evitar duplicar saldos, solo sumar las wallets que no tienen padre (top-level).
    // Sus saldos ya están consolidados (si son padres) o son individuales (si no tienen hijos).
    return _wallets
        .where((wallet) => wallet.parentId == null && _shouldShowWallet(wallet))
        .fold(0.0, (sum, wallet) => sum + (_walletBalances[wallet.id] ?? 0.0));
  }

  // ✅ CORREGIDO: Usar el valor real de ingresos mensuales
  double get _monthlyGrowth => _monthlyIncome;

  // ✅ NUEVO: Filtrar wallets según tipo
  bool _shouldShowWallet(Wallet wallet) {
    switch (_selectedFilter) {
      case WalletFilterType.all:
        return true;
      case WalletFilterType.active:
        return wallet.active;
      case WalletFilterType.archived:
        return !wallet.active;
    }
  }

  // ✅ NUEVO: Obtener wallets filtradas
  List<Wallet> get _filteredWallets {
    return _wallets.where(_shouldShowWallet).toList();
  }

  /// ✅ NUEVO: Construir tree de wallets con balances calculados
  Map<Wallet, List<Wallet>> _buildWalletTree() {
    final filteredWallets = _filteredWallets;
    final Map<Wallet, List<Wallet>> walletTree = {};
    final rootWallets = filteredWallets.where((w) => w.parentId == null).toList();

    for (var rootWallet in rootWallets) {
      final children = filteredWallets
          .where((w) => w.parentId == rootWallet.id)
          .toList();
      children.sort((a, b) => a.name.compareTo(b.name));
      walletTree[rootWallet] = children;
    }

    // Ordenar wallets padre por balance (mayor a menor) o alfabéticamente
    final sortedRootWallets = rootWallets..sort((a, b) {
      // Opción 1: Ordenar por balance descendente
      // final balanceA = _getWalletBalance(a);
      // final balanceB = _getWalletBalance(b);
      // return balanceB.compareTo(balanceA);
      
      // Opción 2: Ordenar alfabéticamente (más consistente)
      return a.name.compareTo(b.name);
    });
    
    return {
      for (var root in sortedRootWallets) root: walletTree[root]!
    };
  }

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final walletTree = _buildWalletTree();

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF8FAFC), // HTML: bg-slate-50
      
      // ✅ NUEVO: AppBar con blur effect exacto del HTML
      appBar: AppAppBar(
        title: 'Wallets',
        type: AppAppBarType.blur, // HTML: bg-slate-50/80 backdrop-blur-md
        leading: AppAppBarLeading.drawer,
        actions: [AppAppBarAction.search],
        onLeadingPressed: _openDrawer,
        onActionsPressed: [_showSearch],
      ),
      
      drawer: const AppDrawer(),
      
      body: Column(
        children: [
          // ✅ CORREGIDO: Agregar padding a los filtros de tipo de wallet
          Container(
            padding: const EdgeInsets.all(16), // HTML: px-4 py-4 similar a categories
            child: WalletTypeFilter(
              selectedType: _selectedFilter,
              onTypeChanged: (type) {
                setState(() {
                  _selectedFilter = type;
                });
              },
            ),
          ),
          
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator(color: Color(0xFF0c7ff2)))
                : _error != null
                    ? _buildErrorState()
                    : RefreshIndicator(
                        onRefresh: _loadWallets,
                        color: const Color(0xFF0c7ff2),
                        child: _buildWalletsList(walletTree),
                      ),
          ),
        ],
      ),
      
      // ✅ NUEVO: Usar AppFloatingActionButton
      floatingActionButton: AppFloatingActionButton(
        onPressed: () => _navigateToWalletForm(),
        icon: Icons.add,
        tooltip: 'Create wallet',
        backgroundColor: const Color(0xFF0c7ff2),
      ),
    );
  }

  // ✅ NUEVO: Construir lista de wallets con balance card
  Widget _buildWalletsList(Map<Wallet, List<Wallet>> walletTree) {
    if (_filteredWallets.isEmpty) {
      return _buildEmptyState();
    }

    return ListView(
      padding: const EdgeInsets.only(bottom: 80), // Espacio para FAB
      children: [
        // ✅ NUEVO: Total Balance Card
        TotalBalanceCard(
          totalBalance: _totalBalance,
          monthlyGrowth: _monthlyGrowth,
          isBalanceVisible: _isBalanceVisible,
          onVisibilityToggle: () {
            setState(() {
              _isBalanceVisible = !_isBalanceVisible;
            });
          },
        ),
        
        const SizedBox(height: 24), // HTML: mt-6
        
        // ✅ NUEVO: Wallet Tree Items con balances calculados
        ...walletTree.entries.map((entry) {
          final parentWallet = entry.key;
          final childWallets = entry.value;
          final parentBalance = _getWalletBalance(parentWallet);
          
          // Crear mapa de balances para wallets hijos
          final childBalances = <int, double>{};
          for (final child in childWallets) {
            childBalances[child.id] = _getWalletBalance(child);
          }
          
          return WalletTreeItem(
            parentWallet: parentWallet,
            childWallets: childWallets,
            chartAccount: _chartAccountsMap[parentWallet.chartAccountId],
            isExpanded: _expandedWallets[parentWallet.id] ?? true, // Default expanded como en HTML
            parentBalance: parentBalance, // ✅ AGREGADO: Pasar balance del padre
            childBalances: childBalances, // ✅ AGREGADO: Pasar balances de hijos
            onToggleExpansion: () {
              setState(() {
                _expandedWallets[parentWallet.id] = !(_expandedWallets[parentWallet.id] ?? true);
              });
            },
            onWalletTap: (wallet) => _navigateToWalletForm(wallet: wallet),
            onWalletMorePressed: (wallet) => _showWalletOptions(wallet),
          );
        }),
        
        // ✅ ELIMINADO: AddWalletInlineButton - solo usar FAB
        // AddWalletInlineButton(
        //   onPressed: () => _navigateToWalletForm(),
        // ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return ListView(
      children: [
        EmptyState(
          icon: Icons.account_balance_wallet_outlined,
          title: 'No hay billeteras', // ✅ CORREGIDO: Remover referencias a _searchQuery
          message: 'Añade tu primera billetera para comenzar a gestionar tus finanzas',
          action: AppButton(
            text: 'Crear billetera',
            onPressed: () => _navigateToWalletForm(),
            type: AppButtonType.filled,
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacing16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: AppDimensions.spacing48,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: AppDimensions.spacing16),
            const Text(
              'Error al cargar las billeteras',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppDimensions.spacing8),
            Text(_error ?? 'Error desconocido'),
            const SizedBox(height: AppDimensions.spacing16),
            AppButton(
              text: 'Reintentar',
              onPressed: _loadWallets,
              type: AppButtonType.filled,
            ),
          ],
        ),
      ),
    );
  }

  void _showSearch() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Search functionality coming soon'),
        backgroundColor: Color(0xFF0c7ff2),
      ),
    );
  }

  void _showWalletOptions(Wallet wallet) {
    final balance = _getWalletBalance(wallet);
    final chartAccount = _chartAccountsMap[wallet.chartAccountId];
    
    WalletOptionsDialog.show(
      context: context,
      wallet: wallet,
      chartAccount: chartAccount,
      balance: balance,
      onOptionSelected: (option) => _handleWalletOption(wallet, option),
    );
  }

  /// ✅ NUEVO: Maneja las opciones seleccionadas del diálogo de wallet
  void _handleWalletOption(Wallet wallet, WalletOption option) {
    switch (option) {
      case WalletOption.viewTransactions:
        _viewWalletTransactions(wallet);
        break;
      case WalletOption.transferFunds:
        _transferFunds(wallet);
        break;
      case WalletOption.editWallet:
        _navigateToWalletForm(wallet: wallet);
        break;
      case WalletOption.duplicateWallet:
        _duplicateWallet(wallet);
        break;
      case WalletOption.archiveWallet:
        _archiveWallet(wallet);
        break;
      case WalletOption.deleteWallet:
        _deleteWallet(wallet);
        break;
    }
  }

  /// ✅ NUEVO: Ver transacciones de la wallet
  void _viewWalletTransactions(Wallet wallet) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('View transactions for ${wallet.name}'),
        backgroundColor: const Color(0xFF0c7ff2),
        action: SnackBarAction(
          label: 'Coming Soon',
          textColor: Colors.white,
          onPressed: () {},
        ),
      ),
    );
  }

  /// ✅ NUEVO: Transferir fondos
  void _transferFunds(Wallet wallet) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Transfer funds from ${wallet.name}'),
        backgroundColor: const Color(0xFF0c7ff2),
        action: SnackBarAction(
          label: 'Coming Soon',
          textColor: Colors.white,
          onPressed: () {},
        ),
      ),
    );
  }

  /// ✅ NUEVO: Duplicar wallet
  Future<void> _duplicateWallet(Wallet wallet) async {
    try {
      // Crear una copia del wallet con nombre modificado
      final now = DateTime.now();
      final duplicatedWallet = await _walletUseCases.createWalletWithAccount(
        parentId: wallet.parentId,
        name: '${wallet.name} (Copy)',
        description: wallet.description,
        currencyId: wallet.currencyId,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Wallet "${wallet.name}" duplicated successfully'),
            backgroundColor: const Color(0xFF16A34A),
            action: SnackBarAction(
              label: 'Edit',
              textColor: Colors.white,
              onPressed: () => _navigateToWalletForm(wallet: duplicatedWallet),
            ),
          ),
        );
        
        _loadWallets(); // Recargar lista
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error duplicating wallet: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  /// ✅ NUEVO: Archivar wallet
  Future<void> _archiveWallet(Wallet wallet) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.archive,
              color: const Color(0xFFEA580C),
              size: 24,
            ),
            const SizedBox(width: 12),
            const Text('Archive wallet'),
          ],
        ),
        content: RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyMedium,
            children: [
              const TextSpan(text: 'Are you sure you want to archive '),
              TextSpan(
                text: wallet.name,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const TextSpan(text: '? It will be hidden from the main view but can be restored later.'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFFEA580C),
            ),
            child: const Text('Archive'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        // Actualizar wallet como inactiva (archived)
        final archivedWallet = Wallet(
          id: wallet.id,
          parentId: wallet.parentId,
          currencyId: wallet.currencyId,
          chartAccountId: wallet.chartAccountId,
          name: wallet.name,
          description: wallet.description,
          active: false, // Marcar como inactiva
          createdAt: wallet.createdAt,
          updatedAt: DateTime.now(),
          deletedAt: null,
        );

        await _walletUseCases.updateWallet(archivedWallet);
        _loadWallets();

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Wallet "${wallet.name}" archived successfully'),
              backgroundColor: const Color(0xFFEA580C),
              action: SnackBarAction(
                label: 'Undo',
                textColor: Colors.white,
                onPressed: () => _restoreWallet(archivedWallet),
              ),
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error archiving wallet: $e'),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      }
    }
  }

  /// ✅ NUEVO: Restaurar wallet archivada
  Future<void> _restoreWallet(Wallet wallet) async {
    try {
      final restoredWallet = Wallet(
        id: wallet.id,
        parentId: wallet.parentId,
        currencyId: wallet.currencyId,
        chartAccountId: wallet.chartAccountId,
        name: wallet.name,
        description: wallet.description,
        active: true, // Restaurar como activa
        createdAt: wallet.createdAt,
        updatedAt: DateTime.now(),
        deletedAt: null,
      );

      await _walletUseCases.updateWallet(restoredWallet);
      _loadWallets();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Wallet "${wallet.name}" restored successfully'),
            backgroundColor: const Color(0xFF16A34A),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error restoring wallet: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  // ✅ NUEVO: Helper para obtener balance de una wallet específica
  double _getWalletBalance(Wallet wallet) {
    return _walletBalances[wallet.id] ?? 0.0;
  }
}
