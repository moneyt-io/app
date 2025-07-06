import 'package:flutter/material.dart';

/// Logo animado de MoneyT con efectos avanzados
class AnimatedMoneyTLogo extends StatefulWidget {
  const AnimatedMoneyTLogo({
    Key? key,
    this.size = 80,
    this.animationDelay = Duration.zero,
  }) : super(key: key);

  final double size;
  final Duration animationDelay;

  @override
  State<AnimatedMoneyTLogo> createState() => _AnimatedMoneyTLogoState();
}

class _AnimatedMoneyTLogoState extends State<AnimatedMoneyTLogo>
    with TickerProviderStateMixin {
  late AnimationController _entryController;
  late AnimationController _breathingController;
  late AnimationController _rotationController;
  
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _breathingAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    
    // Controlador para entrada inicial
    _entryController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    // Controlador para efecto breathing
    _breathingController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    
    // Controlador para rotación sutil
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 4000),
      vsync: this,
    );

    // Animaciones de entrada
    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _entryController,
      curve: Curves.elasticOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _entryController,
      curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
    ));

    // Animación breathing (pulsación sutil)
    _breathingAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _breathingController,
      curve: Curves.easeInOut,
    ));

    // Rotación muy sutil
    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.02, // Rotación mínima (1.15 grados)
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.easeInOut,
    ));

    // Iniciar animaciones con delay
    Future.delayed(widget.animationDelay, () {
      if (mounted) {
        _entryController.forward();
        
        // Iniciar animaciones continuas después de la entrada
        _entryController.addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            _startContinuousAnimations();
          }
        });
      }
    });
  }

  void _startContinuousAnimations() {
    // Breathing effect
    _breathingController.repeat(reverse: true);
    
    // Rotación sutil continua
    _rotationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _entryController.dispose();
    _breathingController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _scaleAnimation,
        _fadeAnimation,
        _breathingAnimation,
        _rotationAnimation,
      ]),
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value * _breathingAnimation.value,
          child: Transform.rotate(
            angle: _rotationAnimation.value,
            child: Opacity(
              opacity: _fadeAnimation.value,
              child: Container(
                width: widget.size,
                height: widget.size,
                decoration: BoxDecoration(
                  color: const Color(0xFF14B8A6), // Teal de MoneyT
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF14B8A6).withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.account_balance_wallet,
                  size: widget.size * 0.5,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
