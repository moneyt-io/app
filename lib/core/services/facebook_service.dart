import 'package:flutter/foundation.dart';
import 'package:facebook_app_events/facebook_app_events.dart';

/// Servicio central para Facebook App Events SDK.
///
/// Singleton que centraliza todos los eventos enviados a Facebook Ads Manager.
/// Nunca lanza excepciones — si falla, solo imprime en debug.
///
/// Eventos implementados:
/// - [init]                     → activateApp (reach de instalaciones)
/// - [trackOnboardingCompleted] → CompletedRegistration (activación de usuario)
/// - [trackSubscribe]           → Subscribe (el más importante para optimizar campañas)
/// - [trackFreeTrial]           → StartTrial (inicio de prueba gratuita)
class FacebookService {
  static final FacebookService _instance = FacebookService._internal();
  factory FacebookService() => _instance;
  FacebookService._internal();

  final FacebookAppEvents _events = FacebookAppEvents();

  // ─── Inicialización ───────────────────────────────────────────────────────

  /// Facebook SDK se inicializa automáticamente desde Info.plist (iOS)
  /// y strings.xml / AndroidManifest (Android).
  /// activateApp() registra la apertura de la app para medir instalaciones.
  Future<void> init() async {
    try {
      await _events.activateApp();
      debugPrint('✅ FacebookService: App activated');
    } catch (e) {
      debugPrint('❌ FacebookService: Init failed: $e');
    }
  }

  // ─── Eventos ──────────────────────────────────────────────────────────────

  /// Llamar cuando el usuario completa el onboarding.
  /// Facebook lo usa para medir "usuarios activados" y optimizar campañas.
  Future<void> trackOnboardingCompleted() async {
    try {
      await _events.logCompletedRegistration(registrationMethod: 'onboarding');
      debugPrint('📊 FacebookService: CompletedRegistration logged');
    } catch (e) {
      debugPrint('❌ FacebookService: logCompletedRegistration failed: $e');
    }
  }

  /// Llamar cuando Superwall confirma que el usuario activó una suscripción paga.
  /// Es el evento más valioso para Facebook Ads — permite optimizar campañas
  /// automáticamente hacia perfiles con alta intención de pago.
  Future<void> trackSubscribe() async {
    try {
      await _events.logSubscribe(orderId: 'moneyt_premium');
      debugPrint('📊 FacebookService: Subscribe logged');
    } catch (e) {
      debugPrint('❌ FacebookService: logSubscribe failed: $e');
    }
  }

  /// Llamar cuando el usuario inicia un free trial.
  Future<void> trackFreeTrial() async {
    try {
      await _events.logStartTrial(orderId: 'moneyt_trial');
      debugPrint('📊 FacebookService: StartTrial logged');
    } catch (e) {
      debugPrint('❌ FacebookService: logStartTrial failed: $e');
    }
  }
}
