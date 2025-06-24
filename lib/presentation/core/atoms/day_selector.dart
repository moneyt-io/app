import 'package:flutter/material.dart';

/// Selector de día con sufijos ordinales
/// 
/// HTML Reference:
/// ```html
/// <select class="form-select w-full rounded-lg border-slate-300 bg-slate-50 text-slate-900 focus:border-blue-500 focus:ring-blue-500 h-14 px-4">
///   <option value="15">15th</option>
/// </select>
/// ```
class DaySelector extends StatelessWidget {
  const DaySelector({
    Key? key,
    required this.label,
    required this.selectedDay,
    required this.onDayChanged,
    this.availableDays,
  }) : super(key: key);

  final String label;
  final int selectedDay;
  final Function(int) onDayChanged;
  final List<int>? availableDays;

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

  /// Obtiene la lista de días disponibles
  List<int> get _days {
    if (availableDays != null) return availableDays!;
    return List.generate(31, (index) => index + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // ✅ AGREGADO: Añadir margin superior para el label flotante
      margin: const EdgeInsets.only(top: 8),
      child: Stack(
        clipBehavior: Clip.none, // ✅ AGREGADO: Permitir que el label se salga
        children: [
          // Dropdown principal
          DropdownButtonFormField<int>(
            value: selectedDay,
            decoration: InputDecoration(
              // HTML: form-select w-full rounded-lg border-slate-300 bg-slate-50 h-14 px-4
              filled: true,
              fillColor: const Color(0xFFF8FAFC), // HTML: bg-slate-50
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8), // HTML: rounded-lg
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
                horizontal: 16, // HTML: px-4
                vertical: 16,   // Para altura h-14
              ),
              labelText: null,
            ),
            style: const TextStyle(
              fontSize: 16, // HTML: text-base
              color: Color(0xFF0F172A), // HTML: text-slate-900
            ),
            dropdownColor: const Color(0xFFF8FAFC), // Mismo color de fondo
            items: _days.map((day) {
              return DropdownMenuItem<int>(
                value: day,
                child: Text('$day${_getDaySuffix(day)}'), // HTML: "15th"
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                onDayChanged(value);
              }
            },
          ),
          
          // Label flotante - ✅ CORREGIDO: Cambiar posicionamiento
          Positioned(
            top: -8, // HTML: -top-2
            left: 12, // HTML: left-3
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4), // HTML: px-1
              decoration: const BoxDecoration(
                color: Color(0xFFF8FAFC), // HTML: bg-slate-50
              ),
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 12, // HTML: text-xs
                  color: Color(0xFF64748B), // HTML: text-slate-500
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
