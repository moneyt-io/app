import 'package:equatable/equatable.dart';
import 'loan_detail.dart';
import 'contact.dart';

enum LoanStatus { active, paid, cancelled, writtenOff }

class LoanEntry extends Equatable {
  final int id;
  final String documentTypeId; // 'L' o 'B'
  final String currencyId;
  final int contactId;
  final int secuencial;
  final DateTime date;
  final double amount;
  final double rateExchange;
  final String? description;
  final LoanStatus status;
  final double totalPaid; // AGREGADO
  final bool active;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final List<LoanDetail> details;
  
  // Entidades relacionadas cargadas
  final Contact? contact;

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
    this.totalPaid = 0.0, // AGREGADO
    required this.active,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.details = const [],
    this.contact,
  });

  // Getters helper críticos para UI
  double get outstandingBalance => amount - totalPaid;
  bool get isPaid => outstandingBalance <= 0.01; // Tolerancia para decimales
  bool get isActive => status == LoanStatus.active && !isPaid;
  bool get canReceivePayments => isActive;
  bool get canWriteOff => isActive && outstandingBalance > 0;
  bool get isLend => documentTypeId == 'L';
  bool get isBorrow => documentTypeId == 'B';

  LoanEntry copyWith({
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
    double? totalPaid, // AGREGADO
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    List<LoanDetail>? details,
    Contact? contact,
  }) {
    return LoanEntry(
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
      totalPaid: totalPaid ?? this.totalPaid, // AGREGADO
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      details: details ?? this.details,
      contact: contact ?? this.contact,
    );
  }

  @override
  List<Object?> get props => [
        id,
        documentTypeId,
        currencyId,
        contactId,
        secuencial,
        date,
        amount,
        rateExchange,
        description,
        status,
        totalPaid, // AGREGADO
        active,
        createdAt,
        updatedAt,
        deletedAt,
        details,
        contact,
      ];

  @override
  String toString() {
    return 'LoanEntry{id: $id, documentTypeId: $documentTypeId, contactId: $contactId, amount: $amount, totalPaid: $totalPaid, status: $status}';
  }
}
