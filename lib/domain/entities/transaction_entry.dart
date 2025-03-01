import 'package:equatable/equatable.dart';
import 'transaction_detail.dart';

class TransactionEntry extends Equatable {
  final int id;
  final String documentTypeId;
  final String currencyId;
  final int journalId;
  final int? contactId;
  final int secuencial;
  final DateTime date;
  final double amount;
  final double rateExchange;
  final String? description;
  final bool active;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final List<TransactionDetail> details;

  const TransactionEntry({
    required this.id,
    required this.documentTypeId,
    required this.currencyId,
    required this.journalId,
    this.contactId,
    required this.secuencial,
    required this.date,
    required this.amount,
    required this.rateExchange,
    this.description,
    required this.active,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.details = const [],
  });

  @override
  List<Object?> get props => [
    id,
    documentTypeId,
    currencyId,
    journalId,
    contactId,
    secuencial,
    date,
    amount,
    rateExchange,
    description,
    active,
    createdAt,
    updatedAt,
    deletedAt,
    details,
  ];
}
