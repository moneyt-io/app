import 'package:flutter/material.dart';
import '../../../domain/entities/wallet.dart';

class WalletDetailScreen extends StatelessWidget {
  final Wallet wallet;

  const WalletDetailScreen({Key? key, required this.wallet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(wallet.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nombre: ${wallet.name}', style: Theme.of(context).textTheme.titleMedium),
            if (wallet.description != null)
              Text('Descripción: ${wallet.description}', style: Theme.of(context).textTheme.bodyMedium),
            Text('Moneda: ${wallet.currencyId}', style: Theme.of(context).textTheme.bodyMedium),
            // Add more wallet details here
          ],
        ),
      ),
    );
  }
}
