import 'package:flutter/material.dart';
import '../molecules/account_balance_card.dart';
import '../molecules/stats_card.dart';
import '../molecules/transaction_list_item.dart';
import '../organisms/app_drawer.dart';
import '../routes/navigation_service.dart';
import '../routes/app_routes.dart';
import '../../domain/entities/transaction.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Datos de ejemplo para la pantalla principal
  final _mockTotalBalance = 2500.0;
  final _mockIncomeMonth = 1500.0;
  final _mockExpensesMonth = 850.0;
  final _mockSavingsMonth = 650.0;
  
  // Lista de transacciones recientes para mostrar
  final _recentTransactions = [
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
  
  // Simulación de cuentas
  final _mockAccounts = [
    {'name': 'Cuenta Principal', 'balance': 1800.0},
    {'name': 'Ahorros', 'balance': 4500.0},
    {'name': 'Efectivo', 'balance': 200.0},
  ];

  void _navigateToTransactionForm({String type = 'all'}) {
    NavigationService.navigateTo(AppRoutes.transactionForm, arguments: {
      'type': type,
    });
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
    // Simulación de categorías para mostrar
    final mockCategories = {1: 'Alimentación', 2: 'Transporte', 5: 'Salario'};
    
    return Column(
      children: _recentTransactions.map((transaction) {
        return TransactionListItem(
          transaction: transaction,
          categoryName: transaction.categoryId != null ? 
            mockCategories[transaction.categoryId] : null,
          onTap: () => _navigateToTransactionForm(
            type: transaction.type,
          ),
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