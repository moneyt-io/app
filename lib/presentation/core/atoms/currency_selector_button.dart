import 'package:flutter/material.dart';

/// Botón selector de currency con ícono circular basado en wallet_form.html
/// ✅ VERSIÓN PRINCIPAL - Eliminar currency_selection_button.dart duplicado
/// 
/// HTML Reference:
/// ```html
/// <button onclick="window.location.href='../components/currency_dialog.html'" class="form-input w-full rounded-lg border-slate-300 bg-slate-50 text-slate-900 h-14 px-4 text-base font-normal leading-normal flex items-center justify-between">
/// ```
class CurrencySelectorButton extends StatelessWidget {
  const CurrencySelectorButton({
    Key? key,
    required this.label,
    required this.selectedCurrency,
    required this.selectedCurrencyName,
    required this.onPressed,
    this.enabled = true,
  }) : super(key: key);

  final String label;
  final String selectedCurrency;
  final String selectedCurrencyName;
  final VoidCallback onPressed;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ✅ CORREGIDO: Container con altura fija para consistencia
        Stack(
          clipBehavior: Clip.none,
          children: [
            // Button content
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: enabled ? onPressed : null,
                borderRadius: BorderRadius.circular(8), // HTML: rounded-lg
                child: Container(
                  width: double.infinity,
                  height: 56, // HTML: h-14 - altura fija sin margin top
                  padding: const EdgeInsets.symmetric(horizontal: 16), // HTML: px-4
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC), // HTML: bg-slate-50
                    borderRadius: BorderRadius.circular(8), // HTML: rounded-lg
                    border: Border.all(
                      color: const Color(0xFFCBD5E1), // HTML: border-slate-300
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      // Currency icon and text
                      Expanded(
                        child: Row(
                          children: [
                            // Currency icon circle
                            Container(
                              width: 32, // HTML: h-8 w-8
                              height: 32,
                              decoration: BoxDecoration(
                                color: _getCurrencyBackgroundColor(selectedCurrency),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  _getCurrencySymbol(selectedCurrency),
                                  style: TextStyle(
                                    fontSize: 14, // HTML: text-sm
                                    fontWeight: FontWeight.bold, // HTML: font-bold
                                    color: _getCurrencyTextColor(selectedCurrency),
                                  ),
                                ),
                              ),
                            ),
                            
                            const SizedBox(width: 12), // HTML: gap-3
                            
                            // Currency name
                            Expanded(
                              child: Text(
                                '$selectedCurrency - $selectedCurrencyName',
                                style: const TextStyle(
                                  fontSize: 16, // HTML: text-base
                                  fontWeight: FontWeight.w500, // HTML: font-medium
                                  color: Color(0xFF0F172A), // HTML: text-slate-900
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Expand icon
                      Icon(
                        Icons.expand_more, // HTML: expand_more
                        color: const Color(0xFF94A3B8), // HTML: text-slate-400
                        size: 24,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            // ✅ CORREGIDO: Floating label posicionado correctamente
            Positioned(
              left: 12, // HTML: left-3
              top: -10, // ✅ CORREGIDO: Posición negativa para que sobresalga
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4), // HTML: px-1
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC), // HTML: bg-slate-50
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12, // HTML: text-xs
                    color: Color(0xFF64748B), // HTML: text-slate-500
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Obtiene el símbolo de la currency
  String _getCurrencySymbol(String currencyCode) {
    switch (currencyCode.toUpperCase()) {
      case 'USD':
        return '\$';
      case 'EUR':
        return '€';
      case 'COP':
        return '\$';
      case 'MXN':
        return '\$';
      case 'GBP':
        return '£';
      default:
        return currencyCode.substring(0, 1);
    }
  }

  /// Obtiene el color de fondo del ícono según la currency
  Color _getCurrencyBackgroundColor(String currencyCode) {
    switch (currencyCode.toUpperCase()) {
      case 'USD':
        return const Color(0xFFDCFCE7); // HTML: bg-green-100
      case 'EUR':
        return const Color(0xFFDBEAFE); // bg-blue-100
      case 'COP':
        return const Color(0xFFFEF3C7); // bg-yellow-100
      case 'MXN':
        return const Color(0xFFD1FAE5); // bg-emerald-100
      default:
        return const Color(0xFFDCFCE7); // Default green
    }
  }

  /// Obtiene el color del texto del ícono según la currency
  Color _getCurrencyTextColor(String currencyCode) {
    switch (currencyCode.toUpperCase()) {
      case 'USD':
        return const Color(0xFF16A34A); // HTML: text-green-600
      case 'EUR':
        return const Color(0xFF2563EB); // text-blue-600
      case 'COP':
        return const Color(0xFFD97706); // text-yellow-600
      case 'MXN':
        return const Color(0xFF059669); // text-emerald-600
      default:
        return const Color(0xFF16A34A); // Default green
    }
  }
}
