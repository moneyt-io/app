import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import '../../../../domain/entities/recurring_transaction.dart';
import '../../../../domain/enums/recurrence_frequency.dart';
import '../../../../domain/usecases/recurring_transaction_usecases.dart';
import '../../../../core/utils/recurring_date_helper.dart';
import '../../../../core/utils/icon_to_emoji_mapper.dart';
import '../../../core/l10n/generated/strings.g.dart';
import '../../theme/v2_colors.dart';
import '../../shared/widgets/v2_date_selection_sheet.dart';
import 'v2_recurrence_sheet.dart';

/// Modal sheet to edit amount, description, frequency, next execution date,
/// pause/resume, or delete a recurring transaction rule without altering
/// any historical transactions in the ledger.
class RecurringTransactionEditSheet extends StatefulWidget {
  final RecurringTransaction rule;
  final VoidCallback onUpdated;

  const RecurringTransactionEditSheet({
    super.key,
    required this.rule,
    required this.onUpdated,
  });

  static Future<void> show(
    BuildContext context, {
    required RecurringTransaction rule,
    required VoidCallback onUpdated,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => RecurringTransactionEditSheet(
        rule: rule,
        onUpdated: onUpdated,
      ),
    );
  }

  @override
  State<RecurringTransactionEditSheet> createState() =>
      _RecurringTransactionEditSheetState();
}

class _RecurringTransactionEditSheetState
    extends State<RecurringTransactionEditSheet> {
  late TextEditingController _amountController;
  late TextEditingController _descriptionController;
  late RecurrenceFrequency _frequency;
  late DateTime _executionDate;
  late bool _active;
  bool _isSaving = false;

  final _useCases = GetIt.instance<RecurringTransactionUseCases>();

  @override
  void initState() {
    super.initState();
    _amountController =
        TextEditingController(text: widget.rule.amount.toStringAsFixed(2));
    _descriptionController =
        TextEditingController(text: widget.rule.description ?? '');
    _frequency = widget.rule.recurrenceFrequency;
    _executionDate = widget.rule.nextExecutionDate;
    _active = widget.rule.active;
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  String _freqLabel(RecurrenceFrequency freq, AppStrings t) {
    return switch (freq) {
      RecurrenceFrequency.daily     => t.v2.transactions.recurrenceDaily,
      RecurrenceFrequency.weekly    => t.v2.transactions.recurrenceWeekly,
      RecurrenceFrequency.monthly   => t.v2.transactions.recurrenceMonthly,
      RecurrenceFrequency.bimonthly => t.v2.transactions.recurrenceBimonthly,
      RecurrenceFrequency.quarterly => t.v2.transactions.recurrenceQuarterly,
      RecurrenceFrequency.yearly    => t.v2.transactions.recurrenceYearly,
    };
  }

  Future<void> _selectDate() async {
    final picked = await V2DateSelectionSheet.showSingle(
      context,
      initialDate: _executionDate,
    );
    if (picked != null && picked != _executionDate) {
      setState(() => _executionDate = picked);
    }
  }

  Future<void> _save() async {
    final t = context.t;
    final amount = double.tryParse(_amountController.text.replaceAll(',', '.'));
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t.v2.transactions.invalidAmount)),
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      final updated = widget.rule.copyWith(
        amount: amount,
        description: _descriptionController.text.trim().isNotEmpty
            ? _descriptionController.text.trim()
            : null,
        frequency: _frequency.key,
        active: _active,
        nextExecutionDate: RecurringDateHelper.toDateOnly(_executionDate),
        updatedAt: DateTime.now(),
      );

      await _useCases.updateRecurringTransaction(updated);
      widget.onUpdated();

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(t.v2.transactions.recurringRuleUpdated)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(t.v2.transactions.error(error: e.toString()))),
        );
        setState(() => _isSaving = false);
      }
    }
  }

  Future<void> _confirmDelete() async {
    final t = context.t;
    final confirmed = await showCupertinoDialog<bool>(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text(t.v2.transactions.deleteRecurringTitle),
        content: Text(t.v2.transactions.deleteRecurringContent),
        actions: [
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () => Navigator.pop(context, true),
            child: Text(t.v2.transactions.delete),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.pop(context, false),
            child: Text(t.v2.transactions.cancel),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      await _useCases.deleteRecurringTransaction(widget.rule.id);
      widget.onUpdated();
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(t.v2.transactions.recurringRuleDeleted)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final isIncome = widget.rule.isIncome;
    final emoji = (widget.rule.category != null && widget.rule.category!.icon.isNotEmpty)
        ? IconToEmojiMapper.getEmoji(widget.rule.category!.icon)
        : (isIncome ? '💰' : '🏷️');

    final langCode = LocaleSettings.currentLocale.languageCode;
    final dateStr = DateFormat('d MMM yyyy', langCode).format(_executionDate);

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: EdgeInsets.only(
        top: 20,
        left: 24,
        right: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 32,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Header
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: V2Colors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Text(emoji, style: const TextStyle(fontSize: 22)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.rule.category?.name ??
                          (isIncome
                              ? t.v2.transactions.recurringIncome
                              : t.v2.transactions.recurringExpense),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Manrope',
                        color: V2Colors.onSurface,
                      ),
                    ),
                    Text(
                      widget.rule.wallet?.name ?? '',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: V2Colors.onSurfaceVariant,
                        fontFamily: 'Manrope',
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline_rounded,
                    color: Color(0xFFB3261E)),
                onPressed: _confirmDelete,
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Amount field
          Text(
            t.v2.transactions.amount,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: V2Colors.onSurfaceVariant,
              fontFamily: 'Manrope',
            ),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: _amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              fontFamily: 'Manrope',
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFF6F7FA),
              prefixText: '${widget.rule.currencyId} ',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Description field
          Text(
            t.v2.transactions.description,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: V2Colors.onSurfaceVariant,
              fontFamily: 'Manrope',
            ),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: _descriptionController,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              fontFamily: 'Manrope',
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFF6F7FA),
              hintText: t.v2.transactions.addNote,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Date Selector (Next Execution Date)
          Text(
            t.v2.transactions.recurringNextExecution,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: V2Colors.onSurfaceVariant,
              fontFamily: 'Manrope',
            ),
          ),
          const SizedBox(height: 6),
          InkWell(
            onTap: _selectDate,
            borderRadius: BorderRadius.circular(14),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: const Color(0xFFF6F7FA),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  const Text('📅', style: TextStyle(fontSize: 18)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      dateStr,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Manrope',
                        color: V2Colors.onSurface,
                      ),
                    ),
                  ),
                  const Icon(Icons.calendar_today_rounded,
                      size: 16, color: V2Colors.primary),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Frequency selection
          Text(
            t.v2.transactions.recurrence,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: V2Colors.onSurfaceVariant,
              fontFamily: 'Manrope',
            ),
          ),
          const SizedBox(height: 6),
          InkWell(
            onTap: () async {
              final selected = await V2RecurrenceSheet.show(
                context,
                currentFrequency: _frequency,
              );
              if (selected != null) {
                setState(() => _frequency = selected);
              }
            },
            borderRadius: BorderRadius.circular(14),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: const Color(0xFFF6F7FA),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Text(_frequency.emoji, style: const TextStyle(fontSize: 18)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      _freqLabel(_frequency, t),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Manrope',
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios_rounded,
                      size: 14, color: V2Colors.onSurfaceVariant),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Active / Paused switch
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF6F7FA),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.v2.transactions.recurringStatus,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Manrope',
                      ),
                    ),
                    Text(
                      _active
                          ? t.v2.transactions.recurringActive
                          : t.v2.transactions.recurringPaused,
                      style: TextStyle(
                        fontSize: 12,
                        color: _active
                            ? const Color(0xFF1B873F)
                            : V2Colors.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Manrope',
                      ),
                    ),
                  ],
                ),
                CupertinoSwitch(
                  value: _active,
                  activeTrackColor: V2Colors.primary,
                  onChanged: (val) => setState(() => _active = val),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Save button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: _isSaving ? null : _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: V2Colors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: _isSaving
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    )
                  : Text(
                      t.v2.transactions.saveChanges,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Manrope',
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
