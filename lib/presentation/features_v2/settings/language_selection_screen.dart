import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../core/providers/language_provider.dart';
import '../../core/l10n/generated/strings.g.dart';
import '../theme/v2_colors.dart';

class LanguageInfo {
  final AppLocale locale;
  final String name;
  final String flag;
  final Color backgroundColor;

  const LanguageInfo({
    required this.locale,
    required this.name,
    required this.flag,
    required this.backgroundColor,
  });
}

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  static const List<LanguageInfo> _availableLanguages = [
    LanguageInfo(
      locale: AppLocale.es,
      name: 'Español',
      flag: '🇪🇸',
      backgroundColor: Color(0xFFFEF3C7),
    ),
    LanguageInfo(
      locale: AppLocale.en,
      name: 'English',
      flag: '🇺🇸',
      backgroundColor: Color(0xFFDBEAFE),
    ),
    LanguageInfo(
      locale: AppLocale.pt,
      name: 'Português',
      flag: '🇧🇷',
      backgroundColor: Color(0xFFD1FAE5),
    ),
    LanguageInfo(
      locale: AppLocale.fr,
      name: 'Français',
      flag: '🇫🇷',
      backgroundColor: Color(0xFFE0E7FF),
    ),
    LanguageInfo(
      locale: AppLocale.vi,
      name: 'Tiếng Việt',
      flag: '🇻🇳',
      backgroundColor: Color(0xFFFCE7F3),
    ),
    LanguageInfo(
      locale: AppLocale.fil,
      name: 'Filipino',
      flag: '🇵🇭',
      backgroundColor: Color(0xFFFEF08A),
    ),
    LanguageInfo(
      locale: AppLocale.id,
      name: 'Bahasa Indonesia',
      flag: '🇮🇩',
      backgroundColor: Color(0xFFFEE2E2),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: V2Colors.background,
        appBar: AppBar(
          backgroundColor: V2Colors.background,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: V2Colors.onSurface),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            t.v2.settings.language,
            style: const TextStyle(
              color: V2Colors.onSurface,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              fontFamily: 'Manrope',
            ),
          ),
          centerTitle: true,
        ),
        body: Consumer<LanguageProvider>(
          builder: (context, provider, child) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              itemCount: _availableLanguages.length,
              itemBuilder: (context, index) {
                final language = _availableLanguages[index];
                final isSelected = provider.currentLocale == language.locale;

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: V2Colors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected ? V2Colors.primary : Colors.transparent,
                      width: isSelected ? 2 : 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        provider.setLocale(language.locale);
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: language.backgroundColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                language.flag,
                                style: const TextStyle(fontSize: 24),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                language.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: V2Colors.onSurface,
                                  fontFamily: 'Manrope',
                                ),
                              ),
                            ),
                            if (isSelected)
                              const Icon(
                                Icons.check_circle,
                                color: V2Colors.primary,
                                size: 24,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
