import 'package:flutter/material.dart';
import '../../../../domain/enums/recurrence_frequency.dart';
import '../../theme/v2_colors.dart';
import '../../../core/l10n/generated/strings.g.dart';

/// Bottom sheet that lets the user pick a [RecurrenceFrequency] for a
/// transaction. Returns the selected [RecurrenceFrequency], or `null` when the
/// user picks "No repeat" or dismisses the sheet.
class V2RecurrenceSheet extends StatelessWidget {
  final RecurrenceFrequency? currentFrequency;

  const V2RecurrenceSheet({
    super.key,
    this.currentFrequency,
  });

  /// Convenience method to show the sheet and await a selection.
  ///
  /// Returns the chosen [RecurrenceFrequency], `null` for "No repeat",
  /// or the [currentFrequency] if the sheet is dismissed without a selection
  /// (i.e., the future completes with the same value as before).
  static Future<RecurrenceFrequency?> show(
    BuildContext context, {
    RecurrenceFrequency? currentFrequency,
  }) {
    return showModalBottomSheet<RecurrenceFrequency?>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => V2RecurrenceSheet(currentFrequency: currentFrequency),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.70,
      ),
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: bottomInset > 0 ? bottomInset + 24 : 48,
      ),
      decoration: const BoxDecoration(
        color: V2Colors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Handle
          Center(
            child: Container(
              width: 48,
              height: 4,
              decoration: BoxDecoration(
                color: V2Colors.outlineVariant.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.v2.transactions.recurrenceSheetTitle,
                      style: const TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: V2Colors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      t.v2.transactions.recurrenceSheetSubtitle,
                      style: const TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: V2Colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: V2Colors.onSurfaceVariant),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // "No repeat" option
          _RecurrenceOption(
            emoji: '🚫',
            label: t.v2.transactions.recurrenceNone,
            isSelected: currentFrequency == null,
            onTap: () => Navigator.pop(context, null),
          ),
          const SizedBox(height: 8),

          // Divider
          Container(
            height: 1,
            color: V2Colors.outlineVariant.withValues(alpha: 0.3),
            margin: const EdgeInsets.symmetric(vertical: 4),
          ),
          const SizedBox(height: 8),

          // Frequency options
          ...RecurrenceFrequency.values.map((freq) {
            final label = switch (freq) {
              RecurrenceFrequency.daily     => t.v2.transactions.recurrenceDaily,
              RecurrenceFrequency.weekly    => t.v2.transactions.recurrenceWeekly,
              RecurrenceFrequency.monthly   => t.v2.transactions.recurrenceMonthly,
              RecurrenceFrequency.bimonthly => t.v2.transactions.recurrenceBimonthly,
              RecurrenceFrequency.quarterly => t.v2.transactions.recurrenceQuarterly,
              RecurrenceFrequency.yearly    => t.v2.transactions.recurrenceYearly,
            };
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _RecurrenceOption(
                emoji: freq.emoji,
                label: label,
                isSelected: currentFrequency == freq,
                onTap: () => Navigator.pop(context, freq),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _RecurrenceOption extends StatelessWidget {
  final String emoji;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _RecurrenceOption({
    required this.emoji,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? V2Colors.primary.withValues(alpha: 0.1)
              : V2Colors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? V2Colors.primary : Colors.transparent,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Emoji circle
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: isSelected
                    ? V2Colors.primary.withValues(alpha: 0.15)
                    : V2Colors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Text(
                emoji,
                style: const TextStyle(fontSize: 22),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected ? V2Colors.primary : V2Colors.onSurface,
                ),
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: V2Colors.primary,
                size: 22,
              ),
          ],
        ),
      ),
    );
  }
}
