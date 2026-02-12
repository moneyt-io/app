import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../navigation/navigation_service.dart';
import '../../navigation/app_routes.dart';
import '../../core/services/onboarding_service.dart';
import '../auth/auth_provider.dart' as app_auth;
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
import '../../core/l10n/generated/strings.g.dart'; // ✅ AÑADIDO

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
  
  // ✅ NUEVO: Estado levantado (Lifted State) para persistencia de selección
  PainPoint? _selectedPainPoint;
  PersonalGoal? _selectedGoal;
  CurrentMethod? _selectedMethod;

  // Notificador para que las páginas hijas controlen el estado del botón
  final ValueNotifier<bool> _isButtonEnabled = ValueNotifier(true);
  
  // ✅ MOVIDO: Getter para _pages que usa el estado
  List<Widget> get _pages => [
    WelcomePage(),
    ProblemStatementPage(),
    SpecificProblemPage(
      // Ya no pasamos ValueNotifier, pasamos estado y callback
      selectedPainPoint: _selectedPainPoint,
      onPainPointSelected: (painPoint) {
        setState(() {
          _selectedPainPoint = painPoint;
          _isButtonEnabled.value = true;
        });
      },
    ),
    PersonalGoalPage(
      selectedGoal: _selectedGoal,
      onGoalSelected: (goal) {
        setState(() {
          _selectedGoal = goal;
          _isButtonEnabled.value = true;
        });
      },
    ),
    SolutionPreviewPage(),
    CurrentMethodPage(
      selectedMethod: _selectedMethod,
      onMethodSelected: (method) {
        setState(() {
          _selectedMethod = method;
          _isButtonEnabled.value = true;
        });
      },
    ),
    FeatureShowcaseSimplePage(),
    CompletePage(),
  ];

  @override
  void initState() {
    super.initState();
    print('🎬 Enhanced OnboardingScreen: Initialized');

    _pageController = PageController();
    _skipButtonController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    
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

  // ✅ SIMPLIFICADO: Navegación directa al Home, omitiendo Login explícito
  Future<void> _completeOnboarding() async {
    print('🎯 OnboardingScreen: Completing onboarding...');

    try {
      // 1. Marcar onboarding como completado
      await OnboardingService.markOnboardingCompleted();

      // 2. Iniciar sesión como invitado automáticamente para cumplir requisitos de Auth
      if (mounted) {
        final authProvider = context.read<app_auth.AuthProvider>();
        await authProvider.continueAsGuest();
      }

      // 3. Navegar directamente al Home
      // (El Home se encargará de mostrar la Paywall si es necesario)
      if (mounted) {
        NavigationService.navigateToAndClearStack(AppRoutes.home);
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

      // ✅ LOGICA CORREGIDA: Verificar si ya hay una selección previa
      bool shouldEnable = true;
      
      switch (page) {
        case 2: // SpecificProblemPage
          shouldEnable = _selectedPainPoint != null;
          break;
        case 3: // PersonalGoalPage
          shouldEnable = _selectedGoal != null;
          break;
        case 5: // CurrentMethodPage
          shouldEnable = _selectedMethod != null;
          break;
        default:
          shouldEnable = true;
      }
      
      _isButtonEnabled.value = shouldEnable;
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

                    // Skip button eliminated
                    const SizedBox(width: 48),
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
                        _getButtonLabel(_currentPage), // ✅ AÑADIDO: Getter dinámico
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

  // ✅ NUEVO: Getter para etiquetas de botones localizadas
  String _getButtonLabel(int index) {
    if (index >= 8) return t.common.retry; // Fallback
    
    final labels = [
      t.onboarding.buttons.start,
      t.onboarding.buttons.fixIt,
      t.onboarding.buttons.actionContinue, // ✅ CORREGIDO: Renombrado a actionContinue
      t.onboarding.buttons.setGoal,
      t.onboarding.buttons.wantControl,
      t.onboarding.buttons.actionContinue, // ✅ CORREGIDO: Renombrado a actionContinue
      t.onboarding.buttons.great,
      t.onboarding.buttons.firstTransaction,
    ];
    
    return labels[index];
  }
}
