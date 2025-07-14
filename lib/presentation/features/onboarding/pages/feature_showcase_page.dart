import 'package:flutter/material.dart';
import '../theme/onboarding_theme.dart';
import '../widgets/animated_feature_icon.dart';
import '../widgets/staggered_text_animation.dart';

/// Página individual para mostrar una característica específica
class FeatureShowcasePage extends StatelessWidget {
  const FeatureShowcasePage({
    Key? key,
    required this.feature,
  }) : super(key: key);

  final FeatureInfo feature;

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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: OnboardingTheme.spacing32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // Badge si es "Coming Soon"
              if (!feature.isAvailable) ...[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'PRÓXIMAMENTE',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withOpacity(0.9),
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                const SizedBox(height: OnboardingTheme.spacing24),
              ],

              // Animated Feature Icon
              AnimatedFeatureIcon(
                icon: feature.icon,
                backgroundColor: feature.isAvailable
                    ? Colors.white.withOpacity(0.2)
                    : Colors.white.withOpacity(0.1),
                iconColor: feature.isAvailable
                    ? Colors.white
                    : Colors.white.withOpacity(0.6),
                size: 100,
                animationDelay: const Duration(milliseconds: 200),
              ),

              const SizedBox(height: OnboardingTheme.spacing48),

              // Feature Title
              StaggeredTextAnimation(
                text: feature.title,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: feature.isAvailable
                      ? Colors.white
                      : Colors.white.withOpacity(0.7),
                  height: 1.3,
                ),
                delay: const Duration(milliseconds: 400),
              ),

              const SizedBox(height: OnboardingTheme.spacing24),

              // Feature Description
              StaggeredTextAnimation(
                text: feature.description,
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

              // Feature Benefits
              if (feature.benefits.isNotEmpty) ...[
                const SizedBox(height: OnboardingTheme.spacing32),
                Column(
                  children: feature.benefits.asMap().entries.map((entry) {
                    final index = entry.key;
                    final benefit = entry.value;
                    return _buildBenefitItem(
                      benefit,
                      Duration(milliseconds: 800 + (index * 200)),
                      feature.isAvailable,
                    );
                  }).toList(),
                ),
              ],

              const Spacer(),

              // El botón es manejado por OnboardingScreen.
              // Este SizedBox asegura que el contenido tenga espacio suficiente en la parte inferior.
              const SizedBox(height: 96),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBenefitItem(String text, Duration delay, bool isAvailable) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: StaggeredTextAnimation(
        text: text,
        style: TextStyle(
          fontSize: 16,
          color: isAvailable 
              ? Colors.white.withOpacity(0.9)
              : Colors.white.withOpacity(0.6),
          height: 1.5,
        ),
        delay: delay,
        textAlign: TextAlign.center,
      ),
    );
  }
}

/// Información de una característica
class FeatureInfo {
  final String title;
  final String description;
  final IconData icon;
  final bool isAvailable;
  final List<String> benefits;

  const FeatureInfo({
    required this.title,
    required this.description,
    required this.icon,
    required this.isAvailable,
    this.benefits = const [],
  });

  /// Features disponibles actualmente
  static const List<FeatureInfo> availableFeatures = [
    FeatureInfo(
      title: 'Gestión de Préstamos',
      description: 'Controla cuotas, intereses y fechas de vencimiento de manera intuitiva',
      icon: Icons.handshake,
      isAvailable: true,
      benefits: [
        '💰 Seguimiento de pagos automático',
        '📅 Recordatorios de vencimientos',
        '📊 Cálculo de intereses en tiempo real',
      ],
    ),
    FeatureInfo(
      title: 'Aprende Contabilidad', // ✅ CAMBIADO: De "Núcleo Contable" a "Aprende Contabilidad"
      description: 'Domina conceptos contables básicos mientras organizas tus finanzas personales', // ✅ CAMBIADO: Enfoque educativo
      icon: Icons.account_tree,
      isAvailable: true,
      benefits: [
        '📚 Comprende cómo funcionan las cuentas', // ✅ CAMBIADO: Enfoque en aprendizaje
        '🎓 Aprende a crear asientos contables simples', // ✅ CAMBIADO: Educativo en lugar de automático
        '📊 Visualiza el impacto de cada transacción', // ✅ CAMBIADO: Comprensión en lugar de reportes
      ],
    ),
  ];

  /// Features que vendrán en el futuro
  static const List<FeatureInfo> upcomingFeatures = [
    FeatureInfo(
      title: 'Open Banking',
      description: 'Conecta tus cuentas bancarias y categoriza movimientos automáticamente',
      icon: Icons.account_balance,
      isAvailable: false,
      benefits: [
        '🔗 Conexión segura con bancos',
        '🤖 Categorización automática',
        '🔄 Sincronización en tiempo real',
      ],
    ),
    FeatureInfo(
      title: 'Inversiones', // ✅ CAMBIADO: De "Inversiones Crypto" a "Inversiones"
      description: 'Sigue el rendimiento de tus inversiones en crypto, acciones y otros activos financieros', // ✅ CAMBIADO: Más comprehensivo
      icon: Icons.trending_up, // ✅ CAMBIADO: Ícono más general
      isAvailable: false,
      benefits: [
        '📊 Portfolio completo multi-activo', // ✅ CAMBIADO: Más ambicioso
        '💹 Análisis de rendimiento y riesgo', // ✅ CAMBIADO: Más útil que alertas
        '📈 Métricas de diversificación', // ✅ CAMBIADO: Más profesional
      ],
    ),
    FeatureInfo(
      title: 'Multi-moneda',
      description: 'Administra saldos y transacciones en múltiples divisas',
      icon: Icons.currency_exchange,
      isAvailable: false,
      benefits: [
        '🌍 Soporte para 150+ monedas',
        '💱 Conversión automática',
        '📊 Reportes multi-divisa',
      ],
    ),
    FeatureInfo(
      title: 'Gastos compartidos',
      description: 'Divide cuentas y coordina pagos con amigos o familia',
      icon: Icons.groups,
      isAvailable: false,
      benefits: [
        '👥 Grupos de gastos',
        '⚖️ División automática de costos',
        '💸 Seguimiento de deudas',
      ],
    ),
  ];

  /// Todas las features (disponibles + próximamente)
  static List<FeatureInfo> get allFeatures => [
    ...availableFeatures,
    ...upcomingFeatures,
  ];
}
