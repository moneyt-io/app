/// Material Design 3 Spacing and Dimension Tokens
/// Define el sistema de espaciado y dimensiones siguiendo M3 guidelines
class AppDimensions {
  AppDimensions._();

  // --- Spacing Scale (8dp base unit) ---
  static const double spacing2 = 2.0;   // 0.25x
  static const double spacing4 = 4.0;   // 0.5x
  static const double spacing8 = 8.0;   // 1x base
  static const double spacing12 = 12.0; // 1.5x
  static const double spacing16 = 16.0; // 2x
  static const double spacing20 = 20.0; // 2.5x
  static const double spacing24 = 24.0; // 3x
  static const double spacing32 = 32.0; // 4x
  static const double spacing40 = 40.0; // 5x
  static const double spacing48 = 48.0; // 6x
  static const double spacing56 = 56.0; // 7x
  static const double spacing64 = 64.0; // 8x

  // --- Border Radius ---
  static const double radiusXSmall = 4.0;
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusXLarge = 24.0;
  static const double radiusCircular = 50.0;

  // --- Icon Sizes ---
  static const double iconSizeSmall = 16.0;
  static const double iconSizeMedium = 24.0;
  static const double iconSizeLarge = 32.0;
  static const double iconSizeXLarge = 48.0;

  // --- Component Heights ---
  static const double buttonHeightSmall = 32.0;
  static const double buttonHeightMedium = 40.0;
  static const double buttonHeightLarge = 48.0;
  static const double buttonHeightXLarge = 56.0;

  static const double textFieldHeight = 56.0;
  static const double listItemHeightDefault = 56.0; // RENOMBRADO: altura por defecto
  static const double appBarHeight = 64.0;

  // --- Elevation (Material 3) ---
  static const double elevation0 = 0.0;
  static const double elevation1 = 1.0;
  static const double elevation2 = 2.0;
  static const double elevation3 = 3.0;
  static const double elevation4 = 8.0;
  static const double elevation5 = 12.0;
  static const double elevation6 = 16.0; // Elevación alta para cards prominentes

  // --- Breakpoints para Responsive Design ---
  static const double breakpointCompact = 600.0;    // Phone
  static const double breakpointMedium = 840.0;     // Tablet
  static const double breakpointExpanded = 1200.0;  // Desktop

  // --- Layout Constraints ---
  static const double maxContentWidth = 1200.0;
  static const double minTouchTarget = 48.0;

  // --- Aspect Ratios ---
  static const double aspectRatioSquare = 1.0;
  static const double aspectRatioCard = 16 / 9;
  static const double aspectRatioAvatar = 1.0;

  // --- Animation Durations ---
  static const Duration animationDurationShort = Duration(milliseconds: 150);
  static const Duration animationDurationMedium = Duration(milliseconds: 300);
  static const Duration animationDurationLong = Duration(milliseconds: 500);

  // --- Dimensiones específicas del diseño de contactos ---
  
  /// Avatar sizes (match del diseño HTML)
  static const double avatarSizeSmall = 32.0;
  static const double avatarSizeMedium = 48.0;    // Tamaño principal del diseño
  static const double avatarSizeLarge = 64.0;
  
  /// FAB dimensions (match del diseño HTML)
  static const double fabSize = 64.0;             // 64x64px del diseño
  static const double fabIconSize = 32.0;         // Ícono interno
  static const double fabBorderRadius = 16.0;    // rounded-2xl
  
  /// Search field dimensions
  static const double searchFieldHeight = 48.0;   // Altura específica del diseño
  static const double searchIconSize = 24.0;      // Ícono de búsqueda
  
  /// Contact list dimensions (específico para contactos)
  static const double contactListItemHeight = 72.0;    // RENOMBRADO: altura específica contactos
  static const double contactListItemPaddingV = 12.0;  // RENOMBRADO: padding vertical
  static const double contactListItemPaddingH = 16.0;  // RENOMBRADO: padding horizontal
  
  /// Contact info spacing
  static const double contactInfoSpacing = 4.0;   // Entre nombre y info secundaria
  static const double contactItemSpacing = 16.0;  // Entre avatar y texto
}
