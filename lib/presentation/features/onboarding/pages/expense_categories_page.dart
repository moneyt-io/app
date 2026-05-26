import 'package:flutter/material.dart';
import '../../../core/l10n/generated/strings.g.dart';

enum ExpenseCategory {
  diningOut('comer_fuera'),
  cravings('antojos'),
  subscriptions('suscripciones'),
  outings('salidas'),
  shopping('compras'),
  delivery('domicilios');

  const ExpenseCategory(this.key);
  final String key;
}

class ExpenseCategoriesPage extends StatelessWidget {
  final List<ExpenseCategory> selectedCategories;
  final ValueChanged<ExpenseCategory> onCategoryToggled;

  const ExpenseCategoriesPage({
    super.key,
    required this.selectedCategories,
    required this.onCategoryToggled,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24, // Space for top navigation
        bottom: 120, // Space for bottom button
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF4DA1FF), Color(0xFF1E5EFF)],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1E5EFF).withOpacity(0.2),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Center(
              child: Icon(
                Icons.savings_outlined, // piggy-bank approximation
                color: Colors.white,
                size: 32,
              ),
            ),
          ),
          const SizedBox(height: 24),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 26,
                height: 1.2,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
                letterSpacing: -0.5,
              ),
              children: [
                const TextSpan(
                  text: '¿',
                  style: TextStyle(color: Color(0xFF2563EB)),
                ),
                TextSpan(text: t.v2.onboarding.expenseCategories.title1.replaceAll('¿', '')),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            t.v2.onboarding.expenseCategories.subtitle,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 32),
          _buildOption(
            value: ExpenseCategory.diningOut,
            emoji: '🍔',
            text: t.v2.onboarding.expenseCategories.diningOut,
          ),
          const SizedBox(height: 12),
          _buildOption(
            value: ExpenseCategory.cravings,
            emoji: '☕',
            text: t.v2.onboarding.expenseCategories.cravings,
          ),
          const SizedBox(height: 12),
          _buildOption(
            value: ExpenseCategory.subscriptions,
            emoji: '📺',
            text: t.v2.onboarding.expenseCategories.subscriptions,
          ),
          const SizedBox(height: 12),
          _buildOption(
            value: ExpenseCategory.outings,
            emoji: '🎉',
            text: t.v2.onboarding.expenseCategories.outings,
          ),
          const SizedBox(height: 12),
          _buildOption(
            value: ExpenseCategory.shopping,
            emoji: '🛍️',
            text: t.v2.onboarding.expenseCategories.shopping,
          ),
          const SizedBox(height: 12),
          _buildOption(
            value: ExpenseCategory.delivery,
            emoji: '🛵',
            text: t.v2.onboarding.expenseCategories.delivery,
          ),
        ],
      ),
    );
  }

  Widget _buildOption({
    required ExpenseCategory value,
    required String emoji,
    required String text,
  }) {
    final isSelected = selectedCategories.contains(value);

    return GestureDetector(
      onTap: () {
        // Enforce max 3 logic in the UI or let the parent handle it
        if (!isSelected && selectedCategories.length >= 3) {
          // You could show a snackbar here or handle it in the parent.
          // For now, let the parent decide or just don't toggle if it's already 3.
          // The cleanest way is to pass it and let parent handle, but if parent
          // just blindly adds, we should prevent it here if max is reached.
          // We'll pass it anyway and let parent handle the limit.
        }
        onCategoryToggled(value);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFFBFDBFE) : const Color(0xFFF1F5F9), // hover:border-blue-200
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              alignment: Alignment.center,
              child: Text(
                emoji,
                style: const TextStyle(fontSize: 24),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? const Color(0xFF2563EB) : const Color(0xFF1E293B),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
