import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_floating_label_field.dart';

/// Campo especializado para montos monetarios
/// 
/// Extiende AppFloatingLabelField con funcionalidades específicas para dinero:
/// - Formateo automático de números
/// - Símbolo de moneda
/// - Validación de montos
/// 
/// Ejemplo de uso:
/// ```dart
/// AppAmountField(
///   controller: _amountController,
///   label: 'Amount',
///   currency: 'USD',
///   validator: _validateAmount,
/// )
/// ```
class AppAmountField extends StatelessWidget {
  const AppAmountField({
    Key? key,
    this.controller,
    required this.label,
    this.placeholder,
    this.validator,
    this.onChanged,
    this.currency = 'USD',
    this.enabled = true,
    this.autofocus = false,
  }) : super(key: key);

  final TextEditingController? controller;
  final String label;
  final String? placeholder;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final String currency;
  final bool enabled;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return AppFloatingLabelField(
      controller: controller,
      label: label,
      placeholder: placeholder ?? 'Enter amount',
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      textInputAction: TextInputAction.done,
      validator: validator ?? _defaultValidator,
      onChanged: onChanged,
      enabled: enabled,
      autofocus: autofocus,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
      ],
    );
  }

  String? _defaultValidator(String? value) {
    if (value?.trim().isEmpty == true) {
      return 'Amount is required';
    }
    
    final double? amount = double.tryParse(value!);
    if (amount == null) {
      return 'Invalid amount';
    }
    
    if (amount <= 0) {
      return 'Amount must be greater than zero';
    }
    
    return null;
  }
}
