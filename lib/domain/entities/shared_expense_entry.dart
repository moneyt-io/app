import 'package:equatable/equatable.dart';
import 'shared_expense_detail.dart';

class SharedExpenseEntry extends Equatable {
  final int id;
  final String documentTypeId;
  final String currencyId;
  final int secuencial;
  final DateTime date;
  final double amount;
  final double rateExchange;
  final bool active;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final List<SharedExpenseDetail> details;

  const SharedExpenseEntry({
    required this.id,
    required this.documentTypeId,
    required this.currencyId,
    required this.secuencial,
    required this.date,
    required this.amount,
    required this.rateExchange,
    required this.active,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.details = const [],
  });

  @override
  List<Object?> get props => [
    id, documentTypeId, currencyId, secuencial,
    date, amount, rateExchange, active,
    createdAt, updatedAt, deletedAt, details,
  ];
}
