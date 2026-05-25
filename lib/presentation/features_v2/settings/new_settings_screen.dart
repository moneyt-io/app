import 'dart:ui';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';
import '../theme/v2_colors.dart';
import '../dashboard/widgets/parallax_background.dart';
import '../dashboard/widgets/dashboard2_bottom_nav.dart';
import '../../core/providers/background_provider.dart';
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
      value: SystemUiOverlayStyle.light, // Texto blanco para fondo oscuro
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            // Background Image with Parallax compartida
            const ParallaxBackground(
              imageUrl:
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuBwYJtbLoiRlK81HfQ0l7k4ySGsyJeulQ5JpR_i0oIcnwM_9Pw_1IBnZ81Yk48phFd11NOlBX-OHgmovM__zWyLxpcfQ721O5NjjvLM_7LkERh01LoHkOddGXkwHpoI-AHMuT8bcbMn849_lNZ7Su4h9TYOpv_qUTD6XXWe7Yps8HV7sQVkcNQKhhaIzTrwgESMzN-MvMbARMYlmjgpHQSr0vFRfsEkwAJWwGYqohbqQuSGjFSOnqyq7eDOq6wiFI3-d2d74TspvgIC',
              parallaxFactor: 14.0,
            ),

            // Desenfoque extra sutil en toda la imagen de fondo
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: const SizedBox(),
              ),
            ),

            // Gradient Overlay para suavizar el texto
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.6),
                      Colors.black.withValues(alpha: 0.0),
                      const Color(
                          0xFFFAF8FF), // Fades to surface background color
                    ],
                    stops: const [0.0, 0.4, 0.8],
                  ),
                ),
              ),
            ),

            // Content
            SafeArea(
              bottom: false,
              child: Column(
                children: [
                  // App Bar Transparente Custom
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        IconButton(
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Expanded(
                          child: Text(
                            t.v2.settings.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Manrope',
                              shadows: [
                                Shadow(
                                  color: Colors.black45,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
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
                          top: 32,
                          bottom: 140), // Espacio para el bottom nav
                      children: [
                        _buildGlassmorphismOptionItem(
                          context,
                          icon: Icons.category_outlined,
                          title: t.v2.settings.categories,
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (_) => const V2CategoriesScreen(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        _buildGlassmorphismOptionItem(
                          context,
                          icon: Icons.account_balance_wallet_outlined,
                          title: t.v2.settings.wallets,
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (_) => const V2WalletsScreen(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        _buildGlassmorphismOptionItem(
                          context,
                          icon: Icons.language,
                          title: t.v2.settings.language,
                          trailingText: currentLanguage,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      const LanguageSelectionScreen()),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        _buildGlassmorphismOptionItem(
                          context,
                          icon: Icons.attach_money,
                          title: t.v2.settings.currency,
                          trailingText:
                              '${currentCurrency.id} (${currentCurrency.symbol})',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      const CurrencySelectionScreen()),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        _buildGlassmorphismOptionItem(
                          context,
                          icon: Icons.support_agent,
                          title: t.v2.settings.contact,
                          onTap: () {},
                        ),
                        const SizedBox(height: 32),
                        _buildGlassmorphismOptionItem(
                          context,
                          icon: Icons.history,
                          title: t.v2.settings.legacyView,
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

            // Same Bottom Nav as Dashboard
            const Dashboard2BottomNav(),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassmorphismOptionItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? trailingText,
    required VoidCallback onTap,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(
                alpha:
                    0.25), // Opacidad reducida para que se note el efecto de cristal
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: V2Colors.primary.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        icon,
                        color: V2Colors.primary,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: V2Colors.onSurface,
                          fontFamily: 'Manrope',
                        ),
                      ),
                    ),
                    if (trailingText != null) ...[
                      Text(
                        trailingText,
                        style: const TextStyle(
                          fontSize: 16,
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
