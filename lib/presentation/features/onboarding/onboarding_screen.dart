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
import '../../../../core/services/analytics_service.dart';

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

  // Configuración remota — se carga desde PostHog al init
  List<int> _activeSteps = [0, 1, 2, 3, 4, 5, 6, 7];
  String _variant = 'control';

  // Estado levantado para persistencia de selección
  PainPoint? _selectedPainPoint;
  PersonalGoal? _selectedGoal;
  CurrentMethod? _selectedMethod;

  // Notificador para que las páginas hijas controlen el estado del botón
  final ValueNotifier<bool> _isButtonEnabled = ValueNotifier(true);

  // Índice absoluto (0-7) de la página actualmente visible
  int get _currentStepIndex =>
      _currentPage < _activeSteps.length ? _activeSteps[_currentPage] : _currentPage;

  // Todas las páginas posibles en orden fijo (0-7)
  List<Widget> get _allPages => [
    WelcomePage(),                                                    // 0
    ProblemStatementPage(),                                           // 1
    SpecificProblemPage(
      selectedPainPoint: _selectedPainPoint,
      onPainPointSelected: (painPoint) {
        setState(() {
          _selectedPainPoint = painPoint;
          _isButtonEnabled.value = true;
        });
        AnalyticsService().trackOnboardingChoiceSelected(
          stepName: 'specific_problem',
          choice: painPoint.name,
        );
      },
    ),                                                                // 2
    PersonalGoalPage(
      selectedGoal: _selectedGoal,
      onGoalSelected: (goal) {
        setState(() {
          _selectedGoal = goal;
          _isButtonEnabled.value = true;
        });
        AnalyticsService().trackOnboardingChoiceSelected(
          stepName: 'personal_goal',
          choice: goal.name,
        );
      },
    ),                                                                // 3
    SolutionPreviewPage(),                                            // 4
    CurrentMethodPage(
      selectedMethod: _selectedMethod,
      onMethodSelected: (method) {
        setState(() {
          _selectedMethod = method;
          _isButtonEnabled.value = true;
        });
        AnalyticsService().trackOnboardingChoiceSelected(
          stepName: 'current_method',
          choice: method.name,
        );
      },
    ),                                                                // 5
    FeatureShowcaseSimplePage(),                                      // 6
    CompletePage(),                                                   // 7
  ];

  // Páginas activas según la configuración remota
  List<Widget> get _pages {
    final all = _allPages;
    return _activeSteps.map((i) => all[i]).toList();
  }

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

    // Cargar configuración remota de PostHog (ya cacheada desde SplashScreen)
    _loadOnboardingConfig();

    // Trackear step 0 manualmente — onPageChanged no lo captura porque
    // la página inicial nunca "cambia hacia ella"
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AnalyticsService().trackOnboardingStepViewed(_activeSteps[0]);
    });
  }

  Future<void> _loadOnboardingConfig() async {
    final config = await AnalyticsService().getOnboardingConfig();
    if (!mounted) return;
    setState(() {
      _activeSteps = config.steps;
      _variant = config.variant;
    });
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
        AnalyticsService().trackOnboardingStepCompleted(_currentStepIndex);
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
    AnalyticsService().trackOnboardingSkipped(_currentStepIndex);
    _goToPage(_pages.length - 1); // Ir a la CompletePage
  }

  // ✅ SIMPLIFICADO: Navegación directa al Home, omitiendo Login explícito
  Future<void> _completeOnboarding() async {
    print('🎯 OnboardingScreen: Completing onboarding...');

    AnalyticsService().trackOnboardingCompleted(
      painPoint: _selectedPainPoint?.name,
      goal: _selectedGoal?.name,
      method: _selectedMethod?.name,
      variant: _variant,
    );

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
    final stepIndex = page < _activeSteps.length ? _activeSteps[page] : page;
    AnalyticsService().trackOnboardingStepViewed(stepIndex);
    setState(() {
      _currentPage = page;
      _showSkipButton = page < _pages.length - 1;

      // Verificar si ya hay una selección previa usando el índice absoluto
      bool shouldEnable = true;
      switch (stepIndex) {
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
                        _getButtonLabel(_currentStepIndex),
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
