import 'package:flutter/material.dart';

/// Item de configuración basado en settings.html
/// 
/// HTML Reference:
/// ```html
/// <button class="flex items-center gap-4 w-full px-3 py-3 hover:bg-slate-50 rounded-lg">
///   <div class="flex items-center justify-center h-10 w-10 rounded-full bg-blue-100 text-blue-600">
///     <span class="material-symbols-outlined">person</span>
///   </div>
/// </button>
/// ```
class SettingsItem extends StatelessWidget {
  const SettingsItem({
    Key? key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.backgroundColor,
    this.iconColor,
    this.isDestructive = false,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? iconColor;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final effectiveBackgroundColor = backgroundColor ?? 
        (isDestructive ? const Color(0xFFFEE2E2) : const Color(0xFFDBEAFE)); // HTML: bg-red-100 / bg-blue-100
    
    final effectiveIconColor = iconColor ?? 
        (isDestructive ? const Color(0xFFDC2626) : const Color(0xFF2563EB)); // HTML: text-red-600 / text-blue-600

    final titleColor = isDestructive 
        ? const Color(0xFFDC2626) // HTML: text-red-600
        : const Color(0xFF1E293B); // HTML: text-slate-800

    final subtitleColor = isDestructive
        ? const Color(0xFFEF4444) // HTML: text-red-500
        : const Color(0xFF64748B); // HTML: text-slate-500

    final hoverColor = isDestructive
        ? const Color(0xFFFEF2F2) // HTML: hover:bg-red-50
        : const Color(0xFFF8FAFC); // HTML: hover:bg-slate-50

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8), // HTML: rounded-lg
        splashColor: hoverColor,
        child: Container(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 12), // HTML: px-3 py-3
          child: Row(
            children: [
              // Icon
              Container(
                width: 40, // HTML: h-10 w-10
                height: 40,
                decoration: BoxDecoration(
                  color: effectiveBackgroundColor,
                  shape: BoxShape.circle, // HTML: rounded-full
                ),
                child: Icon(
                  icon,
                  color: effectiveIconColor,
                  size: 24,
                ),
              ),
              
              const SizedBox(width: 16), // HTML: gap-4
              
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16, // HTML: text-base
                        fontWeight: FontWeight.w500, // HTML: font-medium
                        color: titleColor,
                      ),
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle!,
                        style: TextStyle(
                          fontSize: 14, // HTML: text-sm
                          color: subtitleColor,
                        ),
                      ),
                  ],
                ),
              ),
              
              // Trailing widget
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ),
    );
  }
}
