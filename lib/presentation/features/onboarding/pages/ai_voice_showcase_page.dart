import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'main_priority_page.dart';

class AIVoiceShowcasePage extends StatefulWidget {
  final PersonalGoal? selectedGoal;
  
  const AIVoiceShowcasePage({super.key, this.selectedGoal});

  @override
  State<AIVoiceShowcasePage> createState() => _AIVoiceShowcasePageState();
}

class _AIVoiceShowcasePageState extends State<AIVoiceShowcasePage>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  Timer? _timer;
  
  final List<FloatingTransaction> _transactions = [];
  final Random _random = Random();
  final List<String> _examples = [
    'Café \$3.50',
    'Uber \$12.00',
    'Cine \$15.00',
    'Súper \$45.20',
    'Gasolina \$30.00',
    'Netflix \$10.99',
    'Cena \$25.00',
    'Farmacia \$18.50'
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      if (mounted) {
        setState(() {
          final text = _examples[_random.nextInt(_examples.length)];
          final isLeft = _random.nextBool();
          final xOffset = _random.nextDouble(); // 0 to 1
          final id = DateTime.now().millisecondsSinceEpoch;
          
          _transactions.add(FloatingTransaction(id: id, text: text, xOffset: xOffset, isLeft: isLeft));
          
          // Remove after animation completes (3 seconds)
          Future.delayed(const Duration(seconds: 3), () {
            if (mounted) {
              setState(() {
                _transactions.removeWhere((t) => t.id == id);
              });
            }
          });
        });
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24, 
        bottom: 120, 
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: _buildDynamicTitleSpan(widget.selectedGoal),
          ),
          const SizedBox(height: 64),
          _buildMicrophoneAnimation(),
          const SizedBox(height: 64),
          const Text(
            'Registra tus gastos con solo\ndecirlo a tu celular',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Color(0xFF4B5563),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  TextSpan _buildDynamicTitleSpan(PersonalGoal? goal) {
    const baseStyle = TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      color: Color(0xFF131B2E),
      height: 1.2,
    );

    const highlightStyle = TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: Color(0xFF131B2E),
    );

    String meta;
    if (goal == null) {
      meta = 'Alcanzar tu meta';
    } else {
      switch (goal) {
        case PersonalGoal.breakHabits:
          meta = 'Romper tus malos hábitos financieros';
          break;
        case PersonalGoal.stopStress:
          meta = 'Dejar de preocuparte por el dinero';
          break;
        case PersonalGoal.buildFuture:
          meta = 'Construir un futuro más abundante';
          break;
        case PersonalGoal.feelControl:
          meta = 'Sentir que vuelves a controlar tu dinero';
          break;
        case PersonalGoal.saveGoal:
          meta = 'Ahorrar para tus metas importantes';
          break;
      }
    }

    return TextSpan(
      style: baseStyle,
      children: [
        TextSpan(text: meta, style: highlightStyle),
        const TextSpan(text: ' será posible sin esfuerzo con la inteligencia artificial.'),
      ],
    );
  }

  Widget _buildMicrophoneAnimation() {
    return SizedBox(
      height: 240,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // Floating transactions
          for (var t in _transactions)
            Positioned(
              key: ValueKey(t.id),
              child: FloatingTextWidget(
                text: t.text,
                xOffset: t.xOffset,
                isLeft: t.isLeft,
              ),
            ),
            
          // Sound waves
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Transform.scale(
                    scale: 1.0 + (_pulseController.value * 0.4),
                    child: Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF3B82F6).withOpacity(0.1 - (_pulseController.value * 0.1)),
                        border: Border.all(
                          color: const Color(0xFF3B82F6).withOpacity(0.2 - (_pulseController.value * 0.2)),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  Transform.scale(
                    scale: 1.0 + (_pulseController.value * 0.2),
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF3B82F6).withOpacity(0.15 - (_pulseController.value * 0.15)),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          
          // Text above microphone
          const Positioned(
            top: -20,
            child: Column(
              children: [
                Text(
                  'Escuchando...',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2563EB),
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.graphic_eq, size: 16, color: Color(0xFF3B82F6)),
                  ],
                ),
              ],
            ),
          ),
          
          // Inner microphone button
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Transform.scale(
                scale: 1.0 + (_pulseController.value * 0.05),
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF3B82F6).withOpacity(0.4),
                        blurRadius: 20 + (_pulseController.value * 10),
                        spreadRadius: 4 + (_pulseController.value * 4),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.mic,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class FloatingTransaction {
  final int id;
  final String text;
  final double xOffset; 
  final bool isLeft;

  FloatingTransaction({required this.id, required this.text, required this.xOffset, required this.isLeft});
}

class FloatingTextWidget extends StatelessWidget {
  final String text;
  final double xOffset; 
  final bool isLeft;

  const FloatingTextWidget({
    super.key, 
    required this.text, 
    required this.xOffset, 
    required this.isLeft
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(seconds: 3),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        // Fade in quickly, stay, fade out slowly
        double opacity = value < 0.1 ? value / 0.1 : 
                        value > 0.8 ? (1 - value) / 0.2 : 1.0;
        
        // Move up from 60 to -100
        double yOffset = 60 - (160 * value);
        
        // Move horizontally slightly to spread
        double dx = xOffset * 100 + 40; 
        if (isLeft) dx = -dx;

        return Transform.translate(
          offset: Offset(dx, yOffset),
          child: Opacity(
            opacity: opacity,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF3B82F6).withOpacity(0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E40AF),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
