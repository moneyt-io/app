import 'package:drift/drift.dart';
import '../../domain/entities/loan_entry.dart';
import '../../domain/entities/loan_detail.dart' as loan_detail;
import '../datasources/local/database.dart';
import 'loan_detail_model.dart';

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
  final LoanStatus status;
  final double totalPaid;
  final bool active;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final List<loan_detail.LoanDetail> details;

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
    required this.totalPaid,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.details = const [],
  });

  // Constructor para crear nuevos préstamos
  LoanEntryModel.create({
    required this.documentTypeId,
    required this.currencyId,
    required this.contactId,
    required this.secuencial,
    required this.date,
    required this.amount,
    this.rateExchange = 1.0,
    this.description,
    this.status = LoanStatus.active,
    this.totalPaid = 0.0,
    this.active = true,
    this.details = const [],
  }) : id = 0,
       createdAt = DateTime.now(),
       updatedAt = DateTime.now(),
       deletedAt = null;

  // Factory desde entidad de base de datos
  factory LoanEntryModel.fromDatabase(LoanEntries entry) {
    return LoanEntryModel(
      id: entry.id,
      documentTypeId: entry.documentTypeId,
      currencyId: entry.currencyId,
      contactId: entry.contactId,
      secuencial: entry.secuencial,
      date: entry.date,
      amount: entry.amount,
      rateExchange: entry.rateExchange,
      description: entry.description,
      status: _parseStatus(entry.status),
      totalPaid: entry.totalPaid,
      active: entry.active,
      createdAt: entry.createdAt,
      updatedAt: entry.updatedAt,
      deletedAt: entry.deletedAt,
    );
  }

  // Factory desde entidad del dominio
  factory LoanEntryModel.fromEntity(LoanEntry entity) {
    return LoanEntryModel(
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
      totalPaid: entity.totalPaid,
      active: entity.active,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      deletedAt: entity.deletedAt,
      details: entity.details,
    );
  }

  // Convertir a Companion para operaciones de BD
  LoanEntriesCompanion toCompanion() {
    return LoanEntriesCompanion(
      id: id == 0 ? const Value.absent() : Value(id),
      documentTypeId: Value(documentTypeId),
      currencyId: Value(currencyId),
      contactId: Value(contactId),
      secuencial: Value(secuencial),
      date: Value(date),
      amount: Value(amount),
      rateExchange: Value(rateExchange),
      description: Value(description),
      status: Value(_statusToString(status)),
      totalPaid: Value(totalPaid),
      active: Value(active),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: Value(deletedAt),
    );
  }

  // Convertir a entidad del dominio
  LoanEntry toEntity() {
    return LoanEntry(
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
      totalPaid: totalPaid,
      active: active,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
      details: details,
    );
  }

  // Helper methods
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

  // Crear copia con cambios
  LoanEntryModel copyWith({
    int? id,
    String? documentTypeId,
    String? currencyId,
    int? contactId,
    int? secuencial,
    DateTime? date,
    double? amount,
    double? rateExchange,
    String? description,
    LoanStatus? status,
    double? totalPaid,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    List<loan_detail.LoanDetail>? details,
  }) {
    return LoanEntryModel(
      id: id ?? this.id,
      documentTypeId: documentTypeId ?? this.documentTypeId,
      currencyId: currencyId ?? this.currencyId,
      contactId: contactId ?? this.contactId,
      secuencial: secuencial ?? this.secuencial,
      date: date ?? this.date,
      amount: amount ?? this.amount,
      rateExchange: rateExchange ?? this.rateExchange,
      description: description ?? this.description,
      status: status ?? this.status,
      totalPaid: totalPaid ?? this.totalPaid,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      details: details ?? this.details,
    );
  }
}
