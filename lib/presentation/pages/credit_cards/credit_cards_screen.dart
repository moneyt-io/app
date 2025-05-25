import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import '../../../domain/entities/credit_card.dart';
import '../../../domain/entities/chart_account.dart';
import '../../../domain/usecases/credit_card_usecases.dart';
import '../../../domain/usecases/chart_account_usecases.dart';
import '../../atoms/app_button.dart';
import '../../../core/presentation/app_dimensions.dart';
import '../../molecules/empty_state.dart';
import '../../molecules/search_field.dart';
import '../../molecules/confirm_delete_dialog.dart';
import '../../organisms/app_drawer.dart';
import '../../routes/navigation_service.dart';
import '../../routes/app_routes.dart';
import '../../molecules/credit_card_list_item.dart';

class CreditCardsScreen extends StatefulWidget {
  const CreditCardsScreen({Key? key}) : super(key: key);

  @override
  State<CreditCardsScreen> createState() => _CreditCardsScreenState();
}

class _CreditCardsScreenState extends State<CreditCardsScreen> {
  final CreditCardUseCases _creditCardUseCases = GetIt.instance<CreditCardUseCases>();
  final ChartAccountUseCases _chartAccountUseCases = GetIt.instance<ChartAccountUseCases>();
  final TextEditingController _searchController = TextEditingController();

  List<CreditCard> _creditCards = [];
  Map<int, ChartAccount> _chartAccountsMap = {};
  String _searchQuery = '';
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadCreditCards();
  }

  @override
  void dispose() {
    _searchController.dispose();
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

      if (mounted) {
        setState(() {
          _creditCards = creditCards;
          _chartAccountsMap = chartAccountsMap;
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
      // Si el pago fue exitoso, refrescar la lista
      if (result == true) {
        _loadCreditCards();
      }
    });
  }

  Future<void> _deleteCreditCard(CreditCard creditCard) async {
    try {
      final confirmed = await ConfirmDeleteDialog.show(
        context: context,
        title: 'Eliminar tarjeta',
        message: '¿Estás seguro de eliminar la tarjeta "${creditCard.name}"?',
      );

      if (confirmed == true) {
        await _creditCardUseCases.deleteCreditCard(creditCard.id);
        _loadCreditCards();
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Tarjeta eliminada correctamente')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al eliminar la tarjeta: $e')),
        );
      }
    }
  }

  List<CreditCard> get _filteredCreditCards {
    if (_searchQuery.isEmpty) {
      return _creditCards;
    }
    
    return _creditCards.where((card) => 
      card.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
      (card.description?.toLowerCase() ?? '').contains(_searchQuery.toLowerCase())
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarjetas de Crédito'),
      ),
      drawer: const AppDrawer(),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToCreditCardForm(),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(child: Text('Error: $_error'));
    }

    if (_creditCards.isEmpty) {
      return const EmptyState(
        icon: Icons.credit_card,
        title: 'No hay tarjetas',
        message: 'Agrega tu primera tarjeta de crédito',
      );
    }

    final filteredCards = _filteredCreditCards;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(AppDimensions.spacing16),
          child: SearchField(
            controller: _searchController,
            hintText: 'Buscar tarjetas...',
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
        ),
        Expanded(
          child: filteredCards.isEmpty
              ? const Center(child: Text('No se encontraron resultados'))
              : ListView.builder(
                  padding: const EdgeInsets.all(AppDimensions.spacing16),
                  itemCount: filteredCards.length,
                  itemBuilder: (context, index) {
                    final card = filteredCards[index];
                    
                    // Calcular próxima fecha de pago
                    final nextPayment = _creditCardUseCases.getNextPaymentDate(card);
                    final formattedNextPayment = DateFormat('dd MMM').format(nextPayment);
                    
                    // Calcular disponible (simplificado por ahora)
                    final availableCredit = card.quota;
                    
                    return CreditCardListItem(
                      creditCard: card,
                      availableCredit: availableCredit,
                      nextPaymentDate: formattedNextPayment,
                      onTap: () => _navigateToCreditCardForm(creditCard: card),
                      onDelete: () => _deleteCreditCard(card),
                      onPay: () => _navigateToPayment(card),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
