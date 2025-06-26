import 'wallet.dart';

/// Clase para mostrar información de wallet en widgets del dashboard
class WalletDisplayItem {
  final int id;
  final String name;
  final double balance;
  final String currencyId;
  final String? chartAccountName;

  const WalletDisplayItem({
    required this.id,
    required this.name,
    required this.balance,
    required this.currencyId,
    this.chartAccountName,
  });

  factory WalletDisplayItem.fromWallet(Wallet wallet, double balance) {
    return WalletDisplayItem(
      id: wallet.id,
      name: wallet.name,
      balance: balance,
      currencyId: wallet.currencyId,
      chartAccountName: null, // TODO: Load from chart account
    );
  }
}
