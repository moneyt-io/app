import 'package:flutter/material.dart';

/// Botón de filtro estilo chip con ícono y texto
/// 
/// HTML Reference:
/// ```html
/// <button class="flex-shrink-0 h-10 px-4 rounded-full bg-blue-500/10 text-blue-700 border border-blue-200 text-sm font-medium active">
///   <span class="material-symbols-outlined text-lg mr-2">credit_card</span>
///   All
/// </button>
/// ```
class FilterChipButton extends StatelessWidget {
  const FilterChipButton({
    Key? key,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40, // HTML: h-10
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(20), // HTML: rounded-full
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16), // HTML: px-4
            decoration: BoxDecoration(
              color: isSelected 
                  ? const Color(0xFF3B82F6).withOpacity(0.1) // HTML: bg-blue-500/10
                  : const Color(0xFFF1F5F9), // HTML: bg-slate-100
              border: Border.all(
                color: isSelected 
                    ? const Color(0xFFBFDBFE) // HTML: border-blue-200
                    : const Color(0xFFE2E8F0), // HTML: border-slate-200
              ),
              borderRadius: BorderRadius.circular(20), // HTML: rounded-full
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 18, // HTML: text-lg
                  color: isSelected 
                      ? const Color(0xFF1D4ED8) // HTML: text-blue-700
                      : const Color(0xFF475569), // HTML: text-slate-600
                ),
                const SizedBox(width: 8), // HTML: mr-2
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14, // HTML: text-sm
                    fontWeight: FontWeight.w500, // HTML: font-medium
                    color: isSelected 
                        ? const Color(0xFF1D4ED8) // HTML: text-blue-700
                        : const Color(0xFF475569), // HTML: text-slate-600
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
