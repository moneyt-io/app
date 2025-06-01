import 'package:flutter/material.dart';

class TermsCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String label;
  final VoidCallback onReadTerms;
  final String readTermsLabel;
  
  const TermsCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.label,
    required this.onReadTerms,
    this.readTermsLabel = 'Leer términos',
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CheckboxListTile(
          title: Text(label),
          value: value,
          onChanged: onChanged,
        ),
        TextButton(
          onPressed: onReadTerms,
          child: Text(readTermsLabel),
        ),
      ],
    );
  }
}
