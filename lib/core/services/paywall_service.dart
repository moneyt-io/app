import 'package:superwallkit_flutter/superwallkit_flutter.dart';

/// Servicio para encapsular toda la lógica de Superwall.
///
/// Responsabilidades:
/// - Inicializar el SDK de Superwall.
/// - Implementar el `SuperwallDelegate` para manejar eventos de la paywall.
/// - Exponer métodos simples para registrar eventos.
/// - Gestionar la navegación después de la interacción con la paywall.
class PaywallService implements SuperwallDelegate {
  // TODO: Reemplaza 'YOUR_SUPERWALL_API_KEY' con tu clave de API pública de Superwall.
  static const String _apiKey = 'pk_7fedd9149f8698d2116bff03452f6cb65dfcd260bcd58ecc';

  /// Inicializa Superwall y establece este servicio como el delegado.
  Future<void> init() async {
    try {
      // La configuración es estática.
      await Superwall.configure(_apiKey);
      // La asignación del delegate se hace a través de la instancia compartida.
      Superwall.shared.setDelegate(this); // ✅ CORRECCIÓN FINAL
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
    _navigateToNextStep();
  }

  @override
  void didPresentPaywall(PaywallInfo paywallInfo) {
    print(' PaywallService: Paywall presented: ${paywallInfo.name}');
  }

  @override
  void handleCustomPaywallAction(String name) {
    print(' PaywallService: Custom action: $name');
  }

  @override
  void handleLog(String level, String scope, String? message, Map<dynamic, dynamic>? info, String? error) {
    // Opcional: puedes imprimir logs de Superwall si lo necesitas para depurar.
  }

  @override
  void handleSuperwallEvent(SuperwallEventInfo eventInfo) {
    print(' PaywallService: Superwall event: ${eventInfo.event.name}');
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
  }

  @override
  void willDismissPaywall(PaywallInfo paywallInfo) {
    print(' PaywallService: Will dismiss paywall: ${paywallInfo.name}');
  }

  @override
  void willPresentPaywall(PaywallInfo paywallInfo) {
    print(' PaywallService: Will present paywall: ${paywallInfo.name}');
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
