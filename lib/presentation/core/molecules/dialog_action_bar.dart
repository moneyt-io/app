import 'package:flutter/material.dart';
import '../atoms/app_button.dart';

/// Action bar específico para diálogos basado en FormActionBar
/// 
/// HTML Reference:
/// ```html
/// <div class="p-4 border-t border-slate-200">
///   <div class="flex gap-3">
///     <button class="flex-1 bg-slate-200 text-slate-700">Cancel</button>
///     <button class="flex-1 bg-[#0c7ff2] text-slate-50">Select</button>
///   </div>
/// </div>
/// ```
class DialogActionBar extends StatelessWidget {
  const DialogActionBar({
    Key? key,
    required this.onCancel,
    required this.onConfirm,
    this.cancelText = 'Cancel',
    this.confirmText = 'Confirm',
    this.isLoading = false,
    this.enabled = true,
  }) : super(key: key);

  final VoidCallback onCancel;
  final VoidCallback onConfirm;
  final String cancelText;
  final String confirmText;
  final bool isLoading;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12), // ✅ CORREGIDO: px-4 py-3 igual que FormActionBar
      decoration: const BoxDecoration(
        // ✅ CORRECTO: Sin fondo como en el HTML del diálogo
        border: Border(
          top: BorderSide(
            color: Color(0xFFE2E8F0), // HTML: border-slate-200
          ),
        ),
      ),
      child: Row(
        children: [
          // ✅ CORREGIDO: Usar estilos exactos del HTML del diálogo
          Expanded(
            child: Container(
              height: 48, // HTML: h-12
              child: OutlinedButton(
                onPressed: enabled ? onCancel : null,
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xFFE2E8F0), // HTML: bg-slate-200
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24), // HTML: rounded-full
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20), // HTML: px-5
                  minimumSize: const Size(84, 48), // HTML: min-w-[84px] h-12
                ),
                child: Text(
                  cancelText,
                  style: const TextStyle(
                    fontSize: 14, // HTML: text-sm
                    fontWeight: FontWeight.w500, // HTML: font-medium
                    color: Color(0xFF334155), // HTML: text-slate-700
                    letterSpacing: -0.3, // HTML: tracking-tight
                    height: 1.4, // HTML: leading-normal
                  ),
                ),
              ),
            ),
          ),
          
          const SizedBox(width: 12), // HTML: gap-3
          
          Expanded(
            child: Container(
              height: 48, // HTML: h-12
              child: ElevatedButton(
                onPressed: enabled && !isLoading ? onConfirm : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0c7ff2), // HTML: bg-[#0c7ff2]
                  elevation: 2, // HTML: shadow-sm
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24), // HTML: rounded-full
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20), // HTML: px-5
                  minimumSize: const Size(84, 48), // HTML: min-w-[84px] h-12
                ),
                child: Text(
                  isLoading ? 'Loading...' : confirmText,
                  style: const TextStyle(
                    fontSize: 14, // HTML: text-sm
                    fontWeight: FontWeight.w500, // HTML: font-medium
                    color: Color(0xFFF1F5F9), // HTML: text-slate-50
                    letterSpacing: -0.3, // HTML: tracking-tight
                    height: 1.4, // HTML: leading-normal
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
