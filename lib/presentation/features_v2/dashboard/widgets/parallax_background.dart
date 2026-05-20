import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class ParallaxBackground extends StatefulWidget {
  final String imageUrl;
  final double parallaxFactor;

  const ParallaxBackground({
    super.key,
    required this.imageUrl,
    this.parallaxFactor = 8.0, // Aún más sutil a petición del usuario
  });

  @override
  State<ParallaxBackground> createState() => _ParallaxBackgroundState();
}

class _ParallaxBackgroundState extends State<ParallaxBackground> {
  StreamSubscription<AccelerometerEvent>? _streamSubscription;
  
  // Variables estáticas globales para recordar la última inclinación
  static double _lastPitch = 0.0;
  static double _lastRoll = 0.0;
  
  double _pitch = 0.0;
  double _roll = 0.0;

  @override
  void initState() {
    super.initState();
    
    // Inicializar con la última inclinación conocida para evitar saltos
    _pitch = _lastPitch;
    _roll = _lastRoll;
    
    try {
      _streamSubscription = accelerometerEventStream().listen((event) {
        if (mounted) {
          setState(() {
            _roll = (event.x / 9.8).clamp(-1.0, 1.0);
            _pitch = (event.y / 9.8).clamp(-1.0, 1.0);
            
            // Actualizar la memoria global
            _lastRoll = _roll;
            _lastPitch = _pitch;
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
          fit: BoxFit.fitWidth,
          alignment: Alignment.topCenter,
        ),
      ),
    );
  }
}
