import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Sistema de partículas flotantes con tema financiero
class FloatingParticles extends StatefulWidget {
  const FloatingParticles({
    Key? key,
    this.particleCount = 20,
  }) : super(key: key);

  final int particleCount;

  @override
  State<FloatingParticles> createState() => _FloatingParticlesState();
}

class _FloatingParticlesState extends State<FloatingParticles>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<Particle> _particles;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );

    _particles = List.generate(widget.particleCount, (index) => Particle());
    
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: ParticlesPainter(_particles, _controller.value),
          size: Size.infinite,
        );
      },
    );
  }
}

class Particle {
  late double x;
  late double y;
  late double size;
  late Color color;
  late double speed;
  late double direction;
  late IconData icon;

  Particle() {
    final random = math.Random();
    x = random.nextDouble();
    y = random.nextDouble();
    size = 8 + random.nextDouble() * 16; // 8-24px
    speed = 0.1 + random.nextDouble() * 0.2; // Velocidad lenta
    direction = random.nextDouble() * math.pi * 2;
    
    // Colores relacionados con finanzas/prosperidad
    final colors = [
      Colors.white.withOpacity(0.1),
      Colors.white.withOpacity(0.2),
      const Color(0xFF14B8A6).withOpacity(0.3), // Teal
      const Color(0xFFEAB308).withOpacity(0.2), // Gold
    ];
    color = colors[random.nextInt(colors.length)];
    
    // Iconos financieros
    final icons = [
      Icons.attach_money,
      Icons.trending_up,
      Icons.savings,
      Icons.account_balance_wallet,
    ];
    icon = icons[random.nextInt(icons.length)];
  }
}

class ParticlesPainter extends CustomPainter {
  final List<Particle> particles;
  final double animationValue;

  ParticlesPainter(this.particles, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    for (final particle in particles) {
      // Calcular posición actual
      final currentX = (particle.x + math.cos(particle.direction) * particle.speed * animationValue) % 1.0;
      final currentY = (particle.y + math.sin(particle.direction) * particle.speed * animationValue) % 1.0;
      
      final x = currentX * size.width;
      final y = currentY * size.height;

      // Dibujar partícula como círculo simple (más performante que iconos)
      final paint = Paint()
        ..color = particle.color
        ..style = PaintingStyle.fill;

      canvas.drawCircle(
        Offset(x, y),
        particle.size / 2,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
