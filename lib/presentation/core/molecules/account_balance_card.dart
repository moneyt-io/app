import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../domain/entities/wallet.dart';
import '../../../domain/services/balance_calculation_service.dart';
import '../../../core/utils/number_formatter.dart';
import '../atoms/app_card.dart';
import '../atoms/app_icon.dart';
import '../design_system/tokens/app_dimensions.dart';

class AccountBalanceCard extends StatefulWidget {
  final Wallet wallet;
  final VoidCallback? onTap;

  const AccountBalanceCard({
    Key? key,
    required this.wallet,
    this.onTap,
  }) : super(key: key);

  @override
  State<AccountBalanceCard> createState() => _AccountBalanceCardState();
}

class _AccountBalanceCardState extends State<AccountBalanceCard> {
  final BalanceCalculationService _balanceService = GetIt.instance<BalanceCalculationService>();
  double _currentBalance = 0.0;
  bool _isLoadingBalance = true;

  @override
  void initState() {
    super.initState();
    _loadWalletBalance();
  }

  @override
  void didUpdateWidget(AccountBalanceCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Recargar balance si cambió el wallet
    if (oldWidget.wallet.id != widget.wallet.id) {
      _loadWalletBalance();
    }
  }

  Future<void> _loadWalletBalance() async {
    setState(() {
      _isLoadingBalance = true;
    });

    try {
      final balance = await _balanceService.calculateWalletBalance(widget.wallet.id);
      if (mounted) {
        setState(() {
          _currentBalance = balance;
          _isLoadingBalance = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _currentBalance = 0.0;
          _isLoadingBalance = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    
    return AppCard(
      elevation: AppCardElevation.medium,
      onTap: widget.onTap,
      margin: EdgeInsets.symmetric(
        horizontal: AppDimensions.spacing16,
        vertical: AppDimensions.spacing8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppIconContainer(
                iconData: Icons.account_balance_wallet,
                size: AppIconSize.medium,
                backgroundColor: colorScheme.primaryContainer,
                iconColor: colorScheme.onPrimaryContainer,
              ),
              SizedBox(width: AppDimensions.spacing12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.wallet.name,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: AppDimensions.spacing4),
                    Text(
                      'Cuenta',
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimensions.spacing16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Saldo disponible',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              _isLoadingBalance 
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
                    ),
                  )
                : Text(
                    NumberFormatter.formatCurrency(_currentBalance),
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: _currentBalance >= 0 
                          ? colorScheme.primary
                          : colorScheme.error,
                    ),
                  ),
            ],
          ),
        ],
      ),
    );
  }
}
