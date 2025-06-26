import 'package:flutter/material.dart';
import '../atoms/quick_action_button.dart';

/// Grid de acciones rápidas basado en dashboard_main.html
/// 
/// HTML Reference:
/// ```html
/// <div class="grid grid-cols-4 gap-3">
///   <button class="flex flex-col items-center gap-2 p-4 rounded-xl bg-red-50 text-red-600 hover:bg-red-100 widget-card">
/// ```
class QuickActionsGrid extends StatelessWidget {
  const QuickActionsGrid({
    Key? key,
    required this.onExpensePressed,
    required this.onIncomePressed,
    required this.onTransferPressed,
    required this.onAllPressed,
  }) : super(key: key);

  final VoidCallback onExpensePressed;
  final VoidCallback onIncomePressed;
  final VoidCallback onTransferPressed;
  final VoidCallback onAllPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16), // HTML: px-4
      child: Row(
        children: [
          // Expense
          Expanded(
            child: QuickActionButton(
              type: QuickActionType.expense,
              onPressed: onExpensePressed,
            ),
          ),
          
          const SizedBox(width: 12), // HTML: gap-3
          
          // Income
          Expanded(
            child: QuickActionButton(
              type: QuickActionType.income,
              onPressed: onIncomePressed,
            ),
          ),
          
          const SizedBox(width: 12), // HTML: gap-3
          
          // Transfer
          Expanded(
            child: QuickActionButton(
              type: QuickActionType.transfer,
              onPressed: onTransferPressed,
            ),
          ),
          
          const SizedBox(width: 12), // HTML: gap-3
          
          // All
          Expanded(
            child: QuickActionButton(
              type: QuickActionType.all,
              onPressed: onAllPressed,
            ),
          ),
        ],
      ),
    );
  }
}
