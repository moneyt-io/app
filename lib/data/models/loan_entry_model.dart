import 'package:drift/drift.dart';
import '../../domain/entities/loan_detail.dart';
import '../../domain/entities/loan_entry.dart';
import '../datasources/local/database.dart';

class LoanEntryModel {
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

  LoanEntryModel({
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
  });

  LoanEntryModel.create({
    required this.documentTypeId,
    required this.currencyId,
    required this.contactId,
    required this.secuencial,
    required this.date,
    required this.amount,
    required this.rateExchange,
    this.description,
    required this.status,
  })  : id = 0,
        active = true,
        createdAt = DateTime.now(),
        updatedAt = null,
        deletedAt = null;

  LoanEntriesCompanion toCompanion() => LoanEntriesCompanion(
    id: id == 0 ? const Value.absent() : Value(id),
    documentTypeId: Value(documentTypeId),
    currencyId: Value(currencyId),
    contactId: Value(contactId),
    secuencial: Value(secuencial),
    date: Value(date),
    amount: Value(amount),
    rateExchange: Value(rateExchange),
    description: Value(description),
    status: Value(status),
    active: Value(active),
    createdAt: Value(createdAt),
    updatedAt: Value(updatedAt),
    deletedAt: Value(deletedAt),
  );

  LoanEntry toEntity({List<LoanDetail> details = const []}) => LoanEntry(
    id: id,
    documentTypeId: documentTypeId,
    currencyId: currencyId,
    contactId: contactId,
    secuencial: secuencial,
    date: date,
    amount: amount,
    rateExchange: rateExchange,
    description: description,
    status: status,
    active: active,
    createdAt: createdAt,
    updatedAt: updatedAt,
    deletedAt: deletedAt,
    details: details,
  );

  factory LoanEntryModel.fromEntity(LoanEntry entity) => LoanEntryModel(
    id: entity.id,
    documentTypeId: entity.documentTypeId,
    currencyId: entity.currencyId,
    contactId: entity.contactId,
    secuencial: entity.secuencial,
    date: entity.date,
    amount: entity.amount,
    rateExchange: entity.rateExchange,
    description: entity.description,
    status: entity.status,
    active: entity.active,
    createdAt: entity.createdAt,
    updatedAt: entity.updatedAt,
    deletedAt: entity.deletedAt,
  );
}
