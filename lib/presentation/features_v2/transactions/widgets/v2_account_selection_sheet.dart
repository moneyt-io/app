import 'package:flutter/material.dart';
import '../../../core/organisms/account_selector_modal.dart' show SelectableAccount;
import '../../../../core/utils/number_formatter.dart';
import '../../../../core/utils/icon_to_emoji_mapper.dart';
import '../../theme/v2_colors.dart';

class V2AccountSelectionSheet extends StatelessWidget {
  final List<SelectableAccount> accounts;
  final SelectableAccount? initialSelection;

  const V2AccountSelectionSheet({
    super.key,
    required this.accounts,
    this.initialSelection,
  });

  static Future<SelectableAccount?> show(
    BuildContext context, {
    required List<SelectableAccount> accounts,
    SelectableAccount? initialSelection,
  }) {
    return showModalBottomSheet<SelectableAccount?>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => V2AccountSelectionSheet(
        accounts: accounts,
        initialSelection: initialSelection,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
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
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Seleccionar Billetera',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: V2Colors.onSurface,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: V2Colors.onSurfaceVariant),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          Expanded(
            child: accounts.isEmpty
              ? const Center(
                  child: Text(
                    'No hay billeteras disponibles',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      color: V2Colors.outlineVariant,
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.only(top: 8, bottom: 24),
                  itemCount: accounts.length,
                  itemBuilder: (context, index) {
                    final account = accounts[index];
                    final isSelected = initialSelection?.id == account.id && initialSelection?.isCreditCard == account.isCreditCard;
                    
                    return GestureDetector(
                      onTap: () => Navigator.pop(context, account),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: V2Colors.surfaceContainerLowest,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected ? V2Colors.primary : Colors.transparent,
                            width: isSelected ? 2 : 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.03),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: V2Colors.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignment: Alignment.center,
                              child: account.isCreditCard 
                                ? const Icon(Icons.credit_card, color: V2Colors.primary)
                                : Text(
                                    IconToEmojiMapper.getEmoji(account.icon ?? '58376'), // 58376 is Icons.account_balance_wallet.codePoint
                                    style: const TextStyle(fontSize: 24),
                                  ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    account.name,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: V2Colors.onSurface,
                                      fontFamily: 'Manrope',
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    NumberFormatter.formatCurrencyWithCode(account.balance ?? 0.0, currencyId: account.currencyId),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: V2Colors.onSurfaceVariant,
                                      fontFamily: 'Manrope',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (isSelected)
                              const Icon(
                                Icons.check_circle,
                                color: V2Colors.primary,
                                size: 24,
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
          ),
        ],
      ),
    );
  }
}
