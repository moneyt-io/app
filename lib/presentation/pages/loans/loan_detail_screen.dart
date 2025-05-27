import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import '../../../domain/entities/loan_entry.dart';
import '../../../domain/entities/contact.dart';
import '../../../domain/usecases/contact_usecases.dart';
import '../../providers/loan_provider.dart';
import '../../routes/app_routes.dart';
import '../../routes/navigation_service.dart';
import '../../../core/presentation/app_dimensions.dart'; // ← Corregir ruta de importación

class LoanDetailScreen extends StatefulWidget {
  final LoanEntry loan;

  const LoanDetailScreen({
    super.key,
    required this.loan,
  });

  @override
  State<LoanDetailScreen> createState() => _LoanDetailScreenState();
}

class _LoanDetailScreenState extends State<LoanDetailScreen> {
  final _contactUseCases = GetIt.instance<ContactUseCases>();
  
  Contact? _contact;
  bool _isLoading = true;
  LoanEntry? _currentLoan;

  @override
  void initState() {
    super.initState();
    _currentLoan = widget.loan;
    _loadContactData();
  }

  Future<void> _loadContactData() async {
    try {
      final contact = await _contactUseCases.getContactById(_currentLoan!.contactId);
      if (mounted) {
        setState(() {
          _contact = contact;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al cargar datos: ${e.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detalle de Préstamo')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de Préstamo'),
        actions: [
          if (_currentLoan!.status == LoanStatus.active) ...[
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: _navigateToEdit,
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                switch (value) {
                  case 'mark_paid':
                    _showMarkPaidDialog();
                    break;
                  case 'cancel':
                    _showCancelDialog();
                    break;
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'mark_paid',
                  child: ListTile(
                    leading: Icon(Icons.check_circle),
                    title: Text('Marcar como pagado'),
                  ),
                ),
                const PopupMenuItem(
                  value: 'cancel',
                  child: ListTile(
                    leading: Icon(Icons.cancel),
                    title: Text('Cancelar préstamo'),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Información principal
            _buildMainInfoCard(),
            const SizedBox(height: AppDimensions.spacing16),

            // Información del contacto
            _buildContactCard(),
            const SizedBox(height: AppDimensions.spacing16),

            // Detalles financieros
            _buildFinancialDetailsCard(),
            const SizedBox(height: AppDimensions.spacing16),

            // Historial de pagos (placeholder)
            _buildPaymentHistoryCard(),
            const SizedBox(height: AppDimensions.spacing24),

            // Botones de acción
            if (_currentLoan!.status == LoanStatus.active)
              _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildMainInfoCard() {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: _getStatusColor().withOpacity(0.1),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Icon(
                    _getLoanIcon(),
                    color: _getStatusColor(),
                    size: 24,
                  ),
                ),
                const SizedBox(width: AppDimensions.spacing16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getLoanTypeText(),
                        style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Préstamo #${_currentLoan!.secuencial}',
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.spacing12,
                    vertical: 6.0, // ← Cambiado a valor constante
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor().withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    _getStatusText(),
                    style: textTheme.labelMedium?.copyWith(
                      color: _getStatusColor(),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.spacing16),
            
            // Monto principal
            Center(
              child: Column(
                children: [
                  Text(
                    'Monto del Préstamo',
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spacing4),
                  Text(
                    '\$${_currentLoan!.amount.toStringAsFixed(2)} ${_currentLoan!.currencyId}',
                    style: textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),

            // Saldo pendiente si aplica
            if (_currentLoan!.outstandingBalance > 0) ...[
              const SizedBox(height: AppDimensions.spacing12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppDimensions.spacing12),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Text(
                      'Saldo Pendiente',
                      style: textTheme.bodySmall?.copyWith(
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.spacing4),
                    Text(
                      '\$${_currentLoan!.outstandingBalance.toStringAsFixed(2)}',
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard() {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _currentLoan!.isLend ? 'Prestado a' : 'Recibido de',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppDimensions.spacing12),
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  child: Text(
                    (_contact?.name ?? 'N')[0].toUpperCase(),
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: AppDimensions.spacing16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _contact?.name ?? 'Contacto #${_currentLoan!.contactId}',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (_contact?.email != null) ...[
                        const SizedBox(height: AppDimensions.spacing2),
                        Text(
                          _contact!.email!,
                          style: textTheme.bodySmall,
                        ),
                      ],
                      if (_contact?.phone != null) ...[
                        const SizedBox(height: AppDimensions.spacing2),
                        Text(
                          _contact!.phone!,
                          style: textTheme.bodySmall,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinancialDetailsCard() {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detalles Financieros',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppDimensions.spacing16),
            
            _buildDetailRow('Fecha:', 
                '${_currentLoan!.date.day}/${_currentLoan!.date.month}/${_currentLoan!.date.year}'),
            _buildDetailRow('Moneda:', _currentLoan!.currencyId),
            _buildDetailRow('Monto original:', 
                '\$${_currentLoan!.amount.toStringAsFixed(2)}'),
            _buildDetailRow('Total pagado:', 
                '\$${_currentLoan!.totalPaid.toStringAsFixed(2)}'),
            _buildDetailRow('Saldo pendiente:', 
                '\$${_currentLoan!.outstandingBalance.toStringAsFixed(2)}'),
            
            if (_currentLoan!.description != null && _currentLoan!.description!.isNotEmpty) ...[
              const SizedBox(height: AppDimensions.spacing12),
              Text(
                'Descripción:',
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: AppDimensions.spacing4),
              Text(
                _currentLoan!.description!,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.spacing8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentHistoryCard() {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Historial de Pagos',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppDimensions.spacing16),
            
            // Placeholder para historial de pagos
            Center(
              child: Column(
                children: [
                  Icon(
                    Icons.payment,
                    size: 48,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  const SizedBox(height: AppDimensions.spacing8),
                  Text(
                    'Historial de pagos será implementado en próximas versiones',
                    style: textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: () {
              // TODO: Implementar registro de pago en fases posteriores
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Registro de pagos será implementado en próximas versiones'),
                  backgroundColor: Colors.orange,
                ),
              );
            },
            icon: const Icon(Icons.payment),
            label: Text(_currentLoan!.isLend ? 'Registrar Cobro' : 'Registrar Pago'),
          ),
        ),
        const SizedBox(height: AppDimensions.spacing12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: _showMarkPaidDialog,
            icon: const Icon(Icons.check_circle_outline),
            label: const Text('Marcar como Pagado Completo'),
          ),
        ),
      ],
    );
  }

  // Helper methods
  IconData _getLoanIcon() {
    return _currentLoan!.isLend ? Icons.trending_up : Icons.trending_down;
  }

  String _getLoanTypeText() {
    return _currentLoan!.isLend ? 'Préstamo Otorgado' : 'Préstamo Recibido';
  }

  String _getStatusText() {
    switch (_currentLoan!.status) {
      case LoanStatus.active:
        return 'Activo';
      case LoanStatus.paid:
        return 'Pagado';
      case LoanStatus.cancelled:
        return 'Cancelado';
      case LoanStatus.writtenOff:
        return 'Asumido';
    }
  }

  Color _getStatusColor() {
    switch (_currentLoan!.status) {
      case LoanStatus.active:
        return Theme.of(context).colorScheme.primary;
      case LoanStatus.paid:
        return Colors.green;
      case LoanStatus.cancelled:
        return Theme.of(context).colorScheme.outline;
      case LoanStatus.writtenOff:
        return Colors.orange;
    }
  }

  void _navigateToEdit() {
    NavigationService.navigateTo(
      AppRoutes.loanForm,
      arguments: _currentLoan,
    ).then((result) {
      if (result != null) {
        // Recargar datos del préstamo
        // TODO: Obtener préstamo actualizado
      }
    });
  }

  void _showMarkPaidDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Marcar como pagado'),
        content: const Text(
          '¿Confirmas que este préstamo ha sido pagado completamente?',
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
              await provider.markLoanAsPaid(_currentLoan!.id);
              if (mounted) {
                // Actualizar estado local
                setState(() {
                  _currentLoan = _currentLoan!.copyWith(
                    status: LoanStatus.paid,
                    totalPaid: _currentLoan!.amount,
                  );
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Préstamo marcado como pagado'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            child: const Text('Marcar como pagado'),
          ),
        ],
      ),
    );
  }

  void _showCancelDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancelar préstamo'),
        content: const Text(
          '¿Estás seguro de que deseas cancelar este préstamo? Esta acción cambiará su estado a cancelado.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No cancelar'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.pop(context);
              final provider = Provider.of<LoanProvider>(context, listen: false);
              await provider.updateLoanStatus(
                loanId: _currentLoan!.id,
                newStatus: LoanStatus.cancelled,
              );
              if (mounted) {
                // Actualizar estado local
                setState(() {
                  _currentLoan = _currentLoan!.copyWith(
                    status: LoanStatus.cancelled,
                  );
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Préstamo cancelado'),
                    backgroundColor: Colors.orange,
                  ),
                );
              }
            },
            child: const Text('Cancelar préstamo'),
          ),
        ],
      ),
    );
  }
}
