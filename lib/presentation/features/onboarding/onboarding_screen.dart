import 'package:flutter/material.dart';
import '../../navigation/navigation_service.dart';
import '../../navigation/app_routes.dart';
import '../../core/services/onboarding_service.dart'; // ✅ AGREGADO
import 'pages/welcome_page.dart';
import 'pages/values_page.dart';
import 'pages/feature_tour_page.dart';
import 'pages/complete_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const WelcomePage(),
    const ValuesPage(),
    const FeatureTourPage(),
    const CompletePage(),
  ];

  @override
  void initState() {
    super.initState();
    print('🎬 OnboardingScreen: Initialized'); // Debug
  }

  void _nextPage() {
    if (_currentIndex < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _completeOnboarding() async {
    print('✅ OnboardingScreen: Completing onboarding...'); // Debug
    
    // ✅ CORREGIDO: Marcar onboarding como completado
    await OnboardingService.markOnboardingCompleted();
    
    print('🏠 OnboardingScreen: Navigating to home...'); // Debug
    // Navegar al home
    NavigationService.navigateToAndClearStack(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    print('🎨 OnboardingScreen: Building with page $_currentIndex'); // Debug
    
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: _pages.map((page) {
          if (page is WelcomePage) {
            return WelcomePage(onNext: _nextPage);
          } else if (page is ValuesPage) {
            return ValuesPage(onNext: _nextPage);
          } else if (page is FeatureTourPage) {
            return FeatureTourPage(onNext: _nextPage, onSkip: _completeOnboarding);
          } else if (page is CompletePage) {
            return CompletePage(onComplete: _completeOnboarding);
          }
          return page;
        }).toList(),
      ),
    );
  }
}
