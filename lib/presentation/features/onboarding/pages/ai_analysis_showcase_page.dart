import 'dart:math';
import 'package:flutter/material.dart';
import 'financial_goals_page.dart';
import 'expense_categories_page.dart';

class AIAnalysisShowcasePage extends StatefulWidget {
  final VoidCallback onAnalysisComplete;
  final bool startWithLoading;
  final PainPoint? selectedPainPoint;
  final Set<ExpenseCategory> selectedCategories;

  const AIAnalysisShowcasePage({
    super.key,
    required this.onAnalysisComplete,
    required this.startWithLoading,
    this.selectedPainPoint,
    this.selectedCategories = const {},
  });

  @override
  State<AIAnalysisShowcasePage> createState() => _AIAnalysisShowcasePageState();
}

class _AIAnalysisShowcasePageState extends State<AIAnalysisShowcasePage>
    with TickerProviderStateMixin {
  late bool _isAnalyzing;
  late AnimationController _loadingController;
  late Animation<double> _loadingProgress;

  final List<String> _loadingMessages = [
    'Revisando tus gastos diarios...',
    'Categorizando tus transacciones...',
    'Encontrando patrones de gasto...',
    'Generando recomendaciones...',
  ];

  @override
  void initState() {
    super.initState();
    _isAnalyzing = widget.startWithLoading;
    if (_isAnalyzing) {
      _startAnalysis();
    }
  }

  void _startAnalysis() {
    _loadingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _loadingProgress = Tween<double>(begin: 0, end: 100).animate(CurvedAnimation(
      parent: _loadingController,
      curve: Curves.easeInOut,
    ));

    _loadingController.forward().then((_) {
      if (mounted) {
        setState(() {
          _isAnalyzing = false;
        });
        widget.onAnalysisComplete();
      }
    });
  }

  @override
  void dispose() {
    if (widget.startWithLoading) {
      _loadingController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      child: _isAnalyzing ? _buildAnalyzingState() : _buildCompletedState(),
    );
  }

  Widget _buildAnalyzingState() {
    // Prevent dragging while analyzing by using an AbsorbPointer or just ignoring it
    // but the PageView swiping cannot be disabled from here easily. 
    // We let them swipe away if they really want, or we can use a widget to block horizontal drag.
    return Stack(
      key: const ValueKey('analyzing'),
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
                animation: _loadingProgress,
                builder: (context, child) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: CustomPaint(
                          painter: CircularProgressPainter(_loadingProgress.value),
                        ),
                      ),
                      Text(
                        '${_loadingProgress.value.toInt()}%',
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
                animation: _loadingProgress,
                builder: (context, child) {
                  int messageIndex = (_loadingProgress.value / 25).floor();
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

  Widget _buildCompletedState() {
    return SingleChildScrollView(
      key: const ValueKey('completed'),
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: 120,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Análisis concluido',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF131B2E),
            ),
          ),
          const SizedBox(height: 24),
          RichText(
            textAlign: TextAlign.center,
            text: _buildDynamicTextSpan(),
          ),
          const SizedBox(height: 48),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildAnimatedBar(
                percentage: '68%',
                label: 'Tu resultado',
                color: const Color(0xFF3B82F6),
                targetHeight: 200,
                textColor: Colors.white,
                delayMs: 300,
              ),
              const SizedBox(width: 32),
              _buildAnimatedBar(
                percentage: '25%',
                label: 'Media',
                color: const Color(0xFFE5E7EB),
                targetHeight: 100,
                textColor: const Color(0xFF1F2937),
                delayMs: 600,
              ),
            ],
          ),
          const SizedBox(height: 48),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOutQuart,
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(0, 20 * (1 - value)),
                  child: child,
                ),
              );
            },
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 16,
                  height: 1.4,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1F2937),
                ),
                children: [
                  TextSpan(
                    text: 'Estás gastando 68% ',
                    style: TextStyle(color: Color(0xFFDC2626), fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'más que la media de las personas, esto ',
                  ),
                  TextSpan(
                    text: 'afecta brutalmente\n',
                    style: TextStyle(color: Color(0xFFDC2626), fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'a tus metas en corto y mediano plazo',
                    style: TextStyle(color: Color(0xFFDC2626), fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedBar({
    required String percentage,
    required String label,
    required Color color,
    required double targetHeight,
    required Color textColor,
    required int delayMs,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: targetHeight),
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeOutQuart,
          builder: (context, height, child) {
            return Container(
              width: 100,
              height: height,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(16),
              ),
              child: height > 40
                  ? Center(
                      child: Text(
                        percentage,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: textColor.withOpacity((height / targetHeight).clamp(0.0, 1.0)),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            );
          },
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF4B5563),
          ),
        ),
      ],
    );
  }

  TextSpan _buildDynamicTextSpan() {
    const baseStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: Color(0xFF131B2E),
      height: 1.4,
    );

    const highlightStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: Color(0xFF3B82F6),
      height: 1.4,
    );

    if (widget.selectedCategories.isEmpty || widget.selectedPainPoint == null) {
      return const TextSpan(
        style: baseStyle,
        text: 'Tus gastos consumen gran parte de tu presupuesto, parece que tus métodos actuales ya no están funcionando.',
      );
    }

    final category = widget.selectedCategories.first;
    String gastosStr;
    switch (category) {
      case ExpenseCategory.diningOut:
        gastosStr = 'Comer fuera consume';
        break;
      case ExpenseCategory.cravings:
        gastosStr = 'Los antojos consumen';
        break;
      case ExpenseCategory.subscriptions:
        gastosStr = 'Las suscripciones consumen';
        break;
      case ExpenseCategory.outings:
        gastosStr = 'Las salidas consumen';
        break;
      case ExpenseCategory.shopping:
        gastosStr = 'Las compras impulsivas consumen';
        break;
      case ExpenseCategory.delivery:
        gastosStr = 'Los domicilios consumen';
        break;
    }

    String intentosStr;
    switch (widget.selectedPainPoint!) {
      case PainPoint.trackMoney:
        intentosStr = 'entender exactamente a dónde va tu dinero';
        break;
      case PainPoint.spendLess:
        intentosStr = 'intentar gastar menos por tu cuenta';
        break;
      case PainPoint.lessStress:
        intentosStr = 'preocuparte menos por el dinero';
        break;
      case PainPoint.saveMoney:
        intentosStr = 'tratar de ahorrar sin una guía clara';
        break;
    }

    return TextSpan(
      style: baseStyle,
      children: [
        TextSpan(text: gastosStr, style: highlightStyle),
        const TextSpan(text: ' gran parte de tu presupuesto, parece que '),
        TextSpan(text: intentosStr, style: highlightStyle),
        const TextSpan(text: ' ya no está funcionando.'),
      ],
    );
  }
}

// Painters for the loading state

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
      colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
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
