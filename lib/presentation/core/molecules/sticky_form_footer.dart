import 'package:flutter/material.dart';
import 'dart:ui'; // ✅ AGREGADO: Import para ImageFilter y BackdropFilter
import '../atoms/app_button.dart';

/// Footer sticky para formularios con botones Cancel/Save
/// 
/// HTML Reference:
/// ```html
/// <footer class="sticky bottom-0 bg-slate-50/80 backdrop-blur-md px-4 py-3 border-t border-slate-200">
///   <div class="flex gap-3">
///     <button class="flex-1 rounded-full h-12 px-5 bg-slate-200 text-slate-700">Cancel</button>
///     <button class="flex-1 rounded-full h-12 px-5 bg-[#0c7ff2] text-slate-50">Save</button>
///   </div>
/// </footer>
/// ```
class StickyFormFooter extends StatelessWidget {
  const StickyFormFooter({
    Key? key,
    required this.onCancel,
    required this.onSave,
    this.cancelText = 'Cancel',
    this.saveText = 'Save',
    this.isLoading = false,
    this.isSaveEnabled = true,
  }) : super(key: key);

  final VoidCallback onCancel;
  final VoidCallback onSave;
  final String cancelText;
  final String saveText;
  final bool isLoading;
  final bool isSaveEnabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      // HTML: sticky bottom-0 bg-slate-50/80 backdrop-blur-md border-t border-slate-200
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC).withOpacity(0.8), // HTML: bg-slate-50/80
        border: const Border(
          top: BorderSide(
            color: Color(0xFFE2E8F0), // HTML: border-slate-200
          ),
        ),
      ),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0), // HTML: backdrop-blur-md
          child: Container(
            padding: const EdgeInsets.all(16), // HTML: px-4 py-3
            child: Row(
              children: [
                // Cancel button - ✅ CORREGIDO: Usar Container para altura y estilo personalizado
                Expanded(
                  child: Container(
                    height: 48, // HTML: h-12
                    child: ElevatedButton(
                      onPressed: isLoading ? null : onCancel,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE2E8F0), // HTML: bg-slate-200
                        foregroundColor: const Color(0xFF374151), // HTML: text-slate-700
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24), // HTML: rounded-full
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        cancelText,
                        style: const TextStyle(
                          fontSize: 14, // HTML: text-sm
                          fontWeight: FontWeight.w500, // HTML: font-medium
                          letterSpacing: -0.025, // HTML: tracking-tight
                        ),
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(width: 12), // HTML: gap-3
                
                // Save button - ✅ CORREGIDO: Usar Container para altura y estilo personalizado
                Expanded(
                  child: Container(
                    height: 48, // HTML: h-12
                    child: ElevatedButton(
                      onPressed: (isLoading || !isSaveEnabled) ? null : onSave,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0c7ff2), // HTML: bg-[#0c7ff2]
                        foregroundColor: const Color(0xFFF8FAFC), // HTML: text-slate-50
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24), // HTML: rounded-full
                        ),
                        elevation: 2, // HTML: shadow-sm
                      ),
                      child: isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text(
                              saveText,
                              style: const TextStyle(
                                fontSize: 14, // HTML: text-sm
                                fontWeight: FontWeight.w500, // HTML: font-medium
                                letterSpacing: -0.025, // HTML: tracking-tight
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
    );
  }
}
