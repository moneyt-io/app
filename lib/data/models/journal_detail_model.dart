import 'package:drift/drift.dart';
import '../../domain/entities/journal_detail.dart';
import '../datasources/local/database.dart';

class JournalDetailModel {
  final int id;
  final int journalId;
  final String currencyId;
  final int chartAccountId;
  final double credit;
  final double debit;
  final double rateExchange;

  JournalDetailModel({
    required this.id,
    required this.journalId,
    required this.currencyId,
    required this.chartAccountId,
    required this.credit,
    required this.debit,
    required this.rateExchange,
  });

  // Constructor para crear nuevos detalles
  JournalDetailModel.create({
    required this.journalId,
    required this.currencyId,
    required this.chartAccountId,
    required this.credit,
    required this.debit,
    this.rateExchange = 1.0,
  }) : id = 0;

  // Factory desde entidad de base de datos
  factory JournalDetailModel.fromDatabase(JournalDetails detail) {
    return JournalDetailModel(
      id: detail.id,
      journalId: detail.journalId,
      currencyId: detail.currencyId,
      chartAccountId: detail.chartAccountId,
      credit: detail.credit,
      debit: detail.debit,
      rateExchange: detail.rateExchange,
    );
  }

  // Factory desde entidad del dominio
  factory JournalDetailModel.fromEntity(JournalDetail entity) {
    return JournalDetailModel(
      id: entity.id,
      journalId: entity.journalId,
      currencyId: entity.currencyId,
      chartAccountId: entity.chartAccountId,
      credit: entity.credit,
      debit: entity.debit,
      rateExchange: entity.rateExchange,
    );
  }

  // Convertir a Companion para operaciones de BD
  JournalDetailsCompanion toCompanion() {
    return JournalDetailsCompanion(
      id: id == 0 ? const Value.absent() : Value(id),
      journalId: Value(journalId),
      currencyId: Value(currencyId),
      chartAccountId: Value(chartAccountId),
      credit: Value(credit),
      debit: Value(debit),
      rateExchange: Value(rateExchange),
    );
  }

  // Convertir a entidad del dominio
  JournalDetail toEntity() {
    return JournalDetail(
      id: id,
      journalId: journalId,
      currencyId: currencyId,
      chartAccountId: chartAccountId,
      credit: credit,
      debit: debit,
      rateExchange: rateExchange,
    );
  }
}
