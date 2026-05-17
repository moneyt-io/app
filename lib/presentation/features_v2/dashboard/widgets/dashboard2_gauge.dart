import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Dashboard2Gauge extends StatefulWidget {
  final double income;
  final double expenses;

  const Dashboard2Gauge({
    super.key,
    required this.income,
    required this.expenses,
  });

  @override
  State<Dashboard2Gauge> createState() => _Dashboard2GaugeState();
}

class _Dashboard2GaugeState extends State<Dashboard2Gauge> {
  bool _showPercentage = true;

  @override
  Widget build(BuildContext context) {
    // Calculates percentage of income spent
    double displayPercentage = widget.income > 0 
        ? widget.expenses / widget.income 
        : (widget.expenses > 0 ? 1.5 : 0.0); // If expenses exist but no income, simulate overflow

    Color gaugeColor;
    if (displayPercentage <= 0.8) {
      gaugeColor = const Color(0xFF6CF8BB); // Green
    } else if (displayPercentage <= 1.0) {
      gaugeColor = const Color(0xFFFFB95F); // Yellow/Orange
    } else {
      gaugeColor = const Color(0xFFBA1A1A); // Red
    }

    double remaining = widget.income - widget.expenses;
    String mainText;
    String subText;

    if (_showPercentage) {
      mainText = '${(displayPercentage * 100).toInt()}%';
      subText = displayPercentage > 1.0 ? 'EXCEDIDO' : 'GASTADO';
    } else {
      final formatCurrency = NumberFormat.currency(symbol: '\$', decimalDigits: 2);
      mainText = formatCurrency.format(remaining.abs());
      subText = remaining >= 0 ? 'DISPONIBLE' : 'SOBREGIRADO';
    }

    // Adapt text color conditionally 
    Color textColor = displayPercentage > 1.0 && _showPercentage ? gaugeColor : const Color(0xFF131B2E);
    // Darker variant for subText if it's over limit
    Color subTextColor = displayPercentage > 1.0 ? gaugeColor.withValues(alpha: 0.8) : const Color(0xB3131B2E);

    return GestureDetector(
      onTap: () {
        setState(() {
          _showPercentage = !_showPercentage;
        });
      },
      child: SizedBox(
        width: 250,
        height: 125, // Half of width for a semi-circle
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CustomPaint(
              size: const Size(250, 125),
              painter: _GaugePainter(
                percentage: displayPercentage.clamp(0.0, 1.0),
                color: gaugeColor,
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  mainText,
                  style: TextStyle(
                    fontSize: _showPercentage ? 36 : 28,
                    fontWeight: FontWeight.w800,
                    color: textColor,
                    height: 1,
                    fontFamily: 'Manrope',
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: displayPercentage > 1.0 ? gaugeColor.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    subText,
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: subTextColor,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _GaugePainter extends CustomPainter {
  final double percentage;
  final Color color;

  _GaugePainter({required this.percentage, required this.color});

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

    // Foreground track
    final fgPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 24
      ..strokeCap = StrokeCap.round;

    final sweep = pi * percentage;
    if (sweep > 0) {
      canvas.drawArc(rect, startAngle, sweep, false, fgPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _GaugePainter oldDelegate) {
    return oldDelegate.percentage != percentage || oldDelegate.color != color;
  }
}
