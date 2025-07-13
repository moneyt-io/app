import 'package:flutter/material.dart';
import '../design_system/theme/app_dimensions.dart';

class FilterChipGroup<T> extends StatelessWidget {
  final T selectedValue;
  final Map<T, String> filters;
  final Map<T, IconData> icons; // Añadido para los iconos
  final ValueChanged<T> onFilterChanged;

  const FilterChipGroup({
    Key? key,
    required this.selectedValue,
    required this.filters,
    required this.icons,
    required this.onFilterChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 40, // HTML: h-10
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: filters.entries.map((entry) {
          final value = entry.key;
          final label = entry.value;
          final icon = icons[value];
          final isSelected = value == selectedValue;

          // Colors from transaction_list.html mockup
          final activeBgColor = const Color(0xFF3B82F6).withOpacity(0.1); // bg-blue-500/10
          final activeFgColor = const Color(0xFF1D4ED8); // text-blue-700
          final activeBorderColor = const Color(0xFFBFDBFE); // border-blue-200

          final inactiveBgColor = const Color(0xFFF1F5F9); // bg-slate-100
          final inactiveFgColor = const Color(0xFF475569); // text-slate-600
          final inactiveBorderColor = const Color(0xFFE2E8F0); // border-slate-200

          return Padding(
            padding: const EdgeInsets.only(right: AppDimensions.spacing8), // HTML: gap-2
            child: OutlinedButton.icon(
              onPressed: () => onFilterChanged(value),
              icon: Icon(icon, size: 18), // HTML: text-lg
              label: Text(label),
              style: OutlinedButton.styleFrom(
                backgroundColor: isSelected ? activeBgColor : inactiveBgColor,
                foregroundColor: isSelected ? activeFgColor : inactiveFgColor,
                side: BorderSide(
                  color: isSelected ? activeBorderColor : inactiveBorderColor,
                  width: 1,
                ),
                shape: const StadiumBorder(), // HTML: rounded-full
                padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spacing16), // HTML: px-4
                textStyle: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w500, // HTML: font-medium
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
