import 'package:flutter/material.dart';
import '../theme/onboarding_theme.dart';
import '../widgets/animated_feature_icon.dart';
import '../widgets/staggered_text_animation.dart';

enum PainPoint {
  noSavings('no_savings', 'No logro ahorrar nada 🐷'),       // ✅ ELIMINADO: número ①
  unknownDebt('unknown_debt', 'No sé cuánto debo 💳'),       // ✅ ELIMINADO: número ②
  unknownBalance('unknown_balance', 'No sé cuánto dinero tengo ❓'); // ✅ ELIMINADO: número ③

  const PainPoint(this.key, this.label);
  final String key;
  final String label;
}

class SpecificProblemPage extends StatefulWidget {
  const SpecificProblemPage({
    Key? key,
    required this.isButtonEnabled,
  }) : super(key: key);

  final ValueNotifier<bool> isButtonEnabled;

  @override
  State<SpecificProblemPage> createState() => _SpecificProblemPageState();
}

class _SpecificProblemPageState extends State<SpecificProblemPage>
    with AutomaticKeepAliveClientMixin {
  PainPoint? _selectedPainPoint;

  void _selectPainPoint(PainPoint painPoint) {
    setState(() {
      _selectedPainPoint = painPoint;
    });
    // Notificar al padre que el botón puede ser habilitado
    widget.isButtonEnabled.value = true;
  }

  @override
  bool get wantKeepAlive => true; // Mantener el estado de la página

  @override
  Widget build(BuildContext context) {
    super.build(context); // Necesario para AutomaticKeepAliveClientMixin
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: OnboardingTheme.gradients['problem']!,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(OnboardingTheme.spacing32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              
              // Animated Icon
              AnimatedFeatureIcon(
                icon: Icons.help_outline,
                backgroundColor: Colors.white.withOpacity(0.2),
                iconColor: Colors.white,
                size: 100,
                animationDelay: const Duration(milliseconds: 200),
              ),
              
              const SizedBox(height: OnboardingTheme.spacing48),
              
              // Question
              StaggeredTextAnimation(
                text: 'Cuéntanos, ¿qué te frustra más? 🤔',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.3,
                ),
                delay: const Duration(milliseconds: 400),
              ),
              
              const SizedBox(height: OnboardingTheme.spacing16),
              
              // Subtitle
              StaggeredTextAnimation(
                text: 'Elige la opción que mejor te describe.',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,  // ✅ AGREGADO: Ligeramente más pesado que normal
                  letterSpacing: 0.3,           // ✅ AGREGADO: Espaciado entre letras
                  color: Colors.white,          // ✅ CAMBIADO: Opacidad máxima
                  height: 1.4,                  // ✅ CAMBIADO: Espaciado más compacto
                  shadows: [                    // ✅ AGREGADO: Sombra sutil para profundidad
                    Shadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                delay: const Duration(milliseconds: 600),
              ),
              
              const SizedBox(height: OnboardingTheme.spacing48),
              
              // Pain Point Options
              Column(
                children: PainPoint.values.map((painPoint) => 
                  _buildPainPointOption(painPoint)
                ).toList(),
              ),
              
              const Spacer(),

              // El botón ahora es manejado por OnboardingScreen
              // Se deja un espacio para mantener la consistencia del layout
              const SizedBox(height: 96),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPainPointOption(PainPoint painPoint) {
    final isSelected = _selectedPainPoint == painPoint;
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _selectPainPoint(painPoint),
          borderRadius: BorderRadius.circular(16),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isSelected 
                  ? Colors.white.withOpacity(0.2)
                  : Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected 
                    ? Colors.white.withOpacity(0.6)
                    : Colors.white.withOpacity(0.2),
                width: 2,
              ),
            ),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected 
                        ? Colors.white 
                        : Colors.transparent,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.8),
                      width: 2,
                    ),
                  ),
                  child: isSelected 
                      ? const Icon(
                          Icons.check,
                          size: 16,
                          color: OnboardingTheme.textPrimary,
                        )
                      : null,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    painPoint.label,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.95),
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
