import 'package:flutter/material.dart';

/// Ícono animado para features con efectos visuales, ahora es un widget compartido.
class AnimatedFeatureIcon extends StatefulWidget {
  const AnimatedFeatureIcon({
    Key? key,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
    this.size = 96,
    this.animationDelay = Duration.zero,
  }) : super(key: key);

  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  final Duration animationDelay;

  @override
  State<AnimatedFeatureIcon> createState() => _AnimatedFeatureIconState();
}

class _AnimatedFeatureIconState extends State<AnimatedFeatureIcon>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _rotationController;
  late AnimationController _pulseController;
  
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _pulseAnimation;

  // Valores de animación ahora locales para no depender de OnboardingTheme
  static const Duration _iconAnimationDuration = Duration(milliseconds: 600);
  static const Curve _bounceCurve = Curves.elasticOut;

  @override
  void initState() {
    super.initState();
    
    _scaleController = AnimationController(
      duration: _iconAnimationDuration,
      vsync: this,
    );
    
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: _bounceCurve,
    ));

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.1,
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.easeInOut,
    ));

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    // Iniciar animación con delay
    Future.delayed(widget.animationDelay, () {
      if (mounted) {
        _scaleController.forward();
        _startContinuousAnimations();
      }
    });
  }

  void _startContinuousAnimations() {
    _rotationController.repeat(reverse: true);
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _rotationController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: RotationTransition(
        turns: _rotationAnimation,
        child: ScaleTransition(
          scale: _pulseAnimation,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              widget.icon,
              color: widget.iconColor,
              size: widget.size * 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
