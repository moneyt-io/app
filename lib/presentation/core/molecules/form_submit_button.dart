import 'package:flutter/material.dart';
import '../atoms/app_button.dart';
import '../theme/app_dimensions.dart';

class FormSubmitButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  
  const FormSubmitButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: AppDimensions.spacing16,
        right: AppDimensions.spacing16,
        bottom: MediaQuery.of(context).padding.bottom + AppDimensions.spacing16,
        top: AppDimensions.spacing16,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: AppButton(
        text: text,
        onPressed: isLoading ? null : onPressed,
        isLoading: isLoading,
        type: AppButtonType.primary,
        isFullWidth: true,
      ),
    );
  }
}
