import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/credit_cards_table.dart';

part 'credit_cards_dao.g.dart';

@DriftAccessor(tables: [CreditCard])
class CreditCardDao extends DatabaseAccessor<AppDatabase> with _$CreditCardDaoMixin {
  CreditCardDao(AppDatabase db) : super(db);

  // Cambiado el tipo de retorno a CreditCardData
  Future<List<CreditCards>> getAllCreditCards() => select(creditCard).get();
  
  // Cambiado el tipo de retorno a CreditCardData
  Future<CreditCards?> getCreditCardById(int id) =>
      (select(creditCard)..where((t) => t.id.equals(id))).getSingleOrNull();

  // Cambiado el tipo de retorno a CreditCardData
  Stream<List<CreditCards>> watchAllCreditCards() => select(creditCard).watch();

  Future<int> insertCreditCard(CreditCardsCompanion creditCard) =>
      into(this.creditCard).insert(creditCard);

  Future<bool> updateCreditCard(CreditCardsCompanion creditCard) =>
      update(this.creditCard).replace(creditCard);

  Future<int> deleteCreditCard(int id) =>
      (delete(creditCard)..where((t) => t.id.equals(id))).go();
}
