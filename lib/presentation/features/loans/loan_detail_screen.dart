import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import '../../../domain/entities/loan_entry.dart';
import '../../../domain/entities/contact.dart';
import '../../../domain/usecases/loan_usecases.dart';
import '../../../domain/usecases/contact_usecases.dart';
import 'loan_provider.dart';
import '../../core/atoms/loan_status_chip.dart';
import '../../core/molecules/loan_payment_modal.dart';
import '../../core/molecules/write_off_modal.dart';
import '../../navigation/navigation_service.dart';
import '../../core/theme/app_dimensions.dart';

class LoanDetailScreen extends StatefulWidget {
  final int loanId;

  const LoanDetailScreen({
    super.key,
    required this.loanId,
  });

  @override
  State<LoanDetailScreen> createState() => _LoanDetailScreenState();
}

class _LoanDetailScreenState extends State<LoanDetailScreen> {
  LoanEntry? _loan;
  Contact? _contact;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadLoanData();
  }

  Future<void> _loadLoanData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final loanUseCases = GetIt.instance<LoanUseCases>();
      final contactUseCases = GetIt.instance<ContactUseCases>();

      final loan = await loanUseCases.getLoanById(widget.loanId);
      if (loan == null) {
        setState(() {
          _errorMessage = 'Préstamo no encontrado';
          _isLoading = false;
        });
        return;
      }

      final contact = await contactUseCases.getContactById(loan.contactId);

      setState(() {
        _loan = loan;
        _contact = contact;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error al cargar préstamo: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Cargando...')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_errorMessage != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: theme.colorScheme.error),
              const SizedBox(height: 16),
              Text(
                _errorMessage!,
                style: TextStyle(color: theme.colorScheme.error),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loadLoanData,
                child: const Text('Reintentar'),
              ),
            ],
          ),
        ),
      );
    }

    final loan = _loan!;
    final contact = _contact;
    final isLend = loan.documentTypeId == 'L';
    final outstandingBalance = loan.amount - loan.totalPaid;
    final canMakePayment = loan.status == LoanStatus.active && outstandingBalance > 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(isLend ? 'Préstamo Otorgado' : 'Préstamo Recibido'),
        actions: [
          if (canMakePayment)
            IconButton(
              icon: Icon(isLend ? Icons.payment : Icons.attach_money),
              onPressed: () => _showPaymentModal(context),
              tooltip: isLend ? 'Recibir pago' : 'Realizar pago',
            ),
          PopupMenuButton<String>(
            onSelected: (value) => _handleMenuAction(context, value),
            itemBuilder: (context) => [
              if (canMakePayment)
                PopupMenuItem(
                  value: 'payment',
                  child: Row(
                    children: [
                      Icon(isLend ? Icons.payment : Icons.attach_money),
                      const SizedBox(width: 8),
                      Text(isLend ? 'Recibir pago' : 'Realizar pago'),
                    ],
                  ),
                ),
              if (canMakePayment)
                PopupMenuItem(
                  value: 'writeoff',
                  child: Row(
                    children: [
                      const Icon(Icons.cancel_outlined),
                      const SizedBox(width: 8),
                      Text(isLend ? 'Cancelar saldo' : 'Asumir como gasto'),
                    ],
                  ),
                ),
              const PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit),
                    SizedBox(width: 8),
                    Text('Editar'),
                  ],
                ),
              ),
              if (loan.status == LoanStatus.active)
                const PopupMenuItem(
                  value: 'cancel',
                  child: Row(
                    children: [
                      Icon(Icons.block, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Cancelar préstamo', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadLoanData,
        child: ListView(
          padding: const EdgeInsets.all(AppDimensions.paddingMedium),
          children: [
            // Información básica
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.paddingLarge),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: isLend
                              ? theme.colorScheme.primary.withOpacity(0.1)
                              : theme.colorScheme.secondary.withOpacity(0.1),
                          child: Icon(
                            isLend ? Icons.arrow_upward : Icons.arrow_downward,
                            color: isLend
                                ? theme.colorScheme.primary
                                : theme.colorScheme.secondary,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                contact?.name ?? 'Contacto desconocido',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              LoanStatusChip(status: loan.status),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    const Divider(height: 32),
                    
                    // Información financiera
                    _buildInfoRow('Monto original:', '\$${loan.amount.toStringAsFixed(2)}'),
                    _buildInfoRow('Total pagado:', '\$${loan.totalPaid.toStringAsFixed(2)}'),
                    _buildInfoRow(
                      'Saldo pendiente:',
                      '\$${outstandingBalance.toStringAsFixed(2)}',
                      isHighlight: outstandingBalance > 0,
                    ),
                    _buildInfoRow('Moneda:', loan.currencyId),
                    _buildInfoRow(
                      'Fecha:',
                      '${loan.date.day}/${loan.date.month}/${loan.date.year}',
                    ),
                    
                    if (loan.description != null && loan.description!.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Text(
                        'Descripción:',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        loan.description!,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppDimensions.paddingMedium),

            // Acciones rápidas
            if (canMakePayment) ...[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppDimensions.paddingMedium),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Acciones',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.paddingMedium),
                      
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () => _showPaymentModal(context),
                              icon: Icon(isLend ? Icons.payment : Icons.attach_money),
                              label: Text(isLend ? 'Recibir Pago' : 'Realizar Pago'),
                            ),
                          ),
                          const SizedBox(width: AppDimensions.paddingSmall),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => _showWriteOffModal(context),
                              icon: const Icon(Icons.cancel_outlined),
                              label: Text(isLend ? 'Cancelar' : 'Asumir'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: AppDimensions.paddingMedium),
            ],

            // Historial de pagos (placeholder)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.paddingMedium),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Historial de Pagos',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.paddingMedium),
                    
                    if (loan.totalPaid > 0) ...[
                      ListTile(
                        leading: const Icon(Icons.payment),
                        title: const Text('Pago registrado'),
                        subtitle: Text('Total: \$${loan.totalPaid.toStringAsFixed(2)}'),
                        trailing: Text(
                          '${loan.date.day}/${loan.date.month}/${loan.date.year}',
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                    ] else ...[
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(AppDimensions.paddingLarge),
                          child: Text(
                            'No hay pagos registrados',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isHighlight = false}) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: theme.textTheme.bodyMedium,
          ),
          Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: isHighlight ? theme.colorScheme.primary : null,
            ),
          ),
        ],
      ),
    );
  }

  void _handleMenuAction(BuildContext context, String action) {
    switch (action) {
      case 'payment':
        _showPaymentModal(context);
        break;
      case 'writeoff':
        _showWriteOffModal(context);
        break;
      case 'edit':
        NavigationService.goToLoanForm(loan: _loan);
        break;
      case 'cancel':
        _showCancelConfirmation(context);
        break;
    }
  }

  void _showPaymentModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => LoanPaymentModal(
        loan: _loan!,
        onPaymentConfirmed: () {
          Navigator.of(context).pop();
          _loadLoanData();
        },
      ),
    );
  }

  void _showWriteOffModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => WriteOffModal(
        loan: _loan!,
        onConfirmed: () {
          Navigator.of(context).pop();
          _loadLoanData();
        },
      ),
    );
  }

  void _showCancelConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancelar Préstamo'),
        content: const Text(
          '¿Está seguro de que desea cancelar este préstamo? Esta acción no se puede deshacer.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              
              try {
                final provider = Provider.of<LoanProvider>(context, listen: false);
                await provider.updateLoanStatus(
                  loanId: _loan!.id,
                  newStatus: LoanStatus.cancelled,
                );
                
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Préstamo cancelado')),
                  );
                  _loadLoanData();
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: ${e.toString()}')),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Cancelar Préstamo'),
          ),
        ],
      ),
    );
  }
}
