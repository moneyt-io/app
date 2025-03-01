import 'package:equatable/equatable.dart';
import 'journal_detail.dart';

class JournalEntry extends Equatable {
  final int id;
  final String documentTypeId;
  final int secuencial;
  final DateTime date;
  final String? description;
  final bool active;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final List<JournalDetail> details;

  const JournalEntry({
    required this.id,
    required this.documentTypeId,
    required this.secuencial,
    required this.date,
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
    secuencial,
    date,
    description,
    active,
    createdAt,
    updatedAt,
    deletedAt,
    details,
  ];
}
