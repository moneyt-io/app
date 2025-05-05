import '../entities/credit_card.dart';

abstract class CreditCardRepository {
  Future<List<CreditCard>> getAllCreditCards();
  Future<CreditCard?> getCreditCardById(int id);
  Future<CreditCard> createCreditCard({
    required String name,
    String? description,
    required String currencyId,
    required int chartAccountId,
    required double quota,
    required int closingDay,
    required int paymentDueDay,
    required double interestRate,
  });
  Future<CreditCard> updateCreditCard(CreditCard creditCard);
  Future<void> deleteCreditCard(int id);
}
