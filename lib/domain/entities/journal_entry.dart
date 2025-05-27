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
  final DateTime? updatedAt; // CAMBIAR A NULLABLE
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
    this.updatedAt, // NULLABLE
    this.deletedAt,
    this.details = const [],
  });

  // Helper para determinar el tipo de documento
  bool get isIncome => documentTypeId == 'I';
  bool get isExpense => documentTypeId == 'E';
  bool get isTransfer => documentTypeId == 'T';
  bool get isLend => documentTypeId == 'L';
  bool get isBorrow => documentTypeId == 'B';

  // Helper para verificar el balance del asiento contable
  bool get isBalanced {
    double totalDebit = 0.0;
    double totalCredit = 0.0;
    
    for (final detail in details) {
      totalDebit += detail.debit;
      totalCredit += detail.credit;
    }
    
    // Usamos una pequeña tolerancia para evitar problemas de precisión
    const epsilon = 0.001;
    return (totalDebit - totalCredit).abs() < epsilon;
  }

  JournalEntry copyWith({
    int? id,
    String? documentTypeId,
    int? secuencial,
    DateTime? date,
    String? description,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt, // NULLABLE
    DateTime? deletedAt,
    List<JournalDetail>? details,
  }) {
    return JournalEntry(
      id: id ?? this.id,
      documentTypeId: documentTypeId ?? this.documentTypeId,
      secuencial: secuencial ?? this.secuencial,
      date: date ?? this.date,
      description: description ?? this.description,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt, // NULLABLE
      deletedAt: deletedAt ?? this.deletedAt,
      details: details ?? this.details,
    );
  }

  @override
  List<Object?> get props => [
    id,
    documentTypeId,
    secuencial,
    date,
    description,
    active,
    createdAt,
    updatedAt, // PUEDE SER NULL
    deletedAt, // PUEDE SER NULL
    details,
  ];
}
