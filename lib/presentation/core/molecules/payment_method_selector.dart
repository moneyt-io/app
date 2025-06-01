import 'package:flutter/material.dart';
import '../../../domain/entities/wallet.dart';
import '../../../domain/entities/credit_card.dart';
import '../design_system/theme/app_dimensions.dart';

class PaymentMethodSelector extends StatefulWidget {
  final List<Wallet> wallets;
  final List<CreditCard> creditCards;
  final String? selectedPaymentType;
  final int? selectedPaymentId;
  final bool isLendingOperation;
  final bool allowNoTransfer;
  final Function(String?, int?) onPaymentMethodChanged;

  const PaymentMethodSelector({
    super.key,
    required this.wallets,
    required this.creditCards,
    this.selectedPaymentType,
    this.selectedPaymentId,
    required this.isLendingOperation,
    this.allowNoTransfer = true,
    required this.onPaymentMethodChanged,
  });

  @override
  State<PaymentMethodSelector> createState() => _PaymentMethodSelectorState();
}

class _PaymentMethodSelectorState extends State<PaymentMethodSelector> {
  String? _selectedType;
  int? _selectedId;

  @override
  void initState() {
    super.initState();
    _selectedType = widget.selectedPaymentType;
    _selectedId = widget.selectedPaymentId;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Método de Pago',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingMedium),
            
            // Opción: Sin transferencia
            if (widget.allowNoTransfer)
              RadioListTile<String?>(
                title: const Text('Sin transferencia de dinero'),
                subtitle: Text(
                  widget.isLendingOperation
                      ? 'Registrar como ingreso por servicios'
                      : 'Registrar como gasto por servicios',
                  style: theme.textTheme.bodySmall,
                ),
                value: null,
                groupValue: _selectedType,
                onChanged: (value) {
                  setState(() {
                    _selectedType = value;
                    _selectedId = null;
                  });
                  widget.onPaymentMethodChanged(_selectedType, _selectedId);
                },
              ),
            
            // Opción: Wallets
            RadioListTile<String>(
              title: const Text('Desde/Hacia Wallet'),
              subtitle: Text(
                widget.isLendingOperation
                    ? 'Dinero sale del wallet'
                    : 'Dinero entra al wallet',
                style: theme.textTheme.bodySmall,
              ),
              value: 'W',
              groupValue: _selectedType,
              onChanged: (value) {
                setState(() {
                  _selectedType = value;
                  _selectedId = null;
                });
                widget.onPaymentMethodChanged(_selectedType, _selectedId);
              },
            ),
            
            // Selector de wallet específico
            if (_selectedType == 'W') ...[
              const SizedBox(height: AppDimensions.paddingSmall),
              Padding(
                padding: const EdgeInsets.only(left: AppDimensions.paddingLarge),
                child: DropdownButtonFormField<int>(
                  decoration: const InputDecoration(
                    labelText: 'Seleccionar Wallet',
                    border: OutlineInputBorder(),
                  ),
                  value: _selectedId,
                  items: widget.wallets.map((wallet) {
                    return DropdownMenuItem<int>(
                      value: wallet.id,
                      child: Text('${wallet.name} (${wallet.currencyId})'),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedId = value;
                    });
                    widget.onPaymentMethodChanged(_selectedType, _selectedId);
                  },
                ),
              ),
            ],
            
            // Opción: Tarjetas de crédito (solo para préstamos otorgados)
            if (widget.isLendingOperation && widget.creditCards.isNotEmpty)
              RadioListTile<String>(
                title: const Text('Desde Tarjeta de Crédito'),
                subtitle: Text(
                  'Usar tarjeta de crédito para el préstamo',
                  style: theme.textTheme.bodySmall,
                ),
                value: 'C',
                groupValue: _selectedType,
                onChanged: (value) {
                  setState(() {
                    _selectedType = value;
                    _selectedId = null;
                  });
                  widget.onPaymentMethodChanged(_selectedType, _selectedId);
                },
              ),
            
            // Selector de tarjeta específica
            if (_selectedType == 'C') ...[
              const SizedBox(height: AppDimensions.paddingSmall),
              Padding(
                padding: const EdgeInsets.only(left: AppDimensions.paddingLarge),
                child: DropdownButtonFormField<int>(
                  decoration: const InputDecoration(
                    labelText: 'Seleccionar Tarjeta',
                    border: OutlineInputBorder(),
                  ),
                  value: _selectedId,
                  items: widget.creditCards.map((card) {
                    return DropdownMenuItem<int>(
                      value: card.id,
                      child: Text('${card.name} (${card.currencyId})'),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedId = value;
                    });
                    widget.onPaymentMethodChanged(_selectedType, _selectedId);
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
