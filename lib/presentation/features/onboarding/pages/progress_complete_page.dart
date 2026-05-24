import 'package:flutter/material.dart';

class ProgressCompletePage extends StatefulWidget {
  const ProgressCompletePage({super.key});

  @override
  State<ProgressCompletePage> createState() => _ProgressCompletePageState();
}

class _ProgressCompletePageState extends State<ProgressCompletePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Start animation when page appears
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24, // Space for top navigation
        bottom: 120, // Space for bottom button
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 32),
          // Circular Progress
          SizedBox(
            width: 200,
            height: 200,
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedBuilder(
                  animation: _progressAnimation,
                  builder: (context, child) {
                    return SizedBox(
                      width: 200,
                      height: 200,
                      child: CircularProgressIndicator(
                        value: _progressAnimation.value,
                        strokeWidth: 16,
                        backgroundColor: const Color(0xFFEEF2FF), // inverse-on-surface approx
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF2563EB), // primary-container
                        ),
                      ),
                    );
                  },
                ),
                AnimatedBuilder(
                  animation: _progressAnimation,
                  builder: (context, child) {
                    final percentage = (_progressAnimation.value * 100).toInt();
                    return Text(
                      '$percentage%',
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF131B2E),
                        letterSpacing: -1.0,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 64),
          const Text(
            'CONFIGURANDO APP SEGÚN\nTUS RESPUESTAS',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
              color: Color(0xFF434655),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Analizando',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xFF131B2E),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Revisando tus gastos diarios',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFF737686),
            ),
          ),
        ],
      ),
    );
  }
}
