import 'package:flutter/material.dart';

class DrawerListItem extends StatelessWidget {
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  
  const DrawerListItem({
    Key? key,
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    
    return ListTile(
      leading: Icon(
        isSelected ? selectedIcon : icon,
        color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
      ),
      title: Text(
        label,
        style: textTheme.bodyLarge?.copyWith(
          color: isSelected ? colorScheme.primary : colorScheme.onSurface,
          fontWeight: isSelected ? FontWeight.bold : null,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
      selected: isSelected,
      selectedTileColor: colorScheme.primaryContainer.withOpacity(0.3),
      onTap: onTap,
    );
  }
}
