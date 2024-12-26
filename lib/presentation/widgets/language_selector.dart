import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/l10n/language_manager.dart';
import '../../core/l10n/models/language.dart';

class LanguageSelector extends StatelessWidget {
  final bool showTitle;
  final void Function(Language?)? onLanguageSelected;

  const LanguageSelector({
    super.key,
    this.showTitle = true,
    this.onLanguageSelected,
  });

  @override
  Widget build(BuildContext context) {
    final languageManager = Provider.of<LanguageManager>(context);
    final translations = languageManager.translations;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showTitle) ...[
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 8),
            child: Text(
              translations.selectLanguage,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
        Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: languageManager.supportedLanguages.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final language = languageManager.supportedLanguages[index];
              final isSelected = language.code == languageManager.currentLanguage.code;
              
              return ListTile(
                leading: Text(
                  language.flag,
                  style: const TextStyle(fontSize: 24),
                ),
                title: Text(language.nativeName),
                subtitle: Text(language.name),
                trailing: isSelected 
                  ? const Icon(Icons.check, color: Colors.green)
                  : null,
                onTap: () async {
                  await languageManager.changeLanguage(language.code);
                  if (onLanguageSelected != null) {
                    onLanguageSelected!(language);
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
