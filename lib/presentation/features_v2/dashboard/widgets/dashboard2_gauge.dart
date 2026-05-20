import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../domain/entities/transaction_entry.dart';
import '../../../../domain/entities/category.dart';

class Dashboard2Gauge extends StatefulWidget {
  final double income;
  final double expenses;
  final List<TransactionEntry> transactions;
  final Map<int, Category> categoriesDataMap;

  const Dashboard2Gauge({
    super.key,
    required this.income,
    required this.expenses,
    required this.transactions,
    required this.categoriesDataMap,
  });

  @override
  State<Dashboard2Gauge> createState() => _Dashboard2GaugeState();
}

class GaugeSegment {
  final double amount;
  final Color color;
  GaugeSegment(this.amount, this.color);
}

class _Dashboard2GaugeState extends State<Dashboard2Gauge> {
  bool _showPercentage = true;

  @override
  Widget build(BuildContext context) {
    // Calculates percentage of income spent
    double displayPercentage = widget.income > 0 
        ? widget.expenses / widget.income 
        : (widget.expenses > 0 ? 1.0 : 0.0); 

    // Extract categories
    final expensesTx = widget.transactions.where((t) => t.documentTypeId == 'E');
    final Map<String, double> categorySums = {};
    for (final t in expensesTx) {
      final cat = t.category ?? (t.mainCategoryId != null ? widget.categoriesDataMap[t.mainCategoryId!] : null);
      final catId = cat?.id.toString() ?? 'otros';
      categorySums[catId] = (categorySums[catId] ?? 0) + t.amount.abs();
    }

    final sortedCategories = categorySums.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final colors = [
      const Color(0xFF004AC6), // blue
      const Color(0xFF6CF8BB), // green
      const Color(0xFFFFB95F), // orange
      const Color(0xFFBA1A1A), // red
      const Color(0xFF9C27B0), // purple
      const Color(0xFF00BCD4), // indigo
    ];

    List<GaugeSegment> segments = [];
    for (var entry in sortedCategories) {
      final hash = entry.key.hashCode;
      final color = colors[hash % colors.length];
      segments.add(GaugeSegment(entry.value, color));
    }

    // Default color if no segments but expenses exist
    Color overflowColor = const Color(0xFFBA1A1A);

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
    Color textColor = displayPercentage > 1.0 && _showPercentage ? overflowColor : const Color(0xFF131B2E);
    // Darker variant for subText if it's over limit
    Color subTextColor = displayPercentage > 1.0 ? overflowColor.withValues(alpha: 0.8) : const Color(0xB3131B2E);

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
                income: widget.income,
                expenses: widget.expenses,
                segments: segments,
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
                    color: displayPercentage > 1.0 ? overflowColor.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.1),
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
  final double income;
  final double expenses;
  final List<GaugeSegment> segments;

  _GaugePainter({required this.income, required this.expenses, required this.segments});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTRB(12, 12, size.width - 12, (size.height - 12) * 2);
    const startAngle = pi;
    const maxSweep = pi;

    // Background track
    final bgPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 24
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(rect, startAngle, maxSweep, false, bgPaint);

    if (expenses <= 0) return;

    // Si los gastos superan los ingresos, limitamos el visual a llenar todo
    final totalBase = income > 0 ? income : expenses;
    final scale = maxSweep / totalBase;

    double currentAngle = startAngle;
    double totalDrawn = 0;

    for (int i = 0; i < segments.length; i++) {
      final seg = segments[i];
      if (totalDrawn >= totalBase) break;

      double sweep = seg.amount * scale;
      
      // Si este segmento se pasa del máximo del gauge, lo recortamos
      if ((currentAngle - startAngle) + sweep > maxSweep) {
        sweep = maxSweep - (currentAngle - startAngle);
      }

      final paint = Paint()
        ..color = seg.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 24
        // Solo redondeamos los extremos en el primero y el último (o al final del trazo)
        ..strokeCap = StrokeCap.butt;
        
      if (i == 0 && segments.length == 1) {
        paint.strokeCap = StrokeCap.round;
      }

      // Dibujar segmento
      if (sweep > 0) {
        canvas.drawArc(rect, currentAngle, sweep, false, paint);
        currentAngle += sweep;
        totalDrawn += seg.amount;
      }
    }

    // Para redondear los extremos si es necesario, dibujamos pequeños arcos encima
    if (currentAngle > startAngle && currentAngle < startAngle + maxSweep) {
      final capPaint = Paint()
        ..color = segments.last.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 24
        ..strokeCap = StrokeCap.round;
      canvas.drawArc(rect, currentAngle - 0.01, 0.01, false, capPaint);
    }
    
    if (segments.isNotEmpty && currentAngle > startAngle) {
      final capPaint = Paint()
        ..color = segments.first.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 24
        ..strokeCap = StrokeCap.round;
      canvas.drawArc(rect, startAngle, 0.01, false, capPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _GaugePainter oldDelegate) {
    return true; // Simplificado para siempre repintar si cambian los segmentos
  }
}
