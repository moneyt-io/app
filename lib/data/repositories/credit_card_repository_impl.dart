import 'package:injectable/injectable.dart';
import '../../domain/entities/credit_card.dart';
import '../../domain/repositories/credit_card_repository.dart';
import '../local/daos/credit_card_dao.dart';
import '../models/credit_card_model.dart';

@Injectable(as: CreditCardRepository)
class CreditCardRepositoryImpl implements CreditCardRepository {
  final CreditCardDao _dao;

  CreditCardRepositoryImpl(this._dao);

  @override
  Future<List<CreditCard>> getAllCreditCards() async {
    final cards = await _dao.getAllCreditCards();
    return cards.map((card) => CreditCardModel(
      id: card.id,
      currencyId: card.currencyId,
      chartAccountId: card.chartAccountId,
      name: card.name,
      description: card.description,
      quota: card.quota,
      closingDate: card.closingDate,
      active: card.active,
      createdAt: card.createdAt,
      updatedAt: card.updatedAt,
      deletedAt: card.deletedAt,
    ).toEntity()).toList();
  }

  @override
  Future<CreditCard?> getCreditCardById(int id) async {
    final card = await _dao.getCreditCardById(id);
    if (card == null) return null;
    
    return CreditCardModel(
      id: card.id,
      currencyId: card.currencyId,
      chartAccountId: card.chartAccountId,
      name: card.name,
      description: card.description,
      quota: card.quota,
      closingDate: card.closingDate,
      active: card.active,
      createdAt: card.createdAt,
      updatedAt: card.updatedAt,
      deletedAt: card.deletedAt,
    ).toEntity();
  }

  @override
  Stream<List<CreditCard>> watchCreditCards() {
    return _dao.watchAllCreditCards().map(
      (cards) => cards.map((card) => CreditCardModel(
        id: card.id,
        currencyId: card.currencyId,
        chartAccountId: card.chartAccountId,
        name: card.name,
        description: card.description,
        quota: card.quota,
        closingDate: card.closingDate,
        active: card.active,
        createdAt: card.createdAt,
        updatedAt: card.updatedAt,
        deletedAt: card.deletedAt,
      ).toEntity()).toList()
    );
  }

  @override
  Future<CreditCard> createCreditCard(CreditCard creditCard) async {
    final model = CreditCardModel.fromEntity(creditCard);
    final id = await _dao.insertCreditCard(model.toCompanion());
    final createdCard = await getCreditCardById(id);
    if (createdCard == null) {
      throw Exception('Failed to create credit card');
    }
    return createdCard;
  }

  @override
  Future<void> updateCreditCard(CreditCard creditCard) async {
    final model = CreditCardModel.fromEntity(creditCard);
    await _dao.updateCreditCard(model.toCompanion());
  }

  @override
  Future<void> deleteCreditCard(int id) => _dao.deleteCreditCard(id);
}
