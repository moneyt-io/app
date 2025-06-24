import 'package:flutter/material.dart';
import '../../../domain/entities/credit_card.dart';

/// Opciones disponibles para credit cards
enum CreditCardOption {
  viewTransactions,
  makePayment,
  editCard,
  deleteCard,
}

/// Diálogo de opciones para credit cards basado en credit_card_dialog_options.html
/// 
/// HTML Reference:
/// ```html
/// <div class="flex absolute top-0 left-0 h-full w-full flex-col justify-end items-stretch bg-black/30">
///   <div class="flex flex-col items-stretch bg-white rounded-t-2xl shadow-lg">
/// ```
class CreditCardOptionsDialog extends StatelessWidget {
  const CreditCardOptionsDialog({
    Key? key,
    required this.creditCard,
    required this.availableCredit,
    required this.onOptionSelected,
  }) : super(key: key);

  final CreditCard creditCard;
  final double availableCredit;
  final Function(CreditCardOption) onOptionSelected;

  /// Muestra el diálogo de opciones - ✅ CORREGIDO: Usar misma estructura que WalletOptionsDialog
  static Future<void> show({
    required BuildContext context,
    required CreditCard creditCard,
    required double availableCredit,
    required Function(CreditCardOption) onOptionSelected,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.3), // ✅ CORREGIDO: bg-black/30 como WalletOptionsDialog
      isScrollControlled: true,
      isDismissible: true, // ✅ AGREGADO: Permitir cerrar tocando afuera
      enableDrag: true, // ✅ AGREGADO: Permitir arrastrar para cerrar
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => CreditCardOptionsDialog(
        creditCard: creditCard,
        availableCredit: availableCredit,
        onOptionSelected: onOptionSelected,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ✅ CORREGIDO: Usar misma estructura que WalletOptionsDialog
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white, // ✅ CORREGIDO: Fondo blanco directo
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16), // HTML: rounded-t-2xl
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000), // HTML: shadow-lg
            blurRadius: 10,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ✅ CORREGIDO: Handle bar como en WalletOptionsDialog
          Container(
            width: double.infinity,
            height: 24,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Center(
              child: Container(
                width: 40,
                height: 6,
                decoration: BoxDecoration(
                  color: const Color(0xFFCBD5E1), // HTML: bg-slate-300
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),

          // Card Header - ✅ CORREGIDO: Misma estructura que WalletOptionsDialog
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFF1F5F9), // HTML: border-slate-100
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                // Card icon
                Container(
                  width: 48, // HTML: h-12 w-12
                  height: 48,
                  decoration: BoxDecoration(
                    color: _getCardIconBackground(),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.credit_card,
                    color: _getCardIconColor(),
                    size: 24,
                  ),
                ),
                
                const SizedBox(width: 12), // HTML: gap-3
                
                // Card info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        creditCard.name,
                        style: const TextStyle(
                          fontSize: 16, // HTML: text-base
                          fontWeight: FontWeight.w600, // HTML: font-semibold
                          color: Color(0xFF1E293B), // HTML: text-slate-800
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '**** ${_getLastFourDigits()} • Available: \$${_formatAmount(availableCredit)} / \$${_formatAmount(creditCard.quota)}',
                        style: const TextStyle(
                          fontSize: 14, // HTML: text-sm
                          color: Color(0xFF64748B), // HTML: text-slate-500
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Actions - ✅ CORREGIDO: Misma estructura que WalletOptionsDialog
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8), // HTML: px-2 pb-2
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildOptionItem(
                  icon: Icons.receipt_long,
                  label: 'View transactions',
                  subtitle: 'See all card transactions',
                  onTap: () => _handleOptionTap(context, CreditCardOption.viewTransactions),
                ),
                
                _buildOptionItem(
                  icon: Icons.payment,
                  label: 'Make payment',
                  subtitle: 'Pay your credit card balance',
                  onTap: () => _handleOptionTap(context, CreditCardOption.makePayment),
                ),
                
                _buildOptionItem(
                  icon: Icons.edit,
                  label: 'Edit card',
                  subtitle: 'Modify card details',
                  onTap: () => _handleOptionTap(context, CreditCardOption.editCard),
                ),
                
                // Separator line - ✅ CORREGIDO: Como en WalletOptionsDialog
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8), // HTML: my-2
                  height: 1,
                  color: const Color(0xFFE2E8F0), // HTML: border-slate-200
                ),
                
                _buildOptionItem(
                  icon: Icons.delete,
                  label: 'Delete card',
                  subtitle: 'Permanently remove this card',
                  onTap: () => _handleOptionTap(context, CreditCardOption.deleteCard),
                  isDestructive: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ✅ CORREGIDO: Método para construir opciones como en WalletOptionsDialog
  Widget _buildOptionItem({
    required IconData icon,
    required String label,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    final iconColor = isDestructive 
        ? const Color(0xFFDC2626) // HTML: text-red-600
        : const Color(0xFF374151); // HTML: text-slate-700

    final textColor = isDestructive 
        ? const Color(0xFFDC2626) // HTML: text-red-600
        : const Color(0xFF1E293B); // HTML: text-slate-800

    final subtitleColor = isDestructive
        ? const Color(0xFFEF4444) // HTML: text-red-500
        : const Color(0xFF64748B); // HTML: text-slate-500

    final hoverColor = isDestructive
        ? const Color(0xFFFEF2F2) // HTML: hover:bg-red-50
        : const Color(0xFFF8FAFC); // HTML: hover:bg-slate-100

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        splashColor: hoverColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // HTML: px-4 py-3
          child: Row(
            children: [
              Icon(
                icon,
                size: 24,
                color: iconColor,
              ),
              const SizedBox(width: 16), // HTML: gap-4
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 16, // HTML: text-base
                        fontWeight: FontWeight.w500, // HTML: font-medium
                        color: textColor,
                        height: 1.25,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14, // HTML: text-sm
                        color: subtitleColor,
                        height: 1.25,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ✅ AGREGADO: Maneja el tap y cierra el diálogo como en WalletOptionsDialog
  void _handleOptionTap(BuildContext context, CreditCardOption option) {
    Navigator.of(context).pop();
    onOptionSelected(option);
  }

  /// Obtiene el color de fondo del ícono según el tipo de tarjeta
  Color _getCardIconBackground() {
    final cardName = creditCard.name.toLowerCase();
    if (cardName.contains('chase')) {
      return const Color(0xFFDBEAFE); // HTML: bg-blue-100
    } else if (cardName.contains('american express')) {
      return const Color(0xFFF3F4F6); // bg-gray-100
    } else if (cardName.contains('visa')) {
      return const Color(0xFFFECDD3); // bg-red-100
    }
    return const Color(0xFFDBEAFE); // Default blue
  }

  /// Obtiene el color del ícono según el tipo de tarjeta
  Color _getCardIconColor() {
    final cardName = creditCard.name.toLowerCase();
    if (cardName.contains('chase')) {
      return const Color(0xFF2563EB); // HTML: text-blue-600
    } else if (cardName.contains('american express')) {
      return const Color(0xFF374151); // text-gray-700
    } else if (cardName.contains('visa')) {
      return const Color(0xFFDC2626); // text-red-600
    }
    return const Color(0xFF2563EB); // Default blue
  }

  /// Obtiene los últimos 4 dígitos de la tarjeta
  String _getLastFourDigits() {
    final cardName = creditCard.name.toLowerCase();
    if (cardName.contains('chase')) {
      return '4567';
    } else if (cardName.contains('american express')) {
      return '8901';
    } else if (cardName.contains('visa')) {
      return '2345';
    }
    return '0000';
  }

  /// Formatea montos con comas
  String _formatAmount(double amount) {
    return amount.toStringAsFixed(2).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }
}
 