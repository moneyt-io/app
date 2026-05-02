import 'dart:io';
import 'package:flutter/foundation.dart';

import 'package:superwallkit_flutter/superwallkit_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'analytics_service.dart';
import 'tiktok_service.dart';
import 'facebook_service.dart';

/// Servicio para encapsular toda la lógica de Superwall.
///
/// Responsabilidades:
/// - Inicializar el SDK de Superwall.
/// - Implementar el `SuperwallDelegate` para manejar eventos de la paywall.
/// - Exponer métodos simples para registrar eventos.
/// - Gestionar la navegación después de la interacción con la paywall.
class PaywallService implements SuperwallDelegate {
  static final String _apiKey = Platform.isIOS 
      ? dotenv.env['SUPERWALL_KEY_IOS'] ?? ''
      : dotenv.env['SUPERWALL_KEY_ANDROID'] ?? '';

  // ✅ AGREGADO: Notifier para el estado de suscripción
  final ValueNotifier<bool> isPremiumNotifier = ValueNotifier(false);

  /// Inicializa Superwall y establece este servicio como el delegado.
  Future<void> init() async {
    try {
      await Superwall.configure(_apiKey);
      Superwall.shared.setDelegate(this);
      
      // Escucha cambios futuros de suscripción (ej. compra dentro de la sesión)
      Superwall.shared.subscriptionStatus.listen((status) {
        _updateSubscriptionStatus(status);
      });

      // Leer el estado ACTUAL directamente (no del stream, que solo emite en cambios).
      // getSubscriptionStatus() consulta a StoreKit/Play Billing y retorna el valor real.
      try {
        final currentStatus = await Superwall.shared.getSubscriptionStatus();
        _updateSubscriptionStatus(currentStatus);
        print('✅ PaywallService: Initial subscription status: $currentStatus (isPremium: ${isPremiumNotifier.value})');
      } catch (e) {
        print('⚠️ PaywallService: Could not resolve initial subscription status: $e');
      }
      
      print('✅ PaywallService: Superwall configured successfully.');
    } catch (e) {
      print('❌ PaywallService: Error configuring Superwall: $e');
    }
  }

  /// Registra un evento en Superwall.
  ///
  /// Esto puede disparar la presentación de una paywall si una campaña
  /// está configurada para este evento en el dashboard de Superwall.
  Future<void> registerEvent(String name) async {
    print('🔔 PaywallService: Registering event "$name"');
    // ✅ CORRECCIÓN FINAL: El método para registrar un evento/placement es `registerPlacement`.
    await Superwall.shared.registerPlacement(name);
  }

  // --- SuperwallDelegate Callbacks (API v2.3.5) ---
  // ✅ CORREGIDO: Implementación exacta y completa de la interfaz.

  @override
  void didDismissPaywall(PaywallInfo paywallInfo) {
    print(' PaywallService: Paywall dismissed. Info: ${paywallInfo.name}');
    AnalyticsService().trackPaywallDismissed(paywallInfo.name ?? 'unknown');
    _navigateToNextStep();
  }

  @override
  void didPresentPaywall(PaywallInfo paywallInfo) {
    print(' PaywallService: Paywall presented: ${paywallInfo.name}');
    AnalyticsService().trackPaywallViewed(paywallInfo.name ?? 'unknown');
  }

  @override
  void handleCustomPaywallAction(String name) {
    print(' PaywallService: Custom action: $name');
    AnalyticsService().trackCustomPaywallAction(name);
  }

  @override
  void handleLog(String level, String scope, String? message, Map<dynamic, dynamic>? info, String? error) {
    // Opcional: puedes imprimir logs de Superwall si lo necesitas para depurar.
  }

  @override
  void handleSuperwallEvent(SuperwallEventInfo eventInfo) {
    final eventName = eventInfo.event.type.name;
    print(' PaywallService: Superwall event: $eventName');
    
    // Obtenemos el ID del producto si el usuario inicia una transacción o se suscribe
    final productId = eventInfo.event.product?.productIdentifier;
    
    AnalyticsService().trackSuperwallEvent(
      eventName,
      paywallName: eventInfo.event.paywallInfo?.name,
      productId: productId,
    );
    if (eventName == 'freeTrialStart') {
      FacebookService().trackFreeTrial();
    }
  }

  @override
  void paywallWillOpenDeepLink(Uri url) {
    print(' PaywallService: Will open deep link: $url');
  }

  @override
  void paywallWillOpenURL(Uri url) {
    print(' PaywallService: Will open URL: $url');
  }

  @override
  void subscriptionStatusDidChange(SubscriptionStatus newValue) {
    // ✅ CORREGIDO: Usar .toString() para obtener la representación de la clase.
    print(' PaywallService: Subscription status changed: ${newValue.toString()}');
    _updateSubscriptionStatus(newValue);
  }

  void _updateSubscriptionStatus(SubscriptionStatus status) {
    final isPremium = status is SubscriptionStatusActive;
    if (isPremiumNotifier.value != isPremium) {
      isPremiumNotifier.value = isPremium;
      print('⭐️ PaywallService: Premium status updated to $isPremium');
      if (isPremium) {
        TikTokService().trackSubscribe();
        FacebookService().trackSubscribe();
      }
    }
  }

  @override
  void willDismissPaywall(PaywallInfo paywallInfo) {
    print(' PaywallService: Will dismiss paywall: ${paywallInfo.name}');
  }

  @override
  void willPresentPaywall(PaywallInfo paywallInfo) {
    print(' PaywallService: Will present paywall: ${paywallInfo.name}');
    AnalyticsService().stopRecording(); // Detener grabación justo ANTES de mostrar la paywall
  }

  // ✅ AÑADIDO: Métodos adicionales requeridos por la versión 2.3.5
  @override
  void handleSuperwallDeepLink(Uri fullURL, List<String> pathComponents, Map<String, String> queryParameters) {
    print(' PaywallService: Handling Superwall deep link: $fullURL');
  }

  // ✅ AÑADIDO: Los 2 métodos finales requeridos por la interfaz.
  @override
  void didRedeemLink(RedemptionResult result) {
    print(' PaywallService: Link redeemed with result: ${result.toString()}');
  }

  @override
  void willRedeemLink() {
    print(' PaywallService: Will attempt to redeem link.');
  }

  /// Navega al siguiente paso en el flujo de la app después de que la paywall se cierra.
  void _navigateToNextStep() {
    // ✅ CAMBIADO: Ya no se necesita navegación.
    // La paywall se cierra y el usuario permanece en la pantalla actual (HomeScreen).
    print(' PaywallService: Paywall dismissed. No navigation needed.');
  }
}
