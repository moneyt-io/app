import 'package:flutter/material.dart';

/// A custom selector button widget that mimics the appearance of a text field
/// with a floating label, providing a consistent UI for selection fields.
///
/// This widget is designed to be a reusable component for all selector fields
/// across the app, such as date, account, or category selectors, ensuring
/// they share the same visual style as the `AppFloatingLabelField`.
///
/// It displays a label that floats above the selector's border, a selected
/// value, an optional leading icon, and a trailing dropdown arrow.
class AppFloatingLabelSelector extends StatelessWidget {
  final String label;
  final String value;
  final IconData? icon;
  final VoidCallback onTap;
  final bool enabled;
  final bool hasValue;
  final Color? iconColor;
  final Color? iconBackgroundColor;

  const AppFloatingLabelSelector({
    Key? key,
    required this.label,
    required this.value,
    this.icon,
    required this.onTap,
    this.enabled = true,
    this.hasValue = true,
    this.iconColor,
    this.iconBackgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: enabled ? onTap : null,
            borderRadius: BorderRadius.circular(8), // HTML: rounded-lg
            child: Container(
              width: double.infinity,
              height: 56, // HTML: h-14, consistent height
              padding: const EdgeInsets.symmetric(horizontal: 16), // HTML: px-4
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC), // HTML: bg-slate-50
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFFCBD5E1), // HTML: border-slate-300
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  if (icon != null)
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: iconBackgroundColor ?? Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        icon,
                        color: iconColor ??
                            const Color(0xFF94A3B8), // Default to slate-400
                        size: 20,
                      ),
                    ),
                  if (icon != null) const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      value,
                      style: TextStyle(
                        fontSize: 16, // HTML: text-base
                        fontWeight: FontWeight.w500,
                        color: hasValue
                            ? const Color(0xFF0F172A) // text-slate-900
                            : const Color(0xFF64748B), // text-slate-500
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(
                    Icons.expand_more,
                    color: Color(0xFF94A3B8), // HTML: text-slate-400
                  ),
                ],
              ),
            ),
          ),
        ),
        // Floating Label
        Positioned(
          top: -8,
          left: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            color: const Color(0xFFF8FAFC), // Match background to hide border
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xFF64748B), // HTML: text-slate-500
              ),
            ),
          ),
        ),
      ],
    );
  }
}
