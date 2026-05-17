import 'package:flutter/material.dart';

class NewTransactionScreen extends StatelessWidget {
  const NewTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("Nueva Transacción"),
        actions: [
          IconButton(
            icon: Icon(Icons.auto_awesome, color: theme.colorScheme.primary),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Meta Selectors
                  Row(
                    children: [
                      _buildMetaPill(context, "Hoy", Icons.expand_more),
                      const SizedBox(width: 8),
                      _buildMetaPill(context, "Una vez", Icons.expand_more),
                      const SizedBox(width: 8),
                      _buildMetaPill(context, "Lista Privada", Icons.lock_outline),
                    ],
                  ),
                  const SizedBox(height: 40),
                  
                  // Amount Entry
                  Text(
                    "MONTO",
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.outline,
                      letterSpacing: 2.0,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "\$",
                        style: theme.textTheme.displayLarge?.copyWith(
                          color: theme.colorScheme.outlineVariant,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: TextField(
                          autofocus: true,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          style: theme.textTheme.displayLarge?.copyWith(
                            color: theme.colorScheme.onBackground,
                          ),
                          decoration: InputDecoration(
                            hintText: "0.00",
                            hintStyle: theme.textTheme.displayLarge?.copyWith(
                              color: theme.colorScheme.surfaceContainerHighest,
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
                  const SizedBox(height: 40),
                  
                  // Description Entry
                  Text(
                    "DESCRIPCIÓN",
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.outline,
                      letterSpacing: 2.0,
                    ),
                  ),
                  const SizedBox(height: 4),
                  TextField(
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onBackground,
                    ),
                    decoration: InputDecoration(
                      hintText: "Agregar nota...",
                      hintStyle: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.outlineVariant.withValues(alpha: 0.6),
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      filled: false,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                  // Category Selection
                  Text(
                    "CATEGORÍA",
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.outline,
                      letterSpacing: 2.0,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      _buildAddCategoryButton(context),
                      _buildCategoryPill(context, "🍴", "Comida", true),
                      _buildCategoryPill(context, "🛍️", "Compras", false),
                      _buildCategoryPill(context, "🚗", "Transporte", false),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          // Bottom Action Bar
          Container(
            padding: EdgeInsets.only(
              left: 20, 
              right: 20, 
              top: 16, 
              bottom: MediaQuery.of(context).viewInsets.bottom > 0 ? 16 : MediaQuery.of(context).padding.bottom + 16
            ),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 30,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.3)),
                  ),
                  child: Icon(Icons.tag, color: theme.colorScheme.onSurfaceVariant),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.inverseSurface,
                      foregroundColor: theme.colorScheme.onInverseSurface,
                      minimumSize: const Size.fromHeight(56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.check_circle_outline, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          "Guardar",
                          style: theme.textTheme.labelMedium?.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetaPill(BuildContext context, String label, IconData icon) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(width: 4),
          Icon(icon, size: 18, color: theme.colorScheme.onSurface),
        ],
      ),
    );
  }

  Widget _buildAddCategoryButton(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow,
        shape: BoxShape.circle,
        border: Border.all(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.2)),
      ),
      child: Icon(Icons.add, color: theme.colorScheme.outline),
    );
  }

  Widget _buildCategoryPill(BuildContext context, String emoji, String label, bool selected) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: selected ? theme.colorScheme.secondaryContainer.withValues(alpha: 0.1) : theme.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: selected 
              ? theme.colorScheme.secondaryContainer.withValues(alpha: 0.5)
              : theme.colorScheme.outlineVariant.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 8),
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: selected ? theme.colorScheme.onSecondaryContainer : theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
