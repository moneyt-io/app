import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/services.dart';

import '../theme/onboarding_theme.dart';
import '../widgets/animated_feature_icon.dart';
import '../widgets/staggered_text_animation.dart';
import '../../../navigation/app_routes.dart';
import '../../../navigation/navigation_service.dart';
import '../../../core/services/onboarding_service.dart';

class CompletePage extends StatefulWidget {
  const CompletePage({
    Key? key,
    this.onComplete,
  }) : super(key: key);

  final VoidCallback? onComplete;

  @override
  State<CompletePage> createState() => _CompletePageState();
}

class _CompletePageState extends State<CompletePage>
    with TickerProviderStateMixin {
  late ConfettiController _confettiController;
  late AnimationController _buttonController;
  late Animation<double> _buttonScale;

  @override
  void initState() {
    super.initState();

    _confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );

    _buttonController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _buttonScale = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _buttonController,
      curve: Curves.easeInOut,
    ));

    // Iniciar confetti después de un delay
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (mounted) {
        _confettiController.play();
      }
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  void _handleButtonTap() async {
    print('🎉 Enhanced CompletePage: Button tapped');

    // Animar el botón
    await _buttonController.forward();
    await _buttonController.reverse();

    // Haptic feedback de éxito
    HapticFeedback.heavyImpact();

    // ✅ CAMBIADO: Navegar al login en lugar del home directamente
    print('🔐 Enhanced CompletePage: Navigating to login...');

    // Marcar onboarding como completado
    await OnboardingService.markOnboardingCompleted();

    // Navegar al login
    NavigationService.navigateToAndClearStack(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: OnboardingTheme.gradients['completion']!,
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            // Confetti
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirection: 1.57, // radians - 90 degrees
                emissionFrequency: 0.05,
                numberOfParticles: 50,
                gravity: 0.05,
                shouldLoop: false,
                colors: const [
                  Colors.white,
                  Color(0xFF14B8A6),
                  Color(0xFF3B82F6),
                  Color(0xFF8B5CF6),
                  Color(0xFF10B981),
                ],
              ),
            ),

            // Main content
            Padding(
              padding: const EdgeInsets.all(OnboardingTheme.spacing32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),

                  // Animated Rocket Icon
                  AnimatedFeatureIcon(
                    icon: Icons.rocket_launch,
                    backgroundColor: Colors.white.withOpacity(0.2),
                    iconColor: Colors.white,
                    size: 120,
                    animationDelay: const Duration(milliseconds: 300),
                  ),

                  const SizedBox(height: OnboardingTheme.spacing48),

                  // Success Title
                  StaggeredTextAnimation(
                    text: '¡Estás listo para\ndespegar! 🚀',
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.2,
                    ),
                    delay: const Duration(milliseconds: 600),
                  ),

                  const SizedBox(height: OnboardingTheme.spacing24),

                  // Motivational Message
                  StaggeredTextAnimation(
                    text:
                        'Tu viaje hacia el control financiero\ncomienza ahora. ¡Vamos a conquistar\ntus metas juntos!',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white.withOpacity(0.9),
                      height: 1.5,
                    ),
                    delay: const Duration(milliseconds: 800),
                  ),

                  const Spacer(),

                  // Call-to-Action Button
                  AnimatedBuilder(
                    animation: _buttonScale,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _buttonScale.value,
                        child: Container(
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
                              onTap: _handleButtonTap,
                              borderRadius: BorderRadius.circular(28),
                              child: const Center(
                                child: Text(
                                  '¡Comenzar mi aventura!',
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
                      );
                    },
                  ),

                  const SizedBox(height: OnboardingTheme.spacing24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
