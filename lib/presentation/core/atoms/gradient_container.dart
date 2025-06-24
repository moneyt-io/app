import 'package:flutter/material.dart';

/// Tipos de gradientes disponibles basados en credit_card_list.html
enum GradientType {
  blueSapphire,     // Chase Sapphire: blue-600 to blue-800
  grayAmex,         // AmEx: gray-700 to gray-900
  redVisa,          // Visa Blocked: red-500 to red-700
  purplePink,       // Summary Card: purple-600 to pink-600
}

/// Contenedor con gradiente y decoraciones circulares
/// 
/// HTML Reference:
/// ```html
/// <div class="bg-gradient-to-r from-blue-600 to-blue-800 rounded-2xl p-6 text-white relative overflow-hidden">
///   <div class="absolute top-0 right-0 w-32 h-32 bg-white/10 rounded-full -mr-16 -mt-16"></div>
/// ```
class GradientContainer extends StatelessWidget {
  const GradientContainer({
    Key? key,
    required this.gradientType,
    required this.child,
    this.borderRadius,
    this.padding,
    this.height,
    this.width,
    this.showDecorations = true,
    this.opacity,
  }) : super(key: key);

  final GradientType gradientType;
  final Widget child;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final double? width;
  final bool showDecorations;
  final double? opacity;

  /// Obtiene los colores del gradiente según el tipo
  List<Color> get _gradientColors {
    switch (gradientType) {
      case GradientType.blueSapphire:
        return [const Color(0xFF2563EB), const Color(0xFF1E40AF)]; // blue-600 to blue-800
      case GradientType.grayAmex:
        return [const Color(0xFF374151), const Color(0xFF111827)]; // gray-700 to gray-900
      case GradientType.redVisa:
        return [const Color(0xFFEF4444), const Color(0xFFB91C1C)]; // red-500 to red-700
      case GradientType.purplePink:
        return [const Color(0xFF9333EA), const Color(0xFFDB2777)]; // purple-600 to pink-600
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget container = Container(
      width: width,
      height: height,
      padding: padding ?? const EdgeInsets.all(24), // HTML: p-6
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft, // HTML: from-
          end: Alignment.centerRight,  // HTML: to-
          colors: _gradientColors,
        ),
        borderRadius: borderRadius ?? BorderRadius.circular(16), // HTML: rounded-2xl
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // ✅ CORREGIDO: Usar LayoutBuilder para obtener dimensiones válidas
          return Stack(
            clipBehavior: Clip.none, // ✅ AGREGADO: Permitir que decoraciones se salgan
            children: [
              // Decoraciones circulares de fondo
              if (showDecorations) ...[
                // Círculo superior derecho
                Positioned(
                  top: -64,
                  right: -64,
                  child: Container(
                    width: 128, // HTML: w-32
                    height: 128, // HTML: h-32
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1), // HTML: bg-white/10
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                // Círculo inferior izquierdo (solo en algunas cards)
                if (gradientType == GradientType.blueSapphire)
                  Positioned(
                    bottom: -48,
                    left: -48,
                    child: Container(
                      width: 96, // HTML: w-24
                      height: 96, // HTML: h-24
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1), // HTML: bg-white/10
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
              // Contenido principal - usar Positioned.fill para llenar todo el espacio
              Positioned.fill(
                child: child,
              ),
            ],
          );
        },
      ),
    );

    // Aplicar opacidad si es necesario (para cards bloqueadas)
    if (opacity != null) {
      container = Opacity(
        opacity: opacity!,
        child: container,
      );
    }

    return container;
  }
}
