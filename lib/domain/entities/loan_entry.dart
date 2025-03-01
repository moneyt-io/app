import 'package:equatable/equatable.dart';
import 'loan_detail.dart';

class LoanEntry extends Equatable {
  final int id;
  final String documentTypeId;
  final String currencyId;
  final int contactId;
  final int secuencial;
  final DateTime date;
  final double amount;
  final double rateExchange;
  final String? description;
  final String status;
  final bool active;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final List<LoanDetail> details;

  const LoanEntry({
    required this.id,
    required this.documentTypeId,
    required this.currencyId,
    required this.contactId,
    required this.secuencial,
    required this.date,
    required this.amount,
    required this.rateExchange,
    this.description,
    required this.status,
    required this.active,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.details = const [],
  });

  @override
  List<Object?> get props => [
    id, documentTypeId, currencyId, contactId, 
    secuencial, date, amount, rateExchange,
    description, status, active, createdAt, 
    updatedAt, deletedAt, details,
  ];
}
