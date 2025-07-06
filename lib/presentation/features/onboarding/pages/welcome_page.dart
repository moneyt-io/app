import 'package:flutter/material.dart';
import '../theme/onboarding_theme.dart';
import '../widgets/animated_feature_icon.dart';
import '../widgets/staggered_text_animation.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({
    Key? key,
    this.onNext,
  }) : super(key: key);

  final VoidCallback? onNext;

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with TickerProviderStateMixin {
  late AnimationController _buttonController;
  late Animation<double> _buttonScale;

  @override
  void initState() {
    super.initState();
    
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
  }

  @override
  void dispose() {
    _buttonController.dispose();
    super.dispose();
  }

  void _handleButtonTap() {
    _buttonController.forward().then((_) {
      _buttonController.reverse();
      widget.onNext?.call();
    });
  }

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
          padding: const EdgeInsets.all(OnboardingTheme.spacing32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              
              // Animated Logo
              AnimatedFeatureIcon(
                icon: Icons.account_balance_wallet,
                backgroundColor: Colors.white.withOpacity(0.2),
                iconColor: Colors.white,
                size: 120,
                animationDelay: const Duration(milliseconds: 300),
              ),
              
              const SizedBox(height: OnboardingTheme.spacing48),
              
              // Animated Title
              StaggeredTextAnimation(
                text: '¡Bienvenido a MoneyT!',
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
                text: 'Tu viaje hacia el control financiero\ncomienza aquí',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white.withOpacity(0.9),
                  height: 1.5,
                ),
                delay: const Duration(milliseconds: 800),
              ),
              
              const Spacer(),
              
              // Animated Button
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
                              'Empezar mi viaje',
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
      ),
    );
  }
}
