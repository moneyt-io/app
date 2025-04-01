import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/transaction_entry.dart';
import '../../domain/usecases/transaction_usecases.dart';
import '../../domain/usecases/category_usecases.dart';
import '../../domain/usecases/contact_usecases.dart';
import '../atoms/app_button.dart';
import '../molecules/empty_state.dart';
import '../molecules/search_field.dart';
import '../molecules/date_filter_selector.dart';
import '../organisms/app_drawer.dart';
import '../organisms/transaction_list_section.dart';
import '../routes/navigation_service.dart';
import '../routes/app_routes.dart';

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
    final result = await NavigationService.navigateTo(
      AppRoutes.transactionDetail,
      arguments: transaction
    );

    if (result != null) {
      _loadTransactions();
    }
  }

  Future<void> _deleteTransaction(TransactionEntry transaction) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar transacción'),
        content: const Text('¿Estás seguro de eliminar esta transacción?'),
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
            SnackBar(content: Text('Error al eliminar: ${e.toString()}')),
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
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator())
        : _error != null
          ? _buildErrorState()
          : Column(
              children: [
                // Barra de búsqueda
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SearchField(
                    controller: _searchController,
                    hintText: 'Buscar transacciones',
                    onChanged: (value) => setState(() => _searchQuery = value),
                  ),
                ),
                
                // Selector de filtro por fecha
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: DateFilterSelector(
                    selectedFilter: _selectedFilter,
                    startDate: _startDate,
                    endDate: _endDate,
                    onFilterChanged: _applyDateFilter,
                    onCustomDateSelected: _selectCustomDateRange,
                  ),
                ),
                
                const SizedBox(height: 8),
                
                // Lista de transacciones
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: List.generate(4, (index) => 
                      _buildTransactionsList(filteredTransactions)
                    ),
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToTransactionForm(),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            const Text(
              'Error al cargar las transacciones',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(_error ?? 'Error desconocido'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _loadTransactions,
              child: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionsList(List<TransactionEntry> transactions) {
    if (transactions.isEmpty) {
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

    // Agrupar transacciones por fecha
    final groupedTransactions = <String, List<TransactionEntry>>{};
    for (final transaction in transactions) {
      final dateString = DateFormat('yyyy-MM-dd').format(transaction.date);
      if (!groupedTransactions.containsKey(dateString)) {
        groupedTransactions[dateString] = [];
      }
      groupedTransactions[dateString]!.add(transaction);
    }

    final sortedDates = groupedTransactions.keys.toList()..sort((a, b) => b.compareTo(a));

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: sortedDates.length,
      itemBuilder: (context, index) {
        final dateString = sortedDates[index];
        final date = DateTime.parse(dateString);
        final transactionsForDate = groupedTransactions[dateString]!;
        
        return TransactionListSection(
          title: DateFormat.yMMMMEEEEd('es').format(date),
          transactions: transactionsForDate,
          categoriesMap: _categoriesMap,
          contactsMap: _contactsMap,
          onTransactionTap: _navigateToTransactionDetail,
          onTransactionDelete: _deleteTransaction,
        );
      },
    );
  }
}
