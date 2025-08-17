import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../design_system/tokens/app_dimensions.dart';
import '../design_system/tokens/app_colors.dart';

/// Data class for an action in the ExpandableFab.
class FabAction {
  const FabAction({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.backgroundColor,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final Color? backgroundColor;
}

/// An expandable Floating Action Button that displays multiple actions in a modern,
/// animated fashion. It features a blurred overlay, staggered animations, and
/// haptic feedback for a premium user experience.
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
  final _layerLink = LayerLink();
  late AnimationController _controller;
  late Animation<double> _expandAnimation;
  bool _isExpanded = false;
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      value: 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _overlayEntry?.remove();
    super.dispose();
  }

  void _toggleExpansion() {
    HapticFeedback.lightImpact();
    if (_isExpanded) {
      _close();
    } else {
      _open();
    }
  }

  void _open() {
    setState(() => _isExpanded = true);
    _controller.forward();
    _overlayEntry = _buildOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!); 
  }

  void _close() {
    setState(() => _isExpanded = false);
    _controller.reverse().whenComplete(() {
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: SizedBox(
        width: AppDimensions.fabSize,
        height: AppDimensions.fabSize,
        child: FloatingActionButton(
          elevation: 6.0,
          backgroundColor: AppColors.primaryBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.fabBorderRadius),
          ),
          child: RotationTransition(
            turns: Tween<double>(begin: 0.0, end: 0.125).animate(_expandAnimation),
            child: const Icon(Icons.add, color: Colors.white, size: AppDimensions.fabIconSize),
          ),
          onPressed: _toggleExpansion,
        ),
      ),
    );
  }

  OverlayEntry _buildOverlayEntry() {
    return OverlayEntry(
      builder: (context) {
        return GestureDetector(
          onTap: _close,
          behavior: HitTestBehavior.translucent,
          child: Stack(
            children: [
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                  child: Container(
                    color: Colors.black.withOpacity(0.25),
                  ),
                ),
              ),
              CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                targetAnchor: Alignment.topRight,
                followerAnchor: Alignment.bottomRight,
                offset: const Offset(0, -12.0),
                child: Material(
                  color: Colors.transparent,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: _buildActionItems(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildActionItems() {
    final children = <Widget>[];
    final count = widget.actions.length;
    const step = 0.5 / 3; // Distribute animation over the first half

    for (var i = 0; i < count; i++) {
      final action = widget.actions[i];
      final animation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(i * step, 1.0, curve: Curves.easeOutCubic),
        ),
      );

      children.add(
        FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.5),
              end: Offset.zero,
            ).animate(animation),
            child: _ActionButton(
              action: action,
              onPressed: () {
                HapticFeedback.lightImpact();
                _close();
                action.onPressed();
              },
            ),
          ),
        ),
      );
    }
    return children;
  }
}

/// A private widget to represent a single action button in the ExpandableFab.
class _ActionButton extends StatelessWidget {
  const _ActionButton({
    Key? key,
    required this.action,
    required this.onPressed,
  }) : super(key: key);

  final FabAction action;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    final chipColor = isLight ? Colors.white : theme.colorScheme.surface;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0, right: 4.0),
      child: Material(
        shape: const StadiumBorder(),
        clipBehavior: Clip.antiAlias,
        color: chipColor,
        elevation: 4.0,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  action.label,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 12),
                Icon(action.icon, size: 20, color: action.backgroundColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
