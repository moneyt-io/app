import 'package:equatable/equatable.dart';
import 'contact.dart';
import 'loan_detail.dart' as loan_detail;

enum LoanStatus { active, paid, cancelled, writtenOff }

class LoanEntry extends Equatable {
  final int id;
  final String documentTypeId; // 'L' (Lend) o 'B' (Borrow)
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
  
  // Entidades relacionadas cargadas
  final Contact? contact;
  final List<loan_detail.LoanDetail> details;

  const LoanEntry({
    required this.id,
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
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.contact,
    this.details = const [],
  });

  /// Calcula el saldo pendiente del préstamo
  double get outstandingBalance => amount - totalPaid;

  /// Verifica si el préstamo está completamente pagado
  bool get isPaid => outstandingBalance <= 0 || status == LoanStatus.paid;

  /// Verifica si es un préstamo otorgado (prestado a otros)
  bool get isLend => documentTypeId == 'L';

  /// Verifica si es un préstamo recibido (prestado de otros)
  bool get isBorrow => documentTypeId == 'B';

  /// Verifica si se puede realizar un pago en este préstamo
  bool get canMakePayment => status == LoanStatus.active && outstandingBalance > 0;

  /// Verifica si se puede cancelar el saldo pendiente del préstamo
  bool get canWriteOff => status == LoanStatus.active && outstandingBalance > 0;

  /// Verifica si es un préstamo otorgado (alias para isLend)
  bool get isLendLoan => documentTypeId == 'L';

  /// Verifica si es un préstamo recibido (alias para isBorrow)  
  bool get isBorrowLoan => documentTypeId == 'B';

  /// Calcula el porcentaje pagado del préstamo
  double get paymentPercentage {
    if (amount <= 0) return 0.0;
    return (totalPaid / amount * 100).clamp(0.0, 100.0);
  }

  /// Verifica si el préstamo está activo y puede ser modificado
  bool get isActive => status == LoanStatus.active && active;

  /// Verifica si el préstamo fue cancelado o dado de baja
  bool get isCancelledOrWrittenOff => 
      status == LoanStatus.cancelled || status == LoanStatus.writtenOff;

  /// Crea una copia del préstamo con los campos especificados modificados
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
    double? totalPaid,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Contact? contact,
    List<loan_detail.LoanDetail>? details,
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
      totalPaid: totalPaid ?? this.totalPaid,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      contact: contact ?? this.contact,
      details: details ?? this.details,
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
        totalPaid,
        active,
        createdAt,
        updatedAt,
        deletedAt,
        contact,
        details,
      ];

  @override
  String toString() {
    return 'LoanEntry('
        'id: $id, '
        'documentTypeId: $documentTypeId, '
        'contactId: $contactId, '
        'amount: $amount, '
        'totalPaid: $totalPaid, '
        'status: $status, '
        'outstandingBalance: $outstandingBalance'
        ')';
  }
}
