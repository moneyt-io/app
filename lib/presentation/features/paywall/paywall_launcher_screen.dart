import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:moneyt_pfm/core/services/paywall_service.dart';
import 'package:moneyt_pfm/presentation/navigation/app_routes.dart';
import 'package:moneyt_pfm/presentation/navigation/navigation_service.dart';

class PaywallLauncherScreen extends StatefulWidget {
  const PaywallLauncherScreen({super.key});

  @override
  State<PaywallLauncherScreen> createState() => _PaywallLauncherScreenState();
}

class _PaywallLauncherScreenState extends State<PaywallLauncherScreen> {
  @override
  void initState() {
    super.initState();
    // Usamos addPostFrameCallback para asegurarnos de que el widget esté construido
    // antes de intentar mostrar una superposición como la paywall.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _triggerPaywallAndNavigate();
    });
  }

  Future<void> _triggerPaywallAndNavigate() async {
    try {
      final paywallService = GetIt.instance<PaywallService>();
      // Registramos el evento que dispara la paywall de Superwall.
      // El método de Superwall maneja la presentación de la UI.
      await paywallService.registerEvent('moneyt_pro');
    } catch (e) {
      print('PaywallLauncherScreen: Error triggering paywall: $e');
      // Si hay un error, continuamos al login para no bloquear al usuario.
    } finally {
      // Una vez que la paywall se cierra (comprando o no), navegamos al login.
      // Pasamos el "ticket" para que el HomeScreen sepa que ya mostramos la paywall.
      if (mounted) {
        NavigationService.navigateToAndClearStack(
          AppRoutes.login,
          arguments: {'hasJustSeenPaywall': true},
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Pantalla de carga simple mientras se procesa la lógica.
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
