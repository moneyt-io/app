import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/credit_card_table.dart';

part 'credit_card_dao.g.dart';

@DriftAccessor(tables: [CreditCards])
class CreditCardDao extends DatabaseAccessor<AppDatabase> with _$CreditCardDaoMixin {
  CreditCardDao(AppDatabase db) : super(db);

  // Consultas básicas
  Future<List<CreditCard>> getAllCreditCards() => 
      (select(creditCards)..where((c) => c.active.equals(true))).get();

  Stream<List<CreditCard>> watchAllCreditCards() => 
      (select(creditCards)..where((c) => c.active.equals(true))).watch();

  Future<CreditCard> getCreditCardById(int id) =>
      (select(creditCards)..where((c) => c.id.equals(id))).getSingle();

  // Operaciones CRUD
  Future<int> insertCreditCard(CreditCard creditCard) =>
      into(creditCards).insert(creditCard);

  Future<bool> updateCreditCard(CreditCard creditCard) =>
      update(creditCards).replace(creditCard);

  // Soft delete con customUpdate
  Future<int> softDeleteCreditCard(int id) =>
      customUpdate(
        'UPDATE credit_cards SET active = FALSE, deleted_at = ? WHERE id = ?',
        variables: [Variable.withDateTime(DateTime.now()), Variable.withInt(id)],
        updates: {creditCards},
      );

  // Consulta por cuenta contable
  Future<List<CreditCard>> getCreditCardsByChartAccount(int chartAccountId) =>
      (select(creditCards)
        ..where((c) => c.chartAccountId.equals(chartAccountId) & c.active.equals(true)))
        .get();
}
