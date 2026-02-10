import 'package:flutter/material.dart';
import '../theme/onboarding_theme.dart';
import '../../../core/atoms/animated_feature_icon.dart';
import '../widgets/staggered_text_animation.dart';
import '../../../core/l10n/generated/strings.g.dart'; // ✅ CORREGIDO

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: OnboardingTheme.gradients['welcome']!,
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

              // Animated Logo
              AnimatedFeatureIcon(
                icon: Icons.account_balance_wallet,
                backgroundColor: Colors.white,
                iconColor:
                    const Color(0xFF047857), // Verde oscuro del gradiente
                size: 100,
                animationDelay: const Duration(milliseconds: 300),
              ),

              const SizedBox(height: OnboardingTheme.spacing48),

              // Animated Title
              StaggeredTextAnimation(
                text: t.onboarding.welcome.title, // ✅ LOCALIZADO
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.2,
                ),
                delay: const Duration(milliseconds: 600),
              ),

              const SizedBox(height: OnboardingTheme.spacing16),

              // Animated Subtitle
              StaggeredTextAnimation(
                text: t.onboarding.welcome.subtitle, // ✅ LOCALIZADO
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
                delay: const Duration(milliseconds: 800),
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
