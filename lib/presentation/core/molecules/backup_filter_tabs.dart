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

    // ✅ CORREGIDO: Cambiar SingleChildScrollView por Row con alineación a la izquierda
    return Row(
      mainAxisAlignment: MainAxisAlignment.start, // ✅ AGREGADO: Alinear a la izquierda
      children: filters.map((filter) {
        final isSelected = selectedFilter == filter['name'];
        
        return Padding(
          padding: const EdgeInsets.only(right: 8), // HTML: gap-2
          child: SizedBox(
            height: 40, // HTML: h-10
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => onFilterChanged(filter['name'] as String),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16), // HTML: px-4
                  decoration: BoxDecoration(
                    color: isSelected 
                        ? const Color(0x1A3B82F6) // HTML: bg-blue-500/10
                        : const Color(0xFFF1F5F9), // HTML: bg-slate-100
                    borderRadius: BorderRadius.circular(20), // HTML: rounded-full
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF93C5FD) // HTML: border-blue-200
                          : const Color(0xFFE2E8F0), // HTML: border-slate-200
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        filter['icon'] as IconData,
                        size: 16, // HTML: text-sm
                        color: isSelected
                            ? const Color(0xFF1D4ED8) // HTML: text-blue-700
                            : const Color(0xFF475569), // HTML: text-slate-600
                      ),
                      const SizedBox(width: 8), // HTML: mr-2
                      Text(
                        filter['name'] as String,
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
          ),
        );
      }).toList(),
    );
  }
}
