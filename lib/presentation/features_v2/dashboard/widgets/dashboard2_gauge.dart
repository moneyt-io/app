import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../domain/entities/transaction_entry.dart';
import '../../../../core/utils/number_formatter.dart';
import '../../../../domain/entities/category.dart';
import '../../../core/l10n/generated/strings.g.dart';

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
  final String categoryName;
  final double amount;
  final Color color;
  final double startAngle;
  final double sweepAngle;
  
  GaugeSegment(this.categoryName, this.amount, this.color, this.startAngle, this.sweepAngle);
}

class _Dashboard2GaugeState extends State<Dashboard2Gauge> {
  bool _showPercentage = true;
  int? _selectedIndex;
  Offset? _touchPosition;
  bool _isTrackingGauge = false;

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
      const Color(0xFF004AC6), // Royal Blue
      const Color(0xFF0D9488), // Teal
      const Color(0xFFD97706), // Amber
      const Color(0xFF059669), // Emerald
      const Color(0xFF7C3AED), // Violet
      const Color(0xFFDC2626), // Soft Red
      const Color(0xFF2563EB), // Blue 600
      const Color(0xFFD946EF), // Fuchsia
      const Color(0xFF0F766E), // Dark Teal
      const Color(0xFFEA580C), // Orange
      const Color(0xFF4F46E5), // Indigo
      const Color(0xFFBE123C), // Rose
    ];

    List<GaugeSegment> segments = [];
    final sortedKeys = widget.categoriesDataMap.keys.toList()..sort();
    
    // Asegurar que el gráfico siempre se vea 100% lleno con los gastos
    final totalExpensesToDraw = widget.expenses;
    const maxSweep = pi;
    final scale = totalExpensesToDraw > 0 ? maxSweep / totalExpensesToDraw : 0.0;
    
    double currentAngle = pi; // start angle
    double totalDrawn = 0.0;

    for (var entry in sortedCategories) {
      if (totalDrawn >= totalExpensesToDraw) break;
      
      int colorIndex = 0;
      String categoryName = t.v2.dashboard.activityList.others;
      
      if (entry.key != 'otros') {
        final parsedId = int.tryParse(entry.key);
        if (parsedId != null) {
          final idx = sortedKeys.indexOf(parsedId);
          if (idx != -1) colorIndex = idx;
          categoryName = widget.categoriesDataMap[parsedId]?.name ?? t.v2.dashboard.activityList.others;
        }
      }
      
      final color = colors[colorIndex % colors.length];
      
      double sweep = entry.value * scale;
      if ((currentAngle - pi) + sweep > maxSweep) {
        sweep = maxSweep - (currentAngle - pi);
      }
      
      if (sweep > 0) {
        segments.add(GaugeSegment(categoryName, entry.value, color, currentAngle, sweep));
        currentAngle += sweep;
        totalDrawn += entry.value;
      }
    }

    // Default color if no segments but expenses exist
    Color overflowColor = const Color(0xFFBA1A1A);

    double remaining = widget.income - widget.expenses;
    String mainText;
    String subText;

    if (_selectedIndex != null && _selectedIndex! < segments.length) {
      final selectedSegment = segments[_selectedIndex!];
      mainText = NumberFormatter.formatCurrency(selectedSegment.amount);
      subText = selectedSegment.categoryName.toUpperCase();
    } else if (_showPercentage) {
      mainText = '${(displayPercentage * 100).toInt()}%';
      subText = displayPercentage > 1.0 ? t.v2.dashboard.gauge.exceeded : t.v2.dashboard.gauge.spent;
    } else {
      mainText = NumberFormatter.formatCurrency(remaining.abs());
      subText = remaining >= 0 ? t.v2.dashboard.gauge.available : t.v2.dashboard.gauge.overdrawn;
    }

    // Adapt text color conditionally 
    Color textColor = (_selectedIndex == null && displayPercentage > 1.0 && _showPercentage) ? overflowColor : Colors.white;
    // Darker variant for subText if it's over limit
    Color subTextColor = (_selectedIndex == null && displayPercentage > 1.0) ? overflowColor.withValues(alpha: 0.8) : Colors.white.withValues(alpha: 0.8);
    
    // Shadows for contrast on white text
    List<Shadow> textShadows = textColor == Colors.white ? [
      Shadow(
        color: Colors.black.withValues(alpha: 0.25),
        blurRadius: 10,
        offset: const Offset(0, 2),
      )
    ] : [];

    if (_selectedIndex != null && _selectedIndex! < segments.length) {
      textColor = segments[_selectedIndex!].color;
      subTextColor = segments[_selectedIndex!].color.withValues(alpha: 0.8);
      textShadows = []; // Quitar sombra si tiene color para mantener la estética limpia
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (details) {
        _isTrackingGauge = _isOverGauge(details.localPosition);
        if (_isTrackingGauge) {
          _handleTouch(details.localPosition, segments, isFirstTouch: true);
        }
      },
      onTapUp: (details) {
        if (_isTrackingGauge) {
          _isTrackingGauge = false;
          setState(() => _selectedIndex = null);
        } else if (!_isOverGauge(details.localPosition)) {
          setState(() {
            _showPercentage = !_showPercentage;
          });
        }
      },
      onTapCancel: () {
        if (_isTrackingGauge) {
          _isTrackingGauge = false;
          setState(() => _selectedIndex = null);
        }
      },
      onHorizontalDragStart: (details) {
        if (!_isTrackingGauge) {
          _isTrackingGauge = _isOverGauge(details.localPosition);
        }
        if (_isTrackingGauge) {
          _handleTouch(details.localPosition, segments, isFirstTouch: true);
        }
      },
      onHorizontalDragUpdate: (details) {
        if (_isTrackingGauge) {
          _handleTouch(details.localPosition, segments, isFirstTouch: false);
        }
      },
      onHorizontalDragEnd: (details) {
        if (_isTrackingGauge) {
          _isTrackingGauge = false;
          setState(() => _selectedIndex = null);
        }
      },
      onHorizontalDragCancel: () {
        if (_isTrackingGauge) {
          _isTrackingGauge = false;
          setState(() => _selectedIndex = null);
        }
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
                selectedIndex: _selectedIndex,
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 150),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: Text(
                    mainText,
                    key: ValueKey<String>(mainText),
                    style: TextStyle(
                      fontSize: (_showPercentage && _selectedIndex == null) ? 36 : 24,
                      fontWeight: FontWeight.w800,
                      color: textColor,
                      height: 1,
                      fontFamily: 'Manrope',
                      shadows: textShadows,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: _selectedIndex != null 
                        ? segments[_selectedIndex!].color.withValues(alpha: 0.1)
                        : (displayPercentage > 1.0 ? overflowColor.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.1)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    subText,
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: subTextColor,
                      letterSpacing: 1.5,
                      shadows: textShadows,
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

  bool _isOverGauge(Offset localPosition) {
    // Determina si las coordenadas (X, Y) están estrictamente sobre el área pintada del arco
    final dx = localPosition.dx - 125.0; // 250/2 (centro X)
    final dy = localPosition.dy - 125.0; // 125 (centro Y)
    
    final distance = sqrt(dx * dx + dy * dy);
    
    // El arco tiene radio interno ~89 y externo ~113
    // Damos un margen de error humano (80 a 135)
    return distance >= 80 && distance <= 135;
  }

  void _handleTouch(Offset localPosition, List<GaugeSegment> segments, {bool isFirstTouch = false}) {
    if (segments.isEmpty) return;

    if (isFirstTouch) {
      final dx = localPosition.dx - 125.0; 
      final dy = localPosition.dy - 125.0; 
      final distance = sqrt(dx * dx + dy * dy);
      
      if (distance < 80 || distance > 135) {
        return; 
      }
    }
    
    double progressX = (localPosition.dx - 12) / (250 - 24);
    progressX = progressX.clamp(0.0, 1.0); 

    double totalSweep = 0;
    for (var seg in segments) {
      totalSweep += seg.sweepAngle;
    }

    double targetAngleProgress = progressX * totalSweep;

    int? newIndex;
    double currentProgressAccumulated = 0;
    
    for (int i = 0; i < segments.length; i++) {
      final seg = segments[i];
      currentProgressAccumulated += seg.sweepAngle;
      
      if (targetAngleProgress <= currentProgressAccumulated) {
        newIndex = i;
        break;
      }
    }
    
    if (newIndex == null && segments.isNotEmpty) {
      newIndex = segments.length - 1;
    }

    if (newIndex != _selectedIndex) {
      if (newIndex != null) {
        if (isFirstTouch) {
          HapticFeedback.lightImpact();
        } else {
          HapticFeedback.selectionClick();
        }
      }
      setState(() {
        _selectedIndex = newIndex;
      });
    }
  }
}

class _GaugePainter extends CustomPainter {
  final double income;
  final double expenses;
  final List<GaugeSegment> segments;
  final int? selectedIndex;

  _GaugePainter({required this.income, required this.expenses, required this.segments, this.selectedIndex});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTRB(14, 14, size.width - 14, (size.height - 14) * 2);
    const startAngle = pi;
    const maxSweep = pi;

    // Background track
    final bgPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 24
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(rect, startAngle, maxSweep, false, bgPaint);

    if (expenses <= 0 || segments.isEmpty) return;

    double totalSegmentAmount = 0.0;
    for (var seg in segments) {
      totalSegmentAmount += seg.amount;
    }
    
    if (totalSegmentAmount <= 0) return;

    // Dibujaremos tapones bases DEBAJO de todo. 
    // Para que los bordes del gauge siempre sean perfectamente curvos y coloreados
    // sin que un StrokeCap.round tape agresivamente a otro segmento contiguo.
    
    // Tapón inicial (izquierda)
    bool isFirstSelected = selectedIndex == 0;
    final firstColor = (selectedIndex != null && !isFirstSelected) 
        ? segments.first.color.withValues(alpha: 0.3) 
        : segments.first.color.withValues(alpha: 0.85);
        
    final firstCapPaint = Paint()
      ..color = firstColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = isFirstSelected ? 28.0 : 24.0
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(rect, startAngle, 0.001, false, firstCapPaint);

    // Tapón final (derecha)
    bool isLastSelected = selectedIndex == segments.length - 1;
    final lastColor = (selectedIndex != null && !isLastSelected) 
        ? segments.last.color.withValues(alpha: 0.3) 
        : segments.last.color.withValues(alpha: 0.85);
        
    final lastCapPaint = Paint()
      ..color = lastColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = isLastSelected ? 28.0 : 24.0
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(rect, startAngle + maxSweep - 0.001, 0.001, false, lastCapPaint);

    // Ahora dibujamos los segmentos puros usando Butt (bordes planos perfectos)
    double currentAngle = startAngle;

    for (int i = 0; i < segments.length; i++) {
      double proportion = segments[i].amount / totalSegmentAmount;
      double rawSweep = proportion * maxSweep;

      bool isSelected = selectedIndex == i;
      bool isDimmed = selectedIndex != null && !isSelected;
      
      final paintColor = isDimmed 
          ? segments[i].color.withValues(alpha: 0.3) 
          : segments[i].color.withValues(alpha: 0.85);

      final strokeW = isSelected ? 28.0 : 24.0;

      final paint = Paint()
        ..color = paintColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeW
        ..strokeCap = StrokeCap.butt;

      if (i == segments.length - 1) {
        // El último segmento debe rellenar matemáticamente hasta el borde final
        // para garantizar que no haya huecos de decimales
        rawSweep = maxSweep - (currentAngle - startAngle);
        if (rawSweep > 0) {
          canvas.drawArc(rect, currentAngle, rawSweep, false, paint);
        }
      } else {
        // Agregamos apenas 0.005 radianes (ni medio grado) al dibujarlo
        // Solo lo suficiente para matar el difuminado anti-aliasing del canvas entre dos colores.
        if (rawSweep > 0) {
          canvas.drawArc(rect, currentAngle, rawSweep + 0.005, false, paint);
        }
      }

      currentAngle += rawSweep;
    }
    
    // Si hay un segmento seleccionado, queremos que sus bordes se vean impecables
    // y destaquen ligeramente sobre los demás, así que redibujamos el segmento seleccionado
    // por encima de todo con StrokeCap.butt
    if (selectedIndex != null && selectedIndex! < segments.length) {
      double start = startAngle;
      for (int i = 0; i < selectedIndex!; i++) {
        start += (segments[i].amount / totalSegmentAmount) * maxSweep;
      }
      
      double sweep = (segments[selectedIndex!].amount / totalSegmentAmount) * maxSweep;
      if (selectedIndex! == segments.length - 1) {
        sweep = maxSweep - (start - startAngle);
      }
      
      final highlightPaint = Paint()
        ..color = segments[selectedIndex!].color.withValues(alpha: 0.85)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 28.0
        ..strokeCap = StrokeCap.butt;
        
      if (sweep > 0) {
        canvas.drawArc(rect, start, sweep + (selectedIndex! == segments.length - 1 ? 0 : 0.005), false, highlightPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _GaugePainter oldDelegate) {
    return oldDelegate.income != income ||
           oldDelegate.expenses != expenses ||
           oldDelegate.selectedIndex != selectedIndex ||
           oldDelegate.segments != segments;
  }
}
