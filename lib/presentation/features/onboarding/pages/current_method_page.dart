import 'package:flutter/material.dart';
import '../theme/onboarding_theme.dart';
import '../widgets/animated_feature_icon.dart';
import '../widgets/staggered_text_animation.dart';
import '../../../core/l10n/generated/strings.g.dart';

enum CurrentMethod {
  excel,
  notebook,
  none;

  String get label {
    switch (this) {
      case CurrentMethod.excel:
        return t.onboarding.currentMethod.options.excel;
      case CurrentMethod.notebook:
        return t.onboarding.currentMethod.options.notebook;
      case CurrentMethod.none:
        return t.onboarding.currentMethod.options.none;
    }
  }
}

class CurrentMethodPage extends StatefulWidget {
  const CurrentMethodPage({
    Key? key,
    required this.isButtonEnabled,
  }) : super(key: key);

  final ValueNotifier<bool> isButtonEnabled;

  @override
  State<CurrentMethodPage> createState() => _CurrentMethodPageState();
}

class _CurrentMethodPageState extends State<CurrentMethodPage>
    with AutomaticKeepAliveClientMixin {
  CurrentMethod? _selectedMethod;

  void _selectMethod(CurrentMethod method) {
    setState(() {
      _selectedMethod = method;
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
          colors: OnboardingTheme.gradients['trust']!,
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
                icon: Icons.edit_note,
                backgroundColor: Colors.white.withOpacity(0.2),
                iconColor: Colors.white,
                size: 100,
                animationDelay: const Duration(milliseconds: 200),
              ),

              const SizedBox(height: OnboardingTheme.spacing48),

              // Question
              StaggeredTextAnimation(
                text: t.onboarding.currentMethod.title,
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
                text: t.onboarding.currentMethod.subtitle,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight
                      .w400, // ✅ AGREGADO: Ligeramente más pesado que normal
                  letterSpacing: 0.3, // ✅ AGREGADO: Espaciado entre letras
                  color: Colors.white, // ✅ CAMBIADO: Opacidad máxima
                  height: 1.4, // ✅ CAMBIADO: Espaciado más compacto
                  shadows: [
                    // ✅ AGREGADO: Sombra sutil para profundidad
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

              // Method Options
              Column(
                children: CurrentMethod.values
                    .map((method) => _buildMethodOption(method))
                    .toList(),
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

  Widget _buildMethodOption(CurrentMethod method) {
    final isSelected = _selectedMethod == method;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _selectMethod(method),
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
                    color: isSelected ? Colors.white : Colors.transparent,
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
                    method.label,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.95),
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
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
