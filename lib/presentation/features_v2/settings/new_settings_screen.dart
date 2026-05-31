import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../theme/v2_colors.dart';
import '../dashboard/widgets/dashboard2_bottom_nav.dart';
import '../../core/providers/currency_provider.dart';
import '../../core/providers/language_provider.dart';
import '../../core/l10n/generated/strings.g.dart';
import 'currency_selection_screen.dart';
import 'language_selection_screen.dart';
import 'package:flutter/cupertino.dart';
import 'v2_categories_screen.dart';
import 'v2_wallets_screen.dart';

class NewSettingsScreen extends StatelessWidget {
  final VoidCallback onToggleLegacy;

  const NewSettingsScreen({
    super.key,
    required this.onToggleLegacy,
  });

  @override
  Widget build(BuildContext context) {
    final currencyProvider = context.watch<CurrencyProvider>();
    final currentCurrency = currencyProvider.currentCurrency;

    final languageProvider = context.watch<LanguageProvider>();
    final currentLanguage = languageProvider.getCurrentLanguageName();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark, // Dark text for light background
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F7FA), // Light solid background
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            // Content
            SafeArea(
              bottom: false,
              child: Column(
                children: [
                  // App Bar Custom
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        IconButton(
                          icon:
                              const Icon(Icons.arrow_back, color: V2Colors.onSurface),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Expanded(
                          child: Text(
                            t.v2.settings.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: V2Colors.onSurface,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Manrope',
                            ),
                          ),
                        ),
                        const SizedBox(
                            width:
                                48), // Espacio para equilibrar el botón de atrás
                      ],
                    ),
                  ),



                  // Scrollable Options List
                  Expanded(
                    child: ListView(
                      physics: const ClampingScrollPhysics(),
                      padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 8,
                          bottom: 32), // Reducido al ocultar el bottom nav
                      children: [
                        _buildOptionItem(
                          context,
                          emoji: '🏷️',
                          title: t.v2.settings.categories,
                          iconBgColor: const Color(0xFFFFF7ED),
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (_) => const V2CategoriesScreen(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 12),
                        _buildOptionItem(
                          context,
                          emoji: '💳',
                          title: t.v2.settings.wallets,
                          iconBgColor: const Color(0xFFF0F9FF),
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (_) => const V2WalletsScreen(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 12),
                        _buildOptionItem(
                          context,
                          emoji: '🌐',
                          title: t.v2.settings.language,
                          trailingText: currentLanguage,
                          iconBgColor: const Color(0xFFF0FDF4),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      const LanguageSelectionScreen()),
                            );
                          },
                        ),
                        const SizedBox(height: 12),
                        _buildOptionItem(
                          context,
                          emoji: '🪙',
                          title: t.v2.settings.currency,
                          trailingText:
                              '${currentCurrency.id} (${currentCurrency.symbol})',
                          iconBgColor: const Color(0xFFFFFBEB),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      const CurrencySelectionScreen()),
                            );
                          },
                        ),
                        const SizedBox(height: 12),
                        _buildOptionItem(
                          context,
                          emoji: '🎧',
                          title: t.v2.settings.contact,
                          iconBgColor: const Color(0xFFFAF5FF),
                          onTap: () {},
                        ),
                        const SizedBox(height: 12),
                        _buildOptionItem(
                          context,
                          emoji: '🕰️',
                          title: t.v2.settings.legacyView,
                          iconBgColor: const Color(0xFFF8FAFC),
                          trailingWidget: CupertinoSwitch(
                            value: false,
                            activeColor: V2Colors.primary,
                            onChanged: (value) {
                              if (value) {
                                Navigator.pop(context);
                                onToggleLegacy();
                              }
                            },
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            onToggleLegacy();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionItem(
    BuildContext context, {
    required String emoji,
    required String title,
    String? trailingText,
    required Color iconBgColor,
    Widget? trailingWidget,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    emoji,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: V2Colors.onSurface,
                      fontFamily: 'Manrope',
                    ),
                  ),
                ),
                if (trailingWidget != null)
                  trailingWidget
                else ...[
                  if (trailingText != null) ...[
                    Text(
                      trailingText,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: V2Colors.onSurfaceVariant,
                        fontFamily: 'Manrope',
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  const Icon(
                    Icons.chevron_right,
                    color: V2Colors.outlineVariant,
                    size: 20,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
