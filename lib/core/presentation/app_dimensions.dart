/// CLASE DEFINITIVA PARA DIMENSIONES - NO MODIFICAR SIN REVISAR TODOS LOS USOS
/// 
/// Esta clase contiene TODAS las dimensiones utilizadas en la aplicación.
/// Incluye aliases para mantener compatibilidad con código existente.
class AppDimensions {
  // ==================== ESPACIADO ====================
  static const double spacing2 = 2.0;
  static const double spacing4 = 4.0;
  static const double spacing8 = 8.0;
  static const double spacing12 = 12.0;
  static const double spacing16 = 16.0;
  static const double spacing20 = 20.0;
  static const double spacing24 = 24.0;
  static const double spacing32 = 32.0;
  static const double spacing40 = 40.0; // AGREGADO
  static const double spacing48 = 48.0;
  static const double spacing64 = 64.0;
  
  // ==================== BORDES Y RADIOS ====================
  static const double borderRadius = 8.0;
  static const double borderRadiusSmall = 4.0;
  static const double borderRadiusLarge = 12.0;
  static const double borderRadiusXLarge = 16.0;
  
  // Aliases para compatibilidad
  static const double radiusSmall = borderRadiusSmall;
  static const double radiusMedium = borderRadius;
  static const double radiusLarge = borderRadiusLarge;
  static const double radiusXLarge = borderRadiusXLarge;
  
  // Anchos de bordes
  static const double borderWidth = 1.0;
  static const double borderWidthThin = 0.5;
  static const double borderWidthThick = 2.0;
  
  // Aliases para compatibilidad
  static const double cardBorderWidth = borderWidth;
  
  // ==================== ELEVACIONES ====================
  static const double elevation1 = 1.0;
  static const double elevation2 = 2.0;
  static const double elevation4 = 4.0;
  static const double elevation8 = 8.0;
  static const double elevation16 = 16.0;
  
  // Aliases para compatibilidad
  static const double elevationLow = elevation1;
  static const double elevationMedium = elevation4;
  static const double elevationHigh = elevation8;
  
  // ==================== TAMAÑOS DE ICONOS ====================
  static const double iconSmall = 16.0;
  static const double iconMedium = 24.0;
  static const double iconLarge = 32.0;
  static const double iconXLarge = 48.0;
  
  // Aliases para compatibilidad
  static const double iconSizeSmall = iconSmall;
  static const double iconSizeMedium = iconMedium;
  static const double iconSizeLarge = iconLarge;
  static const double iconSizeXLarge = iconXLarge;
  
  // ==================== ALTURAS ESTÁNDAR ====================
  static const double buttonHeight = 48.0;
  static const double buttonHeightSmall = 32.0;
  static const double buttonHeightLarge = 56.0;
  static const double inputHeight = 56.0;
  static const double listItemHeight = 72.0;
  static const double listItemHeightCompact = 56.0;
  
  // ==================== TAMAÑOS DE AVATARES ====================
  static const double avatarSizeSmall = 32.0;
  static const double avatarSize = 40.0;
  static const double avatarSizeMedium = 48.0;
  static const double avatarSizeLarge = 56.0;
  static const double avatarSizeXLarge = 72.0;
  
  // ==================== ANCHOS ESTÁNDAR ====================
  static const double maxContentWidth = 600.0;
  static const double minButtonWidth = 120.0;
  static const double fabSize = 56.0;
  
  // ==================== ALTURAS DE COMPONENTES ====================
  static const double appBarHeight = 56.0;
  static const double tabBarHeight = 48.0;
  static const double bottomNavHeight = 80.0;
  static const double cardMinHeight = 120.0;
  
  // ==================== PADDING Y MARGIN ESTÁNDAR ====================
  static const double paddingSmall = spacing8;
  static const double paddingMedium = spacing16;
  static const double paddingLarge = spacing24;
  static const double paddingXLarge = spacing32;
  
  static const double marginSmall = spacing8;
  static const double marginMedium = spacing16;
  static const double marginLarge = spacing24;
  static const double marginXLarge = spacing32;
  
  // ==================== PROPIEDADES ESPECÍFICAS DE COMPONENTES ====================
  // Para dialogs
  static const double dialogPadding = spacing24;
  static const double dialogRadius = borderRadiusLarge;
  
  // Para cards
  static const double cardPadding = spacing16;
  static const double cardRadius = borderRadius;
  static const double cardElevation = elevation2;
  
  // Para formularios
  static const double formSpacing = spacing16;
  static const double fieldSpacing = spacing12;
  
  // Para listas
  static const double listPadding = spacing16;
  static const double listItemPadding = spacing12;
  
  // ==================== BREAKPOINTS RESPONSIVOS ====================
  static const double mobileBreakpoint = 600.0;
  static const double tabletBreakpoint = 1024.0;
  static const double desktopBreakpoint = 1440.0;
}
