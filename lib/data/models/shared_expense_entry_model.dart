import 'package:drift/drift.dart';
import '../../domain/entities/shared_expense_detail.dart';
import '../../domain/entities/shared_expense_entry.dart';
import '../datasources/local/database.dart';

class SharedExpenseEntryModel {
  final int id;
  final String documentTypeId;
  final String currencyId;
  final int secuencial;
  final DateTime date;
  final double amount;
  final double rateExchange;
  final bool active;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  SharedExpenseEntryModel({
    required this.id,
    required this.documentTypeId,
    required this.currencyId,
    required this.secuencial,
    required this.date,
    required this.amount,
    required this.rateExchange,
    required this.active,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  SharedExpenseEntryModel.create({
    required this.documentTypeId,
    required this.currencyId,
    required this.secuencial,
    required this.date,
    required this.amount,
    required this.rateExchange,
  })  : id = 0,
        active = true,
        createdAt = DateTime.now(),
        updatedAt = null,
        deletedAt = null;

  SharedExpenseEntriesCompanion toCompanion() => SharedExpenseEntriesCompanion(
        id: id == 0 ? const Value.absent() : Value(id),
        documentTypeId: Value(documentTypeId),
        currencyId: Value(currencyId),
        secuencial: Value(secuencial),
        date: Value(date),
        amount: Value(amount),
        rateExchange: Value(rateExchange),
        active: Value(active),
        createdAt: Value(createdAt),
        updatedAt: Value(updatedAt),
        deletedAt: Value(deletedAt),
      );

  SharedExpenseEntry toEntity({List<SharedExpenseDetail> details = const []}) => 
      SharedExpenseEntry(
        id: id,
        documentTypeId: documentTypeId,
        currencyId: currencyId,
        secuencial: secuencial,
        date: date,
        amount: amount,
        rateExchange: rateExchange,
        active: active,
        createdAt: createdAt,
        updatedAt: updatedAt,
        deletedAt: deletedAt,
        details: details,
      );

  factory SharedExpenseEntryModel.fromEntity(SharedExpenseEntry entity) => 
      SharedExpenseEntryModel(
        id: entity.id,
        documentTypeId: entity.documentTypeId,
        currencyId: entity.currencyId,
        secuencial: entity.secuencial,
        date: entity.date,
        amount: entity.amount,
        rateExchange: entity.rateExchange,
        active: entity.active,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
        deletedAt: entity.deletedAt,
      );
}
