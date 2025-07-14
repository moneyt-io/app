import 'package:flutter/material.dart';
import 'dart:async';

import '../theme/onboarding_theme.dart';
import '../widgets/staggered_text_animation.dart';

class CompletePage extends StatefulWidget {
  const CompletePage({Key? key}) : super(key: key);

  @override
  State<CompletePage> createState() => _CompletePageState();
}

class _CompletePageState extends State<CompletePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _beforeAnimation;
  late Animation<double> _afterAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    final curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );

    _beforeAnimation = Tween<double>(begin: 0, end: 0.3).animate(curvedAnimation);
    _afterAnimation = Tween<double>(begin: 0, end: 0.7).animate(curvedAnimation);

    // Iniciar la animación después de un breve retraso para que coincida con la entrada de la página
    Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: OnboardingTheme.spacing32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // Título
              StaggeredTextAnimation(
                text: '¡Estás listo para despegar! 🚀',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.3,
                ),
                delay: const Duration(milliseconds: 200),
              ),

              const SizedBox(height: OnboardingTheme.spacing24),

              // Descripción
              StaggeredTextAnimation(
                text: 'Registra tu primera transacción y mira cómo sube tu probabilidad de éxito 📈',
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
                delay: const Duration(milliseconds: 400),
              ),

              const SizedBox(height: OnboardingTheme.spacing48),

              // Infografía animada
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return _buildProbabilityInfographic();
                },
              ),

              const Spacer(),

              // Espacio para el botón centralizado
              const SizedBox(height: 96),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProbabilityInfographic() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.25), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Probabilidad de lograr tu meta',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          _buildProbabilityBar(
            label: 'Antes de MoneyT',
            value: _beforeAnimation.value,
            color: Colors.grey[400]!,
            backgroundColor: Colors.black.withOpacity(0.2),
          ),
          const SizedBox(height: 20),
          _buildProbabilityBar(
            label: 'Con MoneyT',
            value: _afterAnimation.value,
            color: const Color(0xFF34D399), // emerald-400
            backgroundColor: Colors.black.withOpacity(0.2),
          ),
        ],
      ),
    );
  }

  Widget _buildProbabilityBar({
    required String label,
    required double value,
    required Color color,
    required Color backgroundColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 14)),
            Text(
              '${(value * 100).toInt()}%',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              width: constraints.maxWidth,
              height: 10,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: constraints.maxWidth * value,
                  height: 10,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.5),
                        blurRadius: 8,
                        spreadRadius: 1,
                      )
                    ]
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
