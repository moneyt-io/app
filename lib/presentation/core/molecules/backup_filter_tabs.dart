import 'package:flutter/material.dart';

/// Tabs de filtro para backups basado en backup_list.html
/// 
/// HTML Reference:
/// ```html
/// <div class="flex gap-2 overflow-x-auto">
///   <button class="flex-shrink-0 h-10 px-4 rounded-full bg-blue-500/10 text-blue-700 border border-blue-200 text-sm font-medium active">
/// ```
class BackupFilterTabs extends StatelessWidget {
  const BackupFilterTabs({
    Key? key,
    required this.selectedFilter,
    required this.onFilterChanged,
  }) : super(key: key);

  final String selectedFilter;
  final ValueChanged<String> onFilterChanged;

  @override
  Widget build(BuildContext context) {
    final filters = [
      {'name': 'All', 'icon': Icons.backup},
      {'name': 'Auto', 'icon': Icons.schedule},
      {'name': 'Manual', 'icon': Icons.touch_app},
    ];

    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: filters.map((filter) {
          final isSelected = selectedFilter == filter['name'];
          
          return Padding(
            padding: const EdgeInsets.only(right: 8), // Consistent spacing
            child: OutlinedButton.icon(
              onPressed: () => onFilterChanged(filter['name'] as String),
              icon: Icon(filter['icon'] as IconData, size: 18),
              label: Text(filter['name'] as String),
              style: OutlinedButton.styleFrom(
                backgroundColor: isSelected ? const Color(0x1A3B82F6) : const Color(0xFFF1F5F9),
                foregroundColor: isSelected ? const Color(0xFF1D4ED8) : const Color(0xFF475569),
                side: BorderSide(
                  color: isSelected ? const Color(0xFF93C5FD) : const Color(0xFFE2E8F0),
                  width: 1,
                ),
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
