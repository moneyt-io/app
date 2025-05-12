import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/credit_cards_table.dart';

part 'credit_cards_dao.g.dart';

@DriftAccessor(tables: [CreditCard])
class CreditCardDao extends DatabaseAccessor<AppDatabase> with _$CreditCardDaoMixin {
  CreditCardDao(AppDatabase db) : super(db);

  Future<List<CreditCards>> getAllCreditCards() => select(creditCard).get();
  
  Future<CreditCards?> getCreditCardById(int id) =>
      (select(creditCard)..where((t) => t.id.equals(id))).getSingleOrNull();

  Stream<List<CreditCards>> watchAllCreditCards() => select(creditCard).watch();

  Future<int> insertCreditCard(CreditCardsCompanion creditCard) =>
      into(this.creditCard).insert(creditCard);

  Future<bool> updateCreditCard(CreditCardsCompanion creditCard) =>
      update(this.creditCard).replace(creditCard);

  Future<int> deleteCreditCard(int id) =>
      (delete(creditCard)..where((t) => t.id.equals(id))).go();
}
