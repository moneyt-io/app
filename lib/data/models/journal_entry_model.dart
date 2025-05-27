import 'package:drift/drift.dart';
import '../../domain/entities/journal_entry.dart';
import '../../domain/entities/journal_detail.dart';
import '../datasources/local/database.dart';

class JournalEntryModel {
  final int id;
  final String documentTypeId;
  final int secuencial;
  final DateTime date;
  final String? description;
  final bool active;
  final DateTime createdAt;
  final DateTime? updatedAt; // CAMBIAR A NULLABLE
  final DateTime? deletedAt;
  final List<JournalDetail> details;

  JournalEntryModel({
    required this.id,
    required this.documentTypeId,
    required this.secuencial,
    required this.date,
    this.description,
    required this.active,
    required this.createdAt,
    this.updatedAt, // CAMBIAR A NULLABLE
    this.deletedAt,
    this.details = const [],
  });

  // Constructor para crear nuevos journals
  JournalEntryModel.create({
    required this.documentTypeId,
    required this.secuencial,
    required this.date,
    this.description,
    this.active = true,
    this.details = const [],
  }) : id = 0,
       createdAt = DateTime.now(),
       updatedAt = DateTime.now(), // PUEDE SER NULLABLE
       deletedAt = null;

  // Factory desde entidad de base de datos
  factory JournalEntryModel.fromDatabase(JournalEntries entry) {
    return JournalEntryModel(
      id: entry.id,
      documentTypeId: entry.documentTypeId,
      secuencial: entry.secuencial,
      date: entry.date,
      description: entry.description,
      active: entry.active,
      createdAt: entry.createdAt,
      updatedAt: entry.updatedAt, // AHORA COMPATIBLE
      deletedAt: entry.deletedAt,
    );
  }

  // Factory desde entidad del dominio
  factory JournalEntryModel.fromEntity(JournalEntry entity) {
    return JournalEntryModel(
      id: entity.id,
      documentTypeId: entity.documentTypeId,
      secuencial: entity.secuencial,
      date: entity.date,
      description: entity.description,
      active: entity.active,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      deletedAt: entity.deletedAt,
      details: entity.details,
    );
  }

  // Convertir a Companion para operaciones de BD
  JournalEntriesCompanion toCompanion() {
    return JournalEntriesCompanion(
      id: id == 0 ? const Value.absent() : Value(id),
      documentTypeId: Value(documentTypeId),
      secuencial: Value(secuencial),
      date: Value(date),
      description: Value(description),
      active: Value(active),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt ?? DateTime.now()), // MANEJAR NULL
      deletedAt: Value(deletedAt),
    );
  }

  // Convertir a entidad del dominio
  JournalEntry toEntity() {
    return JournalEntry(
      id: id,
      documentTypeId: documentTypeId,
      secuencial: secuencial,
      date: date,
      description: description,
      active: active,
      createdAt: createdAt,
      updatedAt: updatedAt ?? DateTime.now(), // MANEJAR NULL
      deletedAt: deletedAt,
      details: details,
    );
  }
}
