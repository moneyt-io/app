import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String> onChanged;

  const SearchField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SearchBar(
      controller: controller,
      onChanged: onChanged,
      hintText: hintText,
      leading: Icon(
        Icons.search_rounded,
        color: colorScheme.onSurfaceVariant,
      ),
      trailing: [
        if (controller.text.isNotEmpty)
          IconButton(
            onPressed: () {
              controller.clear();
              onChanged('');
            },
            icon: Icon(
              Icons.clear_rounded,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
      ],
      padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 16),
      ),
      backgroundColor: MaterialStateProperty.all(
        colorScheme.surfaceVariant.withOpacity(0.3),
      ),
      elevation: MaterialStateProperty.all(0),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: colorScheme.outline.withOpacity(0.5),
            width: 0.5,
          ),
        ),
      ),
    );
  }
}
