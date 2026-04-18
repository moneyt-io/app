import 'package:flutter/foundation.dart';
import 'package:tiktok_events_sdk/tiktok_events_sdk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Servicio central para TikTok Events SDK.
///
/// Singleton que centraliza todos los eventos enviados a TikTok Ads Manager.
/// Nunca lanza excepciones — si falla, solo imprime en debug.
///
/// Eventos implementados:
/// - [trackAppLaunch]           → LaunchApp (medir reach de instalaciones)
/// - [trackOnboardingCompleted] → CompleteRegistration (activación de usuario)
/// - [trackSubscribe]           → Subscribe (el más importante para optimizar campañas)
class TikTokService {
  static final TikTokService _instance = TikTokService._internal();
  factory TikTokService() => _instance;
  TikTokService._internal();

  bool _initialized = false;

  // ─── Inicialización ───────────────────────────────────────────────────────

  Future<void> init() async {
    try {
      final appId = dotenv.env['TIKTOK_APP_ID'] ?? '';
      final mobileAppId = dotenv.env['TIKTOK_MOBILE_APP_ID'] ?? '';

      if (appId.isEmpty || mobileAppId.isEmpty) {
        debugPrint('⚠️ TikTokService: IDs missing in .env');
        return;
      }

      await TikTokEventsSdk.initSdk(
        androidAppId: appId,
        tikTokAndroidId: mobileAppId,
        iosAppId: appId,
        tiktokIosId: mobileAppId,
        isDebugMode: kDebugMode,
        logLevel: kDebugMode ? TikTokLogLevel.verbose : TikTokLogLevel.info,
      );

      _initialized = true;
      debugPrint('✅ TikTokService: SDK initialized (debugMode: $kDebugMode)');
    } catch (e) {
      debugPrint('❌ TikTokService: Init failed: $e');
    }
  }

  // ─── Log interno (nunca lanza) ────────────────────────────────────────────

  Future<void> _logEvent(String eventName, {TTEventType? eventType}) async {
    if (!_initialized) return;
    try {
      await TikTokEventsSdk.logEvent(
        event: TikTokEvent(
          eventName: eventName,
          eventType: eventType ?? TTEventType.none,
        ),
      );
      debugPrint('📊 TikTokService: event "$eventName" logged');
    } catch (e) {
      debugPrint('❌ TikTokService: logEvent "$eventName" failed: $e');
    }
  }

  // ─── Eventos ──────────────────────────────────────────────────────────────

  /// Llamar cuando la app se abre por primera vez en sesión.
  /// Permite a TikTok medir el reach real de instalaciones vinculadas a anuncios.
  Future<void> trackAppLaunch() async {
    await _logEvent('LaunchApp');
  }

  /// Llamar cuando el usuario completa el onboarding.
  /// TikTok lo usa para medir "usuarios activados" y optimizar campañas
  /// hacia perfiles que probablemente activen la app (no solo la instalen).
  Future<void> trackOnboardingCompleted() async {
    await _logEvent('CompleteRegistration');
  }

  /// Llamar cuando Superwall confirma que el usuario activó una suscripción.
  /// Es el evento más valioso para TikTok Ads — permite optimizar campañas
  /// automáticamente hacia perfiles con alta intención de pago.
  Future<void> trackSubscribe() async {
    await _logEvent('Subscribe');
  }
}
