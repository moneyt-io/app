import 'package:get_it/get_it.dart';
import '../entities/credit_card.dart';
import '../entities/chart_account.dart';
import '../repositories/credit_card_repository.dart';
import '../repositories/chart_account_repository.dart';

class CreditCardUseCases {
  final CreditCardRepository _creditCardRepository;
  final ChartAccountRepository _chartAccountRepository;

  CreditCardUseCases(this._creditCardRepository, this._chartAccountRepository);

  Future<List<CreditCard>> getAllCreditCards() {
    return _creditCardRepository.getAllCreditCards();
  }

  Future<CreditCard?> getCreditCardById(int id) {
    return _creditCardRepository.getCreditCardById(id);
  }

  Future<CreditCard> createCreditCardWithAccount({
    required String name,
    String? description,
    required String currencyId,
    required double quota,
    required int closingDay,
    required int paymentDueDay,
    required double interestRate,
  }) async {
    // Use the specialized method for creating credit card chart accounts
    final chartAccount = await _chartAccountRepository.generateAccountForCreditCard('Tarjeta $name');
    
    // Then create the credit card with reference to the chart account
    return _creditCardRepository.createCreditCard(
      name: name,
      description: description,
      currencyId: currencyId,
      chartAccountId: chartAccount.id,
      quota: quota,
      closingDay: closingDay,
      paymentDueDay: paymentDueDay,
      interestRate: interestRate,
    );
  }

  Future<CreditCard> updateCreditCard(CreditCard creditCard) {
    return _creditCardRepository.updateCreditCard(creditCard);
  }

  Future<void> deleteCreditCard(int id) {
    return _creditCardRepository.deleteCreditCard(id);
  }

  // Utility method to calculate the next payment date based on today and the card's payment due day
  DateTime getNextPaymentDate(CreditCard creditCard) {
    final today = DateTime.now();
    int paymentDay = creditCard.paymentDueDay;
    
    // If today is after payment day this month, get next month's date
    if (today.day > paymentDay) {
      int nextMonth = today.month + 1;
      int year = today.year;
      if (nextMonth > 12) {
        nextMonth = 1;
        year++;
      }
      
      // Handle invalid dates (e.g., Feb 30)
      int daysInMonth = DateTime(year, nextMonth + 1, 0).day;
      if (paymentDay > daysInMonth) {
        paymentDay = daysInMonth;
      }
      
      return DateTime(year, nextMonth, paymentDay);
    } else {
      // If today is before or on payment day, use this month's date
      return DateTime(today.year, today.month, paymentDay);
    }
  }
}
