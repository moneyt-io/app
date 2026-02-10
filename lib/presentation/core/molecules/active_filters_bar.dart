import 'package:flutter/material.dart';
import '../l10n/generated/strings.g.dart';

class ActiveFilter {
  final String key;
  final String label;
  final IconData icon;
  final Color color;

  ActiveFilter({
    required this.key,
    required this.label,
    required this.icon,
    required this.color,
  });
}

class ActiveFiltersBar extends StatelessWidget {
  final List<ActiveFilter> activeFilters;
  final VoidCallback onAddFilter;
  final Function(String) onRemoveFilter;
  final bool showAddButton;

  const ActiveFiltersBar({
    Key? key,
    required this.activeFilters,
    required this.onAddFilter,
    required this.onRemoveFilter,
    this.showAddButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ...activeFilters.map((filter) => _buildFilterPill(filter)),
          if (showAddButton) _buildAddFilterButton(),
        ],
      ),
    );
  }

  Widget _buildFilterPill(ActiveFilter filter) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: filter.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(filter.icon, size: 14, color: filter.color),
          const SizedBox(width: 6),
          Text(
            filter.label,
            style: TextStyle(
              color: filter.color,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 4),
          InkWell(
            onTap: () => onRemoveFilter(filter.key),
            child: Icon(Icons.close, size: 14, color: filter.color),
          ),
        ],
      ),
    );
  }

  Widget _buildAddFilterButton() {
    return TextButton.icon(
      onPressed: onAddFilter,
      icon: const Icon(Icons.add, size: 16),
      label: Text(t.transactions.filter.add),
      style: TextButton.styleFrom(
        foregroundColor: Colors.grey[600],
        textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        padding: const EdgeInsets.symmetric(horizontal: 8),
      ),
    );
  }
}
