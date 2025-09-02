import 'package:equatable/equatable.dart';

import 'contact.dart';

class LoanContactSummary extends Equatable {
  final Contact contact;
  final double totalLent;
  final double totalBorrowed;
  final int activeLoanCount;
  final DateTime? nextDueDate;
  final bool isOverdue;
  final int overdueDays;
  final String currencyId;

  const LoanContactSummary({
    required this.contact,
    required this.totalLent,
    required this.totalBorrowed,
    required this.activeLoanCount,
    this.nextDueDate,
    this.isOverdue = false,
    this.overdueDays = 0,
    required this.currencyId,
  });

  double get netBalance => totalLent - totalBorrowed;

  @override
  List<Object?> get props => [
        contact,
        totalLent,
        totalBorrowed,
        activeLoanCount,
        nextDueDate,
        isOverdue,
        overdueDays,
        currencyId,
      ];
}
