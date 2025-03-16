import 'package:flutter/material.dart';

class FormFieldContainer extends StatelessWidget {
  final Widget child;
  
  const FormFieldContainer({
    Key? key,
    required this.child,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outline.withOpacity(0.3),
        ),
      ),
      child: child,
    );
  }
}
