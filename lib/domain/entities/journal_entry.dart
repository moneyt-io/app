import 'package:equatable/equatable.dart';
import 'journal_detail.dart';

class JournalEntry extends Equatable {
  final int id;
  final String documentTypeId;  // Referencia a document_types (I,E,T,L,B)
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
    required this.details,
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

  @override
  List<Object?> get props => [
    id, documentTypeId, secuencial, date, description,
    active, createdAt, updatedAt, deletedAt
  ];
}
