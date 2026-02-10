import 'package:flutter/material.dart';
import '../../../domain/entities/category.dart';
import '../design_system/tokens/app_colors.dart';
import '../l10n/generated/strings.g.dart';

/// Opciones disponibles en el diálogo de categoría
enum CategoryOption {
  edit,
  duplicate,
  viewTransactions,
  delete,
}

/// Bottom sheet dialog que muestra opciones para una categoría específica
/// Basado en category_dialog_options.html
class CategoryOptionsDialog extends StatelessWidget {
  const CategoryOptionsDialog({
    Key? key,
    required this.category,
    required this.onOptionSelected,
  }) : super(key: key);

  final Category category;
  final Function(CategoryOption) onOptionSelected;

  /// Método estático para mostrar el diálogo
  static Future<void> show({
    required BuildContext context,
    required Category category,
    required Function(CategoryOption) onOptionSelected,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.3), // HTML: bg-black/30
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => CategoryOptionsDialog(
        category: category,
        onOptionSelected: onOptionSelected,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16), // HTML: rounded-t-2xl
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000), // HTML: shadow-lg
            blurRadius: 10,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: double.infinity,
            height: 24, // HTML: h-6
            padding: const EdgeInsets.symmetric(vertical: 8), // HTML: py-2
            child: Center(
              child: Container(
                width: 40, // HTML: w-10
                height: 6, // HTML: h-1.5
                decoration: BoxDecoration(
                  color: const Color(0xFFCBD5E1), // HTML: bg-slate-300
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),

          // Category Header
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12), // HTML: px-4 py-3
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFF1F5F9), // HTML: border-slate-100
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                // Category Icon
                Container(
                  width: 40, // HTML: h-10 w-10
                  height: 40,
                  decoration: BoxDecoration(
                    color: _getCategoryBackgroundColor(),
                    shape: BoxShape.circle, // HTML: rounded-full
                  ),
                  child: Icon(
                    _getCategoryIcon(),
                    color: _getCategoryIconColor(),
                    size: 20,
                  ),
                ),
                
                const SizedBox(width: 12), // HTML: gap-3
                
                // Category Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category.name,
                        style: const TextStyle(
                          fontSize: 16, // HTML: text-base
                          fontWeight: FontWeight.w600, // HTML: font-semibold
                          color: Color(0xFF1E293B), // HTML: text-slate-800
                        ),
                      ),
                      Text(
                        '${_getCategoryTypeText()} category',
                        style: const TextStyle(
                          fontSize: 14, // HTML: text-sm
                          color: Color(0xFF64748B), // HTML: text-slate-500
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Options List
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8), // HTML: px-2 pb-2
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildOptionItem(
                  icon: Icons.edit,
                  title: 'Edit category',
                  subtitle: 'Modify name, type or icon',
                  onTap: () => _handleOptionTap(context, CategoryOption.edit),
                ),
                _buildOptionItem(
                  icon: Icons.content_copy,
                  title: 'Duplicate category',
                  subtitle: 'Create a copy of this category',
                  onTap: () => _handleOptionTap(context, CategoryOption.duplicate),
                ),
                _buildOptionItem(
                  icon: Icons.visibility,
                  title: 'View transactions',
                  subtitle: 'See all transactions in this category',
                  onTap: () => _handleOptionTap(context, CategoryOption.viewTransactions),
                ),
                
                // Divider
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8), // HTML: my-2
                  child: Divider(
                    color: Color(0xFFE2E8F0), // HTML: border-slate-200
                    height: 1,
                  ),
                ),
                
                _buildOptionItem(
                  icon: Icons.delete,
                  title: 'Delete category',
                  subtitle: 'This action cannot be undone',
                  onTap: () => _handleOptionTap(context, CategoryOption.delete),
                  isDestructive: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Construye item de opción en la lista
  Widget _buildOptionItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    final iconColor = isDestructive 
        ? const Color(0xFFDC2626) // HTML: text-red-600
        : const Color(0xFF334155); // HTML: text-slate-700

    final titleColor = isDestructive 
        ? const Color(0xFFDC2626) // HTML: text-red-600
        : const Color(0xFF1E293B); // HTML: text-slate-800

    final subtitleColor = isDestructive 
        ? const Color(0xFFEF4444) // HTML: text-red-500
        : const Color(0xFF64748B); // HTML: text-slate-500

    final hoverColor = isDestructive
        ? const Color(0xFFFEF2F2) // HTML: hover:bg-red-50
        : const Color(0xFFF1F5F9); // HTML: hover:bg-slate-100

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8), // HTML: rounded-lg
        splashColor: hoverColor,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12), // HTML: px-4 py-3
          child: Row(
            children: [
              Icon(
                icon,
                size: 24,
                color: iconColor,
              ),
              const SizedBox(width: 16), // HTML: gap-4
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16, // HTML: text-base
                        fontWeight: FontWeight.w500, // HTML: font-medium
                        color: titleColor,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14, // HTML: text-sm
                        color: subtitleColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Maneja el tap en una opción y cierra el diálogo
  void _handleOptionTap(BuildContext context, CategoryOption option) {
    Navigator.of(context).pop();
    onOptionSelected(option);
  }

  /// Obtiene el ícono de la categoría
  IconData _getCategoryIcon() {
    switch (category.name.toLowerCase()) {
      case 'salary':
        return Icons.work;
      case 'business':
        return Icons.business;
      case 'investment':
        return Icons.trending_up;
      case 'food':
      case 'food & dining':
        return Icons.restaurant;
      case 'housing':
        return Icons.home;
      case 'transportation':
        return Icons.directions_car;
      default:
        return Icons.category;
    }
  }

  /// Obtiene el color del ícono según el tipo de categoría
  Color _getCategoryIconColor() {
    if (category.documentTypeId == 'I') {
      return const Color(0xFF16A34A); // HTML: text-green-600
    } else {
      return const Color(0xFFDC2626); // HTML: text-red-600
    }
  }

  /// Obtiene el color de fondo según el tipo de categoría
  Color _getCategoryBackgroundColor() {
    if (category.documentTypeId == 'I') {
      return const Color(0xFFDCFCE7); // HTML: bg-green-100
    } else {
      return const Color(0xFFFEE2E2); // HTML: bg-red-100
    }
  }

  /// Obtiene el texto del tipo de categoría
  String _getCategoryTypeText() {
    return category.documentTypeId == 'I' 
        ? t.transactions.types.income 
        : t.transactions.types.expense;
  }
}
