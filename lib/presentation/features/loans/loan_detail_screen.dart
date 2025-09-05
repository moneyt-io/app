import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

import '../../../domain/entities/loan_entry.dart';
import 'loan_provider.dart';
import '../../core/atoms/loan_status_chip.dart';
import '../../core/molecules/loan_payment_modal.dart';
import '../../core/molecules/write_off_modal.dart';
import '../../navigation/navigation_service.dart';
import '../../core/design_system/theme/app_dimensions.dart';

class LoanDetailScreen extends StatefulWidget {
  final int loanId;

  const LoanDetailScreen({
    super.key,
    required this.loanId,
  });

  @override
  _LoanDetailScreenState createState() => _LoanDetailScreenState();
}

class _LoanDetailScreenState extends State<LoanDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LoanProvider>();
    final loan = provider.loans.firstWhereOrNull((l) => l.id == widget.loanId);

    if (provider.isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Cargando...')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (loan == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              const Text('Préstamo no encontrado'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.read<LoanProvider>().loadLoans(),
                child: const Text('Reintentar'),
              ),
            ],
          ),
        ),
      );
    }

    final contact = loan.contact;
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
              onPressed: () => _showPaymentModal(context, loan),
              tooltip: isLend ? 'Recibir pago' : 'Realizar pago',
            ),
          PopupMenuButton<String>(
            onSelected: (value) => _handleMenuAction(context, value, loan),
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
        onRefresh: () => context.read<LoanProvider>().loadLoans(),
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
                              ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                              : Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                          child: Icon(
                            isLend ? Icons.arrow_upward : Icons.arrow_downward,
                            color: isLend
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                contact?.name ?? 'Contacto desconocido',
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
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
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        loan.description!,
                        style: Theme.of(context).textTheme.bodyMedium,
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
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.paddingMedium),
                      
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () => _showPaymentModal(context, loan),
                              icon: Icon(isLend ? Icons.payment : Icons.attach_money),
                              label: Text(isLend ? 'Recibir Pago' : 'Realizar Pago'),
                            ),
                          ),
                          const SizedBox(width: AppDimensions.paddingSmall),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => _showWriteOffModal(context, loan),
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
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
                          style: Theme.of(context).textTheme.bodySmall,
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

  void _handleMenuAction(BuildContext context, String action, LoanEntry loan) {
    switch (action) {
      case 'payment':
        _showPaymentModal(context, loan);
        break;
      case 'writeoff':
        _showWriteOffModal(context, loan);
        break;
      case 'edit':
        NavigationService.goToLoanForm(loan: loan);
        break;
      case 'cancel':
        _showCancelConfirmation(context, loan);
        break;
    }
  }

  void _showPaymentModal(BuildContext context, LoanEntry loan) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => LoanPaymentModal(
        loan: loan,
        onPaymentConfirmed: () {
          Navigator.of(context).pop();
          // No need to call _loadLoanData, provider handles update
        },
      ),
    );
  }

  void _showWriteOffModal(BuildContext context, LoanEntry loan) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => WriteOffModal(
        loan: loan,
        onConfirmed: () {
          Navigator.of(context).pop();
          // No need to call _loadLoanData, provider handles update
        },
      ),
    );
  }

  void _showCancelConfirmation(BuildContext context, LoanEntry loan) {
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
                  loanId: loan.id,
                  newStatus: LoanStatus.cancelled,
                );
                
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Préstamo cancelado')),
                  );
                  Navigator.of(context).pop(); // Pop detail screen after cancellation
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
