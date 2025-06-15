import 'package:flutter/material.dart';
import '../design_system/tokens/app_dimensions.dart';
import '../design_system/tokens/app_colors.dart';

/// Tamaños disponibles para el avatar
enum AppAvatarSize {
  small,   // 32px
  medium,  // 48px - Principal del diseño
  large,   // 64px
}

/// Avatar component que sigue el diseño HTML
/// 
/// Ejemplo de uso:
/// ```dart
/// AppAvatar(
///   name: 'John Doe',
///   imageUrl: 'https://example.com/avatar.jpg',
///   size: AppAvatarSize.medium,
/// )
/// ```
class AppAvatar extends StatelessWidget {
  const AppAvatar({
    Key? key,
    required this.name,
    this.imageUrl,
    this.size = AppAvatarSize.medium,
    this.backgroundColor,
    this.textColor,
    this.onTap,
  }) : super(key: key);

  /// Nombre para mostrar inicial como fallback
  final String name;
  
  /// URL de la imagen (opcional)
  final String? imageUrl;
  
  /// Tamaño del avatar
  final AppAvatarSize size;
  
  /// Color de fondo personalizado
  final Color? backgroundColor;
  
  /// Color del texto personalizado
  final Color? textColor;
  
  /// Callback cuando se toca el avatar
  final VoidCallback? onTap;

  /// Obtiene el tamaño numérico según el enum
  double get _avatarSize {
    switch (size) {
      case AppAvatarSize.small:
        return AppDimensions.avatarSizeSmall;
      case AppAvatarSize.medium:
        return AppDimensions.avatarSizeMedium;
      case AppAvatarSize.large:
        return AppDimensions.avatarSizeLarge;
    }
  }

  /// Obtiene el tamaño del texto según el tamaño del avatar
  double get _textSize {
    switch (size) {
      case AppAvatarSize.small:
        return 14.0;
      case AppAvatarSize.medium:
        return 18.0;
      case AppAvatarSize.large:
        return 24.0;
    }
  }

  /// Obtiene la inicial del nombre
  String get _initial {
    if (name.isEmpty) return '?';
    return name.trim()[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    Widget avatar = Container(
      width: _avatarSize,
      height: _avatarSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor ?? colorScheme.primaryContainer,
        image: imageUrl?.isNotEmpty == true
            ? DecorationImage(
                image: NetworkImage(imageUrl!),
                fit: BoxFit.cover,
                onError: (_, __) {
                  // Si falla la imagen, mostrará el fallback automáticamente
                },
              )
            : null,
      ),
      child: imageUrl?.isNotEmpty != true
          ? Center(
              child: Text(
                _initial,
                style: TextStyle(
                  fontSize: _textSize,
                  fontWeight: FontWeight.w600,
                  color: textColor ?? colorScheme.onPrimaryContainer,
                ),
              ),
            )
          : null,
    );

    if (onTap != null) {
      avatar = InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(_avatarSize / 2),
        child: avatar,
      );
    }

    return avatar;
  }
}
