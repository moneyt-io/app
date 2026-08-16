import 'package:drift/drift.dart';
import '../../domain/entities/recurring_transaction.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/wallet.dart';
import '../../domain/entities/contact.dart';
import '../datasources/local/database.dart';

class RecurringTransactionModel {
  final int id;
  final String documentTypeId;
  final String currencyId;
  final int paymentId;
  final String paymentTypeId;
  final int categoryId;
  final int? contactId;
  final double amount;
  final double rateExchange;
  final String? description;
  final String frequency;
  final DateTime startDate;
  final DateTime? endDate;
  final DateTime? lastExecutedAt;
  final DateTime nextExecutionDate;
  final bool active;
  final bool autoCreate;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  RecurringTransactionModel({
    required this.id,
    required this.documentTypeId,
    required this.currencyId,
    required this.paymentId,
    this.paymentTypeId = 'W',
    required this.categoryId,
    this.contactId,
    required this.amount,
    this.rateExchange = 1.0,
    this.description,
    required this.frequency,
    required this.startDate,
    this.endDate,
    this.lastExecutedAt,
    required this.nextExecutionDate,
    this.active = true,
    this.autoCreate = true,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory RecurringTransactionModel.fromDatabase(RecurringTransactionData data) {
    return RecurringTransactionModel(
      id: data.id,
      documentTypeId: data.documentTypeId,
      currencyId: data.currencyId,
      paymentId: data.paymentId,
      paymentTypeId: data.paymentTypeId,
      categoryId: data.categoryId,
      contactId: data.contactId,
      amount: data.amount,
      rateExchange: data.rateExchange,
      description: data.description,
      frequency: data.frequency,
      startDate: data.startDate,
      endDate: data.endDate,
      lastExecutedAt: data.lastExecutedAt,
      nextExecutionDate: data.nextExecutionDate,
      active: data.active,
      autoCreate: data.autoCreate,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
      deletedAt: data.deletedAt,
    );
  }

  RecurringTransactionDataCompanion toCompanion() {
    return RecurringTransactionDataCompanion(
      id: id == 0 ? const Value.absent() : Value(id),
      documentTypeId: Value(documentTypeId),
      currencyId: Value(currencyId),
      paymentId: Value(paymentId),
      paymentTypeId: Value(paymentTypeId),
      categoryId: Value(categoryId),
      contactId: Value(contactId),
      amount: Value(amount),
      rateExchange: Value(rateExchange),
      description: Value(description),
      frequency: Value(frequency),
      startDate: Value(startDate),
      endDate: Value(endDate),
      lastExecutedAt: Value(lastExecutedAt),
      nextExecutionDate: Value(nextExecutionDate),
      active: Value(active),
      autoCreate: Value(autoCreate),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null ? const Value.absent() : Value(updatedAt!),
      deletedAt: Value(deletedAt),
    );
  }

  RecurringTransaction toEntity({
    Category? category,
    Wallet? wallet,
    Contact? contact,
  }) {
    return RecurringTransaction(
      id: id,
      documentTypeId: documentTypeId,
      currencyId: currencyId,
      paymentId: paymentId,
      paymentTypeId: paymentTypeId,
      categoryId: categoryId,
      contactId: contactId,
      amount: amount,
      rateExchange: rateExchange,
      description: description,
      frequency: frequency,
      startDate: startDate,
      endDate: endDate,
      lastExecutedAt: lastExecutedAt,
      nextExecutionDate: nextExecutionDate,
      active: active,
      autoCreate: autoCreate,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
      category: category,
      wallet: wallet,
      contact: contact,
    );
  }

  factory RecurringTransactionModel.fromEntity(RecurringTransaction entity) {
    return RecurringTransactionModel(
      id: entity.id,
      documentTypeId: entity.documentTypeId,
      currencyId: entity.currencyId,
      paymentId: entity.paymentId,
      paymentTypeId: entity.paymentTypeId,
      categoryId: entity.categoryId,
      contactId: entity.contactId,
      amount: entity.amount,
      rateExchange: entity.rateExchange,
      description: entity.description,
      frequency: entity.frequency,
      startDate: entity.startDate,
      endDate: entity.endDate,
      lastExecutedAt: entity.lastExecutedAt,
      nextExecutionDate: entity.nextExecutionDate,
      active: entity.active,
      autoCreate: entity.autoCreate,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      deletedAt: entity.deletedAt,
    );
  }
}
