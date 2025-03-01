import 'package:equatable/equatable.dart';

class JournalDetail extends Equatable {
  final int id;
  final int journalId;
  final String currencyId;
  final int chartAccountId;
  final double credit;
  final double debit;
  final double rateExchange;

  const JournalDetail({
    required this.id,
    required this.journalId,
    required this.currencyId,
    required this.chartAccountId,
    required this.credit,
    required this.debit,
    required this.rateExchange,
  });

  @override
  List<Object?> get props => [
    id,
    journalId,
    currencyId,
    chartAccountId,
    credit,
    debit,
    rateExchange,
  ];
}
