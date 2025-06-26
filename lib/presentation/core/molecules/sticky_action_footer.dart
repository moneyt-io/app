import 'package:flutter/material.dart';
import 'dart:ui';
import '../atoms/app_button.dart';

/// Footer pegajoso con acciones que replica el diseño HTML
/// 
/// HTML Reference:
/// ```html
/// <footer class="sticky bottom-0 bg-slate-50/80 backdrop-blur-md px-4 py-3 border-t border-slate-200">
///   <button class="w-full ... bg-[#0c7ff2] ...">Save Changes</button>
/// </footer>
/// ```
class StickyActionFooter extends StatelessWidget {
  const StickyActionFooter({
    Key? key,
    required this.primaryText,
    required this.onPrimaryPressed,
    this.secondaryText,
    this.onSecondaryPressed,
    this.isLoading = false,
    this.isPrimaryEnabled = true,
  }) : super(key: key);

  final String primaryText;
  final VoidCallback onPrimaryPressed;
  final String? secondaryText;
  final VoidCallback? onSecondaryPressed;
  final bool isLoading;
  final bool isPrimaryEnabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC).withOpacity(0.8), // HTML: bg-slate-50/80
        border: const Border(
          top: BorderSide(
            color: Color(0xFFE2E8F0), // HTML: border-slate-200
            width: 1,
          ),
        ),
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12), // HTML: backdrop-blur-md
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(16), // HTML: px-4 py-3
              child: secondaryText != null
                  ? Row(
                      children: [
                        // Secondary button
                        if (onSecondaryPressed != null)
                          Expanded(
                            child: AppButton(
                              text: secondaryText!,
                              onPressed: onSecondaryPressed,
                              type: AppButtonType.outlined,
                              isFullWidth: true,
                            ),
                          ),
                        
                        if (onSecondaryPressed != null)
                          const SizedBox(width: 12),
                        
                        // Primary button
                        Expanded(
                          child: AppButton(
                            text: primaryText,
                            onPressed: isPrimaryEnabled ? onPrimaryPressed : null,
                            type: AppButtonType.filled,
                            isLoading: isLoading,
                            isFullWidth: true,
                          ),
                        ),
                      ],
                    )
                  : AppButton(
                      text: primaryText,
                      onPressed: isPrimaryEnabled ? onPrimaryPressed : null,
                      type: AppButtonType.filled,
                      isLoading: isLoading,
                      isFullWidth: true,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
