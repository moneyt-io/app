import 'package:flutter/material.dart';

/// Header estándar para widgets del dashboard basado en dashboard_main.html
/// 
/// HTML Reference:
/// ```html
/// <div class="flex items-center justify-between p-4 border-b border-slate-100">
///   <div class="flex items-center gap-3">
///     <div class="flex items-center justify-center h-10 w-10 rounded-full bg-blue-100 text-blue-600">
///       <span class="material-symbols-outlined">account_balance_wallet</span>
///     </div>
///     <div>
///       <h3 class="text-slate-800 text-base font-semibold">Wallets</h3>
///       <p class="text-slate-500 text-sm">5 accounts</p>
///     </div>
///   </div>
///   <span class="material-symbols-outlined text-slate-400">chevron_right</span>
/// </div>
/// ```
class WidgetCardHeader extends StatelessWidget {
  const WidgetCardHeader({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.iconColor = const Color(0xFF2563EB), // Default blue
    this.iconBackgroundColor = const Color(0xFFDBEAFE), // Default blue-100
    this.showChevron = true,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color iconColor;
  final Color iconBackgroundColor;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16), // HTML: p-4
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color(0xFFF1F5F9), // HTML: border-slate-100
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              // Icon + text section
              Expanded(
                child: Row(
                  children: [
                    // Icon container
                    Container(
                      width: 40, // HTML: h-10 w-10
                      height: 40,
                      decoration: BoxDecoration(
                        color: iconBackgroundColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        icon,
                        color: iconColor,
                        size: 24,
                      ),
                    ),
                    
                    const SizedBox(width: 12), // HTML: gap-3
                    
                    // Text section
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 16, // HTML: text-base
                              fontWeight: FontWeight.w600, // HTML: font-semibold
                              color: Color(0xFF1E293B), // HTML: text-slate-800
                            ),
                          ),
                          Text(
                            subtitle,
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
              
              // Chevron icon
              if (showChevron)
                const Icon(
                  Icons.chevron_right,
                  color: Color(0xFF94A3B8), // HTML: text-slate-400
                  size: 24,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
