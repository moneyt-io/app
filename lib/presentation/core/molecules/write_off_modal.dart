import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../domain/entities/loan_entry.dart';
import '../../features/loans/loan_provider.dart';
import '../theme/app_dimensions.dart';

class WriteOffModal extends StatefulWidget {
  final LoanEntry loan;
  final VoidCallback onConfirmed;

  const WriteOffModal({
    super.key,
    required this.loan,
    required this.onConfirmed,
  });

  @override
  State<WriteOffModal> createState() => _WriteOffModalState();
}

class _WriteOffModalState extends State<WriteOffModal> {
  final _descriptionController = TextEditingController();
  bool _isLoading = false;
  
  double get _outstandingBalance => widget.loan.amount - widget.loan.totalPaid;
  bool get _isLend => widget.loan.documentTypeId == 'L';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      padding: EdgeInsets.only(
        top: AppDimensions.paddingMedium,
        left: AppDimensions.paddingMedium,
        right: AppDimensions.paddingMedium,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppDimensions.paddingMedium,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(
                Icons.warning_amber,
                color: theme.colorScheme.error,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _isLend ? 'Cancelar Saldo Pendiente' : 'Asumir como Gasto',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          
          const SizedBox(height: AppDimensions.paddingMedium),
          
          // Advertencia
          Container(
            padding: const EdgeInsets.all(AppDimensions.paddingMedium),
            decoration: BoxDecoration(
              color: theme.colorScheme.errorContainer.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: theme.colorScheme.error,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Esta acción es irreversible. ${_isLend ? 'El saldo pendiente se cancelará definitivamente' : 'El saldo se registrará como gasto asumido'}.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.error,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: AppDimensions.paddingMedium),
          
          // Información del préstamo
          Container(
            padding: const EdgeInsets.all(AppDimensions.paddingMedium),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Contacto:'),
                    Text(widget.loan.contact?.name ?? 'Desconocido'),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Monto original:'),
                    Text('\$${widget.loan.amount.toStringAsFixed(2)}'),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Pagado:'),
                    Text('\$${widget.loan.totalPaid.toStringAsFixed(2)}'),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _isLend ? 'Monto a cancelar:' : 'Monto a asumir:',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\$${_outstandingBalance.toStringAsFixed(2)}',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.error,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: AppDimensions.paddingMedium),
          
          // Descripción opcional
          TextFormField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              labelText: 'Descripción (opcional)',
              border: OutlineInputBorder(),
              hintText: 'Ej: Ayuda familiar, Saldo incobrable, etc.',
            ),
            maxLines: 2,
          ),
          
          const SizedBox(height: AppDimensions.paddingLarge),
          
          // Botones
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancelar'),
                ),
              ),
              const SizedBox(width: AppDimensions.paddingMedium),
              Expanded(
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleConfirm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.error,
                    foregroundColor: theme.colorScheme.onError,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(_isLend ? 'Cancelar Saldo' : 'Asumir Gasto'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _handleConfirm() async {
    setState(() => _isLoading = true);

    try {
      final description = _descriptionController.text.isEmpty 
          ? null 
          : _descriptionController.text;

      final loanProvider = Provider.of<LoanProvider>(context, listen: false);
      
      await loanProvider.writeOffLoan(
        loanId: widget.loan.id,
        description: description,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isLend 
                ? 'Saldo cancelado exitosamente' 
                : 'Gasto asumido exitosamente'),
          ),
        );
        widget.onConfirmed();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }
}
