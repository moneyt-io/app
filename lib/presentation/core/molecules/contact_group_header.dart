import 'package:flutter/material.dart';
import '../design_system/tokens/app_dimensions.dart';
import '../design_system/tokens/app_colors.dart';

/// Group header que match el diseño HTML exactamente
class ContactGroupHeader extends StatelessWidget {
  const ContactGroupHeader({
    Key? key,
    required this.letter,
  }) : super(key: key);

  final String letter;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.spacing16,
        vertical: AppDimensions.spacing8,
      ),
      decoration: BoxDecoration(
        color: AppColors.slate50,
        border: Border(
          bottom: BorderSide(
            color: AppColors.slate200,
            width: 1,
          ),
        ),
      ),
      child: Text(
        letter.toUpperCase(),
        // CORREGIDO: text-sm del HTML = 14px, no 12px
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          fontSize: 14, // CORREGIDO: text-sm = 14px explícito
          color: AppColors.slate600,
          fontWeight: FontWeight.w600, // font-semibold
          letterSpacing: 1.5, // CORREGIDO: tracking-wider aumentado
        ),
      ),
    );
  }
}
