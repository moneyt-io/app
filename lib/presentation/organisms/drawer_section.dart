import 'package:flutter/material.dart';
import '../molecules/drawer_list_item.dart';

class DrawerSection extends StatelessWidget {
  final String title;
  final List<DrawerItemData> items;
  final String? currentRoute;
  final Function(String route, Map<String, dynamic>? arguments) onNavigate;
  
  const DrawerSection({
    Key? key,
    required this.title,
    required this.items,
    this.currentRoute,
    required this.onNavigate,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: textTheme.titleSmall?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...items.map((item) {
          final isSelected = currentRoute == item.route;
          return DrawerListItem(
            icon: item.icon,
            selectedIcon: item.selectedIcon,
            label: item.label,
            isSelected: isSelected,
            onTap: () => onNavigate(item.route, item.arguments),
          );
        }),
      ],
    );
  }
}

class DrawerItemData {
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final String route;
  final Map<String, dynamic>? arguments;

  const DrawerItemData({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.route,
    this.arguments,
  });
}
