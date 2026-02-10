import 'package:flutter/material.dart';
import '../theme/onboarding_theme.dart';
import '../widgets/animated_feature_icon.dart';
import '../widgets/staggered_text_animation.dart';
import '../../../core/l10n/generated/strings.g.dart'; // ✅ CORREGIDO

class ProblemStatementPage extends StatelessWidget {
  const ProblemStatementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: OnboardingTheme.gradients['problem']!,
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
                icon: Icons.sentiment_dissatisfied,
                backgroundColor: Colors.white.withOpacity(0.2),
                iconColor: Colors.white,
                size: 100,
                animationDelay: const Duration(milliseconds: 200),
              ),

              const SizedBox(height: OnboardingTheme.spacing48),

              // Problem Statement
              StaggeredTextAnimation(
                text: t.onboarding.problemStatement.title, // ✅ LOCALIZADO
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.3,
                ),
                delay: const Duration(milliseconds: 400),
              ),

              const SizedBox(height: OnboardingTheme.spacing24),

              // Empathetic message
              StaggeredTextAnimation(
                text: t.onboarding.problemStatement.subtitle, // ✅ LOCALIZADO
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
}
