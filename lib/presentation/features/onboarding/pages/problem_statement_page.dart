import 'package:flutter/material.dart';
import '../theme/onboarding_theme.dart';
import '../widgets/animated_feature_icon.dart';
import '../widgets/staggered_text_animation.dart';

class ProblemStatementPage extends StatelessWidget {
  const ProblemStatementPage({
    Key? key,
    this.onNext,
  }) : super(key: key);

  final VoidCallback? onNext;

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
          padding: const EdgeInsets.all(OnboardingTheme.spacing32),
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
                text: '¿Te preocupa no saber\ndónde va tu dinero?',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.3,
                ),
                delay: const Duration(milliseconds: 400),
              ),
              
              const SizedBox(height: OnboardingTheme.spacing24),
              
              // Problem List
              Column(
                crossAxisAlignment: CrossAxisAlignment.center, // ✅ CAMBIADO: De start a center
                children: [
                  _buildProblemItem(
                    '😰 Gastos impulsivos que no recuerdas',
                    const Duration(milliseconds: 600),
                  ),
                  _buildProblemItem(
                    '📊 Falta de visión general de tus finanzas',
                    const Duration(milliseconds: 800),
                  ),
                  _buildProblemItem(
                    '💸 Dificultad para ahorrar dinero',
                    const Duration(milliseconds: 1000),
                  ),
                ],
              ),
              
              const Spacer(),
              
              // Continue Button
              Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onNext,
                    borderRadius: BorderRadius.circular(28),
                    child: const Center(
                      child: Text(
                        'Tengo estos problemas',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: OnboardingTheme.textPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: OnboardingTheme.spacing24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProblemItem(String text, Duration delay) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: StaggeredTextAnimation(
        text: text,
        style: TextStyle(
          fontSize: 16,
          color: Colors.white.withOpacity(0.95),
          height: 1.5,
        ),
        delay: delay,
        textAlign: TextAlign.center, // ✅ CAMBIADO: De TextAlign.left a TextAlign.center
      ),
    );
  }
}
