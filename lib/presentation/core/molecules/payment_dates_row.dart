import 'package:flutter/material.dart';
import '../atoms/app_floating_label_field.dart'; // ✅ CAMBIADO: Usar AppFloatingLabelField

/// Fila de fechas de pago con Cut-off day y Payment day
/// 
/// HTML Reference:
/// ```html
/// <div class="grid grid-cols-2 gap-4">
///   <div class="relative">
///     <label class="absolute -top-2 left-3 px-1 bg-slate-50 text-xs text-slate-500">Cut-off day</label>
///     <select>...</select>
///   </div>
///   <div class="relative">
///     <label class="absolute -top-2 left-3 px-1 bg-slate-50 text-xs text-slate-500">Payment day</label>
///     <select>...</select>
///   </div>
/// </div>
/// ```
class PaymentDatesRow extends StatelessWidget {
  const PaymentDatesRow({
    Key? key,
    required this.cutoffDay,
    required this.paymentDay,
    required this.onCutoffChanged,
    required this.onPaymentChanged,
  }) : super(key: key);

  final int cutoffDay;
  final int paymentDay;
  final Function(int) onCutoffChanged;
  final Function(int) onPaymentChanged;

  /// Obtiene el sufijo ordinal para un día
  String _getDaySuffix(int day) {
    if (day >= 11 && day <= 13) return 'th';
    switch (day % 10) {
      case 1: return 'st';
      case 2: return 'nd';
      case 3: return 'rd';
      default: return 'th';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Cut-off day - ✅ MIGRADO: Usar DropdownButtonFormField con AppFloatingLabelField styling
        Expanded(
          child: Container(
            height: 68, // Misma altura que AppFloatingLabelField
            child: Stack(
              children: [
                // Dropdown principal
                Positioned(
                  top: 12, // Espacio para label flotante
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: DropdownButtonFormField<int>(
                    value: cutoffDay,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFF8FAFC), // HTML: bg-slate-50
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color(0xFFCBD5E1), // HTML: border-slate-300
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color(0xFFCBD5E1),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color(0xFF3B82F6), // HTML: focus:border-blue-500
                          width: 2,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 18,
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF0F172A), // HTML: text-slate-900
                    ),
                    dropdownColor: const Color(0xFFF8FAFC),
                    items: [1, 15, 30].map((day) {
                      return DropdownMenuItem<int>(
                        value: day,
                        child: Text('$day${_getDaySuffix(day)}'),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        onCutoffChanged(value);
                      }
                    },
                  ),
                ),
                
                // Label flotante
                Positioned(
                  left: 12,
                  top: 4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    color: const Color(0xFFF8FAFC),
                    child: const Text(
                      'Cut-off day',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF64748B), // HTML: text-slate-500
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(width: 16), // HTML: gap-4
        
        // Payment day - ✅ MIGRADO: Usar DropdownButtonFormField con AppFloatingLabelField styling
        Expanded(
          child: Container(
            height: 68, // Misma altura que AppFloatingLabelField
            child: Stack(
              children: [
                // Dropdown principal
                Positioned(
                  top: 12, // Espacio para label flotante
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: DropdownButtonFormField<int>(
                    value: paymentDay,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFF8FAFC), // HTML: bg-slate-50
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color(0xFFCBD5E1), // HTML: border-slate-300
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color(0xFFCBD5E1),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color(0xFF3B82F6), // HTML: focus:border-blue-500
                          width: 2,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 18,
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF0F172A), // HTML: text-slate-900
                    ),
                    dropdownColor: const Color(0xFFF8FAFC),
                    items: [5, 10, 20].map((day) {
                      return DropdownMenuItem<int>(
                        value: day,
                        child: Text('$day${_getDaySuffix(day)}'),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        onPaymentChanged(value);
                      }
                    },
                  ),
                ),
                
                // Label flotante
                Positioned(
                  left: 12,
                  top: 4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    color: const Color(0xFFF8FAFC),
                    child: const Text(
                      'Payment day',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF64748B), // HTML: text-slate-500
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
