import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../domain/entities/credit_card.dart';
import '../../../domain/entities/chart_account.dart';
import '../../../domain/usecases/credit_card_usecases.dart';
import '../../../domain/usecases/chart_account_usecases.dart';
import '../../../domain/services/balance_calculation_service.dart'; // ✅ AGREGADO: Import del servicio
import '../../core/atoms/app_app_bar.dart';
import '../../core/atoms/app_floating_action_button.dart'; // ✅ AGREGADO: Import del FAB del core

import '../../core/molecules/credit_summary_card.dart';
import '../../core/molecules/upcoming_payments_list.dart';
import '../../core/molecules/credit_card_visual.dart';
import '../../core/molecules/credit_card_filters.dart';
import '../../core/molecules/empty_state.dart';
import '../../core/atoms/gradient_container.dart';
import '../../core/atoms/credit_card_chip.dart';
import '../../core/organisms/app_drawer.dart'; // ✅ AGREGADO: Import del drawer
import '../../navigation/navigation_service.dart';
import '../../navigation/app_routes.dart';
import '../../core/molecules/credit_card_options_dialog.dart'; // ✅ AGREGADO: Import del nuevo diálogo

class CreditCardsScreen extends StatefulWidget {
  const CreditCardsScreen({Key? key}) : super(key: key);

  @override
  State<CreditCardsScreen> createState() => _CreditCardsScreenState();
}

class _CreditCardsScreenState extends State<CreditCardsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // ✅ AGREGADO: Key para Scaffold
  final CreditCardUseCases _creditCardUseCases = GetIt.instance<CreditCardUseCases>();
  final ChartAccountUseCases _chartAccountUseCases = GetIt.instance<ChartAccountUseCases>();
  final BalanceCalculationService _balanceService = GetIt.instance<BalanceCalculationService>(); // ✅ AGREGADO: Servicio de cálculo

  List<CreditCard> _creditCards = [];
  Map<int, ChartAccount> _chartAccountsMap = {};
  Map<int, double> _usedBalances = {}; // ✅ AGREGADO: Mapa para saldos consumidos
  CreditCardFilter _selectedFilter = CreditCardFilter.all;
  bool _isLoading = true;
  bool _isSummaryVisible = true;
  String? _error;

  // Estadísticas calculadas
  double _totalLimit = 0.0;
  double _totalUsed = 0.0;
  double _totalAvailable = 0.0;
  List<CreditCardPayment> _upcomingPayments = [];

  @override
  void initState() {
    super.initState();
    _loadCreditCards();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _loadCreditCards() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
        _error = null;
      });
    }

    try {
      final creditCards = await _creditCardUseCases.getAllCreditCards();
      final chartAccountIds = creditCards.map((c) => c.chartAccountId).toSet();
      final chartAccounts = await _chartAccountUseCases.getAllChartAccounts();

      final chartAccountsMap = <int, ChartAccount>{};
      for (final account in chartAccounts) {
        if (chartAccountIds.contains(account.id)) {
          chartAccountsMap[account.id] = account;
        }
      }

      // ✅ AGREGADO: Calcular saldos reales para cada tarjeta
      final usedBalances = <int, double>{};
      for (final card in creditCards) {
        usedBalances[card.id] = await _balanceService.calculateCreditCardUsedBalance(card.id);
      }

      if (mounted) {
        setState(() {
          _creditCards = creditCards;
          _chartAccountsMap = chartAccountsMap;
          _usedBalances = usedBalances; // Guardar los saldos calculados
          _isLoading = false;

          // Calcular estadísticas y pagos con los datos actualizados
          _calculateStatistics(creditCards);
          _generateUpcomingPayments(creditCards);
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

  void _calculateStatistics(List<CreditCard> cards) {
    // ✅ CORREGIDO: Calcular estadísticas dinámicamente
    _totalLimit = cards.fold(0.0, (sum, card) => sum + card.quota);
    _totalUsed = _usedBalances.values.fold(0.0, (sum, balance) => sum + balance);
    _totalAvailable = _totalLimit - _totalUsed;
  }

  void _generateUpcomingPayments(List<CreditCard> cards) {
    _upcomingPayments = [];
    final now = DateTime.now();
    
    for (final card in cards) {
      // Calcular próxima fecha de pago
      final nextPaymentDate = _calculateNextPaymentDate(card, now);
      final daysLeft = nextPaymentDate.difference(now).inDays;
      
      // Solo incluir si hay pagos pendientes
      if (daysLeft >= 0 && daysLeft <= 30) {
        double paymentAmount = 0.0;
        
        // Valores de ejemplo basados en el HTML
        if (card.name.contains('Chase')) {
          paymentAmount = 1145.75;
        }
        
        if (paymentAmount > 0) {
          _upcomingPayments.add(CreditCardPayment(
            creditCard: card,
            amount: paymentAmount,
            dueDate: nextPaymentDate,
            daysLeft: daysLeft,
          ));
        }
      }
    }
    
    // Ordenar por fecha más próxima
    _upcomingPayments.sort((a, b) => a.daysLeft.compareTo(b.daysLeft));
  }

  DateTime _calculateNextPaymentDate(CreditCard card, DateTime currentDate) {
    // Usar información del HTML como referencia
    int paymentDay = 10; // Valor por defecto
    
    final cardName = card.name.toLowerCase();
    if (cardName.contains('chase')) {
      paymentDay = 10;
    } else if (cardName.contains('american express') || cardName.contains('amex')) {
      paymentDay = 20;
    } else if (cardName.contains('visa')) {
      paymentDay = 30;
    }
    
    var nextPayment = DateTime(currentDate.year, currentDate.month, paymentDay);
    
    if (nextPayment.isBefore(currentDate) || nextPayment.isAtSameMomentAs(currentDate)) {
      nextPayment = DateTime(currentDate.year, currentDate.month + 1, paymentDay);
    }
    
    return nextPayment;
  }

  void _navigateToCreditCardForm({CreditCard? creditCard}) async {
    final result = await NavigationService.navigateTo(
      AppRoutes.creditCardForm,
      arguments: creditCard,
    );

    if (result != null) {
      _loadCreditCards();
    }
  }

  void _navigateToPayment(CreditCard creditCard) {
    Navigator.of(context).pushNamed(
      AppRoutes.creditCardPayment,
      arguments: creditCard,
    ).then((result) {
      if (result == true) {
        _loadCreditCards();
      }
    });
  }

  void _showCreditCardOptions(CreditCard creditCard) {
    // ✅ REFACTORIZADO: Usar el nuevo diálogo moleculizado
    CreditCardOptionsDialog.show(
      context: context,
      creditCard: creditCard,
      availableCredit: _getAvailableCreditForCard(creditCard),
      onOptionSelected: (option) => _handleCreditCardOption(creditCard, option),
    );
  }

  /// ✅ AGREGADO: Maneja las opciones seleccionadas del diálogo
  void _handleCreditCardOption(CreditCard creditCard, CreditCardOption option) {
    switch (option) {
      case CreditCardOption.viewTransactions:
        _viewCreditCardTransactions(creditCard);
        break;
      case CreditCardOption.makePayment:
        _navigateToPayment(creditCard);
        break;
      case CreditCardOption.editCard:
        _navigateToCreditCardForm(creditCard: creditCard);
        break;
      case CreditCardOption.deleteCard:
        _deleteCreditCard(creditCard);
        break;
    }
  }

  /// ✅ AGREGADO: Ver transacciones de la tarjeta
  void _viewCreditCardTransactions(CreditCard creditCard) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('View transactions for ${creditCard.name}'),
        backgroundColor: const Color(0xFF0c7ff2),
        action: SnackBarAction(
          label: 'Coming Soon',
          textColor: Colors.white,
          onPressed: () {},
        ),
      ),
    );
  }

  Future<void> _deleteCreditCard(CreditCard creditCard) async {
    try {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Delete Credit Card'),
          content: Text('Are you sure you want to delete "${creditCard.name}"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Delete'),
            ),
          ],
        ),
      );

      if (confirmed == true) {
        // ✅ CORREGIDO: Usar el método correcto
        await _creditCardUseCases.deleteCreditCard(creditCard.id);
        _loadCreditCards();
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Credit card deleted successfully')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting credit card: $e')),
        );
      }
    }
  }

  List<CreditCard> get _filteredCreditCards {
    switch (_selectedFilter) {
      case CreditCardFilter.all:
        return _creditCards;
      case CreditCardFilter.active:
        return _creditCards.where((card) => 
          !card.name.toLowerCase().contains('visa') // Temporal: lógica basada en nombre
        ).toList();
      case CreditCardFilter.blocked:
        return _creditCards.where((card) => 
          card.name.toLowerCase().contains('visa') // Temporal: lógica basada en nombre
        ).toList();
    }
  }

  GradientType _getGradientForCard(CreditCard card) {
    if (card.name.toLowerCase().contains('chase')) {
      return GradientType.blueSapphire;
    } else if (card.name.toLowerCase().contains('american express')) {
      return GradientType.grayAmex;
    } else if (card.name.toLowerCase().contains('visa')) {
      return GradientType.redVisa;
    }
    return GradientType.blueSapphire;
  }

  CreditCardStatus _getStatusForCard(CreditCard card) {
    // ✅ CORREGIDO: Usar la propiedad 'active' del modelo de datos
    return card.active ? CreditCardStatus.active : CreditCardStatus.blocked;
  }

  double _getAvailableCreditForCard(CreditCard card) {
    // ✅ CORREGIDO: Calcular crédito disponible real
    final usedBalance = _usedBalances[card.id] ?? 0.0;
    return card.quota - usedBalance;
  }

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void _showSearch() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Search functionality coming soon'),
        backgroundColor: Color(0xFF0c7ff2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // ✅ AGREGADO: Key para poder controlar el drawer
      backgroundColor: const Color(0xFFF8FAFC), // HTML: bg-slate-50
      appBar: AppAppBar(
        title: 'Credit Cards',
        type: AppAppBarType.blur, // HTML: bg-slate-50/80 backdrop-blur-md
        leading: AppAppBarLeading.drawer, // ✅ CORREGIDO: Usar drawer en lugar de back
        actions: [AppAppBarAction.search],
        onLeadingPressed: _openDrawer, // ✅ AGREGADO: Callback para abrir drawer
        onActionsPressed: [_showSearch], // ✅ AGREGADO: Array de callbacks para acciones
      ),
      drawer: const AppDrawer(), // ✅ AGREGADO: Drawer como en WalletsScreen
      body: _buildBody(),
      // ✅ CORREGIDO: Usar AppFloatingActionButton del core y método correcto
      floatingActionButton: AppFloatingActionButton(
        onPressed: () => _navigateToCreditCardForm(),
        icon: Icons.add,
        tooltip: 'Add credit card',
        backgroundColor: const Color(0xFF0c7ff2),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        // ✅ CORREGIDO: Alinear filtros a la izquierda como en WalletsScreen
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16), // HTML: px-4 py-4 similar a wallets
          child: CreditCardFilters(
            selectedFilter: _selectedFilter,
            onFilterChanged: (filter) {
              setState(() {
                _selectedFilter = filter;
              });
            },
          ),
        ),
        
        // Content
        Expanded(
          child: _buildContent(),
        ),
      ],
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(child: Text('Error: $_error'));
    }

    if (_creditCards.isEmpty) {
      return const EmptyState(
        icon: Icons.credit_card,
        title: 'No credit cards',
        message: 'Add your first credit card to get started',
      );
    }

    final filteredCards = _filteredCreditCards;

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Credit Summary
          CreditSummaryCard(
            totalAvailable: _totalAvailable,
            totalUsed: _totalUsed,
            totalLimit: _totalLimit,
            isVisible: _isSummaryVisible,
            onVisibilityToggle: () {
              setState(() {
                _isSummaryVisible = !_isSummaryVisible;
              });
            },
          ),
          
          // Upcoming Payments
          UpcomingPaymentsList(
            payments: _upcomingPayments,
            onPaymentTap: (payment) => _navigateToPayment(payment.creditCard),
          ),
          
          // Credit Cards
          if (filteredCards.isNotEmpty) ...[
            const SizedBox(height: 24),
            ...filteredCards.asMap().entries.map((entry) {
              final card = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: CreditCardVisual(
                  creditCard: card,
                  availableCredit: _getAvailableCreditForCard(card),
                  gradientType: _getGradientForCard(card),
                  status: _getStatusForCard(card),
                  onMorePressed: () => _showCreditCardOptions(card),
                ),
              );
            }).toList(),
          ],
          
          // ✅ ELIMINADO: Botón "Add new credit card"
          // Container(
          //   margin: const EdgeInsets.all(16),
          //   child: DashedBorderButton(
          //     title: 'Add new credit card',
          //     subtitle: 'Register a new credit card',
          //     onPressed: () => _navigateToCreditCardForm(),
          //   ),
          // ),
          
          const SizedBox(height: 80), // Space for FAB
        ],
      ),
    );
  }
}

