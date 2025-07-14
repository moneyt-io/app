import 'package:flutter/material.dart';
import '../theme/onboarding_theme.dart';
import '../widgets/animated_feature_icon.dart';
import '../widgets/staggered_text_animation.dart';

class SolutionPreviewPage extends StatelessWidget {
  const SolutionPreviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: OnboardingTheme.gradients['solution']!,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: OnboardingTheme.spacing32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // Animated Icon
              AnimatedFeatureIcon(
                icon: Icons.lightbulb,
                backgroundColor: Colors.white.withOpacity(0.2),
                iconColor: Colors.white,
                size: 100,
                animationDelay: const Duration(milliseconds: 200),
              ),

              const SizedBox(height: OnboardingTheme.spacing48),

              // Solution Statement
              StaggeredTextAnimation(
                text: 'MoneyT te da control\ntotal de tus finanzas 💡',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.3,
                ),
                delay: const Duration(milliseconds: 400),
              ),

              const SizedBox(height: OnboardingTheme.spacing48),

              // Benefits List
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildBenefitItem(
                    '📊 Visualiza todos tus gastos en tiempo real',
                    const Duration(milliseconds: 600),
                  ),
                  _buildBenefitItem(
                    '🎯 Establece metas y sigue tu progreso',
                    const Duration(milliseconds: 800),
                  ),
                  _buildBenefitItem(
                    '💡 Toma decisiones financieras inteligentes',
                    const Duration(milliseconds: 1000),
                  ),
                ],
              ),

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

  Widget _buildBenefitItem(String text, Duration delay) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: StaggeredTextAnimation(
        text: text,
        style: TextStyle(
          fontSize: 18, // ✅ MEJORADO: Tamaño consistente con otras pantallas
          fontWeight: FontWeight.w400, // ✅ AGREGADO: Peso visual mejorado
          letterSpacing: 0.3, // ✅ AGREGADO: Espaciado entre letras
          color: Colors.white, // ✅ MEJORADO: Máximo contraste
          height: 1.4, // ✅ MEJORADO: Espaciado compacto
          shadows: [
            // ✅ AGREGADO: Sombra sutil para profundidad
            Shadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        delay: delay,
        textAlign: TextAlign.center,
      ),
    );
  }
}
