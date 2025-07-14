import 'package:flutter/material.dart';
import '../theme/onboarding_theme.dart';
import '../widgets/animated_feature_icon.dart';
import '../widgets/staggered_text_animation.dart';

class FeatureItem {
  final IconData icon;
  final String title;
  final Color iconColor;
  final Color backgroundColor;

  const FeatureItem({
    required this.icon,
    required this.title,
    required this.iconColor,
    required this.backgroundColor,
  });
}

class FeatureShowcaseSimplePage extends StatelessWidget {
  const FeatureShowcaseSimplePage({Key? key}) : super(key: key);

  // Features disponibles
  static const availableFeatures = [
    FeatureItem(
      icon: Icons.trending_up,
      title: 'Ingresos',
      iconColor: Color(0xFF16A34A), // green-600
      backgroundColor: Color(0xFFDCFCE7), // green-100
    ),
    FeatureItem(
      icon: Icons.trending_down,
      title: 'Egresos',
      iconColor: Color(0xFFDC2626), // red-600
      backgroundColor: Color(0xFFFEE2E2), // red-100
    ),
    FeatureItem(
      icon: Icons.swap_horiz,
      title: 'Transfer',
      iconColor: Color(0xFF2563EB), // blue-600
      backgroundColor: Color(0xFFDBEAFE), // blue-100
    ),
  ];

  // Features en desarrollo
  static const developmentFeatures = [
    FeatureItem(
      icon: Icons.account_balance,
      title: 'Préstamos',
      iconColor: Color(0xFF7C3AED), // violet-600
      backgroundColor: Color(0xFFEDE9FE), // violet-100
    ),
    FeatureItem(
      icon: Icons.flag,
      title: 'Metas',
      iconColor: Color(0xFFEA580C), // orange-600
      backgroundColor: Color(0xFFFED7AA), // orange-100
    ),
    FeatureItem(
      icon: Icons.pie_chart,
      title: 'Presupuestos',
      iconColor: Color(0xFF0891B2), // cyan-600
      backgroundColor: Color(0xFFCFFAFE), // cyan-100
    ),
    FeatureItem(
      icon: Icons.trending_up_outlined,
      title: 'Inversiones',
      iconColor: Color(0xFF059669), // emerald-600
      backgroundColor: Color(0xFFD1FAE5), // emerald-100
    ),
    FeatureItem(
      icon: Icons.cloud,
      title: 'MoneyT Cloud',
      iconColor: Color(0xFF4338CA), // indigo-600
      backgroundColor: Color(0xFFE0E7FF), // indigo-100
    ),
    FeatureItem(
      icon: Icons.link,
      title: 'Open Banking',
      iconColor: Color(0xFFBE185D), // pink-600
      backgroundColor: Color(0xFFFCE7F3), // pink-100
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: OnboardingTheme.gradients['features']!,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                children: [
                  const SizedBox(height: 72),
                  AnimatedFeatureIcon(
                    icon: Icons.auto_awesome,
                    backgroundColor: Colors.white.withOpacity(0.2),
                    iconColor: Colors.white,
                    size: 80,
                    animationDelay: const Duration(milliseconds: 200),
                  ),
                  const SizedBox(height: 32),
                  StaggeredTextAnimation(
                    text: 'Funciones disponibles y en desarrollo ✨',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.2,
                    ),
                    delay: const Duration(milliseconds: 400),
                  ),
                  const SizedBox(height: 12),
                  StaggeredTextAnimation(
                    text:
                        'Transacciones listas para usar. Más funciones en camino.',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.3,
                      color: Colors.white,
                      height: 1.4,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    delay: const Duration(milliseconds: 600),
                  ),
                  const SizedBox(height: 24),
                  _buildSectionTitle(
                    'DISPONIBLE AHORA',
                    const Duration(milliseconds: 800),
                  ),
                  const SizedBox(height: 12),
                  _buildFeatureGrid(
                    availableFeatures,
                    true,
                    const Duration(milliseconds: 900),
                  ),
                  const SizedBox(height: 24),
                  _buildSectionTitle(
                    'PRÓXIMAMENTE',
                    const Duration(milliseconds: 1200),
                  ),
                  const SizedBox(height: 12),
                  _buildFeatureGrid(
                    developmentFeatures,
                    false,
                    const Duration(milliseconds: 1300),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
            // Este espacio asegura que el contenido no quede debajo del botón
            // centralizado en OnboardingScreen.
            const SizedBox(height: 96),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, Duration delay) {
    return StaggeredTextAnimation(
      text: title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white.withOpacity(0.9),
        letterSpacing: 0.2,
      ),
      delay: delay,
    );
  }

  Widget _buildFeatureGrid(
      List<FeatureItem> features, bool isAvailable, Duration delay) {
    return GridView.builder(
      shrinkWrap: true, // ✅ CRÍTICO: Permite que el grid se ajuste al contenido
      physics:
          const NeverScrollableScrollPhysics(), // ✅ CRÍTICO: Evita scroll interno
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.0, // ✅ MEJORADO: De 0.9 a 1.0 para mejor proporción
        crossAxisSpacing: 12, // ✅ REDUCIDO: De 16 a 12
        mainAxisSpacing: 12, // ✅ REDUCIDO: De 16 a 12
      ),
      itemCount: features.length,
      itemBuilder: (context, index) {
        final feature = features[index];
        return _buildFeatureCard(feature, isAvailable,
            Duration(milliseconds: delay.inMilliseconds + (index * 100)));
      },
    );
  }

  Widget _buildFeatureCard(
      FeatureItem feature, bool isAvailable, Duration delay) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(isAvailable ? 0.15 : 0.08),
        borderRadius: BorderRadius.circular(12), // ✅ REDUCIDO: De 16 a 12
        border: Border.all(
          color: Colors.white.withOpacity(isAvailable ? 0.3 : 0.15),
          width: 1.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon Container
          Container(
            width: 40, // ✅ REDUCIDO: De 48 a 40
            height: 40,
            decoration: BoxDecoration(
              color: feature.backgroundColor.withOpacity(0.9),
              borderRadius: BorderRadius.circular(10), // ✅ REDUCIDO: De 12 a 10
              boxShadow: [
                BoxShadow(
                  color: feature.iconColor.withOpacity(0.2),
                  blurRadius: 6, // ✅ REDUCIDO: De 8 a 6
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              feature.icon,
              size: 20, // ✅ REDUCIDO: De 24 a 20
              color: feature.iconColor,
            ),
          ),

          const SizedBox(height: 6), // ✅ REDUCIDO: De 8 a 6

          // Feature Title
          Text(
            feature.title,
            style: TextStyle(
              fontSize: 11, // ✅ REDUCIDO: De 12 a 11
              fontWeight: FontWeight.w500,
              color: Colors.white.withOpacity(isAvailable ? 0.95 : 0.7),
              letterSpacing: 0.2,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          // Available/Development Indicator
          const SizedBox(height: 3), // ✅ REDUCIDO: De 4 a 3
          Container(
            width: 5, // ✅ REDUCIDO: De 6 a 5
            height: 5,
            decoration: BoxDecoration(
              color: isAvailable
                  ? const Color(0xFF16A34A)
                  : Colors.white.withOpacity(0.4),
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}
