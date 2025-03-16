import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/transaction.dart';
import '../atoms/app_button.dart';
import '../molecules/empty_state.dart';
import '../molecules/search_field.dart';
import '../molecules/transaction_list_item.dart';
import '../molecules/date_filter_selector.dart';
import '../organisms/app_drawer.dart';
import '../organisms/transaction_list_section.dart';
import '../routes/navigation_service.dart';
import '../routes/app_routes.dart';

// Datos de ejemplo para transacciones
final mockTransactions = [
  TransactionEntity(
    id: 1,
    type: 'E',
    flow: 'O',
    amount: 45.50,
    accountId: 1,
    categoryId: 1,
    description: 'Compra supermercado',
    transactionDate: DateTime.now().subtract(const Duration(days: 1)),
    createdAt: DateTime.now(),
  ),
  TransactionEntity(
    id: 2,
    type: 'I',
    flow: 'I',
    amount: 1200.00,
    accountId: 1,
    categoryId: 5,
    description: 'Salario',
    transactionDate: DateTime.now().subtract(const Duration(days: 2)),
    createdAt: DateTime.now(),
  ),
  TransactionEntity(
    id: 3,
    type: 'E',
    flow: 'O',
    amount: 35.75,
    accountId: 2,
    categoryId: 2,
    description: 'Gasolina',
    transactionDate: DateTime.now().subtract(const Duration(days: 3)),
    createdAt: DateTime.now(),
  ),
  TransactionEntity(
    id: 4,
    type: 'T',
    flow: 'T',
    amount: 200.00,
    accountId: 1,
    reference: 'Cuenta 2',
    description: 'Transferencia entre cuentas',
    transactionDate: DateTime.now().subtract(const Duration(days: 4)),
    createdAt: DateTime.now(),
  ),
];

// Mapas simulados de categorías y contactos para visualización
final mockCategories = {1: 'Alimentación', 2: 'Transporte', 3: 'Entretenimiento', 5: 'Salario'};
final mockContacts = {1: 'Ana García', 2: 'Juan Pérez'};

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> with SingleTickerProviderStateMixin {
  final _searchController = TextEditingController();
  late TabController _tabController;
  String _searchQuery = '';
  List<TransactionEntity> _transactions = [...mockTransactions];
  DateTime? _startDate;
  DateTime? _endDate;
  String _selectedFilter = 'all'; // all, month, week, custom

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
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
      });
    }
  }

  void _navigateToTransactionForm({TransactionEntity? transaction}) async {
    final type = transaction?.type ?? (_tabController.index == 0 
        ? 'all' 
        : _tabController.index == 1 
            ? 'E' 
            : _tabController.index == 2 
                ? 'I' 
                : 'T');
    
    final result = await NavigationService.navigateTo(
      AppRoutes.transactionForm,
      arguments: {
        'transaction': transaction,
        'type': type,
      }
    );

    if (result != null && result is TransactionEntity) {
      setState(() {
        if (transaction != null) {
          // Actualizar transacción existente
          final index = _transactions.indexWhere((t) => t.id == transaction.id);
          if (index >= 0) {
            _transactions[index] = result;
          }
        } else {
          // Añadir nueva transacción
          _transactions.add(result);
        }
      });
    }
  }

  Future<void> _deleteTransaction(TransactionEntity transaction) async {
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
      setState(() {
        _transactions.removeWhere((t) => t.id == transaction.id);
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Transacción eliminada con éxito')),
      );
    }
  }

  List<TransactionEntity> _getFilteredTransactions() {
    final currentTabIndex = _tabController.index;
    
    return _transactions.where((transaction) {
      // Filtrar por tipo según la pestaña seleccionada
      final matchesType = currentTabIndex == 0 || 
                        (currentTabIndex == 1 && transaction.type == 'E') || 
                        (currentTabIndex == 2 && transaction.type == 'I') || 
                        (currentTabIndex == 3 && transaction.type == 'T');
      
      // Filtrar por búsqueda de texto
      final matchesSearch = _searchQuery.isEmpty || 
                          transaction.description?.toLowerCase().contains(_searchQuery.toLowerCase()) == true ||
                          (transaction.categoryId != null && 
                            mockCategories[transaction.categoryId]?.toLowerCase().contains(_searchQuery.toLowerCase()) == true);
      
      // Filtrar por fecha
      final matchesDate = (_startDate == null || transaction.transactionDate.isAfter(_startDate!)) && 
                        (_endDate == null || transaction.transactionDate.isBefore(_endDate!.add(const Duration(days: 1))));
      
      return matchesType && matchesSearch && matchesDate;
    }).toList()
      ..sort((a, b) => b.transactionDate.compareTo(a.transactionDate)); // Ordenar por fecha descendente
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
      body: Column(
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
              children: List.generate(4, (index) => _buildTransactionsList(filteredTransactions)),
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

  Widget _buildTransactionsList(List<TransactionEntity> transactions) {
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
    final groupedTransactions = <String, List<TransactionEntity>>{};
    for (final transaction in transactions) {
      final dateString = DateFormat('yyyy-MM-dd').format(transaction.transactionDate);
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
          categoriesMap: mockCategories,
          contactsMap: mockContacts,
          onTransactionTap: (transaction) => _navigateToTransactionForm(transaction: transaction),
          onTransactionDelete: _deleteTransaction,
        );
      },
    );
  }
}
