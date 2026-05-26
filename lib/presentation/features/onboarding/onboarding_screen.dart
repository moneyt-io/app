import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../navigation/navigation_service.dart';
import '../../navigation/app_routes.dart';
import '../../core/services/onboarding_service.dart';
import '../auth/auth_provider.dart' as app_auth;
import 'theme/onboarding_theme.dart';
import 'widgets/animated_page_indicator.dart';
import 'pages/onboarding_splash_page.dart';
import 'pages/testimonials_page.dart';
import 'pages/financial_goals_page.dart';
import 'pages/main_priority_page.dart';
import 'pages/expense_categories_page.dart';
import 'pages/registration_method_page.dart';
import 'pages/ai_analysis_showcase_page.dart';
import 'pages/ai_voice_showcase_page.dart';
import '../../core/l10n/generated/strings.g.dart';
import '../../../../core/services/analytics_service.dart';
import '../../../../core/services/tiktok_service.dart';

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
  List<int> _activeSteps = [0, 1, 2, 3, 4, 5, 6];
  String _variant = 'v2';

  // Estado levantado para persistencia de selección
  bool _isAnalysisComplete = false;
  final ValueNotifier<int> _highestAllowedPageNotifier = ValueNotifier<int>(0);
  final ValueNotifier<int> _currentPageNotifier = ValueNotifier<int>(0);
  PainPoint? _selectedPainPoint;
  PersonalGoal? _selectedGoal;
  CurrentMethod? _selectedMethod;
  List<ExpenseCategory> _selectedCategories = [];

  // Notificador para que las páginas hijas controlen el estado del botón
  final ValueNotifier<bool> _isButtonEnabled = ValueNotifier(true);

  // Índice absoluto (0-7) de la página actualmente visible
  int get _currentStepIndex =>
      _currentPage < _activeSteps.length ? _activeSteps[_currentPage] : _currentPage;

  // Todas las páginas posibles en orden fijo (0-7)
  List<Widget> get _allPages => [
    const OnboardingSplashPage(),                                     // 0
    ExpenseCategoriesPage(
      selectedCategories: _selectedCategories.toList(),
      onCategoryToggled: (category) {
        setState(() {
          if (_selectedCategories.contains(category)) {
            _selectedCategories.remove(category);
          } else {
            if (_selectedCategories.length < 3) {
              _selectedCategories.add(category);
            }
          }
          _isButtonEnabled.value = _selectedCategories.isNotEmpty;
        });
      },
    ),                                                                // 1
    FinancialGoalsPage(
      selectedPainPoint: _selectedPainPoint,
      onPainPointSelected: (painPoint) {
        setState(() {
          _selectedPainPoint = painPoint;
          _isButtonEnabled.value = true;
        });
        AnalyticsService().trackOnboardingChoiceSelected(
          stepName: 'financial_goals',
          choice: painPoint.name,
        );
        // Auto-advance
        Future.delayed(const Duration(milliseconds: 300), () {
          _nextPage();
        });
      },
    ),                                                                // 2
    RegistrationMethodPage(
      selectedMethod: _selectedMethod,
      onMethodSelected: (method) {
        setState(() {
          _selectedMethod = method;
          _isButtonEnabled.value = true;
          _isAnalysisComplete = false; // Reset analysis state if user changes answer
        });
        AnalyticsService().trackOnboardingChoiceSelected(
          stepName: 'registration_method',
          choice: method.name,
        );
        // Auto-advance
        Future.delayed(const Duration(milliseconds: 300), () {
          _nextPage();
        });
      },
    ),                                                                // 3
    AIAnalysisShowcasePage(
      startWithLoading: !_isAnalysisComplete,
      selectedPainPoint: _selectedPainPoint,
      selectedCategories: _selectedCategories.toSet(),
      onAnalysisComplete: () {
        setState(() {
          _isAnalysisComplete = true;
        });
      },
    ),                                                                // 4
    MainPriorityPage(
      selectedGoal: _selectedGoal,
      onGoalSelected: (goal) {
        setState(() {
          _selectedGoal = goal;
          _isButtonEnabled.value = true;
        });
        AnalyticsService().trackOnboardingChoiceSelected(
          stepName: 'main_priority',
          choice: goal.name,
        );
        // Auto-advance
        Future.delayed(const Duration(milliseconds: 300), () {
          _nextPage();
        });
      },
    ),                                                                // 5
    AIVoiceShowcasePage(
      selectedGoal: _selectedGoal,
    ),                                                                // 6
  ];

  // Páginas activas según la configuración remota
  List<Widget> get _pages {
    final all = _allPages;
    return _activeSteps.where((i) => i >= 0 && i < all.length).map((i) => all[i]).toList();
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
    _highestAllowedPageNotifier.dispose();
    _currentPageNotifier.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage == _pages.length - 1) {
      _completeOnboarding();
    } else {
      if (_currentStepIndex == 1 && _selectedCategories.isNotEmpty) {
        AnalyticsService().trackOnboardingChoiceSelected(
          stepName: 'expense_categories',
          choice: _selectedCategories.map((e) => e.name).join(','),
        );
      }
      
      if (_currentPage < _pages.length - 1) {
        if (_highestAllowedPageNotifier.value <= _currentPage) {
          _highestAllowedPageNotifier.value = _currentPage + 1;
        }
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

    if (_highestAllowedPageNotifier.value < page) {
      _highestAllowedPageNotifier.value = page;
    }

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
    TikTokService().trackOnboardingCompleted();

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
    _currentPageNotifier.value = page;
    setState(() {
      _currentPage = page;
      _showSkipButton = page < _pages.length - 1;

      // Verificar si ya hay una selección previa usando el índice absoluto
      bool shouldEnable = true;
      switch (stepIndex) {
        case 1: // ExpenseCategoriesPage
          shouldEnable = _selectedCategories.isNotEmpty;
          break;
        case 2: // FinancialGoalsPage (PainPoint)
          shouldEnable = _selectedPainPoint != null;
          break;
        case 3: // RegistrationMethodPage (CurrentMethod)
          shouldEnable = _selectedMethod != null;
          break;
        case 5: // MainPriorityPage (PersonalGoal)
          shouldEnable = _selectedGoal != null;
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // Top overlay with progress
                if (_currentPage == 1 || _currentPage == 2 || _currentPage == 3 || _currentPage == 5)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Back button
                        IconButton(
                          onPressed: _previousPage,
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Color(0xFF131B2E),
                            size: 24,
                          ),
                        ),

                        // Progress indicator
                        Expanded(
                          child: Center(
                            child: AnimatedPageIndicator(
                              currentPage: _currentPage == 5 ? 3 : _currentPage - 1,
                              totalPages: 4,
                            ),
                          ),
                        ),

                        // Empty space to balance the row
                        const SizedBox(width: 48),
                      ],
                    ),
                  ),

                // Main PageView
                Expanded(
                  child: PageView(
                    physics: _DisableForwardPageScrollPhysics(
                      highestAllowedPageNotifier: _highestAllowedPageNotifier,
                      isButtonEnabledNotifier: _isButtonEnabled,
                      currentPageNotifier: _currentPageNotifier,
                    ),
                    controller: _pageController,
                    onPageChanged: _onPageChanged,
                    children: _pages,
                  ),
                ),
              ],
            ),

            // CTA Button centralizado (hidden on auto-advance and loading screens)
            Builder(
              builder: (context) {
                bool showButton = true;
                if (_currentPage == 2 || _currentPage == 3 || _currentPage == 5) showButton = false;
                if (_currentPage == 4 && !_isAnalysisComplete) showButton = false;

                if (!showButton) return const SizedBox.shrink();

                return Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(32, 16, 32, 24),
                    child: ValueListenableBuilder<bool>(
                      valueListenable: _isButtonEnabled,
                      builder: (context, isEnabled, child) {
                        return Container(
                          height: 56,
                          decoration: BoxDecoration(
                            gradient: isEnabled
                                ? const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                                  )
                                : null,
                            color: isEnabled ? null : const Color(0xFF2B63F1).withOpacity(0.5),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: isEnabled
                                ? [
                                    BoxShadow(
                                      color: const Color(0xFF3B82F6).withOpacity(0.3),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ]
                                : null,
                          ),
                          child: ElevatedButton(
                            onPressed: isEnabled ? _nextPage : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              disabledBackgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              foregroundColor: Colors.white,
                              disabledForegroundColor: Colors.white.withOpacity(0.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              _getButtonLabel(_currentStepIndex),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }
            ),
          ],
        ),
      ),
    );
  }

  // ✅ NUEVO: Getter para etiquetas de botones localizadas
  String _getButtonLabel(int index) {
    if (index >= 9) return t.common.retry; // Fallback
    
    final labels = [
      t.v2.onboarding.buttons.start, // 0 splash
      t.v2.onboarding.buttons.actionContinue, // 1 Expense
      t.v2.onboarding.buttons.actionContinue, // 2 Financial goals
      t.v2.onboarding.buttons.actionContinue, // 3 Registration method
      t.v2.onboarding.buttons.great, // 4 ai analysis
      t.v2.onboarding.buttons.setGoal, // 5 main priority
      t.v2.onboarding.buttons.great, // 6 ai voice
    ];
    
    return labels[index];
  }
}

class _DisableForwardPageScrollPhysics extends PageScrollPhysics {
  final ValueNotifier<int> highestAllowedPageNotifier;
  final ValueNotifier<bool> isButtonEnabledNotifier;
  final ValueNotifier<int> currentPageNotifier;

  const _DisableForwardPageScrollPhysics({
    required this.highestAllowedPageNotifier,
    required this.isButtonEnabledNotifier,
    required this.currentPageNotifier,
    ScrollPhysics? parent,
  }) : super(parent: parent);

  @override
  _DisableForwardPageScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return _DisableForwardPageScrollPhysics(
      highestAllowedPageNotifier: highestAllowedPageNotifier,
      isButtonEnabledNotifier: isButtonEnabledNotifier,
      currentPageNotifier: currentPageNotifier,
      parent: buildParent(ancestor),
    );
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    // If scrolling backwards, allow it (defer to parent to prevent scrolling past 0.0)
    if (value <= position.pixels) {
      return super.applyBoundaryConditions(position, value);
    }

    // Now user is scrolling forward (value > position.pixels)
    final highestPage = highestAllowedPageNotifier.value;
    final maxPixels = highestPage * position.viewportDimension;

    // 1. Block if trying to go past the historically highest allowed page
    if (value > maxPixels) {
      if (position.pixels >= maxPixels) {
        return value - position.pixels; // Prevent further movement
      }
      return value - maxPixels; // Cap the movement
    }

    // 2. Block if current page validation fails (e.g., required option not selected)
    final currentPage = currentPageNotifier.value;
    if (!isButtonEnabledNotifier.value) {
      final currentMaxPixels = currentPage * position.viewportDimension;
      if (value > currentMaxPixels) {
        if (position.pixels >= currentMaxPixels) {
          return value - position.pixels;
        }
        return value - currentMaxPixels;
      }
    }

    return super.applyBoundaryConditions(position, value);
  }
}
