import 'package:flutter/material.dart';
import '../l10n/generated/strings.g.dart';

/// Tipos de acciones rápidas disponibles
enum QuickActionType {
  expense,
  income,
  transfer,
  all,
}

/// Botón de acción rápida basado en dashboard_main.html
/// 
/// HTML Reference:
/// ```html
/// <button class="flex flex-col items-center gap-2 p-4 rounded-xl bg-red-50 text-red-600 hover:bg-red-100 widget-card">
///   <span class="material-symbols-outlined text-2xl">trending_down</span>
///   <span class="text-xs font-medium">Expense</span>
/// </button>
/// ```
class QuickActionButton extends StatelessWidget {
  const QuickActionButton({
    Key? key,
    required this.type,
    required this.onPressed,
  }) : super(key: key);

  final QuickActionType type;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _getBackgroundColor(),
      borderRadius: BorderRadius.circular(12), // HTML: rounded-xl
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        splashColor: _getHoverColor(),
        child: Container(
          padding: const EdgeInsets.all(16), // HTML: p-4
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _getIcon(),
                size: 32, // HTML: text-2xl
                color: _getIconColor(),
              ),
              const SizedBox(height: 8), // HTML: gap-2
              Text(
                _getLabel(),
                style: TextStyle(
                  fontSize: 12, // HTML: text-xs
                  fontWeight: FontWeight.w500, // HTML: font-medium
                  color: _getTextColor(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Obtiene el color de fondo según el tipo
  Color _getBackgroundColor() {
    switch (type) {
      case QuickActionType.expense:
        return const Color(0xFFFEF2F2); // HTML: bg-red-50
      case QuickActionType.income:
        return const Color(0xFFF0FDF4); // HTML: bg-green-50
      case QuickActionType.transfer:
        return const Color(0xFFEFF6FF); // HTML: bg-blue-50
      case QuickActionType.all:
        return const Color(0xFFF1F5F9); // HTML: bg-slate-100
    }
  }

  /// Obtiene el color de hover según el tipo
  Color _getHoverColor() {
    switch (type) {
      case QuickActionType.expense:
        return const Color(0xFFFEE2E2); // HTML: hover:bg-red-100
      case QuickActionType.income:
        return const Color(0xFFDCFCE7); // HTML: hover:bg-green-100
      case QuickActionType.transfer:
        return const Color(0xFFDBEAFE); // HTML: hover:bg-blue-100
      case QuickActionType.all:
        return const Color(0xFFE2E8F0); // HTML: hover:bg-slate-200
    }
  }

  /// Obtiene el ícono según el tipo
  IconData _getIcon() {
    switch (type) {
      case QuickActionType.expense:
        return Icons.trending_down;
      case QuickActionType.income:
        return Icons.trending_up;
      case QuickActionType.transfer:
        return Icons.swap_horiz;
      case QuickActionType.all:
        return Icons.receipt_long;
    }
  }

  /// Obtiene el color del ícono según el tipo
  Color _getIconColor() {
    switch (type) {
      case QuickActionType.expense:
        return const Color(0xFFDC2626); // HTML: text-red-600
      case QuickActionType.income:
        return const Color(0xFF16A34A); // HTML: text-green-600
      case QuickActionType.transfer:
        return const Color(0xFF2563EB); // HTML: text-blue-600
      case QuickActionType.all:
        return const Color(0xFF475569); // HTML: text-slate-600
    }
  }

  /// Obtiene el color del texto según el tipo
  Color _getTextColor() {
    return _getIconColor(); // Mismo color que el ícono
  }

  /// Obtiene el label según el tipo
  String _getLabel() {
    switch (type) {
      case QuickActionType.expense:
        return t.dashboard.actions.expense;
      case QuickActionType.income:
        return t.dashboard.actions.income;
      case QuickActionType.transfer:
        return t.dashboard.actions.transfer;
      case QuickActionType.all:
        return t.dashboard.actions.all;
    }
  }
}
