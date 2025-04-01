import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart'; // Añadir esta importación
import '../molecules/account_balance_card.dart';
import '../molecules/stats_card.dart';
import '../molecules/transaction_list_item.dart';
import '../organisms/app_drawer.dart';
import '../routes/navigation_service.dart';
import '../routes/app_routes.dart';
import '../../domain/entities/transaction_entry.dart';
import '../../domain/usecases/transaction_usecases.dart'; // Añadir esta importación

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Añadir esta propiedad para acceder a transactionUseCases
  final _transactionUseCases = GetIt.instance<TransactionUseCases>();
  
  // Datos de ejemplo para la pantalla principal
  final _mockTotalBalance = 2500.0;
  final _mockIncomeMonth = 1500.0;
  final _mockExpensesMonth = 850.0;
  final _mockSavingsMonth = 650.0;
  
  // Lista de transacciones recientes para mostrar
  List<TransactionEntry> _recentTransactions = [];
  
  // Simulación de cuentas
  final _mockAccounts = [
    {'name': 'Cuenta Principal', 'balance': 1800.0},
    {'name': 'Ahorros', 'balance': 4500.0},
    {'name': 'Efectivo', 'balance': 200.0},
  ];

  @override
  void initState() {
    super.initState();
    _loadRecentTransactions(); // Cargar transacciones al iniciar
  }

  void _navigateToTransactionForm({String type = 'all'}) {
    NavigationService.navigateTo(AppRoutes.transactionForm, arguments: {
      'type': type,
    });
  }

  Future<void> _loadRecentTransactions() async {
    try {
      final transactions = await _transactionUseCases.getAllTransactions();
      setState(() {
        _recentTransactions = transactions.take(5).toList();
      });
    } catch (e) {
      // Manejo de errores
    }
  }

  // Método para recargar todos los datos del dashboard
  Future<void> _loadDashboardData() async {
    await _loadRecentTransactions();
    // Agregar aquí otras cargas de datos cuando se implementen
  }

  void _navigateToTransactionDetail(TransactionEntry transaction) async {
    final result = await NavigationService.navigateTo(
      AppRoutes.transactionDetail,
      arguments: transaction,
    );

    if (result != null) {
      _loadDashboardData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('MoneyT'),
        centerTitle: true,
        elevation: 0,
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () async {
          // Aquí iría la lógica para refrescar los datos
          await Future.delayed(const Duration(seconds: 1));
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Balance total
              AccountBalanceCard(
                title: 'Balance Total',
                balance: _mockTotalBalance,
                currencySymbol: '\$',
                onTap: () => NavigationService.navigateTo(AppRoutes.wallets),
              ),
              
              const SizedBox(height: 20),
              
              // Estadísticas mensuales
              Row(
                children: [
                  Expanded(
                    child: StatsCard(
                      title: 'Ingresos',
                      amount: _mockIncomeMonth,
                      iconData: Icons.arrow_upward,
                      backgroundColor: colorScheme.primaryContainer,
                      iconColor: colorScheme.primary,
                      textColor: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: StatsCard(
                      title: 'Gastos',
                      amount: _mockExpensesMonth,
                      iconData: Icons.arrow_downward,
                      backgroundColor: colorScheme.errorContainer,
                      iconColor: colorScheme.error,
                      textColor: colorScheme.error,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              StatsCard(
                title: 'Ahorros',
                amount: _mockSavingsMonth,
                iconData: Icons.savings,
                backgroundColor: colorScheme.tertiaryContainer,
                iconColor: colorScheme.tertiary,
                textColor: colorScheme.tertiary,
              ),
              
              const SizedBox(height: 20),
              
              // Mis cuentas
              _buildSection(
                title: 'Mis Cuentas', 
                onViewAll: () => NavigationService.navigateTo(AppRoutes.wallets)
              ),
              
              _buildAccountsList(),
              
              const SizedBox(height: 20),
              
              // Transacciones recientes
              _buildSection(
                title: 'Transacciones Recientes', 
                onViewAll: () => NavigationService.navigateTo(AppRoutes.transactions)
              ),
              
              _buildRecentTransactions(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToTransactionForm(),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        child: const Icon(Icons.add),
      ),
    );
  }
  
  Widget _buildSection({required String title, required VoidCallback onViewAll}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: onViewAll,
          child: const Text('Ver todo'),
        ),
      ],
    );
  }
  
  Widget _buildAccountsList() {
    return Column(
      children: _mockAccounts.map((account) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
            ),
          ),
          child: ListTile(
            title: Text(account['name'] as String),
            subtitle: Text('Balance'),
            trailing: Text(
              '\$${(account['balance'] as double).toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {}, // Aquí iría la navegación al detalle de la cuenta
          ),
        );
      }).toList(),
    );
  }
  
  Widget _buildRecentTransactions() {
    if (_recentTransactions.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text('No hay transacciones recientes'),
        ),
      );
    }

    // Simulación de categorías para mostrar
    final mockCategories = {1: 'Alimentación', 2: 'Transporte', 5: 'Salario'};
    
    return Column(
      children: _recentTransactions.map((transaction) {
        return TransactionListItem(
          transaction: transaction,
          categoryName: transaction.mainCategoryId != null ? 
            mockCategories[transaction.mainCategoryId] : null,
          onTap: () => _navigateToTransactionDetail(transaction),
          onDelete: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Función de eliminar aún no implementada')),
            );
          },
        );
      }).toList(),
    );
  }
}