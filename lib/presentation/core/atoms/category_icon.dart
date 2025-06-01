import 'package:flutter/material.dart';
import '../theme/app_dimensions.dart';

/// Átomo que representa el icono de una categoría.
///
/// Este componente muestra un icono dentro de un contenedor circular
/// con colores personalizables.
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
    this.size = AppDimensions.iconMedium, // CORREGIDO
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Convertir el string del icono a IconData
    IconData iconData;
    try {
      // Intentar parsear el string como un código de icono
      iconData = IconData(
        int.parse(icon, radix: 16),
        fontFamily: 'MaterialIcons',
      );
    } catch (e) {
      // Si falla, usar un icono predeterminado
      iconData = Icons.category;
    }
    
    return Container(
      width: AppDimensions.avatarSize,
      height: AppDimensions.avatarSize,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
      ),
      child: Icon(
        iconData,
        color: iconColor,
        size: size,
      ),
    );
  }
}
