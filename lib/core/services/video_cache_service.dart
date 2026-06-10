import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/// Modelo que mapea códigos de idioma a URLs de video.
///
/// El payload de PostHog tiene la forma:
/// ```json
/// {
///   "videos": {
///     "es": "https://cdn.moneyt.io/onboarding/v1_es.mp4",
///     "en": "https://cdn.moneyt.io/onboarding/v1_en.mp4",
///     "default": "https://cdn.moneyt.io/onboarding/v1.mp4"
///   }
/// }
/// ```
class VideoConfig {
  final Map<String, String> videos;

  const VideoConfig({required this.videos});

  /// URL por defecto si no hay video para el idioma actual.
  static const String _hardcodedFallback =
      'https://cdn.moneyt.io/onboarding/Onboarding_Video_1.mp4';

  /// Retorna la URL correspondiente al [languageCode] dado,
  /// o la URL "default" del payload, o la URL hardcodeada como último recurso.
  String getUrlForLocale(String languageCode) {
    return videos[languageCode] ??
        videos['default'] ??
        _hardcodedFallback;
  }

  /// Parsea el payload del feature flag de PostHog.
  /// Retorna null si el payload no tiene la estructura esperada.
  static VideoConfig? fromPayload(dynamic payload) {
    if (payload is! Map) return null;
    final videosRaw = payload['videos'];
    if (videosRaw is! Map) return null;
    try {
      final videos = Map<String, String>.from(
        videosRaw.map((k, v) => MapEntry(k.toString(), v.toString())),
      );
      if (videos.isEmpty) return null;
      return VideoConfig(videos: videos);
    } catch (e) {
      debugPrint('❌ VideoConfig.fromPayload: parse error: $e');
      return null;
    }
  }

  /// Config de respaldo — apunta directamente al video principal en el CDN.
  static VideoConfig get fallback => const VideoConfig(videos: {
        'default': _hardcodedFallback,
      });
}

/// Servicio para gestionar el cache de videos del onboarding.
///
/// Estrategia:
/// 1. En el Splash, se llama a [warmupCache] para pre-descargar el video
///    del idioma actual en background (fire-and-forget).
/// 2. Cuando [VideoShowcasePage] necesita reproducir, llama a [getVideoUri]:
///    - Cache HIT  → devuelve `Uri` al archivo local → reproducción instantánea.
///    - Cache MISS → devuelve `Uri` a la URL remota → fallback a red.
class VideoCacheService {
  VideoCacheService._();

  static final _cacheManager = DefaultCacheManager();

  /// Pre-descarga el video en background para que esté disponible
  /// cuando el usuario llegue a la pantalla de video.
  ///
  /// Es seguro llamar esto múltiples veces — el cache manager deduplica.
  /// No lanza excepciones.
  static Future<void> warmupCache(String url) async {
    try {
      debugPrint('🎬 VideoCacheService: Warming up cache for $url');
      await _cacheManager.downloadFile(url);
      debugPrint('✅ VideoCacheService: Cache warmed up successfully');
    } catch (e) {
      // El warmup es un nice-to-have. Silenciar errores de red.
      debugPrint('⚠️ VideoCacheService: Warmup failed (non-critical): $e');
    }
  }

  /// Devuelve el [File] del video si está en cache local, o `null` si no lo está.
  ///
  /// El llamador debe usar:
  ///   - `VideoPlayerController.file(file)` cuando el resultado NO es null
  ///   - `VideoPlayerController.networkUrl(Uri.parse(url))` cuando es null
  ///
  /// Esto asegura compatibilidad con iOS y Android (contentUri es solo Android).
  /// Nunca lanza excepciones.
  static Future<File?> getCachedFile(String url) async {
    try {
      final fileInfo = await _cacheManager.getFileFromCache(url);
      if (fileInfo != null && await fileInfo.file.exists()) {
        debugPrint('✅ VideoCacheService: Cache HIT for $url');
        return fileInfo.file;
      }
    } catch (e) {
      debugPrint('⚠️ VideoCacheService: Cache lookup failed: $e');
    }
    debugPrint('🌐 VideoCacheService: Cache MISS — will stream from network');
    return null;
  }

  /// Verifica si el video ya está en cache (para el tracking de analytics).
  static Future<bool> isCached(String url) async {
    try {
      final fileInfo = await _cacheManager.getFileFromCache(url);
      return fileInfo != null && await fileInfo.file.exists();
    } catch (_) {
      return false;
    }
  }

  /// Limpia el cache de videos (para testing o reseteo de app).
  static Future<void> clearCache() async {
    try {
      await _cacheManager.emptyCache();
      debugPrint('🗑️ VideoCacheService: Cache cleared');
    } catch (e) {
      debugPrint('❌ VideoCacheService: Error clearing cache: $e');
    }
  }
}
