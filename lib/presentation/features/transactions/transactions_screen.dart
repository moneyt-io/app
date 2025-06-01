import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../domain/entities/transaction_entry.dart';
import '../../../domain/usecases/transaction_usecases.dart';
import '../../../domain/usecases/category_usecases.dart';
import '../../../domain/usecases/contact_usecases.dart';
import '../../core/atoms/app_button.dart';
import '../../core/molecules/empty_state.dart';
import '../../core/molecules/search_field.dart';
import '../../core/molecules/confirm_delete_dialog.dart';
import '../../core/organisms/app_drawer.dart';
import '../../core/organisms/transaction_list_view.dart';
import '../../navigation/navigation_service.dart';
import '../../navigation/app_routes.dart';
import '../../core/theme/app_dimensions.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> with SingleTickerProviderStateMixin {
  final _searchController = TextEditingController();
  final _transactionUseCases = GetIt.instance<TransactionUseCases>();
  final _categoryUseCases = GetIt.instance<CategoryUseCases>();
  final _contactUseCases = GetIt.instance<ContactUseCases>();
  
  late TabController _tabController;
  String _searchQuery = '';
  List<TransactionEntry> _transactions = [];
  Map<int, String> _categoriesMap = {};
  Map<int, String> _contactsMap = {};
  
  DateTime? _startDate;
  DateTime? _endDate;
  String _selectedFilter = 'all'; // all, month, week, custom
  
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        _loadTransactions();
      }
    });
    _loadCategoriesAndContacts();
    _loadTransactions();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadCategoriesAndContacts() async {
    try {
      // Cargar categorías
      final categories = await _categoryUseCases.getAllCategories();
      final categoriesMap = {for (var c in categories) c.id: c.name};
      
      // Cargar contactos
      final contacts = await _contactUseCases.getAllContacts();
      final contactsMap = {for (var c in contacts) c.id: c.name};
      
      setState(() {
        _categoriesMap = categoriesMap;
        _contactsMap = contactsMap;
      });
    } catch (e) {
      // Mostrar error si es necesario
    }
  }

  Future<void> _loadTransactions() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });
      
      List<TransactionEntry> transactions;
      
      // Filtrar por tipo según la pestaña
      switch (_tabController.index) {
        case 1: // Gastos
          transactions = await _transactionUseCases.getTransactionsByType('E');
          break;
        case 2: // Ingresos
          transactions = await _transactionUseCases.getTransactionsByType('I');
          break;
        case 3: // Transferencias
          transactions = await _transactionUseCases.getTransactionsByType('T');
          break;
        default: // Todas
          transactions = await _transactionUseCases.getAllTransactions();
      }
      
      setState(() {
        _transactions = transactions;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _applyDateFilter(String filter) {
    setState(() {
      _selectedFilter = filter;
      final now = DateTime.now();
      
      switch (filter) {
        case 'all':
          _startDate = null;
          _endDate = null;
          break;
        case 'month':
          _startDate = DateTime(now.year, now.month, 1);
          _endDate = DateTime(now.year, now.month + 1, 0);
          break;
        case 'week':
          // Calcular el inicio de la semana (lunes)
          final weekDay = now.weekday;
          _startDate = now.subtract(Duration(days: weekDay - 1));
          _endDate = now.add(Duration(days: 7 - weekDay));
          break;
        case 'custom':
          // No hacer nada, el calendario se mostrará para selección personalizada
          break;
      }
      
      _loadTransactions();
    });
  }

  Future<void> _selectCustomDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      initialDateRange: DateTimeRange(
        start: _startDate ?? DateTime.now().subtract(const Duration(days: 30)),
        end: _endDate ?? DateTime.now(),
      ),
    );

    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
        _selectedFilter = 'custom';
        _loadTransactions();
      });
    }
  }

  void _navigateToTransactionForm({TransactionEntry? transaction}) async {
    String type = 'all';
    if (transaction != null) {
      type = transaction.documentTypeId;
    } else if (_tabController.index > 0) {
      switch (_tabController.index) {
        case 1: type = 'E'; break;
        case 2: type = 'I'; break;
        case 3: type = 'T'; break;
      }
    }
    
    final result = await NavigationService.navigateTo(
      AppRoutes.transactionForm,
      arguments: {
        'transaction': transaction,
        'type': type,
      }
    );

    if (result != null) {
      _loadTransactions();
    }
  }

  void _navigateToTransactionDetail(TransactionEntry transaction) async {
    // Corregir la navegación asegurándose de usar la constante correcta de la ruta
    final result = await NavigationService.navigateTo(
      AppRoutes.transactionDetail, // Usar la constante de ruta correcta
      arguments: transaction
    );

    if (result != null) {
      _loadTransactions();
    }
  }

  Future<void> _deleteTransaction(TransactionEntry transaction) async {
    // Reemplazar el AlertDialog directo con ConfirmDeleteDialog
    final confirmed = await ConfirmDeleteDialog.show(
      context: context,
      title: 'Eliminar transacción',
      message: '¿Estás seguro de eliminar',
      itemName: transaction.description ?? 'esta transacción',
      icon: Icons.receipt_long_outlined,
      isDestructive: true,
    );

    if (confirmed == true) {
      try {
        await _transactionUseCases.deleteTransaction(transaction.id);
        _loadTransactions();
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Transacción eliminada con éxito')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error al eliminar: ${e.toString()}'),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      }
    }
  }

  List<TransactionEntry> _getFilteredTransactions() {
    return _transactions.where((transaction) {
      // Filtrar por búsqueda de texto
      final matchesSearch = _searchQuery.isEmpty || 
                          transaction.description?.toLowerCase().contains(_searchQuery.toLowerCase()) == true ||
                          (_categoriesMap[transaction.mainCategoryId]?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false);
      
      // Filtrar por fecha
      final matchesDate = (_startDate == null || transaction.date.isAfter(_startDate!) || transaction.date.isAtSameMomentAs(_startDate!)) && 
                         (_endDate == null || transaction.date.isBefore(_endDate!.add(const Duration(days: 1))));
      
      return matchesSearch && matchesDate;
    }).toList()
      ..sort((a, b) => b.date.compareTo(a.date)); // Ordenar por fecha descendente
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final filteredTransactions = _getFilteredTransactions();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transacciones'),
        centerTitle: true,
        elevation: 0,
        actions: [
          // Agregamos un IconButton para el filtro de fechas que abrirá un diálogo
          IconButton(
            icon: Icon(
              Icons.filter_list,
              color: colorScheme.primary,
            ),
            onPressed: () => _showFilterDialog(context),
            tooltip: 'Filtrar por fecha',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Todas'),
            Tab(text: 'Gastos'),
            Tab(text: 'Ingresos'),
            Tab(text: 'Transferencias'),
          ],
          labelColor: colorScheme.primary,
          indicatorColor: colorScheme.primary,
          dividerColor: Colors.transparent,
          isScrollable: true,
        ),
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          // Barra de búsqueda
          Padding(
            padding: EdgeInsets.all(AppDimensions.spacing16),
            child: SearchField(
              controller: _searchController,
              hintText: 'Buscar transacciones',
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
          ),
          
          // Contenido principal
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _error != null
                    ? _buildErrorState()
                    : RefreshIndicator(
                        onRefresh: _loadTransactions,
                        child: filteredTransactions.isEmpty
                            ? _buildEmptyState()
                            : TransactionListView(
                                transactions: filteredTransactions,
                                categoriesMap: _categoriesMap,
                                contactsMap: _contactsMap,
                                onTransactionTap: _navigateToTransactionDetail,
                                onTransactionDelete: _deleteTransaction,
                                onTransactionEdit: (transaction) => 
                                  _navigateToTransactionForm(transaction: transaction),
                              ),
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToTransactionForm(),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 2,
        child: Icon(Icons.add, size: AppDimensions.iconSizeMedium),
      ),
    );
  }
  
  // Método para mostrar diálogo de filtro
  Future<void> _showFilterDialog(BuildContext context) async {
    final colorScheme = Theme.of(context).colorScheme;
    
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Filtrar por fecha'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('Todas'),
              leading: Radio<String>(
                value: 'all',
                groupValue: _selectedFilter,
                onChanged: (value) {
                  Navigator.pop(context);
                  _applyDateFilter(value!);
                },
              ),
            ),
            ListTile(
              title: Text('Este mes'),
              leading: Radio<String>(
                value: 'month',
                groupValue: _selectedFilter,
                onChanged: (value) {
                  Navigator.pop(context);
                  _applyDateFilter(value!);
                },
              ),
            ),
            ListTile(
              title: Text('Esta semana'),
              leading: Radio<String>(
                value: 'week',
                groupValue: _selectedFilter,
                onChanged: (value) {
                  Navigator.pop(context);
                  _applyDateFilter(value!);
                },
              ),
            ),
            ListTile(
              title: Text('Rango personalizado'),
              leading: Radio<String>(
                value: 'custom',
                groupValue: _selectedFilter,
                onChanged: (value) {
                  Navigator.pop(context);
                  _selectCustomDateRange();
                },
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.spacing16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: AppDimensions.spacing48,
              color: Theme.of(context).colorScheme.error,
            ),
            SizedBox(height: AppDimensions.spacing16),
            Text(
              'Error al cargar las transacciones',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppDimensions.spacing8),
            Text(_error ?? 'Error desconocido'),
            SizedBox(height: AppDimensions.spacing24),
            ElevatedButton(
              onPressed: _loadTransactions,
              child: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return EmptyState(
      icon: Icons.receipt_long_outlined,
      title: 'No hay transacciones',
      message: _searchQuery.isEmpty && _selectedFilter == 'all'
        ? 'Crea una nueva transacción utilizando el botón "+"'
        : 'No se encontraron transacciones con los filtros aplicados',
      action: _searchQuery.isNotEmpty || _selectedFilter != 'all' ? AppButton(
        text: 'Limpiar filtros',
        onPressed: () {
          _searchController.clear();
          setState(() {
            _searchQuery = '';
            _applyDateFilter('all');
          });
        },
        type: AppButtonType.text,
      ) : null,
    );
  }
}
