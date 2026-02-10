import 'package:flutter/material.dart';
import '../l10n/generated/strings.g.dart';

/// Botón selector de parent wallet basado en wallet_form.html
/// 
/// HTML Reference:
/// ```html
/// <button onclick="window.location.href='wallet_dialog_parent.html'" class="form-input w-full rounded-lg border-slate-300 bg-slate-50 text-slate-900 h-14 px-4 text-base font-normal leading-normal flex items-center justify-between">
///   <div class="flex items-center gap-3">
///     <div class="flex items-center justify-center h-8 w-8 rounded-full bg-slate-100 text-slate-500">
///       <span class="material-symbols-outlined text-sm">account_balance_wallet</span>
///     </div>
///     <span class="text-slate-500">Select parent wallet</span>
///   </div>
///   <span class="material-symbols-outlined text-slate-400">expand_more</span>
/// </button>
/// ```
class ParentWalletSelectorButton extends StatelessWidget {
  const ParentWalletSelectorButton({
    Key? key,
    required this.label,
    this.selectedWalletName,
    required this.onPressed,
    this.enabled = true,
  }) : super(key: key);

  final String label;
  final String? selectedWalletName;
  final VoidCallback onPressed;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final hasSelection = selectedWalletName != null;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Container with floating label exactly like HTML
        Stack(
          clipBehavior: Clip.none, // ✅ AGREGADO: Permitir que el label sobresalga
          children: [
            // Button content
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: enabled ? onPressed : null,
                borderRadius: BorderRadius.circular(8), // HTML: rounded-lg
                child: Container(
                  width: double.infinity,
                  height: 56, // HTML: h-14
                  padding: const EdgeInsets.symmetric(horizontal: 16), // HTML: px-4
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC), // HTML: bg-slate-50
                    borderRadius: BorderRadius.circular(8), // HTML: rounded-lg
                    border: Border.all(
                      color: const Color(0xFFCBD5E1), // HTML: border-slate-300
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      // Wallet icon and text
                      Expanded(
                        child: Row(
                          children: [
                            // Wallet icon circle
                            Container(
                              width: 32, // HTML: h-8 w-8
                              height: 32,
                              decoration: BoxDecoration(
                                color: hasSelection 
                                    ? const Color(0xFFDBEAFE) // bg-blue-100 cuando está seleccionado
                                    : const Color(0xFFF1F5F9), // HTML: bg-slate-100 por defecto
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.account_balance_wallet, // HTML: account_balance_wallet
                                color: hasSelection
                                    ? const Color(0xFF2563EB) // text-blue-600 cuando está seleccionado
                                    : const Color(0xFF64748B), // HTML: text-slate-500 por defecto
                                size: 16, // HTML: text-sm
                              ),
                            ),
                            
                            const SizedBox(width: 12), // HTML: gap-3
                            
                            // Wallet name or placeholder
                            Expanded(
                              child: Text(
                                selectedWalletName ?? t.components.parentWalletSelection.title,
                                style: TextStyle(
                                  fontSize: 16, // HTML: text-base
                                  fontWeight: FontWeight.normal, // HTML: font-normal
                                  color: hasSelection
                                      ? const Color(0xFF0F172A) // text-slate-900 cuando está seleccionado
                                      : const Color(0xFF64748B), // HTML: text-slate-500 por defecto
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Expand icon
                      Icon(
                        Icons.expand_more, // HTML: expand_more
                        color: const Color(0xFF94A3B8), // HTML: text-slate-400
                        size: 24,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            // ✅ CORREGIDO: Floating label con peso tipográfico exacto al text field
            Positioned(
              left: 12, // HTML: left-3
              top: -10, // ✅ CORREGIDO: Subido más para mejor visibilidad
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4), // HTML: px-1
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC), // HTML: bg-slate-50
                  borderRadius: BorderRadius.circular(2), // ✅ AGREGADO: Bordes redondeados
                ),
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12, // HTML: text-xs
                    color: Color(0xFF64748B), // HTML: text-slate-500
                    fontWeight: FontWeight.normal, // ✅ CORREGIDO: Peso normal exacto igual que AppFloatingLabelField
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
