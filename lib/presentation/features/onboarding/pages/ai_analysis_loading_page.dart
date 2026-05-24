import 'dart:math';
import 'package:flutter/material.dart';

class AIAnalysisLoadingPage extends StatefulWidget {
  final VoidCallback onLoadingComplete;

  const AIAnalysisLoadingPage({
    super.key,
    required this.onLoadingComplete,
  });

  @override
  State<AIAnalysisLoadingPage> createState() => _AIAnalysisLoadingPageState();
}

class _AIAnalysisLoadingPageState extends State<AIAnalysisLoadingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progress;

  final List<String> _loadingMessages = [
    'Revisando tus gastos diarios...',
    'Categorizando tus transacciones...',
    'Encontrando patrones de gasto...',
    'Generando recomendaciones...',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _progress = Tween<double>(begin: 0, end: 100).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward().then((_) {
      widget.onLoadingComplete();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background patterns
        Positioned(
          top: 150,
          right: 80,
          child: CustomPaint(
            size: const Size(40, 40),
            painter: DottedPatternPainter(const Color(0xFF34D399)),
          ),
        ),
        Positioned(
          top: 250,
          left: 40,
          child: CustomPaint(
            size: const Size(50, 50),
            painter: DottedPatternPainter(const Color(0xFF93C5FD)),
          ),
        ),
        Positioned(
          top: 300,
          right: 30,
          child: CustomPaint(
            size: const Size(50, 60),
            painter: DottedPatternPainter(const Color(0xFF93C5FD)),
          ),
        ),
        Positioned(
          bottom: 100,
          right: 100,
          child: CustomPaint(
            size: const Size(40, 40),
            painter: DottedPatternPainter(const Color(0xFFBFDBFE)),
          ),
        ),

        // Main content
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _progress,
                builder: (context, child) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: CustomPaint(
                          painter: CircularProgressPainter(_progress.value),
                        ),
                      ),
                      Text(
                        '${_progress.value.toInt()}%',
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF131B2E),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 64),
              const Text(
                'CONFIGURANDO APP SEGÚN\nTUS RESPUESTAS',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF374151),
                  letterSpacing: 1.5,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Analizando',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF131B2E),
                ),
              ),
              const SizedBox(height: 8),
              AnimatedBuilder(
                animation: _progress,
                builder: (context, child) {
                  // Determine message based on progress
                  int messageIndex = (_progress.value / 25).floor();
                  if (messageIndex > 3) messageIndex = 3;
                  return Text(
                    _loadingMessages[messageIndex],
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6B7280),
                      fontWeight: FontWeight.w500,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  final double progress;

  CircularProgressPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw background circle
    final bgPaint = Paint()
      ..color = const Color(0xFFF3F4F6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;
    canvas.drawCircle(center, radius, bgPaint);

    // Draw progress arc
    final rect = Rect.fromCircle(center: center, radius: radius);
    final gradient = const SweepGradient(
      startAngle: -pi / 2,
      endAngle: 3 * pi / 2,
      colors: [Color(0xFF60A5FA), Color(0xFF2563EB)],
    );

    final progressPaint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8;

    canvas.drawArc(
        rect, -pi / 2, (progress / 100) * 2 * pi, false, progressPaint);
  }

  @override
  bool shouldRepaint(CircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class DottedPatternPainter extends CustomPainter {
  final Color color;

  DottedPatternPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    // Draw a random-looking cluster of dots within the size
    final random = Random(color.value); // fixed seed based on color for consistency
    int dotCount = (size.width * size.height / 80).toInt();

    for (int i = 0; i < dotCount; i++) {
      double x = random.nextDouble() * size.width;
      double y = random.nextDouble() * size.height;
      
      // align to grid for dotted look
      x = (x / 8).round() * 8.0;
      y = (y / 8).round() * 8.0;

      canvas.drawCircle(Offset(x, y), 2.5, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
