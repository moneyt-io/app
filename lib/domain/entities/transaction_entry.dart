import 'package:equatable/equatable.dart';
import '../../domain/entities/contact.dart';
import '../../domain/entities/wallet.dart';
import '../../domain/entities/category.dart';
import 'transaction_detail.dart';

class TransactionEntry extends Equatable {
  final int id;
  final String documentTypeId;
  final String currencyId;
  final int journalId;
  final int? contactId;
  final int secuencial;
  final DateTime date;
  final double amount;
  final double rateExchange;
  final String? description;
  final bool active;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final List<TransactionDetail> details;
  final Contact? contact;
  final Wallet? wallet;
  final Category? category;

  const TransactionEntry({
    required this.id,
    required this.documentTypeId,
    required this.currencyId,
    required this.journalId,
    this.contactId,
    required this.secuencial,
    required this.date,
    required this.amount,
    required this.rateExchange,
    this.description,
    required this.active,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.details = const [],
    this.contact,
    this.wallet,
    this.category,
  });

  // Métodos de utilidad
  bool get isIncome => documentTypeId == 'I';
  bool get isExpense => documentTypeId == 'E';
  bool get isTransfer => documentTypeId == 'T';
  
  // Para obtener el detalle principal (primero en la lista)
  TransactionDetail? get mainDetail => details.isNotEmpty ? details.first : null;
  
  // Wallet ID que representa la cuenta principal de la transacción
  int? get mainWalletId => mainDetail?.paymentId;
  
  // Categoría principal de la transacción
  int? get mainCategoryId => mainDetail?.categoryId;
  
  // Detalle origen en transferencias
  TransactionDetail? get sourceDetail => 
      isTransfer && details.isNotEmpty ? 
      details.firstWhere((d) => d.flowId == 'F', orElse: () => details.first) : 
      null;
  
  // Detalle destino en transferencias
  TransactionDetail? get targetDetail => 
      isTransfer && details.length > 1 ? 
      details.firstWhere((d) => d.flowId == 'T', orElse: () => details.last) : 
      null;
  
  @override
  List<Object?> get props => [
    id,
    documentTypeId,
    currencyId,
    journalId,
    contactId,
    secuencial,
    date,
    amount,
    rateExchange,
    description,
    active,
    createdAt,
    updatedAt,
    deletedAt,
    details,
  ];
}
