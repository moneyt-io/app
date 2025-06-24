import 'package:flutter/material.dart';
import 'dart:ui';

/// Header personalizado para formularios con close button y título centrado
/// 
/// HTML Reference:
/// ```html
/// <header class="sticky top-0 z-10 bg-slate-50/80 backdrop-blur-md">
///   <div class="flex items-center p-4 pb-3">
///     <button class="text-slate-700 p-2 -ml-2">
///       <span class="material-symbols-outlined text-2xl">close</span>
///     </button>
///     <h1 class="text-slate-900 text-xl font-semibold leading-tight tracking-tight flex-1 text-center pr-8">New credit card</h1>
///   </div>
/// </header>
/// ```
class FormHeader extends StatelessWidget implements PreferredSizeWidget {
  const FormHeader({
    Key? key,
    required this.title,
    required this.onClose,
  }) : super(key: key);

  final String title;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Container(
      // HTML: sticky top-0 z-10 bg-slate-50/80 backdrop-blur-md
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC).withOpacity(0.8), // HTML: bg-slate-50/80
      ),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0), // HTML: backdrop-blur-md
          child: SafeArea(
            bottom: false,
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12), // HTML: p-4 pb-3
              child: Row(
                children: [
                  // Close button
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: onClose,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.all(8), // HTML: p-2
                        margin: const EdgeInsets.only(left: -8), // HTML: -ml-2
                        child: const Icon(
                          Icons.close, // HTML: material-symbols-outlined close
                          color: Color(0xFF374151), // HTML: text-slate-700
                          size: 24, // HTML: text-2xl
                        ),
                      ),
                    ),
                  ),
                  
                  // Título centrado
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 32), // HTML: pr-8 para compensar el botón
                      child: Text(
                        title,
                        textAlign: TextAlign.center, // HTML: text-center
                        style: const TextStyle(
                          fontSize: 20, // HTML: text-xl
                          fontWeight: FontWeight.w600, // HTML: font-semibold
                          color: Color(0xFF0F172A), // HTML: text-slate-900
                          height: 1.25, // HTML: leading-tight
                          letterSpacing: -0.025, // HTML: tracking-tight
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

  @override
  Size get preferredSize => const Size.fromHeight(80); // Altura aproximada con SafeArea
}
