import 'package:flutter/material.dart';
import '../atoms/app_text_field.dart';

class FormField extends StatelessWidget {
  final String label;
  final String? title;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final IconData? icon;
  final bool isRequired;

  const FormField({
    Key? key,
    required this.label,
    this.title,
    required this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.icon,
    this.isRequired = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Text(
            title!,
            style: textTheme.titleMedium?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
        ],
        AppTextField(
          label: isRequired ? '$label *' : label,
          controller: controller,
          keyboardType: keyboardType,
          validator: validator ?? (isRequired 
              ? (value) => (value == null || value.isEmpty) ? 'Este campo es requerido' : null
              : null),
          prefixIcon: icon,
        ),
      ],
    );
  }
}
