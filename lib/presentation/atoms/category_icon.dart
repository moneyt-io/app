import 'package:flutter/material.dart';

class CategoryIcon extends StatelessWidget {
  final String icon;
  final Color bgColor;
  final Color iconColor;
  final double size;

  const CategoryIcon({
    Key? key,
    required this.icon,
    required this.bgColor,
    required this.iconColor,
    this.size = 40,
  }) : super(key: key);

  IconData _getIconData() {
    // Mapa de nombres de iconos a datos de iconos reales
    final iconMap = {
      'food': Icons.restaurant,
      'transport': Icons.directions_car,
      'entertainment': Icons.movie,
      'health': Icons.medical_services,
      'salary': Icons.payments,
      'investment': Icons.trending_up,
      'shopping': Icons.shopping_bag,
      'home': Icons.home,
      'utilities': Icons.lightbulb,
      'education': Icons.school,
      'gift': Icons.card_giftcard,
      'travel': Icons.flight,
    };

    return iconMap[icon] ?? Icons.category;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(size / 4),
      ),
      child: Icon(
        _getIconData(),
        color: iconColor,
        size: size / 2,
      ),
    );
  }
}
