import 'package:flutter/material.dart';

class CategoriesChipSelectionScreen extends StatelessWidget {
  const CategoriesChipSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("Categorías"),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: theme.colorScheme.onSurfaceVariant),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                children: [
                  Icon(Icons.search, color: theme.colorScheme.outline),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                      decoration: InputDecoration(
                        hintText: "Buscar categorías...",
                        hintStyle: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.outlineVariant,
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        filled: false,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // New Category Button
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                minimumSize: const Size.fromHeight(56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                shadowColor: Colors.black.withValues(alpha: 0.2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.add_circle_outline, size: 24),
                  const SizedBox(width: 8),
                  Text(
                    "Nueva Categoría",
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontSize: 18,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Categories Grid
            Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.start,
              children: [
                _buildCategoryPill(context, "🍴", "Comida"),
                _buildCategoryPill(context, "🛍️", "Compras"),
                _buildCategoryPill(context, "🚗", "Transporte"),
                _buildCategoryPill(context, "🎬", "Ocio"),
                _buildCategoryPill(context, "💊", "Salud"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryPill(BuildContext context, String emoji, String label) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: theme.colorScheme.surfaceContainerHigh.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 8),
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onSurface,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
