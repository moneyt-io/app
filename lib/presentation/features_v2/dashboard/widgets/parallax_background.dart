import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class ParallaxBackground extends StatefulWidget {
  final String imageUrl;
  final double parallaxFactor;

  const ParallaxBackground({
    super.key,
    required this.imageUrl,
    this.parallaxFactor = 14.0, // Reducido un 30% para mayor sutileza
  });

  @override
  State<ParallaxBackground> createState() => _ParallaxBackgroundState();
}

class _ParallaxBackgroundState extends State<ParallaxBackground> {
  StreamSubscription<AccelerometerEvent>? _streamSubscription;
  double _pitch = 0.0;
  double _roll = 0.0;

  @override
  void initState() {
    super.initState();
    try {
      _streamSubscription = accelerometerEventStream().listen((event) {
        if (mounted) {
          setState(() {
            _roll = (event.x / 9.8).clamp(-1.0, 1.0);
            _pitch = (event.y / 9.8).clamp(-1.0, 1.0);
          });
        }
      });
    } catch (e) {
      // Ignorar si el dispositivo no tiene sensores
    }
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Invertido (signo negativo) para simular cámara/ventana
    final offsetX = -_roll * widget.parallaxFactor;
    final offsetY = -_pitch * widget.parallaxFactor;

    return Positioned(
      top: -widget.parallaxFactor,
      bottom: -widget.parallaxFactor,
      left: -widget.parallaxFactor,
      right: -widget.parallaxFactor,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(offsetX, offsetY, 0),
        child: Image.network(
          widget.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
