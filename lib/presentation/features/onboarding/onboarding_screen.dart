import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../navigation/navigation_service.dart';
import '../../navigation/app_routes.dart';
import '../../core/services/onboarding_service.dart';
import 'theme/onboarding_theme.dart';
import 'widgets/animated_page_indicator.dart';
import 'pages/welcome_page.dart';
import 'pages/problem_statement_page.dart';
import 'pages/specific_problem_page.dart';
import 'pages/personal_goal_page.dart';
import 'pages/solution_preview_page.dart';
import 'pages/current_method_page.dart';
import 'pages/features_showcase_simple_page.dart';
import 'pages/complete_page.dart';

/// Onboarding simplificado solo para demostración (frontend de venta)
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _skipButtonController;

  int _currentPage = 0;
  bool _showSkipButton = true;

  // Notificador para que las páginas hijas controlen el estado del botón
  final ValueNotifier<bool> _isButtonEnabled = ValueNotifier(true);

  late final List<Widget> _pages;
  late final List<String> _buttonLabels;

  @override
  void initState() {
    super.initState();
    print('🎬 Enhanced OnboardingScreen: Initialized');

    _pageController = PageController();
    _skipButtonController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _pages = [
      WelcomePage(),
      ProblemStatementPage(),
      SpecificProblemPage(isButtonEnabled: _isButtonEnabled),
      PersonalGoalPage(isButtonEnabled: _isButtonEnabled),
      SolutionPreviewPage(),
      CurrentMethodPage(isButtonEnabled: _isButtonEnabled),
      FeatureShowcaseSimplePage(),
      CompletePage(),
    ];

    _buttonLabels = [
      'Comenzar ahora',
      'Solucionalo hoy ⚡',
      'Continuar',
      'Fijar mi meta 🎯',
      '¡Quiero este control!',
      'Continuar',
      '¡Genial, espero verlo!',
      'Registrar mi primera transacción ➕',
    ];

    // Iniciar animación del botón skip
    _skipButtonController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _skipButtonController.dispose();
    _isButtonEnabled.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage == _pages.length - 1) {
      _completeOnboarding();
    } else {
      if (_currentPage < _pages.length - 1) {
        HapticFeedback.lightImpact();
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      HapticFeedback.lightImpact();

      _pageController.previousPage(
        duration: OnboardingTheme.pageTransition,
        curve: OnboardingTheme.defaultCurve,
      );
    }
  }

  void _goToPage(int page) {
    HapticFeedback.selectionClick();

    _pageController.animateToPage(
      page,
      duration: OnboardingTheme.pageTransition,
      curve: OnboardingTheme.defaultCurve,
    );
  }

  void _skipOnboarding() {
    HapticFeedback.mediumImpact();
    // ✅ CORREGIDO: Navegar a la última página en lugar de completar directamente
    _goToPage(_pages.length - 1); // Ir a la CompletePage
  }

  // ✅ SIMPLIFICADO: Sin guardar preferencias, solo completar
  Future<void> _completeOnboarding() async {
    print('🎯 OnboardingScreen: Completing onboarding...');

    try {
      // ✅ CRÍTICO: Marcar onboarding como completado
      await OnboardingService.markOnboardingCompleted();

      if (mounted) {
        // Navegar a la pantalla de login
        NavigationService.navigateToAndClearStack(AppRoutes.login);
      }
    } catch (e) {
      print('❌ OnboardingScreen: Error completing onboarding: $e');
      // En caso de error, intentar navegar de todos modos
      if (mounted) {
        NavigationService.navigateToAndClearStack(AppRoutes.home);
      }
    }
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
      _showSkipButton = page < _pages.length - 1;

      // Resetear el estado del botón a habilitado por defecto en las páginas que no lo gestionan
      if (page == 0 || page == 1 || page == 4 || page == 6 || page == 7) {
        _isButtonEnabled.value = true;
      } else {
        // Para las páginas interactivas, se deshabilita hasta que el usuario seleccione algo
        _isButtonEnabled.value = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print('🎨 Enhanced OnboardingScreen: Building with page $_currentPage');

    return Scaffold(
      body: Stack(
        children: [
          // Main PageView
          PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: _pages,
          ),

          // Top overlay with progress and skip
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: OnboardingTheme.spacing16,
                  vertical: OnboardingTheme.spacing8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back button (solo si no es la primera página)
                    AnimatedOpacity(
                      opacity: _currentPage > 0 ? 1.0 : 0.0,
                      duration: OnboardingTheme.elementEntrance,
                      child: _currentPage > 0
                          ? IconButton(
                              onPressed: _previousPage,
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                                size: 20,
                              ),
                            )
                          : const SizedBox(width: 48),
                    ),

                    // Progress indicator
                    Expanded(
                      child: Center(
                        child: AnimatedPageIndicator(
                          currentPage: _currentPage,
                          totalPages: _pages.length,
                          onPageTap: _goToPage,
                        ),
                      ),
                    ),

                    // Skip button
                    AnimatedOpacity(
                      opacity: _showSkipButton ? 1.0 : 0.0,
                      duration: OnboardingTheme.elementEntrance,
                      child: _showSkipButton
                          ? TextButton(
                              onPressed: _skipOnboarding,
                              child: const Text(
                                'Saltar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          : const SizedBox(width: 48),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // CTA Button centralizado
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(32, 16, 32, 24),
                child: ValueListenableBuilder<bool>(
                  valueListenable: _isButtonEnabled,
                  builder: (context, isEnabled, child) {
                    return ElevatedButton(
                      onPressed: isEnabled ? _nextPage : null,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 56),
                        backgroundColor: Colors.white,
                        disabledBackgroundColor: Colors.white.withOpacity(0.5),
                        foregroundColor: OnboardingTheme.textPrimary,
                        disabledForegroundColor:
                            OnboardingTheme.textPrimary.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                        elevation: 8,
                        shadowColor: Colors.black.withOpacity(0.1),
                      ),
                      child: Text(
                        _buttonLabels[_currentPage],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
