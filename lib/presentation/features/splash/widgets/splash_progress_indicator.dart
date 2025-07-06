import 'package:flutter/material.dart';

/// Indicador de progreso contextual para splash screen
class SplashProgressIndicator extends StatefulWidget {
  const SplashProgressIndicator({
    Key? key,
    required this.states,
    required this.onComplete,
    this.stateDuration = const Duration(milliseconds: 500),
  }) : super(key: key);

  final List<String> states;
  final VoidCallback onComplete;
  final Duration stateDuration;

  @override
  State<SplashProgressIndicator> createState() => _SplashProgressIndicatorState();
}

class _SplashProgressIndicatorState extends State<SplashProgressIndicator>
    with TickerProviderStateMixin {
  late AnimationController _progressController;
  late AnimationController _textController;
  late Animation<double> _progressAnimation;
  late Animation<double> _textFadeAnimation;
  
  int _currentStateIndex = 0;
  String _currentState = '';

  @override
  void initState() {
    super.initState();
    
    _progressController = AnimationController(
      duration: Duration(milliseconds: widget.states.length * widget.stateDuration.inMilliseconds),
      vsync: this,
    );

    _textController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOut,
    ));

    _textFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeInOut,
    ));

    _startProgressSequence();
  }

  Future<void> _startProgressSequence() async {
    for (int i = 0; i < widget.states.length; i++) {
      if (!mounted) return;
      
      setState(() {
        _currentStateIndex = i;
        _currentState = widget.states[i];
      });

      // Animar entrada del texto
      _textController.forward();
      
      // Esperar duración del estado
      await Future.delayed(widget.stateDuration);
      
      // Animar salida del texto
      await _textController.reverse();
    }

    // Completar progreso
    await _progressController.forward();
    
    if (mounted) {
      widget.onComplete();
    }
  }

  @override
  void dispose() {
    _progressController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Barra de progreso
        Container(
          width: 200,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(2),
          ),
          child: AnimatedBuilder(
            animation: _progressAnimation,
            builder: (context, child) {
              return Align(
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: _progressAnimation.value,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Texto de estado actual
        AnimatedBuilder(
          animation: _textFadeAnimation,
          builder: (context, child) {
            return Opacity(
              opacity: _textFadeAnimation.value,
              child: Text(
                _currentState,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.9),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            );
          },
        ),
      ],
    );
  }
}
