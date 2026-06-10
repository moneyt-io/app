import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/services/analytics_service.dart';
import '../../../../core/services/video_cache_service.dart';
import '../../../core/l10n/generated/strings.g.dart';

/// Pantalla de video del onboarding — estilo Stories de redes sociales.
///
/// Se muestra como ruta modal fullscreen (ver OnboardingScreen._openVideoPage)
/// para tener control total sobre el system UI y evitar la barra blanca del
/// Scaffold padre.
///
/// Estrategia de reproducción (doble pista):
///   Track A — Siempre inicia con networkUrl() para progressive buffering
///             nativo del OS: empieza a reproducir con ~2s de buffer.
///   Track B — En paralelo descarga el archivo completo al cache local.
///             La próxima vez arranca con VideoPlayerController.file() e
///             inicia instantáneamente.
///
/// Al terminar el video navega automáticamente (sin botón).
class VideoShowcasePage extends StatefulWidget {
  final VideoConfig config;

  /// Callback llamado cuando el video finaliza (o falla y pasa el timeout).
  final VoidCallback onVideoCompleted;

  const VideoShowcasePage({
    super.key,
    required this.config,
    required this.onVideoCompleted,
  });

  @override
  State<VideoShowcasePage> createState() => _VideoShowcasePageState();
}

class _VideoShowcasePageState extends State<VideoShowcasePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _progressController;

  VideoPlayerController? _videoController;

  bool _isInitialized = false;
  bool _hasError = false;
  bool _videoCompleted = false;
  bool _fromCache = false;

  late String _videoUrl;
  late String _locale;

  @override
  void initState() {
    super.initState();

    // Ocultar system UI completamente — fullscreen verdadero
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60), // se reajusta tras initialize()
    );

    _locale = LocaleSettings.currentLocale.languageCode;
    _videoUrl = widget.config.getUrlForLocale(_locale);

    _initializeVideo();
  }

  // ─── Inicialización ─────────────────────────────────────────────────────────

  Future<void> _initializeVideo() async {
    try {
      // Verificar cache sincrónicamente (no bloqueante si ya está resuelto)
      final cachedFile = await VideoCacheService.getCachedFile(_videoUrl);
      _fromCache = cachedFile != null;

      VideoPlayerController controller;

      if (cachedFile != null) {
        // Cache HIT → reproducción local instantánea
        controller = VideoPlayerController.file(cachedFile);
      } else {
        // Cache MISS → progressive streaming nativo del OS.
        // Empieza a reproducir con ~2 segundos de buffer sin esperar la descarga completa.
        controller = VideoPlayerController.networkUrl(Uri.parse(_videoUrl));

        // Track B en background: descargar para el próximo lanzamiento
        _downloadInBackground();
      }

      await controller.initialize();

      if (!mounted) {
        controller.dispose();
        return;
      }

      controller.setLooping(false);
      controller.setVolume(1.0);

      // Ajustar la duración del ProgressController al video real
      _progressController.duration = controller.value.duration;

      controller.addListener(_onVideoProgress);
      controller.play();
      _progressController.forward();

      setState(() {
        _videoController = controller;
        _isInitialized = true;
      });

      AnalyticsService().trackOnboardingVideoStarted(
        videoUrl: _videoUrl,
        locale: _locale,
        fromCache: _fromCache,
      );
    } catch (e) {
      debugPrint('❌ VideoShowcasePage: init failed: $e');
      AnalyticsService().trackOnboardingVideoError(
        videoUrl: _videoUrl,
        locale: _locale,
        error: e.toString(),
      );
      if (mounted) {
        setState(() => _hasError = true);
        // Error: esperar 3s y pasar automáticamente (nunca bloquear al usuario)
        Future.delayed(const Duration(seconds: 3), () {
          if (mounted) _navigateNext();
        });
      }
    }
  }

  /// Descarga el video en background sin bloquear la reproducción.
  void _downloadInBackground() {
    VideoCacheService.warmupCache(_videoUrl).then((_) {
      debugPrint('✅ VideoShowcasePage: background download complete');
    });
  }

  // ─── Progreso del video ──────────────────────────────────────────────────────

  void _onVideoProgress() {
    if (_videoController == null || _videoCompleted) return;
    if (!mounted) return;

    final pos = _videoController!.value.position;
    final dur = _videoController!.value.duration;

    if (dur.inMilliseconds > 0) {
      // Sincronizar barra de progreso con posición real
      final ratio = (pos.inMilliseconds / dur.inMilliseconds).clamp(0.0, 1.0);
      if (_progressController.value != ratio) {
        _progressController.value = ratio;
      }

      // Fin: ≤ 150ms antes del final o si el player reporta !isPlaying + completado
      final finished = pos.inMilliseconds >= dur.inMilliseconds - 150;
      final stoppedAtEnd = !_videoController!.value.isPlaying &&
          pos.inMilliseconds > dur.inMilliseconds * 0.95;

      if (finished || stoppedAtEnd) {
        _onVideoFinished();
      }
    }
  }

  void _onVideoFinished() {
    if (_videoCompleted) return;

    AnalyticsService().trackOnboardingVideoCompleted(
      videoUrl: _videoUrl,
      locale: _locale,
      durationSeconds: _videoController?.value.duration.inSeconds ?? 0,
    );

    _navigateNext();
  }

  void _navigateNext() {
    if (_videoCompleted) return;
    setState(() {
      _videoCompleted = true;
      _progressController.value = 1.0;
    });
    // Pequeño delay para que la barra de progreso se vea completada
    Future.delayed(const Duration(milliseconds: 250), () {
      if (mounted) widget.onVideoCompleted();
    });
  }

  // ─── Dispose ────────────────────────────────────────────────────────────────

  @override
  void dispose() {
    // Restaurar system UI al estado normal del onboarding
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([]);

    _videoController?.removeListener(_onVideoProgress);
    _videoController?.dispose();
    _progressController.dispose();
    super.dispose();
  }

  // ─── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // video obligatorio — no se puede saltar
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          fit: StackFit.expand,
          children: [
            // ① Video / fondo de error
            _buildVideoLayer(),

            // ② Barra de progreso (aparece al tener video inicializado o error)
            if (_isInitialized || _hasError)
              _buildProgressBar(),

            // ③ Spinner de carga (solo mientras inicializa)
            if (!_isInitialized && !_hasError)
              _buildLoadingSpinner(),
          ],
        ),
      ),
    );
  }

  // ─── Capas ──────────────────────────────────────────────────────────────────

  Widget _buildVideoLayer() {
    if (_hasError || _videoController == null) {
      return Container(color: Colors.black);
    }

    return Center(
      child: AspectRatio(
        aspectRatio: _videoController!.value.aspectRatio,
        child: VideoPlayer(_videoController!),
      ),
    );
  }

  Widget _buildProgressBar() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      // Usar padding del sistema (notch, etc.) sin SafeArea que reserve espacio blanco
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 10,
          left: 12,
          right: 12,
        ),
        child: AnimatedBuilder(
          animation: _progressController,
          builder: (_, __) => ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: LinearProgressIndicator(
              value: _progressController.value,
              backgroundColor: Colors.white.withValues(alpha: 0.25),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              minHeight: 3,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingSpinner() {
    // Spinner minimalista — sin texto, para parecer que ya carga
    return const Center(
      child: SizedBox(
        width: 32,
        height: 32,
        child: CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 2,
        ),
      ),
    );
  }
}
