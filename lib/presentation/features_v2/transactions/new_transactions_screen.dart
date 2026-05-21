import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../domain/entities/transaction_entry.dart';
import '../../../../domain/entities/category.dart';
import '../../../../core/utils/icon_to_emoji_mapper.dart';
import '../../core/providers/currency_filter_provider.dart';
import '../../features/transactions/transaction_provider.dart';
import 'new_transaction_screen.dart';
import '../theme/v2_colors.dart';
import '../../../../core/utils/number_formatter.dart';

class NewTransactionsScreen extends StatefulWidget {
  const NewTransactionsScreen({super.key});

  @override
  State<NewTransactionsScreen> createState() => _NewTransactionsScreenState();
}

class _NewTransactionsScreenState extends State<NewTransactionsScreen> {
  int? _selectedCategoryId;

  String _formatDateHeader(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0 && now.day == date.day) {
      return "Hoy";
    } else if (difference.inDays == 1 || (difference.inDays == 0 && now.day != date.day)) {
      return "Ayer";
    } else {
      return DateFormat('d \'de\' MMMM', 'es').format(date);
    }
  }

  Map<String, List<TransactionEntry>> _groupTransactions(List<TransactionEntry> transactions) {
    final grouped = <String, List<TransactionEntry>>{};
    for (final t in transactions) {
      final dateStr = _formatDateHeader(t.date);
      if (grouped[dateStr] == null) {
        grouped[dateStr] = [];
      }
      grouped[dateStr]!.add(t);
    }
    return grouped;
  }

  List<Category> _getTopCategories(List<TransactionEntry> transactions, Map<int, Category> categoryMap) {
    final counts = <int, int>{};
    for (final t in transactions) {
      if (t.mainCategoryId != null) {
        counts[t.mainCategoryId!] = (counts[t.mainCategoryId!] ?? 0) + 1;
      }
    }
    
    final sortedIds = counts.keys.toList()
      ..sort((a, b) => counts[b]!.compareTo(counts[a]!));
      
    return sortedIds
        .take(10)
        .map((id) => categoryMap[id])
        .where((c) => c != null)
        .cast<Category>()
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: V2Colors.background,
        body: Consumer2<TransactionProvider, CurrencyFilterProvider>(
          builder: (context, transactionProvider, currencyFilter, child) {
            final selectedCurrency = currencyFilter.selectedCurrencyId;
            
            // Filtro base: moneda
            var transactions = transactionProvider.transactions
                .where((t) => t.currencyId == selectedCurrency)
                .toList()
              ..sort((a, b) => b.date.compareTo(a.date));

            // Extraer el top de categorías SIEMPRE en base a todas las transacciones (para que los chips no desaparezcan al filtrar)
            final topCategories = _getTopCategories(transactions, transactionProvider.categoriesDataMap);

            // Aplicar filtro de categoría seleccionada
            if (_selectedCategoryId != null) {
              transactions = transactions.where((t) => t.mainCategoryId == _selectedCategoryId).toList();
            }

            final groupedTransactions = _groupTransactions(transactions);

            return Stack(
              children: [
                // Scrollable Content
                CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    // Espacio para la cabecera fija (aumentado para evitar solapamiento)
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 120),
                    ),
                    
                    // Categorías Utilizadas
                    if (topCategories.isNotEmpty) ...[
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16, bottom: 8, left: 24),
                          child: Text(
                            "CATEGORÍAS UTILIZADAS",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: V2Colors.outline,
                              letterSpacing: 1.2,
                              fontFamily: 'Manrope',
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: 64,
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount: topCategories.length,
                            itemBuilder: (context, index) {
                              final cat = topCategories[index];
                              final colors = [
                                V2Colors.primaryContainer.withValues(alpha: 0.2),
                                V2Colors.secondaryContainer.withValues(alpha: 0.3),
                                V2Colors.errorContainer.withValues(alpha: 0.4),
                                V2Colors.tertiaryContainer.withValues(alpha: 0.2),
                              ];
                              final bgColor = colors[cat.id.hashCode % colors.length];
                              final isSelected = _selectedCategoryId == cat.id;

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (_selectedCategoryId == cat.id) {
                                      _selectedCategoryId = null; // Toggle off
                                    } else {
                                      _selectedCategoryId = cat.id; // Toggle on
                                    }
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  width: 56,
                                  height: 56,
                                  margin: const EdgeInsets.only(right: 8),
                                  decoration: BoxDecoration(
                                    color: isSelected ? bgColor.withValues(alpha: 0.8) : bgColor,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: isSelected ? V2Colors.primary : Colors.white.withValues(alpha: 0.5),
                                      width: isSelected ? 2 : 1,
                                    ),
                                    boxShadow: [
                                      if (isSelected)
                                        BoxShadow(
                                          color: V2Colors.primary.withValues(alpha: 0.2),
                                          blurRadius: 8,
                                          offset: const Offset(0, 4),
                                        )
                                      else
                                        BoxShadow(
                                          color: Colors.black.withValues(alpha: 0.02),
                                          blurRadius: 4,
                                          offset: const Offset(0, 2),
                                        ),
                                    ],
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    IconToEmojiMapper.getEmoji(cat.icon),
                                    style: TextStyle(
                                      fontSize: isSelected ? 30 : 28,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(height: 16),
                      ),
                    ],

                    // Transacciones agrupadas
                    if (transactions.isEmpty)
                      const SliverFillRemaining(
                        child: Center(
                          child: Text(
                            "No hay transacciones registradas",
                            style: TextStyle(
                              color: V2Colors.outline,
                              fontFamily: 'Manrope',
                              fontSize: 16,
                            ),
                          ),
                        ),
                      )
                    else
                      ...groupedTransactions.entries.map((entry) {
                        return SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                if (index == 0) {
                                  // Cabecera del grupo (Fecha)
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 12, top: 16, left: 4),
                                    child: Text(
                                      entry.key.toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: V2Colors.outline,
                                        letterSpacing: 1.2,
                                        fontFamily: 'Manrope',
                                      ),
                                    ),
                                  );
                                }
                                
                                final t = entry.value[index - 1];
                                final category = t.category ?? (t.mainCategoryId != null ? transactionProvider.categoriesDataMap[t.mainCategoryId!] : null);
                                return _buildTransactionCard(t, category, context);
                              },
                              childCount: entry.value.length + 1, // +1 for the header
                            ),
                          ),
                        );
                      }),
                      
                    // Espacio inferior
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 80),
                    ),
                  ],
                ),

                // Sticky Header with Glassmorphism
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                      child: Container(
                        color: V2Colors.surface.withValues(alpha: 0.8),
                        child: SafeArea(
                          bottom: false,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.arrow_back, color: V2Colors.onSurface),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                    const SizedBox(width: 8),
                                    const Text(
                                      "Actividad Reciente",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: V2Colors.onSurface,
                                        fontFamily: 'Manrope',
                                      ),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  icon: const Icon(Icons.filter_list, color: V2Colors.onSurface),
                                  onPressed: () {
                                    // TODO: Filter action
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTransactionCard(TransactionEntry t, Category? category, BuildContext context) {
    final isIncome = t.isIncome;

    // Asignar color consistente
    final hash = (category?.id.hashCode ?? t.id.hashCode);
    final colors = [
      V2Colors.primary.withValues(alpha: 0.15),
      V2Colors.secondaryContainer.withValues(alpha: 0.3),
      V2Colors.tertiaryContainer.withValues(alpha: 0.2),
      V2Colors.errorContainer.withValues(alpha: 0.4),
    ];
    final avatarBgColor = isIncome ? V2Colors.secondaryContainer.withValues(alpha: 0.3) : colors[hash % colors.length];
    
    final emoji = (category != null && category.icon.isNotEmpty) 
        ? IconToEmojiMapper.getEmoji(category.icon) 
        : (isIncome ? '💰' : '🏷️');

    final title = t.description?.isNotEmpty == true
        ? t.description!
        : (t.contact?.name ?? category?.name ?? 'Transacción');
        
    final subtitle = "${category?.name ?? 'Otros'} • ${DateFormat('HH:mm').format(t.date)}";

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: V2Colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            // TODO: Navigate to detail
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: avatarBgColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: Text(emoji, style: const TextStyle(fontSize: 26)),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: V2Colors.onSurface,
                          fontFamily: 'Manrope',
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: V2Colors.onSurfaceVariant,
                          fontFamily: 'Manrope',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                      Row(
                        children: [
                          Text(
                            "${isIncome ? '+' : '-'}${NumberFormatter.formatCurrency(t.amount.abs())}",
                            style: TextStyle(
                              fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: isIncome ? V2Colors.secondary : V2Colors.onSurface,
                            fontFamily: 'Manrope',
                            letterSpacing: -0.5,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => NewTransactionScreen(
                                    transactionIdToEdit: t.id,
                                    initialType: t.documentTypeId,
                                    initialAmount: t.amount.abs(),
                                    initialDescription: t.description,
                                    initialCategoryId: t.mainCategoryId,
                                    initialWalletId: t.details.isNotEmpty 
                                        ? (t.details.first.paymentTypeId == 'C' ? -t.details.first.paymentId : t.details.first.paymentId) 
                                        : null,
                                    initialDate: t.date,
                                  ),
                                ),
                              );
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(Icons.edit_outlined, size: 16, color: V2Colors.onSurfaceVariant),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  title: const Text('¿Eliminar transacción?', style: TextStyle(fontFamily: 'Manrope', fontWeight: FontWeight.w700)),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(ctx),
                                      child: const Text('Cancelar', style: TextStyle(color: V2Colors.onSurfaceVariant, fontFamily: 'Manrope', fontWeight: FontWeight.w600)),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(ctx);
                                        context.read<TransactionProvider>().deleteTransaction(t.id);
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Transacción eliminada')));
                                      },
                                      child: const Text('Eliminar', style: TextStyle(color: V2Colors.error, fontFamily: 'Manrope', fontWeight: FontWeight.w700)),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(Icons.delete_outline, size: 16, color: V2Colors.error),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
