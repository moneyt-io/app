import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/loan_provider.dart';
import '../../molecules/loan_list_item.dart';
import '../../molecules/loan_summary_card.dart';
import '../../routes/app_routes.dart';
import '../../routes/navigation_service.dart';
import '../../../core/presentation/app_dimensions.dart';

class LoansScreen extends StatefulWidget {
  const LoansScreen({super.key});

  @override
  State<LoansScreen> createState() => _LoansScreenState();
}

class _LoansScreenState extends State<LoansScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Map<String, double> _statistics = {};
  bool _statisticsLoading = true;
  bool _initialLoadCompleted = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialData();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadInitialData() async {
    if (_initialLoadCompleted) return;
    
    final provider = Provider.of<LoanProvider>(context, listen: false);
    await provider.loadLoans();
    await _loadStatistics();
    
    if (mounted) {
      setState(() {
        _initialLoadCompleted = true;
      });
    }
  }

  Future<void> _loadStatistics() async {
    final provider = Provider.of<LoanProvider>(context, listen: false);
    final stats = await provider.getStatistics();
    setState(() {
      _statistics = stats;
      _statisticsLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Préstamos'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Todos'),
            Tab(text: 'Prestados'),
            Tab(text: 'Recibidos'),
            Tab(text: 'Pendientes'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadInitialData,
          ),
        ],
      ),
      body: Consumer<LoanProvider>(
        builder: (context, provider, child) {
          // Mostrar loading solo si no hemos cargado inicialmente Y está cargando
          if (!_initialLoadCompleted && provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              // Tarjeta de resumen
              Padding(
                padding: const EdgeInsets.all(AppDimensions.spacing16),
                child: LoanSummaryCard(
                  totalLent: _statistics['totalLent'] ?? 0.0,
                  totalBorrowed: _statistics['totalBorrowed'] ?? 0.0,
                  outstandingLent: _statistics['outstandingLent'] ?? 0.0,
                  outstandingBorrowed: _statistics['outstandingBorrowed'] ?? 0.0,
                  netBalance: _statistics['netBalance'] ?? 0.0,
                  isLoading: _statisticsLoading,
                ),
              ),

              // Lista de préstamos
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildLoansList(provider.loans),
                    _buildLoansList(provider.activeLends),
                    _buildLoansList(provider.activeBorrows),
                    _buildLoansList(provider.outstandingLoans),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToCreateLoan,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildLoansList(List loans) {
    if (loans.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_balance_wallet_outlined, size: 64, color: Colors.grey),
            SizedBox(height: AppDimensions.spacing16),
            Text(
              'No hay préstamos registrados',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadInitialData,
      child: ListView.builder(
        padding: const EdgeInsets.all(AppDimensions.spacing16),
        itemCount: loans.length,
        itemBuilder: (context, index) {
          final loan = loans[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: AppDimensions.spacing8),
            child: LoanListItem(
              loan: loan,
              onTap: () => _navigateToLoanDetail(loan),
              onEdit: () => _navigateToEditLoan(loan),
              onDelete: () => _showDeleteDialog(loan),
              onMarkPaid: () => _showMarkPaidDialog(loan),
            ),
          );
        },
      ),
    );
  }

  void _navigateToCreateLoan() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppDimensions.spacing16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Tipo de Préstamo',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppDimensions.spacing16),
            ListTile(
              leading: const Icon(Icons.trending_up, color: Colors.blue),
              title: const Text('Prestar Dinero'),
              subtitle: const Text('Dinero que prestas a otros'),
              onTap: () {
                Navigator.pop(context);
                NavigationService.navigateTo(
                  AppRoutes.loanForm,
                  arguments: {'loanType': 'L'},
                ).then((result) {
                  if (result != null) {
                    _loadInitialData();
                  }
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.trending_down, color: Colors.orange),
              title: const Text('Pedir Prestado'),
              subtitle: const Text('Dinero que recibes de otros'),
              onTap: () {
                Navigator.pop(context);
                NavigationService.navigateTo(
                  AppRoutes.loanForm,
                  arguments: {'loanType': 'B'},
                ).then((result) {
                  if (result != null) {
                    _loadInitialData();
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToLoanDetail(loan) {
    NavigationService.navigateTo(
      AppRoutes.loanDetail,
      arguments: loan,
    );
  }

  void _navigateToEditLoan(loan) {
    NavigationService.navigateTo(
      AppRoutes.loanForm,
      arguments: loan,
    ).then((result) {
      if (result != null) {
        _loadInitialData();
      }
    });
  }

  void _showDeleteDialog(loan) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: Text(
          '¿Estás seguro de que deseas eliminar este préstamo?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.pop(context);
              final provider = Provider.of<LoanProvider>(context, listen: false);
              await provider.deleteLoan(loan.id);
              await _loadStatistics();
            },
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  void _showMarkPaidDialog(loan) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Registrar Pago'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('¿Registrar pago para este préstamo?'),
            const SizedBox(height: 16),
            Text(
              'Saldo pendiente: \$${loan.outstandingBalance.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Funcionalidad completa próximamente. Por ahora se registrará un pago simple.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.pop(context);
              final provider = Provider.of<LoanProvider>(context, listen: false);
              
              // Registrar pago por el saldo completo pendiente
              await provider.createLoanPayment(
                loanId: loan.id,
                paymentAmount: loan.outstandingBalance,
                date: DateTime.now(),
                description: 'Pago completo del préstamo',
              );
              
              await _loadStatistics();
            },
            child: const Text('Registrar Pago'),
          ),
        ],
      ),
    );
  }

  void _showWriteOffDialog(loan) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancelar Saldo Pendiente'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('¿Deseas cancelar el saldo pendiente de este préstamo?'),
            const SizedBox(height: 16),
            Text(
              'Saldo a cancelar: \$${loan.outstandingBalance.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Esta acción marcará el préstamo como "Asumido/Cancelado" y no se podrá revertir.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.orange,
            ),
            onPressed: () async {
              Navigator.pop(context);
              final provider = Provider.of<LoanProvider>(context, listen: false);
              
              await provider.writeOffLoan(
                loanId: loan.id,
                description: 'Saldo cancelado/asumido',
              );
              
              await _loadStatistics();
            },
            child: const Text('Cancelar Saldo'),
          ),
        ],
      ),
    );
  }
}
