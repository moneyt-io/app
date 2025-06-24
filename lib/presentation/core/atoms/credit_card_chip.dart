import 'package:flutter/material.dart';

/// Estados posibles de una tarjeta de crédito
enum CreditCardStatus {
  active,   // Verde - totalmente funcional
  blocked,  // Rojo - bloqueada/suspendida
  expired,  // Gris - vencida
}

/// Chip que muestra el estado de una tarjeta de crédito
/// 
/// HTML Reference:
/// ```html
/// <span class="bg-green-500 text-white px-2 py-1 rounded-full text-xs font-medium">Active</span>
/// ```
class CreditCardChip extends StatelessWidget {
  const CreditCardChip({
    Key? key,
    required this.status,
    this.customLabel,
  }) : super(key: key);

  final CreditCardStatus status;
  final String? customLabel;

  /// Obtiene el color de fondo según el estado
  Color get _backgroundColor {
    switch (status) {
      case CreditCardStatus.active:
        return const Color(0xFF10B981); // HTML: bg-green-500
      case CreditCardStatus.blocked:
        return const Color(0xFFEF4444); // HTML: bg-red-500
      case CreditCardStatus.expired:
        return const Color(0xFF6B7280); // HTML: bg-gray-500
    }
  }

  /// Obtiene el texto a mostrar
  String get _label {
    if (customLabel != null) return customLabel!;
    
    switch (status) {
      case CreditCardStatus.active:
        return 'Active';
      case CreditCardStatus.blocked:
        return 'Blocked';
      case CreditCardStatus.expired:
        return 'Expired';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8, // HTML: px-2
        vertical: 4,   // HTML: py-1
      ),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(9999), // HTML: rounded-full
      ),
      child: Text(
        _label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12, // HTML: text-xs
          fontWeight: FontWeight.w500, // HTML: font-medium
        ),
      ),
    );
  }
}
