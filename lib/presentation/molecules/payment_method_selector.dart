import 'package:flutter/material.dart';
import '../../domain/entities/wallet.dart';
import '../../domain/entities/credit_card.dart';
import '../../core/presentation/app_dimensions.dart';

class PaymentMethodSelector extends StatelessWidget {
  final List<Wallet> wallets;
  final List<CreditCard> creditCards;
  final String selectedPaymentType; // 'W' o 'C'
  final int? selectedPaymentId;
  final Function(String type, int? id) onPaymentMethodChanged;
  final bool isLendingOperation;

  const PaymentMethodSelector({
    super.key,
    required this.wallets,
    required this.creditCards,
    required this.selectedPaymentType,
    required this.selectedPaymentId,
    required this.onPaymentMethodChanged,
    required this.isLendingOperation,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Selector de tipo de pago
        if (isLendingOperation && creditCards.isNotEmpty) ...[
          Text(
            'Tipo de Pago',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(height: AppDimensions.spacing8),
          Row(
            children: [
              Expanded(
                child: RadioListTile<String>(
                  title: const Text('Wallet'),
                  value: 'W',
                  groupValue: selectedPaymentType,
                  onChanged: (value) {
                    if (value != null) {
                      onPaymentMethodChanged(value, null);
                    }
                  },
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              Expanded(
                child: RadioListTile<String>(
                  title: const Text('Tarjeta'),
                  value: 'C',
                  groupValue: selectedPaymentType,
                  onChanged: (value) {
                    if (value != null) {
                      onPaymentMethodChanged(value, null);
                    }
                  },
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spacing16),
        ],

        // Selector específico según el tipo
        if (selectedPaymentType == 'W') 
          _buildWalletSelector(context)
        else if (selectedPaymentType == 'C')
          _buildCreditCardSelector(context),
      ],
    );
  }

  Widget _buildWalletSelector(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isLendingOperation ? 'Wallet Origen' : 'Wallet Destino',
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const SizedBox(height: AppDimensions.spacing8),
        DropdownButtonFormField<int>(
          value: selectedPaymentId,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.account_balance_wallet),
          ),
          items: wallets.map((wallet) {
            return DropdownMenuItem<int>(
              value: wallet.id,
              child: Row(
                children: [
                  Icon(
                    Icons.account_balance_wallet,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: AppDimensions.spacing12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          wallet.name,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          wallet.currencyId,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (value) {
            onPaymentMethodChanged('W', value);
          },
          validator: (value) {
            if (value == null) {
              return 'Debe seleccionar un wallet';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildCreditCardSelector(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tarjeta de Crédito',
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const SizedBox(height: AppDimensions.spacing8),
        DropdownButtonFormField<int>(
          value: selectedPaymentId,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.credit_card),
          ),
          items: creditCards.map((card) {
            return DropdownMenuItem<int>(
              value: card.id,
              child: Row(
                children: [
                  Icon(
                    Icons.credit_card,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  const SizedBox(width: AppDimensions.spacing12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          card.name,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          card.currencyId,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (value) {
            onPaymentMethodChanged('C', value);
          },
          validator: (value) {
            if (value == null) {
              return 'Debe seleccionar una tarjeta';
            }
            return null;
          },
        ),
      ],
    );
  }
}
