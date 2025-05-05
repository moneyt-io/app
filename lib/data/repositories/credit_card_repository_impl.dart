import 'package:drift/drift.dart';
import '../../domain/entities/credit_card.dart';
import '../../domain/repositories/credit_card_repository.dart';
import '../datasources/local/database.dart';

class CreditCardRepositoryImpl implements CreditCardRepository {
  final AppDatabase _database;

  CreditCardRepositoryImpl(this._database);

  @override
  Future<List<CreditCard>> getAllCreditCards() async {
    // Replace the selectOnly with regular select method
    final query = _database.select(_database.creditCard).join([
      innerJoin(
        _database.chartAccount,
        _database.chartAccount.id.equalsExp(_database.creditCard.chartAccountId),
      )
    ]);
    
    final results = await query.get();
    return results.map((row) => _mapToCreditCard(row)).toList();
  }

  @override
  Future<CreditCard?> getCreditCardById(int id) async {
    final query = _database.select(_database.creditCard).join([
      innerJoin(
        _database.chartAccount,
        _database.chartAccount.id.equalsExp(_database.creditCard.chartAccountId),
      )
    ]);
    
    query.where(_database.creditCard.id.equals(id));
    final result = await query.getSingleOrNull();
    
    if (result == null) return null;
    return _mapToCreditCard(result);
  }

  @override
  Future<CreditCard> createCreditCard({
    required String name,
    String? description,
    required String currencyId,
    required int chartAccountId,
    required double quota,
    required int closingDay,
    required int paymentDueDay,
    required double interestRate,
  }) async {
    final id = await _database.into(_database.creditCard).insert(
      CreditCardsCompanion.insert(
        name: name,
        description: Value(description),
        currencyId: currencyId,
        chartAccountId: chartAccountId,
        quota: quota,
        closingDay: closingDay,
        paymentDueDay: paymentDueDay,
        interestRate: Value(interestRate),
        active: Value(true),
        createdAt: DateTime.now(), // Direct DateTime, not Value<DateTime>
        updatedAt: Value(DateTime.now()),
        deletedAt: const Value(null),
      ),
    );
    
    return CreditCard(
      id: id,
      name: name,
      description: description,
      currencyId: currencyId,
      chartAccountId: chartAccountId,
      quota: quota,
      closingDay: closingDay,
      paymentDueDay: paymentDueDay,
      interestRate: interestRate,
      active: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      deletedAt: null,
    );
  }

  @override
  Future<CreditCard> updateCreditCard(CreditCard creditCard) async {
    await _database.update(_database.creditCard).replace(
      CreditCardsCompanion(
        id: Value(creditCard.id),
        name: Value(creditCard.name),
        description: Value(creditCard.description),
        currencyId: Value(creditCard.currencyId),
        chartAccountId: Value(creditCard.chartAccountId),
        quota: Value(creditCard.quota),
        closingDay: Value(creditCard.closingDay),
        paymentDueDay: Value(creditCard.paymentDueDay),
        interestRate: Value(creditCard.interestRate),
        active: Value(creditCard.active),
        createdAt: Value(creditCard.createdAt),
        updatedAt: Value(DateTime.now()),
        deletedAt: Value(creditCard.deletedAt),
      ),
    );
    
    return creditCard.copyWith(updatedAt: DateTime.now());
  }

  @override
  Future<void> deleteCreditCard(int id) async {
    await _database.update(_database.creditCard)
      .write(CreditCardsCompanion(
        deletedAt: Value(DateTime.now()),
        active: const Value(false),
      ));
  }

  CreditCard _mapToCreditCard(TypedResult row) {
    return CreditCard(
      id: row.read(_database.creditCard.id)!,
      name: row.read(_database.creditCard.name)!,
      description: row.read(_database.creditCard.description),
      currencyId: row.read(_database.creditCard.currencyId)!,
      chartAccountId: row.read(_database.creditCard.chartAccountId)!,
      quota: row.read(_database.creditCard.quota)!,
      closingDay: row.read(_database.creditCard.closingDay)!,
      paymentDueDay: row.read(_database.creditCard.paymentDueDay)!,
      interestRate: row.read(_database.creditCard.interestRate)!,
      active: row.read(_database.creditCard.active)!,
      createdAt: row.read(_database.creditCard.createdAt)!,
      updatedAt: row.read(_database.creditCard.updatedAt)!,
      deletedAt: row.read(_database.creditCard.deletedAt),
    );
  }
}
