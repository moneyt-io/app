import 'package:flutter/material.dart';
import '../theme/onboarding_theme.dart';

/// Animación de texto con efecto staggered
class StaggeredTextAnimation extends StatefulWidget {
  const StaggeredTextAnimation({
    Key? key,
    required this.text,
    required this.style,
    this.delay = Duration.zero,
    this.textAlign = TextAlign.center,
  }) : super(key: key);

  final String text;
  final TextStyle style;
  final Duration delay;
  final TextAlign textAlign;

  @override
  State<StaggeredTextAnimation> createState() => _StaggeredTextAnimationState();
}

class _StaggeredTextAnimationState extends State<StaggeredTextAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: OnboardingTheme.elementEntrance,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: OnboardingTheme.slideCurve,
    ));

    // Iniciar animación con delay
    Future.delayed(widget.delay, () {
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
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Text(
              widget.text,
              style: widget.style,
              textAlign: widget.textAlign,
            ),
          ),
        );
      },
    );
  }
}
