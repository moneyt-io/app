import 'package:get_it/get_it.dart';
import '../entities/credit_card.dart';
import '../entities/chart_account.dart';
import '../repositories/credit_card_repository.dart';
import '../repositories/chart_account_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

@injectable
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

  Stream<List<CreditCard>> watchAllCreditCards() {
    return _creditCardRepository.watchAllCreditCards();
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
    
    // Create the credit card with the generated chart account
    final creditCard = CreditCard(
      id: 0,
      currencyId: currencyId,
      chartAccountId: chartAccount.id,
      name: name,
      description: description,
      quota: quota,
      closingDay: closingDay,
      paymentDueDay: paymentDueDay,
      interestRate: interestRate,
      active: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      deletedAt: null,
    );
    
    return _creditCardRepository.createCreditCard(creditCard);
  }

  Future<void> updateCreditCard(CreditCard creditCard) {
    return _creditCardRepository.updateCreditCard(creditCard);
  }

  Future<void> deleteCreditCard(int id) {
    return _creditCardRepository.deleteCreditCard(id);
  }

  /// Calcula la próxima fecha de pago para una tarjeta de crédito.
  /// 
  /// Basado en el día de pago (paymentDueDay) y el mes actual.
  /// Si el día de pago ya pasó este mes, devuelve la fecha del próximo mes.
  /// 
  /// @param creditCard La tarjeta de crédito para la que se calcula la fecha de pago
  /// @return Un objeto DateTime con la fecha del próximo pago
  DateTime getNextPaymentDate(CreditCard creditCard) {
    final now = DateTime.now();
    
    // Crear una fecha con el día de pago de este mes
    DateTime paymentDate = DateTime(now.year, now.month, creditCard.paymentDueDay);
    
    // Si el día de pago ya pasó este mes, calcular para el próximo mes
    if (paymentDate.isBefore(now)) {
      // Avanzar al próximo mes
      int nextMonth = now.month + 1;
      int year = now.year;
      
      // Manejar cambio de año
      if (nextMonth > 12) {
        nextMonth = 1;
        year++;
      }
      
      paymentDate = DateTime(year, nextMonth, creditCard.paymentDueDay);
    }
    
    return paymentDate;
  }
  
  /// Calcula el crédito disponible para una tarjeta.
  /// Por ahora, simplemente devuelve el cupo total, pero en una implementación real
  /// debería restar el saldo utilizado.
  double getAvailableCredit(CreditCard creditCard) {
    // TODO: Implementar lógica para obtener saldo usado y calcular disponible
    return creditCard.quota;
  }
}
