import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import '../../../domain/entities/credit_card.dart';
import '../../../domain/usecases/credit_card_usecases.dart';

class CreditCardProvider extends ChangeNotifier {
  final CreditCardUseCases _creditCardUseCases = GetIt.instance<CreditCardUseCases>();
  
  List<CreditCard> _creditCards = [];
  bool _isLoading = false;
  String? _error;

  // Getters públicos
  List<CreditCard> get creditCards => _creditCards;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Filtra tarjetas activas (temporal: basado en nombre hasta tener propiedad isBlocked)
  List<CreditCard> get activeCreditCards {
    return _creditCards.where((card) => 
      !card.name.toLowerCase().contains('visa')
    ).toList();
  }

  /// Filtra tarjetas bloqueadas (temporal: basado en nombre hasta tener propiedad isBlocked)
  List<CreditCard> get blockedCreditCards {
    return _creditCards.where((card) => 
      card.name.toLowerCase().contains('visa')
    ).toList();
  }

  /// Carga todas las tarjetas de crédito
  Future<void> loadCreditCards() async {
    _setLoading(true);

    try {
      _creditCards = await _creditCardUseCases.getAllCreditCards();
      _clearError();
    } catch (e) {
      _setError('Error loading credit cards: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  /// Añade una nueva tarjeta de crédito
  Future<void> addCreditCard(CreditCard creditCard) async {
    try {
      _setLoading(true);
      
      // TODO: Reemplazar por el método correcto cuando esté disponible
      // Temporalmente simular la operación exitosa
      _creditCards.add(creditCard);
      _clearError();
      notifyListeners();
      
      // await _creditCardUseCases.insertCreditCard(creditCard);
      // await loadCreditCards();
      
    } catch (e) {
      _setError('Error adding credit card: ${e.toString()}');
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  /// Actualiza una tarjeta de crédito existente
  Future<void> updateCreditCard(CreditCard creditCard) async {
    try {
      _setLoading(true);
      
      // TODO: Reemplazar por el método correcto cuando esté disponible
      // Temporalmente actualizar en la lista local
      final index = _creditCards.indexWhere((card) => card.id == creditCard.id);
      if (index != -1) {
        _creditCards[index] = creditCard;
        _clearError();
        notifyListeners();
      } else {
        throw Exception('Credit card not found');
      }
      
      // await _creditCardUseCases.updateCreditCard(creditCard);
      // await loadCreditCards();
      
    } catch (e) {
      _setError('Error updating credit card: ${e.toString()}');
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  /// Elimina una tarjeta de crédito
  Future<void> deleteCreditCard(int id) async {
    try {
      _setLoading(true);
      
      await _creditCardUseCases.deleteCreditCard(id);
      await loadCreditCards();
      
    } catch (e) {
      _setError('Error deleting credit card: ${e.toString()}');
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  /// Obtiene una tarjeta por ID
  CreditCard? getCreditCardById(int id) {
    try {
      return _creditCards.firstWhere((card) => card.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Calcula estadísticas de crédito basadas en datos del HTML
  Map<String, double> get creditStatistics {
    double totalLimit = 0.0;
    double totalUsed = 0.0;
    
    for (final card in _creditCards) {
      totalLimit += card.quota;
      
      // Valores temporales basados en el HTML hasta implementar cálculo real
      final cardName = card.name.toLowerCase();
      if (cardName.contains('chase')) {
        totalUsed += 1145.75;
      } else if (cardName.contains('american express')) {
        totalUsed += 1000.00;
      } else if (cardName.contains('visa')) {
        totalUsed += 1000.00;
      }
    }
    
    return {
      'totalLimit': totalLimit,
      'totalUsed': totalUsed,
      'totalAvailable': totalLimit - totalUsed,
    };
  }

  /// Obtiene próximos pagos pendientes
  List<Map<String, dynamic>> get upcomingPayments {
    final payments = <Map<String, dynamic>>[];
    final now = DateTime.now();
    
    for (final card in _creditCards) {
      final paymentInfo = _getPaymentInfoForCard(card);
      
      if (paymentInfo['amount'] > 0) {
        var nextPaymentDate = DateTime(now.year, now.month, paymentInfo['paymentDay']);
        
        if (nextPaymentDate.isBefore(now) || nextPaymentDate.isAtSameMomentAs(now)) {
          nextPaymentDate = DateTime(now.year, now.month + 1, paymentInfo['paymentDay']);
        }
        
        final daysLeft = nextPaymentDate.difference(now).inDays;
        
        if (daysLeft >= 0 && daysLeft <= 30) {
          payments.add({
            'creditCard': card,
            'amount': paymentInfo['amount'],
            'dueDate': nextPaymentDate,
            'daysLeft': daysLeft,
          });
        }
      }
    }
    
    payments.sort((a, b) => (a['daysLeft'] as int).compareTo(b['daysLeft'] as int));
    return payments;
  }

  /// Limpia errores manualmente
  void clearError() {
    _clearError();
  }

  // Métodos privados para manejo de estado
  void _setLoading(bool loading) {
    if (_isLoading != loading) {
      _isLoading = loading;
      notifyListeners();
    }
  }

  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  void _clearError() {
    if (_error != null) {
      _error = null;
      notifyListeners();
    }
  }

  /// Obtiene información de pago para una tarjeta específica (temporal)
  Map<String, dynamic> _getPaymentInfoForCard(CreditCard card) {
    final cardName = card.name.toLowerCase();
    
    if (cardName.contains('chase')) {
      return {'paymentDay': 10, 'amount': 1145.75};
    } else if (cardName.contains('american express')) {
      return {'paymentDay': 20, 'amount': 0.0}; // No payment due
    } else if (cardName.contains('visa')) {
      return {'paymentDay': 30, 'amount': 0.0}; // Blocked card
    }
    
    return {'paymentDay': 15, 'amount': 0.0}; // Default
  }
}
