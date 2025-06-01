import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../domain/entities/loan_entry.dart';
import 'loan_provider.dart';
import '../../core/molecules/loan_list_item.dart';
import '../../core/molecules/loan_summary_card.dart';
import '../../navigation/app_routes.dart';
import '../../navigation/navigation_service.dart';
import '../../core/design_system/theme/app_dimensions.dart';

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
    try {
      final stats = await provider.getStatistics();
      if (mounted) {
        setState(() {
          _statistics = stats;
          _statisticsLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _statisticsLoading = false;
        });
      }
    }
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
      body: Column(
        children: [
          // Tarjeta de resumen
          LoanSummaryCard(
            statistics: _statistics,
            isLoading: _statisticsLoading,
          ),
          
          // Contenido de las tabs
          Expanded(
            child: Consumer<LoanProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading && !_initialLoadCompleted) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (provider.errorMessage != null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          provider.errorMessage!,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _loadInitialData,
                          child: const Text('Reintentar'),
                        ),
                      ],
                    ),
                  );
                }

                return TabBarView(
                  controller: _tabController,
                  children: [
                    _buildLoansList(provider.loans),
                    _buildLoansList(provider.activeLends),
                    _buildLoansList(provider.activeBorrows),
                    _buildLoansList(provider.outstandingLoans),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => NavigationService.goToLoanForm(),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildLoansList(List<LoanEntry> loans) {
    if (loans.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_balance_wallet_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No hay préstamos',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadInitialData,
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 80), // Espacio para FAB
        itemCount: loans.length,
        itemBuilder: (context, index) {
          return LoanListItem(loan: loans[index]);
        },
      ),
    );
  }
}
