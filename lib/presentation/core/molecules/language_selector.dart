import 'package:flutter/material.dart';

class LanguageItem {
  final String code;
  final String name;
  final String flag;

  const LanguageItem({
    required this.code,
    required this.name,
    required this.flag,
  });
}

class LanguageSelector extends StatelessWidget {
  final List<LanguageItem> languages;
  final String value;
  final Function(String?) onChanged;
  final String label;

  const LanguageSelector({
    Key? key,
    required this.languages,
    required this.value,
    required this.onChanged,
    this.label = 'Seleccionar idioma',
    required bool showAsDropDown,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: colorScheme.surface,
      ),
      items: languages.map((language) {
        return DropdownMenuItem<String>(
          value: language.code,
          child: Text('${language.flag} ${language.name}'),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
