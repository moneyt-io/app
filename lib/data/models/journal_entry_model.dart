import 'package:drift/drift.dart';
import '../../domain/entities/journal_entry.dart';
import '../datasources/local/database.dart';
import 'journal_detail_model.dart';

class JournalEntryModel {
  final int id;
  final String documentTypeId;
  final int secuencial;
  final DateTime date;
  final String? description;
  final bool active;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  JournalEntryModel({
    required this.id,
    required this.documentTypeId,
    required this.secuencial,
    required this.date,
    this.description,
    required this.active,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  JournalEntryModel.create({
    required this.documentTypeId,
    required this.secuencial,
    required this.date,
    this.description,
    bool? active,
  })  : id = 0,
        active = active ?? true,
        createdAt = DateTime.now(),
        updatedAt = null,
        deletedAt = null;

  JournalEntriesCompanion toCompanion() => JournalEntriesCompanion(
    id: id == 0 ? const Value.absent() : Value(id),
    documentTypeId: Value(documentTypeId),
    secuencial: Value(secuencial),
    date: Value(date),
    description: Value(description),
    active: Value(active),
    createdAt: Value(createdAt),
    updatedAt: Value(updatedAt),
    deletedAt: Value(deletedAt),
  );

  JournalEntry toEntity({List<JournalDetailModel> details = const []}) => JournalEntry(
    id: id,
    documentTypeId: documentTypeId,
    secuencial: secuencial,
    date: date,
    description: description,
    active: active,
    createdAt: createdAt,
    updatedAt: updatedAt,
    deletedAt: deletedAt,
    details: details.map((detail) => detail.toEntity()).toList(),
  );

  factory JournalEntryModel.fromEntity(JournalEntry entity) => JournalEntryModel(
    id: entity.id,
    documentTypeId: entity.documentTypeId,
    secuencial: entity.secuencial,
    date: entity.date,
    description: entity.description,
    active: entity.active,
    createdAt: entity.createdAt,
    updatedAt: entity.updatedAt,
    deletedAt: entity.deletedAt,
  );
}
