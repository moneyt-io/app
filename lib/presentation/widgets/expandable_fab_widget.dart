import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

class ExpandableFabWidget extends StatelessWidget {
  final GlobalKey<ExpandableFabState> fabKey;
  final void Function(BuildContext context, {required String type}) onTransactionPressed;

  const ExpandableFabWidget({
    Key? key,
    required this.fabKey,
    required this.onTransactionPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, right: 16),
      child: ExpandableFab(
        key: fabKey,
        openButtonBuilder: RotateFloatingActionButtonBuilder(
          child: const Icon(Icons.add),
          fabSize: ExpandableFabSize.regular,
          foregroundColor: Colors.white,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        closeButtonBuilder: DefaultFloatingActionButtonBuilder(
          child: const Icon(Icons.close),
          fabSize: ExpandableFabSize.regular,
          foregroundColor: Colors.white,
          backgroundColor: Colors.red,
        ),
        type: ExpandableFabType.up,
        distance: 70,
        children: [
          FloatingActionButton.small(
            heroTag: 'expense_fab',
            onPressed: () => onTransactionPressed(context, type: 'E'),
            backgroundColor: Colors.red,
            child: const Icon(Icons.arrow_downward),
          ),
          FloatingActionButton.small(
            heroTag: 'income_fab',
            onPressed: () => onTransactionPressed(context, type: 'I'),
            backgroundColor: Colors.green,
            child: const Icon(Icons.arrow_upward),
          ),
          FloatingActionButton.small(
            heroTag: 'transfer_fab',
            onPressed: () => onTransactionPressed(context, type: 'T'),
            backgroundColor: Colors.blue,
            child: const Icon(Icons.swap_horiz),
          ),
        ],
      ),
    );
  }
}
