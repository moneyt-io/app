import 'package:moneyt_pfm/presentation/features/transactions/models/transaction_filter_model.dart';
import '../transactions_screen.dart';

extension TransactionTypeFilterMapping on TransactionTypeFilter {
  TransactionType toTransactionType() {
    switch (this) {
      case TransactionTypeFilter.income:
        return TransactionType.income;
      case TransactionTypeFilter.expense:
        return TransactionType.expense;
      case TransactionTypeFilter.transfer:
        return TransactionType.transfer;
      case TransactionTypeFilter.all:
        throw ArgumentError('Cannot convert all to a single TransactionType');
    }
  }
}

extension TransactionTypeMapping on TransactionType {
  TransactionTypeFilter toFilterType() {
    switch (this) {
      case TransactionType.income:
        return TransactionTypeFilter.income;
      case TransactionType.expense:
        return TransactionTypeFilter.expense;
      case TransactionType.transfer:
        return TransactionTypeFilter.transfer;
    }
  }
}
