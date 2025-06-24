import 'package:flutter/material.dart';
import '../atoms/gradient_container.dart';

/// Card de resumen total de crédito basado en credit_card_list.html
/// 
/// HTML Reference:
/// ```html
/// <div class="bg-gradient-to-r from-purple-600 to-pink-600 mx-4 mt-4 rounded-2xl p-6 text-white">
///   <div class="flex items-center justify-between mb-2">
///     <h2 class="text-white/80 text-sm font-medium">Total Credit Available</h2>
/// ```
class CreditSummaryCard extends StatelessWidget {
  const CreditSummaryCard({
    Key? key,
    required this.totalAvailable,
    required this.totalUsed,
    required this.totalLimit,
    this.isVisible = true,
    this.onVisibilityToggle,
  }) : super(key: key);

  final double totalAvailable;
  final double totalUsed;
  final double totalLimit;
  final bool isVisible;
  final VoidCallback? onVisibilityToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0), // HTML: mx-4 mt-4
      // ✅ CORREGIDO: Reducir altura del card para hacerlo más coherente
      constraints: const BoxConstraints(
        minHeight: 100,  // Reducido de 120
        maxHeight: 140,  // Reducido de 200
      ),
      child: GradientContainer(
        gradientType: GradientType.purplePink,
        showDecorations: false, // Summary card no tiene decoraciones circulares
        padding: const EdgeInsets.all(20), // ✅ REDUCIDO: de 24 a 20 para menos altura
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Credit Available',
                  style: TextStyle(
                    fontSize: 14, // HTML: text-sm
                    fontWeight: FontWeight.w500, // HTML: font-medium
                    color: Colors.white.withOpacity(0.8), // HTML: text-white/80
                  ),
                ),
                if (onVisibilityToggle != null)
                  Material(
                    color: Colors.white.withOpacity(0.2), // HTML: bg-white/20
                    borderRadius: BorderRadius.circular(16),
                    child: InkWell(
                      onTap: onVisibilityToggle,
                      borderRadius: BorderRadius.circular(16),
                      splashColor: Colors.white.withOpacity(0.3), // HTML: hover:bg-white/30
                      child: Container(
                        width: 32, // HTML: h-8 w-8
                        height: 32,
                        child: Icon(
                          isVisible ? Icons.visibility : Icons.visibility_off,
                          color: Colors.white,
                          size: 18, // HTML: text-lg
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            
            const SizedBox(height: 6), // ✅ REDUCIDO: de 8 a 6
            
            // Amount
            Text(
              isVisible 
                  ? '\$${_formatAmount(totalAvailable)}'
                  : '••••••',
              style: const TextStyle(
                fontSize: 26, // ✅ REDUCIDO: de 30 a 26 para menos altura
                fontWeight: FontWeight.bold, // HTML: font-bold
                color: Colors.white,
                height: 1.1, // HTML: mb-1
              ),
            ),
            
            const SizedBox(height: 2), // ✅ REDUCIDO: de 4 a 2
            
            // Usage summary
            Text(
              isVisible 
                  ? 'Used: \$${_formatAmount(totalUsed)} • Available: \$${_formatAmount(totalAvailable)}'
                  : 'Used: •••••• • Available: ••••••',
              style: TextStyle(
                fontSize: 13, // ✅ REDUCIDO: de 14 a 13
                color: Colors.white.withOpacity(0.8), // HTML: text-white/80
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Formatea el monto con comas para miles
  String _formatAmount(double amount) {
    return amount.toStringAsFixed(2).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }
}
