import 'package:drift/drift.dart';
import '../../domain/entities/shared_expense_detail.dart';
import '../datasources/local/database.dart';

class SharedExpenseDetailModel {
  final int id;
  final int sharedExpenseId;
  final String currencyId;
  final int loanId;
  final int transactionId;
  final double percentage;
  final double amount;
  final double rateExchange;
  final String status;

  SharedExpenseDetailModel({
    required this.id,
    required this.sharedExpenseId,
    required this.currencyId,
    required this.loanId,
    required this.transactionId,
    required this.percentage,
    required this.amount,
    required this.rateExchange,
    required this.status,
  });

  SharedExpenseDetailModel.create({
    required this.sharedExpenseId,
    required this.currencyId,
    required this.loanId,
    required this.transactionId,
    required this.percentage,
    required this.amount,
    required this.rateExchange,
    required this.status,
  }) : id = 0;

  SharedExpenseDetailsCompanion toCompanion() => SharedExpenseDetailsCompanion(
        id: id == 0 ? const Value.absent() : Value(id),
        sharedExpenseId: Value(sharedExpenseId),
        currencyId: Value(currencyId),
        loanId: Value(loanId),
        transactionId: Value(transactionId),
        percentage: Value(percentage),
        amount: Value(amount),
        rateExchange: Value(rateExchange),
        status: Value(status),
      );

  SharedExpenseDetail toEntity() => SharedExpenseDetail(
        id: id,
        sharedExpenseId: sharedExpenseId,
        currencyId: currencyId,
        loanId: loanId,
        transactionId: transactionId,
        percentage: percentage,
        amount: amount,
        rateExchange: rateExchange,
        status: status,
      );

  factory SharedExpenseDetailModel.fromEntity(SharedExpenseDetail entity) =>
      SharedExpenseDetailModel(
        id: entity.id,
        sharedExpenseId: entity.sharedExpenseId,
        currencyId: entity.currencyId,
        loanId: entity.loanId,
        transactionId: entity.transactionId,
        percentage: entity.percentage,
        amount: entity.amount,
        rateExchange: entity.rateExchange,
        status: entity.status,
      );
}
