import 'package:flutter/material.dart';
import '../../../domain/entities/credit_card.dart';
import '../atoms/gradient_container.dart';
import '../atoms/credit_card_chip.dart';

/// Tarjeta de crédito visual basada en credit_card_list.html
/// 
/// HTML Reference:
/// ```html
/// <div class="bg-gradient-to-r from-blue-600 to-blue-800 rounded-2xl p-6 text-white relative overflow-hidden">
///   <div class="absolute top-0 right-0 w-32 h-32 bg-white/10 rounded-full -mr-16 -mt-16"></div>
/// ```
class CreditCardVisual extends StatelessWidget {
  const CreditCardVisual({
    Key? key,
    required this.creditCard,
    required this.availableCredit,
    required this.onMorePressed,
    this.gradientType = GradientType.blueSapphire,
    this.status = CreditCardStatus.active,
  }) : super(key: key);

  final CreditCard creditCard;
  final double availableCredit;
  final VoidCallback onMorePressed;
  final GradientType gradientType;
  final CreditCardStatus status;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16), // HTML: mx-4
      // ✅ CORREGIDO: Especificar altura fija para evitar tamaños infinitos
      height: 180, // Altura basada en el diseño HTML
      child: GradientContainer(
        gradientType: gradientType,
        opacity: status == CreditCardStatus.blocked ? 0.7 : null, // HTML: opacity-70 for blocked
        child: Column(
          mainAxisSize: MainAxisSize.min, // ✅ AGREGADO: Usar tamaño mínimo
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row con nombre y more button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        creditCard.name,
                        style: const TextStyle(
                          fontSize: 18, // HTML: text-lg
                          fontWeight: FontWeight.bold, // HTML: font-bold
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        _getCardIdentifier(),
                        style: TextStyle(
                          fontSize: 14, // HTML: text-sm
                          color: _getSecondaryTextColor(),
                        ),
                      ),
                    ],
                  ),
                ),
                Material(
                  color: Colors.white.withOpacity(0.2), // HTML: bg-white/20
                  borderRadius: BorderRadius.circular(16),
                  child: InkWell(
                    onTap: onMorePressed,
                    borderRadius: BorderRadius.circular(16),
                    splashColor: Colors.white.withOpacity(0.3), // HTML: hover:bg-white/30
                    child: Container(
                      width: 32, // HTML: h-8 w-8
                      height: 32,
                      child: const Icon(
                        Icons.more_vert,
                        color: Colors.white,
                        size: 18, // HTML: text-lg
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16), // HTML: mb-4
            
            // Available credit y limit
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AVAILABLE CREDIT',
                      style: TextStyle(
                        fontSize: 12, // HTML: text-xs
                        color: _getSecondaryTextColor(),
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5, // HTML: uppercase tracking-wide
                      ),
                    ),
                    Text(
                      '\$${_formatAmount(availableCredit)}',
                      style: const TextStyle(
                        fontSize: 20, // HTML: text-xl
                        fontWeight: FontWeight.bold, // HTML: font-bold
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'LIMIT',
                      style: TextStyle(
                        fontSize: 12, // HTML: text-xs
                        color: _getSecondaryTextColor(),
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5, // HTML: uppercase tracking-wide
                      ),
                    ),
                    Text(
                      '\$${_formatAmount(creditCard.quota)}',
                      style: const TextStyle(
                        fontSize: 18, // HTML: text-lg
                        fontWeight: FontWeight.w600, // HTML: font-semibold
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            
            const Spacer(), // ✅ AGREGADO: Empujar footer al fondo
            
            // Footer con fechas y estado
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    _getCardFooterText(),
                    style: TextStyle(
                      fontSize: 14, // HTML: text-sm
                      color: _getSecondaryTextColor(),
                    ),
                  ),
                ),
                CreditCardChip(status: status),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Obtiene el color del texto secundario según el gradiente
  Color _getSecondaryTextColor() {
    switch (gradientType) {
      case GradientType.blueSapphire:
        return const Color(0xFFBFDBFE); // HTML: text-blue-100
      case GradientType.grayAmex:
        return const Color(0xFFD1D5DB); // HTML: text-gray-300
      case GradientType.redVisa:
        return const Color(0xFFFECDD3); // HTML: text-red-100
      case GradientType.purplePink:
        return Colors.white.withOpacity(0.8);
    }
  }

  /// ✅ CORREGIDO: Obtiene el identificador de la tarjeta (descripción o nombre).
  String _getCardIdentifier() {
    if (creditCard.description != null && creditCard.description!.isNotEmpty) {
      return creditCard.description!;
    }
    return creditCard.name; // Fallback al nombre si no hay descripción
  }

  /// ✅ CORREGIDO: Obtiene el texto del footer con fechas reales.
  String _getCardFooterText() {
    final closing = 'Closes: Day ${creditCard.closingDay}';
    final payment = 'Due: Day ${creditCard.paymentDueDay}';
    return '$closing  •  $payment';
  }

  /// Formatea montos con comas
  String _formatAmount(double amount) {
    return amount.toStringAsFixed(2).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }


}
