import 'package:drift/drift.dart';
import 'package:moneyt_pfm/domain/entities/transaction_detail.dart';
import '../../domain/entities/transaction_entry.dart';
import '../datasources/local/database.dart';

class TransactionEntryModel {
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

  TransactionEntryModel({
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
  });

  // Constructor para nuevas transacciones
  TransactionEntryModel.create({
    required this.documentTypeId,
    required this.currencyId,
    required this.journalId,
    this.contactId,
    required this.secuencial,
    required this.date,
    required this.amount,
    required this.rateExchange,
    this.description,
    bool? active,
  })  : id = 0,
        active = active ?? true,
        createdAt = DateTime.now(),
        updatedAt = null,
        deletedAt = null;

  // Convertir a Companion para Drift
  TransactionEntriesCompanion toCompanion() => TransactionEntriesCompanion(
    id: id == 0 ? const Value.absent() : Value(id),
    documentTypeId: Value(documentTypeId),
    currencyId: Value(currencyId),
    journalId: Value(journalId),
    contactId: Value(contactId),
    secuencial: Value(secuencial),
    date: Value(date),
    amount: Value(amount),
    rateExchange: Value(rateExchange),
    description: Value(description),
    active: Value(active),
    createdAt: Value(createdAt),
    updatedAt: Value(updatedAt),
    deletedAt: Value(deletedAt),
  );

  TransactionEntry toEntity({List<TransactionDetail> details = const []}) => TransactionEntry(
    id: id,
    documentTypeId: documentTypeId,
    currencyId: currencyId,
    journalId: journalId,
    contactId: contactId,
    secuencial: secuencial,
    date: date,
    amount: amount,
    rateExchange: rateExchange,
    description: description,
    active: active,
    createdAt: createdAt,
    updatedAt: updatedAt,
    deletedAt: deletedAt,
    details: details,
  );

  factory TransactionEntryModel.fromEntity(TransactionEntry entity) => TransactionEntryModel(
    id: entity.id,
    documentTypeId: entity.documentTypeId,
    currencyId: entity.currencyId,
    journalId: entity.journalId,
    contactId: entity.contactId,
    secuencial: entity.secuencial,
    date: entity.date,
    amount: entity.amount,
    rateExchange: entity.rateExchange,
    description: entity.description,
    active: entity.active,
    createdAt: entity.createdAt,
    updatedAt: entity.updatedAt,
    deletedAt: entity.deletedAt,
  );
}
