import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../l10n/generated/strings.g.dart';

/// Header de saludo personalizado basado en dashboard_main.html
///
/// HTML Reference:
/// ```html
/// <div class="flex items-center gap-3">
///   <button class="flex items-center justify-center h-10 w-10 rounded-full bg-blue-100 text-blue-600">
///     <span class="material-symbols-outlined">menu</span>
///   </button>
///   <div>
///     <h1 class="text-slate-900 text-lg font-semibold">Good morning, Alex</h1>
///     <p class="text-slate-500 text-sm">December 16, 2024</p>
///   </div>
/// </div>
/// ```
class GreetingHeader extends StatelessWidget {
  const GreetingHeader({
    Key? key,
    required this.onMenuPressed,
    required this.onStarPressed,
    this.isPremium = false, // ✅ AGREGADO: Estado de suscripción
  }) : super(key: key);

  final VoidCallback onMenuPressed;
  final VoidCallback onStarPressed;
  final bool isPremium;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12), // HTML: p-4 pb-3
      child: Row(
        children: [
          // Menu button + greeting
          Expanded(
            child: Row(
              children: [
                // Menu button
                Material(
                  color: const Color(0xFFDBEAFE), // HTML: bg-blue-100
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    onTap: onMenuPressed,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 40, // HTML: h-10 w-10
                      height: 40,
                      child: const Icon(
                        Icons.menu,
                        color: Color(0xFF2563EB), // HTML: text-blue-600
                        size: 24,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12), // HTML: gap-3

                // Greeting text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.dashboard.greeting,
                        style: const TextStyle(
                          fontSize: 18, // HTML: text-lg
                          fontWeight: FontWeight.w600, // HTML: font-semibold
                          color: Color(0xFF0F172A), // HTML: text-slate-900
                        ),
                      ),
                      Text(
                        _getCurrentDate(),
                        style: const TextStyle(
                          fontSize: 14, // HTML: text-sm
                          color: Color(0xFF64748B), // HTML: text-slate-500
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Action buttons
          Row(
            children: [
              // Star button
              Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  onTap: onStarPressed,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                     width: 40,
                     height: 40,
                     alignment: Alignment.center,
                     child: isPremium
                         ? const Icon(
                             Icons.star,
                             color: Color(0xFFEAB308), // amber-500 filled
                             size: 28,
                           )
                         : const Icon(
                             Icons.star_border_rounded, // border with rounded corners looks better
                             color: Color(0xFFEAB308), // amber-500 outline
                             size: 28,
                           ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Obtiene la fecha actual formateada
  String _getCurrentDate() {
    final now = DateTime.now();
    final formatter = DateFormat('MMMM d, yyyy', 'en_US');
    return formatter.format(now);
  }
}
