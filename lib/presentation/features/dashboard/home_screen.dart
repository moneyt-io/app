import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart'; // Añadir esta importación
import '../../core/molecules/account_balance_card.dart';
import '../../core/molecules/stats_card.dart';
import '../../core/molecules/transaction_list_item.dart';
import '../../core/organisms/app_drawer.dart';
import '../../navigation/navigation_service.dart';
import '../../navigation/app_routes.dart';
import '../../../domain/entities/transaction_entry.dart';
import '../../../domain/entities/wallet.dart'; // Importar entidad Wallet
import '../../../domain/usecases/transaction_usecases.dart'; // Añadir esta importación

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
  
  // Simulación de cuentas - ACTUALIZADO para usar Wallet entities
  final List<Wallet> _mockWallets = [
    Wallet(
      id: 1,
      parentId: null,
      currencyId: 'COP',
      chartAccountId: 1,
      name: 'Cuenta Principal',
      description: 'Cuenta bancaria principal',
      active: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      deletedAt: null,
    ),
    Wallet(
      id: 2,
      parentId: null,
      currencyId: 'COP',
      chartAccountId: 2,
      name: 'Ahorros',
      description: 'Cuenta de ahorros',
      active: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      deletedAt: null,
    ),
    Wallet(
      id: 3,
      parentId: null,
      currencyId: 'COP',
      chartAccountId: 3,
      name: 'Efectivo',
      description: 'Dinero en efectivo',
      active: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      deletedAt: null,
    ),
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
              Column(
                children: _mockWallets.map((wallet) => AccountBalanceCard(
                  wallet: wallet,
                  onTap: () => NavigationService.navigateTo(AppRoutes.wallets),
                )).toList(),
              ),
              
              const SizedBox(height: 20),
              
              // Estadísticas mensuales
              Row(
                children: [
                  Expanded(
                    child: StatsCard(
                      title: 'Ingresos',
                      value: '\$${_mockIncomeMonth.toStringAsFixed(0)}', // CORREGIDO: agregar value
                      icon: Icons.arrow_upward, // CORREGIDO: cambiar iconData por icon
                      color: colorScheme.primary, // CORREGIDO: usar color en lugar de múltiples propiedades
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: StatsCard(
                      title: 'Gastos',
                      value: '\$${_mockExpensesMonth.toStringAsFixed(0)}', // CORREGIDO: agregar value
                      icon: Icons.arrow_downward, // CORREGIDO: cambiar iconData por icon
                      color: colorScheme.error, // CORREGIDO: usar color en lugar de múltiples propiedades
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              StatsCard(
                title: 'Ahorros',
                value: '\$${_mockSavingsMonth.toStringAsFixed(0)}', // CORREGIDO: agregar value
                icon: Icons.savings, // CORREGIDO: cambiar iconData por icon
                color: colorScheme.tertiary, // CORREGIDO: usar color en lugar de múltiples propiedades
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
      children: _mockWallets.map((wallet) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
            ),
          ),
          child: ListTile(
            title: Text(wallet.name),
            subtitle: Text('Balance'),
            trailing: Text(
              'Balance calculado', // CORREGIDO: remover referencia a wallet.balance
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