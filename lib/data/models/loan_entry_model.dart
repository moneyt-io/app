import 'package:drift/drift.dart';
import '../../domain/entities/loan_entry.dart';
import '../../domain/entities/loan_detail.dart';
import '../../domain/entities/contact.dart';
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
  final double totalPaid; // ← CAMPO AGREGADO
  final bool active;
  final DateTime createdAt;
  final DateTime updatedAt;
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
    required this.totalPaid, // ← CAMPO REQUERIDO
    required this.active,
    required this.createdAt,
    required this.updatedAt,
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
  }) : id = 0,
       status = 'ACTIVE',
       totalPaid = 0.0, // ← VALOR POR DEFECTO
       active = true,
       createdAt = DateTime.now(),
       updatedAt = DateTime.now(),
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
    totalPaid: Value(totalPaid), // ← INCLUIDO
    active: Value(active),
    createdAt: Value(createdAt),
    updatedAt: Value(updatedAt),
    deletedAt: Value(deletedAt),
  );

  LoanEntry toEntity({
    List<LoanDetail> details = const [],
    Contact? contact,
  }) => LoanEntry(
    id: id,
    documentTypeId: documentTypeId,
    currencyId: currencyId,
    contactId: contactId,
    secuencial: secuencial,
    date: date,
    amount: amount,
    rateExchange: rateExchange,
    description: description,
    status: _parseStatus(status),
    totalPaid: totalPaid, // ← INCLUIDO
    active: active,
    createdAt: createdAt,
    updatedAt: updatedAt,
    deletedAt: deletedAt,
    details: details,
    contact: contact,
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
    status: _statusToString(entity.status),
    totalPaid: entity.totalPaid, // ← INCLUIDO
    active: entity.active,
    createdAt: entity.createdAt,
    updatedAt: entity.updatedAt,
    deletedAt: entity.deletedAt,
  );

  factory LoanEntryModel.fromDrift(LoanEntries driftModel) => LoanEntryModel(
    id: driftModel.id,
    documentTypeId: driftModel.documentTypeId,
    currencyId: driftModel.currencyId,
    contactId: driftModel.contactId,
    secuencial: driftModel.secuencial,
    date: driftModel.date,
    amount: driftModel.amount,
    rateExchange: driftModel.rateExchange,
    description: driftModel.description,
    status: driftModel.status,
    totalPaid: driftModel.totalPaid, // ← INCLUIDO
    active: driftModel.active,
    createdAt: driftModel.createdAt,
    updatedAt: driftModel.updatedAt,
    deletedAt: driftModel.deletedAt,
  );

  // Helper methods for status conversion
  static LoanStatus _parseStatus(String status) {
    switch (status.toUpperCase()) {
      case 'ACTIVE':
        return LoanStatus.active;
      case 'PAID':
        return LoanStatus.paid;
      case 'CANCELLED':
        return LoanStatus.cancelled;
      case 'WRITTEN_OFF':
        return LoanStatus.writtenOff;
      default:
        return LoanStatus.active;
    }
  }

  static String _statusToString(LoanStatus status) {
    switch (status) {
      case LoanStatus.active:
        return 'ACTIVE';
      case LoanStatus.paid:
        return 'PAID';
      case LoanStatus.cancelled:
        return 'CANCELLED';
      case LoanStatus.writtenOff:
        return 'WRITTEN_OFF';
    }
  }
}
