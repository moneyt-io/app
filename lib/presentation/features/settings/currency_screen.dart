import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/atoms/app_app_bar.dart';
import '../../core/providers/currency_provider.dart';
import '../../core/l10n/generated/strings.g.dart';

class CurrencyScreen extends StatefulWidget {
  const CurrencyScreen({super.key});

  @override
  State<CurrencyScreen> createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  String? _selectedCurrencyId;

  @override
  void initState() {
    super.initState();
    _selectedCurrencyId = context.read<CurrencyProvider>().currencyId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppAppBar(
        title: t.settings.currency.title,
        type: AppAppBarType.blur,
        leading: AppAppBarLeading.back,
        onLeadingPressed: () => Navigator.of(context).pop(),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  _buildCurrencyList(),
                ],
              ),
            ),
          ),
          _buildApplyButton(),
        ],
      ),
    );
  }

  Widget _buildCurrencyList() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFFF1F5F9)),
              ),
            ),
            child: Row(
              children: [
                Text(
                  t.settings.currency.available,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E293B),
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),

          // Currency options
          Container(
            padding: const EdgeInsets.all(4),
            child: Column(
              children: CurrencyProvider.availableCurrencies
                  .map((currency) => _buildCurrencyOption(currency))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyOption(CurrencyInfo currency) {
    final isSelected = _selectedCurrencyId == currency.id;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => setState(() => _selectedCurrencyId = currency.id),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
          child: Row(
            children: [
              // Flag icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: currency.backgroundColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    currency.flag,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),

              const SizedBox(width: 16),

              // Currency info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currency.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    Text(
                      '${currency.symbol} · ${currency.id}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),

              // Selection indicator
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 2,
                    color: isSelected
                        ? const Color(0xFF0c7ff2)
                        : const Color(0xFFCBD5E1),
                  ),
                  color: isSelected
                      ? const Color(0xFF0c7ff2)
                      : Colors.transparent,
                ),
                child: isSelected
                    ? const Icon(Icons.check, color: Colors.white, size: 14)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildApplyButton() {
    final currencyProvider = context.watch<CurrencyProvider>();
    final hasChanges = _selectedCurrencyId != currencyProvider.currencyId;

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF8FAFC),
        border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          onPressed: hasChanges ? _applyCurrency : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0c7ff2),
            foregroundColor: const Color(0xFFF8FAFC),
            disabledBackgroundColor: const Color(0xFFCBD5E1),
            disabledForegroundColor: const Color(0xFF64748B),
            elevation: hasChanges ? 2 : 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          child: Text(t.settings.currency.apply),
        ),
      ),
    );
  }

  Future<void> _applyCurrency() async {
    if (_selectedCurrencyId == null) return;

    final provider = context.read<CurrencyProvider>();
    try {
      await provider.setCurrency(_selectedCurrencyId!);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Currency updated successfully'),
            backgroundColor: Color(0xFF0c7ff2),
            duration: Duration(seconds: 2),
          ),
        );
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) Navigator.of(context).pop();
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating currency: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
