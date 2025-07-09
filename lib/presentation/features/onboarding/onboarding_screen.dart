import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../navigation/navigation_service.dart';
import '../../navigation/app_routes.dart';
import '../../core/services/onboarding_service.dart';
import 'theme/onboarding_theme.dart';
import 'widgets/animated_page_indicator.dart';
import 'pages/welcome_page.dart';
import 'pages/problem_statement_page.dart';
import 'pages/solution_preview_page.dart';
import 'pages/feature_showcase_page.dart';
import 'pages/complete_page.dart';

/// Onboarding rediseñado con mejor UX/UI y storytelling
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

  // Lista de páginas del onboarding
  late final List<Widget> _pages;
  
  @override
  void initState() {
    super.initState();
    print('🎬 Enhanced OnboardingScreen: Initialized');
    
    _pageController = PageController();
    _skipButtonController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    // Construir lista de páginas con features individuales
    _pages = [
      WelcomePage(onNext: _nextPage),
      ProblemStatementPage(onNext: _nextPage),
      SolutionPreviewPage(onNext: _nextPage),
      // Features individuales
      ...FeatureInfo.allFeatures.map((feature) => 
        FeatureShowcasePage(
          feature: feature,
          onNext: _nextPage,
        ),
      ),
      CompletePage(onComplete: _completeOnboarding),
    ];

    // Iniciar animación del botón skip
    _skipButtonController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _skipButtonController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      // AGREGADO: Haptic feedback implementado
      HapticFeedback.lightImpact();
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentPage++;
      });
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

  // AGREGADO: Método crítico faltante
  Future<void> _completeOnboarding() async {
    print('🎯 OnboardingScreen: Completing onboarding...');
    
    try {
      // ✅ CRÍTICO: Marcar onboarding como completado
      await OnboardingService.markOnboardingCompleted();
      
      if (mounted) {
        // Navegar al dashboard/home
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
      // Ocultar skip button en la última página
      _showSkipButton = page < _pages.length - 1;
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
          if (_showSkipButton)
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
                      if (_currentPage > 0)
                        AnimatedOpacity(
                          opacity: _currentPage > 0 ? 1.0 : 0.0,
                          duration: OnboardingTheme.elementEntrance,
                          child: IconButton(
                            onPressed: _previousPage,
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        )
                      else
                        const SizedBox(width: 48),
                      
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
                      FadeTransition(
                        opacity: _skipButtonController,
                        child: TextButton(
                          onPressed: _skipOnboarding,
                          child: const Text(
                            'Saltar',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
