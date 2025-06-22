import 'package:flutter/material.dart';
import 'dart:ui';
import '../design_system/tokens/app_dimensions.dart';
import '../design_system/tokens/app_colors.dart';
import '../l10n/l10n_helper.dart';

/// Barra de acciones para formularios (Cancel/Save)
/// 
/// Replica exactamente el diseño del footer de la maqueta HTML
/// con botones rounded-full y backdrop blur
/// 
/// Ejemplo de uso:
/// ```dart
/// FormActionBar(
///   onCancel: () => Navigator.pop(context),
///   onSave: () => _saveForm(),
///   isLoading: _isLoading,
/// )
/// ```
class FormActionBar extends StatelessWidget {
  const FormActionBar({
    Key? key,
    required this.onCancel,
    required this.onSave,
    this.cancelText,
    this.saveText,
    this.isLoading = false,
    this.enabled = true,
  }) : super(key: key);

  final VoidCallback onCancel;
  final VoidCallback onSave;
  final String? cancelText;
  final String? saveText;
  final bool isLoading;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.slate50.withOpacity(0.8), // bg-slate-50/80
        border: Border(
          top: BorderSide(
            color: AppColors.slate200, // border-slate-200
            width: 1,
          ),
        ),
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12), // backdrop-blur-md
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12), // px-4 py-3
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  // Cancel button - replica exacta del HTML
                  Expanded(
                    child: Container(
                      height: 48, // h-12
                      child: Material(
                        color: AppColors.slate200, // bg-slate-200
                        borderRadius: BorderRadius.circular(24), // rounded-full
                        child: InkWell(
                          onTap: enabled ? onCancel : null,
                          borderRadius: BorderRadius.circular(24),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20), // px-5
                            child: Center(
                              child: Text(
                                cancelText ?? t.common.cancel,
                                style: const TextStyle(
                                  color: Color(0xFF334155), // text-slate-700
                                  fontSize: 14, // text-sm
                                  fontWeight: FontWeight.w500, // font-medium
                                  letterSpacing: -0.025, // tracking-tight
                                ),
                                overflow: TextOverflow.ellipsis, // truncate
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: 12), // gap-3
                  
                  // Save button - replica exacta del HTML
                  Expanded(
                    child: Container(
                      height: 48, // h-12
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24), // rounded-full
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x0F000000), // shadow-sm
                            blurRadius: 2,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Material(
                        color: const Color(0xFF0c7ff2), // bg-[#0c7ff2]
                        borderRadius: BorderRadius.circular(24), // rounded-full
                        child: InkWell(
                          onTap: enabled ? onSave : null,
                          borderRadius: BorderRadius.circular(24),
                          overlayColor: MaterialStateProperty.all(
                            const Color(0xFF2563EB).withOpacity(0.1), // hover:bg-blue-600 effect
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20), // px-5
                            child: Center(
                              child: isLoading
                                  ? const SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                          Color(0xFFF8FAFC), // text-slate-50
                                        ),
                                      ),
                                    )
                                  : Text(
                                      saveText ?? t.common.save,
                                      style: const TextStyle(
                                        color: Color(0xFFF8FAFC), // text-slate-50
                                        fontSize: 14, // text-sm
                                        fontWeight: FontWeight.w500, // font-medium
                                        letterSpacing: -0.025, // tracking-tight
                                      ),
                                      overflow: TextOverflow.ellipsis, // truncate
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
