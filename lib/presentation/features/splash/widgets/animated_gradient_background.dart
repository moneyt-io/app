import 'package:flutter/material.dart';

/// Fondo con gradiente animado que cambia durante la carga
class AnimatedGradientBackground extends StatefulWidget {
  const AnimatedGradientBackground({
    Key? key,
    required this.child,
    this.duration = const Duration(seconds: 2),
  }) : super(key: key);

  final Widget child;
  final Duration duration;

  @override
  State<AnimatedGradientBackground> createState() => _AnimatedGradientBackgroundState();
}

class _AnimatedGradientBackgroundState extends State<AnimatedGradientBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  // Secuencia de gradientes que se irán mostrando
  final List<List<Color>> _gradientSequence = [
    [const Color(0xFF4AE3B5), const Color(0xFF2DD4BF)], // Inicial - Teal claro
    [const Color(0xFF3B82F6), const Color(0xFF1D4ED8)], // Intermedio - Azul
    [const Color(0xFF14B8A6), const Color(0xFF0F766E)], // Final - Teal oscuro
  ];

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        // Calcular qué gradientes interpolar basado en el progreso
        final progress = _animation.value;
        final segmentCount = _gradientSequence.length - 1;
        final segment = (progress * segmentCount).floor().clamp(0, segmentCount - 1);
        final segmentProgress = (progress * segmentCount) - segment;

        final currentGradient = _gradientSequence[segment];
        final nextGradient = segment < segmentCount 
            ? _gradientSequence[segment + 1]
            : _gradientSequence[segment];

        // Interpolar entre gradientes
        final interpolatedColors = [
          Color.lerp(currentGradient[0], nextGradient[0], segmentProgress)!,
          Color.lerp(currentGradient[1], nextGradient[1], segmentProgress)!,
        ];

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              colors: interpolatedColors,
            ),
          ),
          child: widget.child,
        );
      },
    );
  }
}
