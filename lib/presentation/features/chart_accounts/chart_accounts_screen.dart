import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../domain/entities/chart_account.dart';
import '../../../domain/usecases/chart_account_usecases.dart';
import '../../core/atoms/app_button.dart';
import '../../core/molecules/chart_account_type_filter.dart';
import '../../core/molecules/chart_account_list_item.dart';  // Añadir esta importación
import '../../core/molecules/empty_state.dart';
import '../../core/molecules/search_field.dart';
import '../../core/organisms/app_drawer.dart';
import '../../core/organisms/chart_account_tree_view.dart';
import '../../navigation/navigation_service.dart';
import '../../navigation/app_routes.dart';

class ChartAccountsScreen extends StatefulWidget {
  const ChartAccountsScreen({Key? key}) : super(key: key);

  @override
  State<ChartAccountsScreen> createState() => _ChartAccountsScreenState();
}

class _ChartAccountsScreenState extends State<ChartAccountsScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  String? _selectedType;
  List<ChartAccount> _accounts = [];
  bool _showTreeView = true;
  bool _isLoading = true;
  String? _error;

  late final ChartAccountUseCases _chartAccountUseCases;

  @override
  void initState() {
    super.initState();
    _chartAccountUseCases = GetIt.instance<ChartAccountUseCases>();
    _loadAccounts();
  }

  Future<void> _loadAccounts() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final accounts = await _chartAccountUseCases.getAllChartAccounts();
      
      if (mounted) {
        setState(() {
          _accounts = accounts;
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _navigateToChartAccountForm({ChartAccount? account}) async {
    final result = await NavigationService.navigateTo(
      AppRoutes.chartAccountForm,
      arguments: account,
    );

    if (result != null && result is ChartAccount) {
      _loadAccounts(); // Recargar todas las cuentas para reflejar cambios en la jerarquía
    }
  }

  Future<void> _deleteChartAccount(ChartAccount account) async {
    // Verificar si la cuenta tiene hijos
    final hasChildren = _accounts.any((a) => a.parentId == account.id);
    
    if (hasChildren) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No se puede eliminar una cuenta que tiene subcuentas'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Confirmar eliminación
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar cuenta'),
        content: Text('¿Estás seguro de eliminar la cuenta ${account.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      try {
        await _chartAccountUseCases.deleteChartAccount(account.id);
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Cuenta eliminada con éxito'),
              backgroundColor: Colors.green,
            ),
          );
          _loadAccounts(); // Recargar las cuentas
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error al eliminar cuenta: ${e.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  List<ChartAccount> _getFilteredAccounts() {
    return _accounts.where((account) {
      final matchesType = _selectedType == null || account.accountingTypeId == _selectedType;
      final matchesSearch = _searchQuery.isEmpty || 
          account.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          account.code.toLowerCase().contains(_searchQuery.toLowerCase());
      
      return matchesType && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final filteredAccounts = _getFilteredAccounts();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plan de Cuentas'),
        centerTitle: true,
        elevation: 0,
        actions: [
          // Botón para alternar entre vista de árbol y lista
          IconButton(
            icon: Icon(_showTreeView ? Icons.view_list : Icons.account_tree),
            onPressed: () {
              setState(() {
                _showTreeView = !_showTreeView;
              });
            },
            tooltip: _showTreeView ? 'Ver como lista' : 'Ver como árbol',
          ),
          // Eliminamos el botón de refrescar que estaba aquí
        ],
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          // Barra de búsqueda
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SearchField(
              controller: _searchController,
              hintText: 'Buscar cuentas',
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          
          // Filtro por tipo de cuenta
          ChartAccountTypeFilter(
            selectedType: _selectedType,
            onTypeSelected: (type) {
              setState(() {
                _selectedType = type;
              });
            },
          ),
          
          // Lista de cuentas
          Expanded(
            child: RefreshIndicator(
              onRefresh: _loadAccounts,
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _error != null
                      ? _buildErrorState()
                      : _showTreeView
                          ? _buildChartAccountTreeView(filteredAccounts)
                          : _buildChartAccountListView(filteredAccounts),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToChartAccountForm(),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        child: const Icon(Icons.add),
      ),
    );
  }

  // Añadir el método que falta para mostrar el estado de error
  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline,
            size: 48,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 16),
          const Text('Error al cargar las cuentas'),
          const SizedBox(height: 8),
          Text(_error ?? 'Error desconocido'),
          const SizedBox(height: 16),
          AppButton(
            text: 'Reintentar',
            onPressed: _loadAccounts,
            type: AppButtonType.filled,
          ),
        ],
      ),
    );
  }

  // Añadir método para construir la vista de árbol
  Widget _buildChartAccountTreeView(List<ChartAccount> accounts) {
    if (accounts.isEmpty) {
      return _buildEmptyState();
    }

    return ChartAccountTreeView(
      accounts: accounts,
      onAccountTap: (account) => _navigateToChartAccountForm(account: account),
      onAccountDelete: _deleteChartAccount,
    );
  }

  // Añadir método para construir la vista de lista
  Widget _buildChartAccountListView(List<ChartAccount> accounts) {
    if (accounts.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: accounts.length,
      itemBuilder: (context, index) {
        final account = accounts[index];
        return ChartAccountListItem(
          account: account,
          indentation: 0, // Sin indentación en vista de lista
          onTap: () => _navigateToChartAccountForm(account: account),
          onDelete: () => _deleteChartAccount(account),
        );
      },
    );
  }

  // Método auxiliar para estado vacío
  Widget _buildEmptyState() {
    return EmptyState(
      icon: Icons.account_balance_outlined,
      title: 'No hay cuentas',
      message: _searchQuery.isEmpty && _selectedType == null
        ? 'Crea una nueva cuenta utilizando el botón "+"'
        : 'No se encontraron cuentas con los filtros aplicados',
      action: (_searchQuery.isNotEmpty || _selectedType != null) ? AppButton(
        text: 'Limpiar filtros',
        onPressed: () {
          _searchController.clear();
          setState(() {
            _searchQuery = '';
            _selectedType = null;
          });
        },
        type: AppButtonType.text,
      ) : null,
    );
  }
}
