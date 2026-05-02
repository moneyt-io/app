import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:posthog_flutter/posthog_flutter.dart';
import 'facebook_service.dart';

/// Configuración del onboarding retornada por PostHog.
/// [steps] son los índices de páginas a mostrar (0-7), en orden.
/// [variant] es el nombre de la variante activa ('control', 'short', etc.)
class OnboardingConfig {
  final List<int> steps;
  final String variant;

  const OnboardingConfig({required this.steps, required this.variant});

  static OnboardingConfig get defaultConfig => OnboardingConfig(
        steps: [0, 1, 2, 3, 4, 5, 6, 7],
        variant: 'control',
      );
}

/// Servicio central de analytics usando PostHog.
///
/// Singleton que centraliza todos los eventos de la app.
/// Nunca lanza excepciones — si falla, solo imprime en debug.
class AnalyticsService {
  static final AnalyticsService _instance = AnalyticsService._internal();
  factory AnalyticsService() => _instance;
  AnalyticsService._internal();

  static String get _apiKey => kReleaseMode
      ? dotenv.env['POSTHOG_API_KEY_PROD'] ?? ''
      : dotenv.env['POSTHOG_API_KEY_DEV'] ?? '';

  static const String _host = 'https://us.i.posthog.com';

  bool _initialized = false;

  // Nombres de cada paso del onboarding (índice = número de página)
  static const List<String> _onboardingStepNames = [
    'welcome',           // 0
    'problem_statement', // 1
    'specific_problem',  // 2
    'personal_goal',     // 3
    'solution_preview',  // 4
    'current_method',    // 5
    'features_showcase', // 6
    'complete',          // 7
  ];

  // ─── Inicialización ───────────────────────────────────────────────────────

  Future<void> init() async {
    try {
      final config = PostHogConfig(_apiKey)
        ..host = _host
        ..debug = kDebugMode
        ..captureApplicationLifecycleEvents = false
        ..sessionReplay = true;

      await Posthog().setup(config);
      _initialized = true;
      debugPrint('✅ AnalyticsService: PostHog initialized');
    } catch (e) {
      debugPrint('❌ AnalyticsService: Init failed: $e');
    }
  }

  // ─── Capture interno (nunca lanza) ────────────────────────────────────────

  void _capture(String event, {Map<String, Object>? properties}) {
    if (!_initialized) return;
    try {
      Posthog().capture(eventName: event, properties: properties);
    } catch (e) {
      debugPrint('❌ AnalyticsService: capture "$event" failed: $e');
    }
  }

  /// Detiene la grabación de la sesión actual
  void stopRecording() {
    if (!_initialized) return;
    try {
      Posthog().stopSessionRecording();
      debugPrint('✅ AnalyticsService: Session recording stopped');
    } catch (e) {
      debugPrint('❌ AnalyticsService: stopSessionRecording failed: $e');
    }
  }

  // ─── Identificación de usuario ────────────────────────────────────────────

  /// Llamar cuando el usuario se autentica.
  /// En modo guest no es necesario — PostHog ya maneja el anonymousId automáticamente.
  void identify({required String userId, Map<String, Object>? properties}) {
    if (!_initialized) return;
    try {
      Posthog().identify(userId: userId, userProperties: properties);
      debugPrint('✅ AnalyticsService: Identified user $userId');
    } catch (e) {
      debugPrint('❌ AnalyticsService: identify failed: $e');
    }
  }

  /// Llamar al hacer logout para desvincular el perfil del dispositivo.
  void reset() {
    if (!_initialized) return;
    try {
      Posthog().reset();
    } catch (e) {
      debugPrint('❌ AnalyticsService: reset failed: $e');
    }
  }

  // ─── Onboarding ───────────────────────────────────────────────────────────

  /// Cada vez que el usuario llega a una página del onboarding.
  void trackOnboardingStepViewed(int stepIndex) {
    if (stepIndex < 0 || stepIndex >= _onboardingStepNames.length) return;
    _capture('onboarding_step_viewed', properties: {
      'step_index': stepIndex,
      'step_name': _onboardingStepNames[stepIndex],
    });
  }

  /// Cuando el usuario presiona el CTA para avanzar.
  void trackOnboardingStepCompleted(int stepIndex) {
    if (stepIndex < 0 || stepIndex >= _onboardingStepNames.length) return;
    _capture('onboarding_step_completed', properties: {
      'step_index': stepIndex,
      'step_name': _onboardingStepNames[stepIndex],
    });
  }

  /// Cuando el usuario selecciona una opción en páginas con elección.
  void trackOnboardingChoiceSelected({
    required String stepName,
    required String choice,
  }) {
    _capture('onboarding_choice_selected', properties: {
      'step_name': stepName,
      'choice': choice,
    });
  }

  // ─── Feature Flags / Onboarding remoto ──────────────────────────────────

  /// Retorna la configuración del onboarding desde PostHog.
  /// Si el flag no existe, falla o no tiene el formato esperado,
  /// devuelve la config por defecto (8 pasos en orden original).
  Future<OnboardingConfig> getOnboardingConfig() async {
    if (!_initialized) return OnboardingConfig.defaultConfig;
    try {
      final result = await Posthog()
          .getFeatureFlagResult('onboarding_config', sendEvent: false);

      if (result == null) return OnboardingConfig.defaultConfig;

      final variant = result.variant ?? result.enabled.toString();
      final payload = result.payload;

      if (payload is Map && payload['steps'] is List) {
        final steps = List<int>.from(payload['steps'] as List);
        if (steps.isNotEmpty) {
          return OnboardingConfig(steps: steps, variant: variant);
        }
      }
    } catch (e) {
      debugPrint('❌ AnalyticsService: getOnboardingConfig failed: $e');
    }
    return OnboardingConfig.defaultConfig;
  }

  // ─── Onboarding (continuación) ────────────────────────────────────────────

  /// Al completar el onboarding. Incluye las elecciones del usuario
  /// para segmentar en PostHog por pain point, meta y método actual.
  void trackOnboardingCompleted({
    String? painPoint,
    String? goal,
    String? method,
    String? variant,
  }) {
    _capture('onboarding_completed', properties: {
      if (painPoint != null) 'pain_point': painPoint,
      if (goal != null) 'goal': goal,
      if (method != null) 'method': method,
    });
    FacebookService().trackOnboardingCompleted();

    // Persiste las elecciones como person properties para segmentar en cualquier análisis futuro
    if (!_initialized) return;
    try {
      Posthog().setPersonProperties(
        userPropertiesToSet: {
          if (painPoint != null) 'onboarding_pain_point': painPoint,
          if (goal != null) 'onboarding_goal': goal,
          if (method != null) 'onboarding_method': method,
          'onboarding_completed': true,
        },
        userPropertiesToSetOnce: {
          'onboarding_completed_at': DateTime.now().toIso8601String(),
        },
      );
    } catch (_) {}
  }

  /// Si el usuario usa el skip (va directo al último paso).
  void trackOnboardingSkipped(int fromStep) {
    _capture('onboarding_skipped', properties: {
      'from_step': fromStep,
      'from_step_name': fromStep < _onboardingStepNames.length
          ? _onboardingStepNames[fromStep]
          : 'unknown',
    });
  }

  // ─── Superwall / Paywall ──────────────────────────────────────────────────

  /// Cuando la paywall se presenta (desde PaywallService.didPresentPaywall).
  void trackPaywallViewed(String paywallName) {
    _capture('paywall_viewed', properties: {'paywall_name': paywallName});
  }

  /// Cuando la paywall se cierra (desde PaywallService.didDismissPaywall).
  void trackPaywallDismissed(String paywallName) {
    _capture('paywall_dismissed', properties: {'paywall_name': paywallName});
  }

  /// Cuando el usuario interactúa con un botón configurado con un Custom Action en Superwall
  void trackCustomPaywallAction(String actionName) {
    _capture('paywall_custom_action', properties: {'action_name': actionName});
  }

  /// Forwadea los eventos clave de Superwall a PostHog con nombres limpios.
  /// Se llama desde PaywallService.handleSuperwallEvent.
  void trackSuperwallEvent(String superwallEventName, {String? paywallName, String? productId}) {
    final mapped = _mapSuperwallEvent(superwallEventName);
    if (mapped == null) return;

    _capture(mapped, properties: {
      'superwall_event': superwallEventName,
      if (paywallName != null) 'paywall_name': paywallName,
      if (productId != null) 'product_id': productId,
    });

    // Si es suscripción, actualizar person property
    if (mapped == 'subscription_started' || mapped == 'free_trial_started') {
      if (!_initialized) return;
      try {
        Posthog().setPersonProperties(
          userPropertiesToSet: {
            'is_premium': true,
            if (productId != null) 'premium_plan': productId,
          },
          userPropertiesToSetOnce: {
            'first_subscription_at': DateTime.now().toIso8601String(),
          },
        );
      } catch (_) {}
    }
  }

  /// Mapea nombres de eventos de Superwall a nombres limpios de PostHog.
  /// Retorna null para eventos de sistema que no queremos trackear.
  String? _mapSuperwallEvent(String name) {
    switch (name) {
      case 'paywallOpen':
        return 'paywall_viewed';
      case 'paywallClose':
        return 'paywall_dismissed';
      case 'paywallDecline':
      case 'transactionAbandon':
        return 'paywall_declined';
      case 'transactionStart':
        return 'purchase_started';
      case 'transactionComplete':
      case 'subscriptionStart':
        return 'subscription_started';
      case 'transactionFail':
        return 'purchase_failed';
      case 'freeTrialStart':
        return 'free_trial_started';
      case 'transactionRestore':
        return 'subscription_restored';
      default:
        return null;
    }
  }
}
