import 'package:equatable/equatable.dart';
import '../enums/recurrence_frequency.dart';
import 'category.dart';
import 'wallet.dart';
import 'contact.dart';

class RecurringTransaction extends Equatable {
  final int id;
  final String documentTypeId; // 'E' (Expense) or 'I' (Income)
  final String currencyId;
  final int paymentId; // Wallet ID or Credit Card ID
  final String paymentTypeId; // 'W' (Wallet) or 'C' (Credit Card)
  final int categoryId;
  final int? contactId;
  final double amount;
  final double rateExchange;
  final String? description;
  final String frequency; // 'daily', 'weekly', 'monthly', 'bimonthly', 'quarterly', 'yearly'
  final DateTime startDate;
  final DateTime? endDate;
  final DateTime? lastExecutedAt;
  final DateTime nextExecutionDate;
  final bool active;
  final bool autoCreate;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  // Joined presentation data (optional)
  final Category? category;
  final Wallet? wallet;
  final Contact? contact;

  const RecurringTransaction({
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
    this.category,
    this.wallet,
    this.contact,
  });

  bool get isIncome => documentTypeId == 'I';
  bool get isExpense => documentTypeId == 'E';
  bool get isCreditCard => paymentTypeId == 'C';

  RecurrenceFrequency get recurrenceFrequency =>
      RecurrenceFrequency.fromKey(frequency) ?? RecurrenceFrequency.monthly;

  RecurringTransaction copyWith({
    int? id,
    String? documentTypeId,
    String? currencyId,
    int? paymentId,
    String? paymentTypeId,
    int? categoryId,
    int? contactId,
    double? amount,
    double? rateExchange,
    String? description,
    String? frequency,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? lastExecutedAt,
    DateTime? nextExecutionDate,
    bool? active,
    bool? autoCreate,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Category? category,
    Wallet? wallet,
    Contact? contact,
  }) {
    return RecurringTransaction(
      id: id ?? this.id,
      documentTypeId: documentTypeId ?? this.documentTypeId,
      currencyId: currencyId ?? this.currencyId,
      paymentId: paymentId ?? this.paymentId,
      paymentTypeId: paymentTypeId ?? this.paymentTypeId,
      categoryId: categoryId ?? this.categoryId,
      contactId: contactId ?? this.contactId,
      amount: amount ?? this.amount,
      rateExchange: rateExchange ?? this.rateExchange,
      description: description ?? this.description,
      frequency: frequency ?? this.frequency,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      lastExecutedAt: lastExecutedAt ?? this.lastExecutedAt,
      nextExecutionDate: nextExecutionDate ?? this.nextExecutionDate,
      active: active ?? this.active,
      autoCreate: autoCreate ?? this.autoCreate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      category: category ?? this.category,
      wallet: wallet ?? this.wallet,
      contact: contact ?? this.contact,
    );
  }

  @override
  List<Object?> get props => [
        id,
        documentTypeId,
        currencyId,
        paymentId,
        paymentTypeId,
        categoryId,
        contactId,
        amount,
        rateExchange,
        description,
        frequency,
        startDate,
        endDate,
        lastExecutedAt,
        nextExecutionDate,
        active,
        autoCreate,
        createdAt,
        updatedAt,
        deletedAt,
      ];
}
