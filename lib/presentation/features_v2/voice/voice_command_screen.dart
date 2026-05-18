import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../domain/entities/category.dart';
import '../../../domain/usecases/category_usecases.dart';
import '../../../domain/usecases/wallet_usecases.dart';
import '../../../core/utils/icon_to_emoji_mapper.dart';
import '../../../core/services/ai_transaction_service.dart';
import '../transactions/new_transaction_screen.dart';
import '../theme/v2_colors.dart';
import '../dashboard/widgets/parallax_background.dart';

class VoiceCommandScreen extends StatefulWidget {
  const VoiceCommandScreen({super.key});

  @override
  State<VoiceCommandScreen> createState() => _VoiceCommandScreenState();
}

class _VoiceCommandScreenState extends State<VoiceCommandScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Category> _floatingCategories = [];
  List<Offset> _randomPositions = [];

  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  bool _isListening = false;
  bool _isAnalyzing = false;
  String _recognizedText = '';
  
  String get _currentPrompt {
    if (!_isListening) return 'Toca el micrófono para hablar';
    // Animación de los puntos suspensivos basada en el controlador de 4 segundos
    int dots = (_controller.value * 4).floor() % 4;
    String ellipsis = '.' * dots;
    // Rellenamos con espacios invisibles para que el texto no "salte" cambiando de ancho
    return 'Escuchando$ellipsis'.padRight(14, ' '); 
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(); // Continues 0.0 -> 1.0 -> 0.0
    _generateRandomPositions();
    _loadCategories();

    // Iniciar el micrófono automáticamente al abrir la pantalla
    _initSpeech().then((_) {
      if (mounted && _speechEnabled) {
        _startListening();
      }
    });
  }

  void _handleSpeechFinished() {
    if (!mounted) return;
    setState(() => _isListening = false);
    
    final text = _recognizedText.trim();
    // Evitar procesar ruidos cortos o palabras vacías de 1-2 letras
    if (text.length > 2 && !_isAnalyzing) {
      _processWithAI();
    } else if (text.isNotEmpty && text.length <= 2) {
      setState(() {
        _recognizedText = ''; // Limpiar si fue un falso positivo
      });
    }
  }

  Future<void> _initSpeech() async {
    _speechEnabled = await _speechToText.initialize(
      onStatus: (status) {
        if (status == 'done' || status == 'notListening') {
          _handleSpeechFinished();
        }
      },
    );
    if (mounted) setState(() {});
  }

  Future<void> _processWithAI() async {
    setState(() => _isAnalyzing = true);
    
    try {
      final wallets = await GetIt.instance<WalletUseCases>().getAllWallets();
      final categories = await GetIt.instance<CategoryUseCases>().getAllCategories();
      
      final service = AITransactionService();
      final result = await service.parseTransaction(_recognizedText, categories, wallets);
      
      if (result != null && mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => NewTransactionScreen(
              initialType: result.type,
              initialAmount: result.amount > 0 ? result.amount : null,
              initialCategoryId: result.categoryId,
              initialWalletId: result.walletId,
              initialDescription: result.description,
            ),
          ),
        );
      } else {
        if (mounted) {
          setState(() {
            _isAnalyzing = false;
            _recognizedText = '';
          });
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No se pudo procesar el comando. Intenta de nuevo.')));
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isAnalyzing = false;
          _recognizedText = '';
        });
        
        final errorMsg = e.toString().contains('No GEMINI_API_KEY') 
            ? 'Por favor, agrega GEMINI_API_KEY a tu archivo .env para usar la IA.' 
            : 'Error en la IA: ${e.toString()}';
            
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMsg)));
      }
    }
  }

  void _startListening() async {
    if (!_speechEnabled) {
      await _initSpeech();
      if (!_speechEnabled) return;
    }

    setState(() {
      _recognizedText = '';
      _isAnalyzing = false;
      _isListening = true;
    });

    await _speechToText.listen(
      onResult: (result) {
        if (mounted) {
          setState(() {
            _recognizedText = result.recognizedWords;
          });
          // Si el motor indica que es el resultado final (ej. por pausa o stop)
          if (result.finalResult) {
            _handleSpeechFinished();
          }
        }
      },
      localeId: 'es_ES', // Intentar con español por defecto
      pauseFor: const Duration(seconds: 4), // Dar más tiempo para pensar (4s en lugar de 2s)
      listenFor: const Duration(seconds: 30), // Asegurar que no se corte por tiempo máximo
    );
  }

  void _stopListening() async {
    await _speechToText.stop();
    _handleSpeechFinished();
  }

  void _generateRandomPositions() {
    final random = Random();
    _randomPositions = [
      // Top Left quadrant
      Offset(0.05 + random.nextDouble() * 0.2, 0.1 + random.nextDouble() * 0.2),
      // Top Right quadrant
      Offset(0.60 + random.nextDouble() * 0.25, 0.1 + random.nextDouble() * 0.2),
      // Bottom area (below text, above bottom nav)
      Offset(0.15 + random.nextDouble() * 0.6, 0.65 + random.nextDouble() * 0.1),
    ];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadCategories() async {
    try {
      final categories = await GetIt.instance<CategoryUseCases>().getAllCategories();
      // Simulamos "las 7 más usadas" (tomando 7 activas) y seleccionamos 3 al azar
      final top7 = categories.where((c) => c.documentTypeId == 'E').take(7).toList();
      top7.shuffle();
      if (mounted) {
        setState(() {
          _floatingCategories = top7.take(3).toList();
        });
      }
    } catch (e) {
      // Manejar error silenciosamente o registrar log
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light, // Fuerza íconos blancos en la barra de estado
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Stack(
        children: [
          // Background Image with Parallax
          const ParallaxBackground(
            imageUrl: 'https://lh3.googleusercontent.com/aida/ADBb0uiDxjZ6MHOXH3DQxF0xx4bhPcbgSllJ3SeMWdWmLLnHGDN0PGgL4ZU9KHrAgu9vZdYMG2FXBd-PDCei58o_JFb35Ic4-NK_eUxcC6I4CNPiBcb_V8HRinKeCkOXvHoYTcey352vnBBKTuIPKfi_IQPqLsMkX_lAibqwq7IuFmFlMsW92pIDOgCT6Jm98G3GTcT2ScLB6HsJZnG3fbaOgKKh0gQJE5A9wlXhaE3MkMtz2y8Y229y35eSOiJw',
          ),
          
          // Gradient Overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.2),
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.4),
                  ],
                ),
              ),
            ),
          ),
          
          // Floating Emojis
          if (_floatingCategories.isNotEmpty && _randomPositions.isNotEmpty)
            _buildAnimatedFloatingIcon(
              _floatingCategories[0],
              _randomPositions[0],
              0.0, // phase
            ),
          if (_floatingCategories.length > 1 && _randomPositions.length > 1)
            _buildAnimatedFloatingIcon(
              _floatingCategories[1],
              _randomPositions[1],
              2.0, // phase
            ),
          if (_floatingCategories.length > 2 && _randomPositions.length > 2)
            _buildAnimatedFloatingIcon(
              _floatingCategories[2],
              _randomPositions[2],
              4.0, // phase
            ),
          
          // Main Content
          SafeArea(
            child: Column(
              children: [
                // Top App Bar removido a petición (sin Wealth AI, foto, ni settings)
                const SizedBox(height: 72), // Mantenemos el espacio para no tapar los elementos con notches
                
                // Center Text or Analyzing Animation
                Expanded(
                  child: _isAnalyzing
                      ? const AuraAnalyzingAnimation()
                      : Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: AnimatedBuilder(
                              animation: _controller,
                              builder: (context, child) {
                                // Shimmer sutil usando el controlador
                                final shimmerOffset = -1.0 + (_controller.value * 2.0);
                                
                                return ShaderMask(
                                  blendMode: BlendMode.srcIn,
                                  shaderCallback: (bounds) => LinearGradient(
                                    colors: [
                                      Colors.white.withValues(alpha: _isListening ? 0.7 : 0.8),
                                      Colors.white,
                                      Colors.white.withValues(alpha: _isListening ? 0.7 : 0.8),
                                    ],
                                    stops: const [0.0, 0.5, 1.0],
                                    begin: Alignment(shimmerOffset - 1.0, 0),
                                    end: Alignment(shimmerOffset + 1.0, 0),
                                  ).createShader(bounds),
                                  child: Text(
                                    _recognizedText.isNotEmpty ? _recognizedText : _currentPrompt,
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.displayLarge?.copyWith(
                                      color: Colors.white, // Se usa color base para el ShaderMask
                                      fontSize: _recognizedText.isNotEmpty ? 40 : 26,
                                      fontWeight: FontWeight.w600,
                                      height: 1.2,
                                      shadows: [
                                        const Shadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 2)),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                ),
                
                const SizedBox(height: 120), // Spacer para no superponer con el bottom nav
              ],
            ),
          ),
          
          // Bottom Contextual Control Area (Posicionamiento Absoluto para igualar Dashboard)
          Positioned(
            bottom: 32,
            left: 24,
            right: 24,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildBottomActionButton(Icons.close, "Cancelar", () => Navigator.pop(context)),
                          const SizedBox(width: 72), // Espacio para el botón central
                          _buildBottomActionButton(Icons.camera_alt_outlined, "Escanear", () {}),
                        ],
                      ),
                    ),
                  ),
                ),
                
                // Large Integrated Voice Button
                Positioned(
                  bottom: 20, // 32 + 20 = 52px desde el fondo de la pantalla (Igual que en Dashboard)
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      // Animación más suave y fluida (1 ciclo cada 2 segundos)
                      final pulseScale = _isListening 
                          ? 1.0 + (sin(_controller.value * 4 * pi) * 0.1) 
                          : 1.0;
                          
                      return Hero(
                        tag: 'mic_hero_button',
                        // El Hero envuelve al Transform para que la transición de vista a vista use el mismo ancla
                        child: Transform.scale(
                          scale: pulseScale,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: 72,
                            height: 72,
                            decoration: BoxDecoration(
                              color: _isListening ? const Color(0xFFDC2626) : V2Colors.primary,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white.withValues(alpha: 0.2), width: 4),
                              boxShadow: [
                                BoxShadow(
                                  color: (_isListening ? const Color(0xFFDC2626) : V2Colors.primary).withValues(alpha: 0.4),
                                  blurRadius: _isListening ? 35 : 24,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                customBorder: const CircleBorder(),
                                onTap: _speechToText.isNotListening ? _startListening : _stopListening,
                                child: Icon(
                                  _isListening ? Icons.stop_rounded : Icons.mic, 
                                  color: Colors.white, 
                                  size: 36
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildAnimatedFloatingIcon(Category category, Offset screenPos, double phase) {
    final size = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // Un movimiento suave hacia arriba y abajo usando una onda seno
        final dy = sin((_controller.value * 2 * pi) + phase) * 15.0;
        return Positioned(
          top: (size.height * screenPos.dy) + dy,
          left: size.width * screenPos.dx,
          child: child!,
        );
      },
      child: InteractiveFloatingEmoji(
        emoji: IconToEmojiMapper.getEmoji(category.icon),
        label: category.name,
      ),
    );
  }

  Widget _buildBottomActionButton(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white.withValues(alpha: 0.7)),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: 'Manrope',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AuraAnalyzingAnimation extends StatefulWidget {
  const AuraAnalyzingAnimation({super.key});

  @override
  State<AuraAnalyzingAnimation> createState() => _AuraAnalyzingAnimationState();
}

class _AuraAnalyzingAnimationState extends State<AuraAnalyzingAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
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
          painter: _AuraPainter(_controller.value),
          child: const SizedBox.expand(),
        );
      },
    );
  }
}

class _AuraPainter extends CustomPainter {
  final double progress;

  _AuraPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    
    // Usamos colores de V2Colors para mantener la consistencia
    final color1 = V2Colors.primary.withValues(alpha: 0.6); // Azul principal
    final color2 = V2Colors.secondaryContainer.withValues(alpha: 0.5); // Verde aguamarina suave
    final color3 = const Color(0xFFDC2626).withValues(alpha: 0.3); // Acento rojo sutil
    
    // Movimiento orbital suave para 3 esferas
    final angle1 = progress * 2 * pi;
    final angle2 = (progress * 2 * pi) + (2 * pi / 3);
    final angle3 = (progress * 2 * pi) + (4 * pi / 3);
    
    // El radio de órbita y tamaño de las esferas
    final orbitRadius = size.width * 0.15; 
    final orbSize = size.width * 0.35;
    
    // Posiciones dinámicas con formas elípticas
    final pos1 = center + Offset(cos(angle1) * orbitRadius, sin(angle1) * orbitRadius * 0.6);
    final pos2 = center + Offset(cos(angle2) * orbitRadius * 0.7, sin(angle2) * orbitRadius);
    final pos3 = center + Offset(cos(angle3) * orbitRadius, sin(angle3) * orbitRadius * 0.8);
    
    // Difuminado extremo para crear el aura
    const blur = MaskFilter.blur(BlurStyle.normal, 80);
    
    canvas.drawCircle(pos1, orbSize, Paint()..color = color1..maskFilter = blur);
    canvas.drawCircle(pos2, orbSize * 0.9, Paint()..color = color2..maskFilter = blur);
    canvas.drawCircle(pos3, orbSize * 0.8, Paint()..color = color3..maskFilter = blur);
    
    // Un núcleo central brillante que pulsa sutilmente
    final pulse = sin(progress * 4 * pi).abs();
    final corePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.2 + (pulse * 0.2))
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 40);
      
    canvas.drawCircle(center, orbSize * 0.6, corePaint);
  }

  @override
  bool shouldRepaint(covariant _AuraPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class InteractiveFloatingEmoji extends StatefulWidget {
  final String emoji;
  final String label;

  const InteractiveFloatingEmoji({
    super.key,
    required this.emoji,
    required this.label,
  });

  @override
  State<InteractiveFloatingEmoji> createState() => _InteractiveFloatingEmojiState();
}

class _InteractiveFloatingEmojiState extends State<InteractiveFloatingEmoji> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.85 : 1.0,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOutBack,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(36), // Fully rounded
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  width: 72,
                  height: 72,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                  ),
                  child: Text(widget.emoji, style: const TextStyle(fontSize: 28)),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: 'Manrope',
                shadows: [
                  Shadow(color: Colors.black45, blurRadius: 4, offset: Offset(0, 2)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
