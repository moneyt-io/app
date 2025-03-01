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

  JournalDetailsCompanion toCompanion() => JournalDetailsCompanion(
    id: id == 0 ? const Value.absent() : Value(id),
    journalId: Value(journalId),
    currencyId: Value(currencyId),
    chartAccountId: Value(chartAccountId),
    credit: Value(credit),
    debit: Value(debit),
    rateExchange: Value(rateExchange),
  );

  JournalDetail toEntity() => JournalDetail(
    id: id,
    journalId: journalId,
    currencyId: currencyId,
    chartAccountId: chartAccountId,
    credit: credit,
    debit: debit,
    rateExchange: rateExchange,
  );

  factory JournalDetailModel.fromEntity(JournalDetail entity) => JournalDetailModel(
    id: entity.id,
    journalId: entity.journalId,
    currencyId: entity.currencyId,
    chartAccountId: entity.chartAccountId,
    credit: entity.credit,
    debit: entity.debit,
    rateExchange: entity.rateExchange,
  );
}
