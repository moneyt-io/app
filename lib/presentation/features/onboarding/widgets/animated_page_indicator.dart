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
        horizontal: 0,
        vertical: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(totalPages, (index) {
          final isActive = index == currentPage;
          final isPassed = index < currentPage;
          
          return GestureDetector(
            onTap: onPageTap != null ? () => onPageTap!(index) : null,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 24, // Fixed width for all dashes
              height: 4,  // Thin dash
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: isActive || isPassed
                    ? const Color(0xFF2B63F1) // Blue active/passed color
                    : const Color(0xFFE5E7EB), // Gray inactive color
              ),
            ),
          );
        }),
      ),
    );
  }
}
