import '../entities/credit_card.dart';

abstract class CreditCardRepository {
  Future<List<CreditCard>> getAllCreditCards();
  Future<CreditCard?> getCreditCardById(int id);
  Stream<List<CreditCard>> watchAllCreditCards();
  Future<CreditCard> createCreditCard(CreditCard creditCard);
  Future<void> updateCreditCard(CreditCard creditCard);
  Future<void> deleteCreditCard(int id);
}
