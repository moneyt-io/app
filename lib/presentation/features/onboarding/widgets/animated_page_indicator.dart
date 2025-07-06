import 'package:flutter/material.dart';
import '../theme/onboarding_theme.dart';

/// Indicador de progreso animado mejorado
class AnimatedPageIndicator extends StatelessWidget {
  const AnimatedPageIndicator({
    Key? key,
    required this.currentPage,
    required this.totalPages,
    this.onPageTap,
  }) : super(key: key);

  final int currentPage;
  final int totalPages;
  final Function(int)? onPageTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: OnboardingTheme.spacing16,
        vertical: OnboardingTheme.spacing8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(totalPages, (index) {
          final isActive = index == currentPage;
          final isPassed = index < currentPage;
          
          return GestureDetector(
            onTap: onPageTap != null ? () => onPageTap!(index) : null,
            child: AnimatedContainer(
              duration: OnboardingTheme.progressUpdate,
              curve: OnboardingTheme.defaultCurve,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: isActive ? 24 : 8,
              height: 8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: isActive || isPassed
                    ? OnboardingTheme.progressColor
                    : OnboardingTheme.progressBackground,
                boxShadow: isActive
                    ? [
                        BoxShadow(
                          color: OnboardingTheme.progressColor.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
            ),
          );
        }),
      ),
    );
  }
}
