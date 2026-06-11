import 'package:flutter/material.dart';
import '../l10n/generated/strings.g.dart';

/// Selector de íconos para categorías y wallets.
///
/// HTML Reference:
/// ```html
/// <div class="grid grid-cols-6 gap-3">
///   <button class="flex items-center justify-center h-12 w-12 rounded-xl bg-blue-100 text-blue-600 border-2 border-blue-300">
/// ```
class CategoryIconPicker extends StatelessWidget {
  const CategoryIconPicker({
    Key? key,
    required this.selectedIcon,
    required this.onIconSelected,
    this.selectedColor = const Color(0xFF3B82F6),
  }) : super(key: key);

  final IconData selectedIcon;
  final ValueChanged<IconData> onIconSelected;
  final Color selectedColor;

  /// Lista completa de iconos disponibles (categorías + wallets).
  ///
  /// Es `const` — todos los elementos son constantes de compilación.
  /// Esto garantiza compatibilidad con el tree-shaker en release builds.
  static const List<IconData> categoryIcons = [
    // Categorías de ingresos/gastos
    Icons.work,
    Icons.business,
    Icons.laptop_mac,
    Icons.trending_up,
    Icons.home,
    Icons.restaurant,
    Icons.local_gas_station,
    Icons.shopping_cart,
    Icons.medical_services,
    Icons.school,
    Icons.directions_car,
    Icons.flight,
    Icons.movie,
    Icons.fitness_center,
    Icons.pets,
    Icons.child_care,
    Icons.phone,
    Icons.bolt,
    Icons.water_drop,
    Icons.wifi,
    Icons.credit_card,
    Icons.savings,
    Icons.account_balance,
    Icons.calculate,
    // Wallets / cuentas
    Icons.account_balance_wallet,
    Icons.payments,
    Icons.wallet,
    Icons.attach_money,
    Icons.currency_exchange,
  ];

  /// Convierte un codePoint guardado en DB (String decimal o hex) al [IconData]
  /// correspondiente de la lista [categoryIcons].
  ///
  /// **Compatible con release builds**: nunca construye [IconData] dinámicamente
  /// (lo que rompería el tree-shaking de icon fonts). En cambio, busca en la
  /// lista `const` por codePoint.
  ///
  /// Si el codePoint no está en la lista, devuelve [fallback]
  /// (por defecto `Icons.account_balance_wallet`).
  ///
  /// Uso:
  /// ```dart
  /// Icon(CategoryIconPicker.fromCode(wallet.icon))
  /// Icon(CategoryIconPicker.fromCode(category.icon, fallback: Icons.category))
  /// ```
  static IconData fromCode(
    String? code, {
    IconData fallback = Icons.account_balance_wallet,
  }) {
    if (code == null || code.isEmpty) return fallback;
    // Intentar decimal primero (formato que guarda wallet_form_screen),
    // luego hex (formato que usaba category_list_view con radix: 16).
    final parsed = int.tryParse(code) ?? int.tryParse(code, radix: 16);
    if (parsed == null) return fallback;
    return categoryIcons.firstWhere(
      (icon) => icon.codePoint == parsed,
      orElse: () => fallback,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.categories.form.selectIcon,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF374151), // HTML: text-gray-700
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE5E7EB)), // HTML: border-gray-200
          ),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6, // HTML: grid-cols-6
              mainAxisSpacing: 12, // HTML: gap-3
              crossAxisSpacing: 12,
              childAspectRatio: 1,
            ),
            itemCount: categoryIcons.length,
            itemBuilder: (context, index) {
              final icon = categoryIcons[index];
              final isSelected = icon == selectedIcon;

              return Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => onIconSelected(icon),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    height: 48, // HTML: h-12
                    width: 48, // HTML: w-12
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12), // HTML: rounded-xl
                      color: isSelected
                          ? selectedColor.withValues(alpha: 0.1)
                          : const Color(0xFFF9FAFB), // HTML: bg-gray-50
                      border: Border.all(
                        width: 2,
                        color: isSelected
                            ? selectedColor.withValues(alpha: 0.3)
                            : const Color(0xFFE5E7EB), // HTML: border-gray-200
                      ),
                    ),
                    child: Icon(
                      icon,
                      color: isSelected
                          ? selectedColor
                          : const Color(0xFF6B7280), // HTML: text-gray-500
                      size: 24,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
