import 'dart:math';
import 'package:flutter/material.dart';

class Dashboard2Gauge extends StatelessWidget {
  final double percentage;

  const Dashboard2Gauge({
    super.key,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 125, // Half of width for a semi-circle
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CustomPaint(
            size: const Size(250, 125),
            painter: _GaugePainter(),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${(percentage * 100).toInt()}%',
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF131B2E),
                  height: 1,
                  fontFamily: 'Manrope',
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'LO QUE QUEDA',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: Color(0xB3131B2E), // 70% opacity
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ],
      ),
    );
  }
}

class _GaugePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Pad by half the strokeWidth (12) so the arc is completely inside the bounds
    final rect = Rect.fromLTRB(12, 12, size.width - 12, (size.height - 12) * 2);
    const startAngle = pi;
    const sweepAngle = pi;

    // Background track
    final bgPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 24
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(rect, startAngle, sweepAngle, false, bgPaint);

    // Color 1: Orange #ffb95f
    final orangePaint = Paint()
      ..color = const Color(0xFFFFB95F)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 24
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(rect, startAngle, pi * 0.15, false, orangePaint);

    // Color 2: Green #6cf8bb
    final greenPaint = Paint()
      ..color = const Color(0xFF6CF8BB)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 24
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(rect, startAngle + pi * 0.15, pi * 0.35, false, greenPaint);

    // Color 3: Blue #2563eb
    final bluePaint = Paint()
      ..color = const Color(0xFF2563EB)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 24
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(rect, startAngle + pi * 0.50, pi * 0.40, false, bluePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
