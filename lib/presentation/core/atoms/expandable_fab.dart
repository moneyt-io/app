import 'package:flutter/material.dart';
import '../design_system/tokens/app_dimensions.dart';
import '../design_system/tokens/app_colors.dart';

/// Acción del FAB expandible
class FabAction {
  const FabAction({
    required this.icon,
    required this.label,
    required this.onPressed,
    required this.backgroundColor,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;
}

/// FAB expandible que usa el mismo estilo visual que AppFloatingActionButton
/// Solo se diferencia en que puede expandir múltiples acciones
/// 
/// HTML Reference:
/// ```html
/// <div class="fixed bottom-6 right-6 z-50">
///   <div id="fab-actions" class="hidden flex flex-col items-end gap-3 mb-3">
///     <!-- Action buttons with labels -->
///   </div>
///   <button id="main-fab" class="flex items-center justify-center rounded-2xl h-16 w-16 bg-[#0c7ff2]">
///     <span id="fab-icon" class="material-symbols-outlined text-3xl">add</span>
///   </button>
/// </div>
/// ```
class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    Key? key,
    required this.actions,
  }) : super(key: key);

  final List<FabAction> actions;

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isExpanded = false;
  OverlayEntry? _overlayEntry; // ✅ AGREGADO: Overlay entry para pantalla completa

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _overlayEntry?.remove(); // ✅ AGREGADO: Limpiar overlay
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    if (_isExpanded) {
      _closeExpansion();
    } else {
      _showExpansion();
    }
  }

  void _showExpansion() {
    setState(() {
      _isExpanded = true;
    });
    _animationController.forward();
    
    // ✅ CORREGIDO: Crear overlay que ocupa toda la pantalla pero los action buttons van por encima
    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Overlay de fondo
          GestureDetector(
            onTap: _closeExpansion,
            child: Container(
              color: Colors.black.withOpacity(0.2), // HTML: bg-black/20
            ),
          ),
          
          // ✅ CORREGIDO: Action buttons alineados con el centro del FAB principal
          Positioned(
            bottom: 16, // Mismo padding que el FAB
            right: 16 + (AppDimensions.fabSize / 2) - 24, // ✅ CENTRADO: right edge del FAB - mitad del action button (48/2 = 24)
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center, // ✅ CENTRADO: Cambiar a center
              children: [
                // Action buttons animados
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animation.value,
                      child: Opacity(
                        opacity: _animation.value,
                        child: _isExpanded ? _buildActionButtons() : const SizedBox.shrink(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                // Espacio para el FAB principal (que se renderiza separadamente)
                SizedBox(
                  width: AppDimensions.fabSize,
                  height: AppDimensions.fabSize,
                ),
              ],
            ),
          ),
        ],
      ),
    );
    
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _closeExpansion() {
    if (_isExpanded) {
      setState(() {
        _isExpanded = false;
      });
      _animationController.reverse();
      
      // ✅ AGREGADO: Remover overlay
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Main FAB
        Container(
          width: AppDimensions.fabSize,
          height: AppDimensions.fabSize,
          decoration: BoxDecoration(
            color: AppColors.primaryBlue,
            borderRadius: BorderRadius.circular(AppDimensions.fabBorderRadius),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(AppDimensions.fabBorderRadius),
            child: InkWell(
              onTap: _toggleExpansion,
              borderRadius: BorderRadius.circular(AppDimensions.fabBorderRadius),
              splashColor: const Color(0xFF1D4ED8).withOpacity(0.3),
              child: Center(
                // ✅ SOLUCION: Usar Transform.rotate en lugar de AnimatedRotation
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _animation.value * 0.785398, // 45 grados en radianes (π/4)
                      child: Icon(
                        Icons.add, // ✅ SIEMPRE usar el mismo ícono +
                        size: AppDimensions.fabIconSize,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: widget.actions.map((action) => _buildActionButton(action)).toList(),
    );
  }

  Widget _buildActionButton(FabAction action) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12), // HTML: gap-3
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ✅ CORREGIDO: Label tooltip con mejor aislamiento visual
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), // HTML: px-3 py-2
            decoration: BoxDecoration(
              color: Colors.black87, // ✅ CAMBIADO: Usar color más sólido sin opacity
              borderRadius: BorderRadius.circular(8), // HTML: rounded-lg
              boxShadow: const [
                // ✅ AGREGADO: Sombra para separar del overlay
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              action.label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14, // HTML: text-sm
                fontWeight: FontWeight.w500, // HTML: font-medium
                decoration: TextDecoration.none, // ✅ AGREGADO: Asegurar que no haya decoración
              ),
            ),
          ),

          const SizedBox(width: 12), // HTML: gap-3

          // Action button
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: action.backgroundColor,
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              shape: const CircleBorder(),
              child: InkWell(
                onTap: () {
                  _closeExpansion();
                  action.onPressed();
                },
                customBorder: const CircleBorder(),
                splashColor: Colors.white.withOpacity(0.2), // ✅ AGREGADO: Efecto de splash sutil
                child: Center(
                  child: Icon(
                    action.icon,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
