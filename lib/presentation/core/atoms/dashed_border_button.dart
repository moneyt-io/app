import 'package:flutter/material.dart';

/// Botón con borde punteado para agregar elementos
/// 
/// HTML Reference:
/// ```html
/// <button class="flex items-center gap-3 w-full px-4 py-4 rounded-lg border-2 border-dashed border-purple-300 text-purple-600 hover:border-purple-400 hover:bg-purple-50">
///   <span class="material-symbols-outlined">add_circle</span>
///   <div class="text-left">
///     <p class="text-base font-medium">Add new credit card</p>
///     <p class="text-sm opacity-80">Register a new credit card</p>
///   </div>
/// </button>
/// ```
class DashedBorderButton extends StatefulWidget {
  const DashedBorderButton({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.onPressed,
    this.icon = Icons.add_circle,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final VoidCallback onPressed;
  final IconData icon;

  @override
  State<DashedBorderButton> createState() => _DashedBorderButtonState();
}

class _DashedBorderButtonState extends State<DashedBorderButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onPressed,
          borderRadius: BorderRadius.circular(8), // HTML: rounded-lg
          child: Container(
            width: double.infinity, // HTML: w-full
            padding: const EdgeInsets.all(16), // HTML: px-4 py-4
            decoration: BoxDecoration(
              color: _isHovered 
                  ? const Color(0xFFFAF5FF) // HTML: hover:bg-purple-50
                  : Colors.transparent,
              border: Border.all(
                color: _isHovered 
                    ? const Color(0xFFC084FC) // HTML: hover:border-purple-400
                    : const Color(0xFFD8B4FE), // HTML: border-purple-300
                width: 2, // HTML: border-2
              ),
              borderRadius: BorderRadius.circular(8), // HTML: rounded-lg
            ),
            child: Row(
              children: [
                Icon(
                  widget.icon,
                  color: const Color(0xFF9333EA), // HTML: text-purple-600
                  size: 24,
                ),
                const SizedBox(width: 12), // HTML: gap-3
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // HTML: text-left
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 16, // HTML: text-base
                          fontWeight: FontWeight.w500, // HTML: font-medium
                          color: Color(0xFF9333EA), // HTML: text-purple-600
                        ),
                      ),
                      Text(
                        widget.subtitle,
                        style: TextStyle(
                          fontSize: 14, // HTML: text-sm
                          color: const Color(0xFF9333EA).withOpacity(0.8), // HTML: opacity-80
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Custom painter para crear borde punteado
class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;

  const DashedBorderPainter({
    required this.color,
    this.strokeWidth = 2.0,
    this.dashWidth = 5.0,
    this.dashSpace = 3.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(8),
      ));

    _drawDashedPath(canvas, path, paint);
  }

  void _drawDashedPath(Canvas canvas, Path path, Paint paint) {
    final pathMetrics = path.computeMetrics();
    for (final pathMetric in pathMetrics) {
      double distance = 0.0;
      while (distance < pathMetric.length) {
        final extractPath = pathMetric.extractPath(
          distance,
          distance + dashWidth,
        );
        canvas.drawPath(extractPath, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
