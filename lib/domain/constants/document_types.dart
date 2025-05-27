enum DocumentType {
  income('I'),
  expense('E'),
  transfer('T'),
  lend('L'),
  borrow('B'),
  payment('P');

  const DocumentType(this.code);
  final String code;

  String get displayName {
    switch (this) {
      case DocumentType.income:
        return 'Ingreso';
      case DocumentType.expense:
        return 'Gasto';
      case DocumentType.transfer:
        return 'Transferencia';
      case DocumentType.lend:
        return 'Préstamo Otorgado';
      case DocumentType.borrow:
        return 'Préstamo Recibido';
      case DocumentType.payment:
        return 'Pago de Tarjeta';
    }
  }

  static DocumentType fromCode(String code) {
    return DocumentType.values.firstWhere(
      (type) => type.code == code,
      orElse: () => DocumentType.income,
    );
  }
}

enum PaymentType {
  wallet('W'),
  creditCard('C'),
  transaction('T');

  const PaymentType(this.code);
  final String code;

  String get displayName {
    switch (this) {
      case PaymentType.wallet:
        return 'Wallet/Efectivo';
      case PaymentType.creditCard:
        return 'Tarjeta de Crédito';
      case PaymentType.transaction:
        return 'Sin Transferencia';
    }
  }

  static PaymentType fromCode(String code) {
    return PaymentType.values.firstWhere(
      (type) => type.code == code,
      orElse: () => PaymentType.wallet,
    );
  }
}

enum FlowType {
  from('F'),
  to('T');

  const FlowType(this.code);
  final String code;

  String get displayName {
    switch (this) {
      case FlowType.from:
        return 'Desde';
      case FlowType.to:
        return 'Hacia';
    }
  }

  static FlowType fromCode(String code) {
    return FlowType.values.firstWhere(
      (type) => type.code == code,
      orElse: () => FlowType.from,
    );
  }
}

enum AccountingType {
  assets('As'),
  liabilities('Li'),
  equity('Eq'),
  income('In'),
  expenses('Ex');

  const AccountingType(this.code);
  final String code;

  String get displayName {
    switch (this) {
      case AccountingType.assets:
        return 'Activos';
      case AccountingType.liabilities:
        return 'Pasivos';
      case AccountingType.equity:
        return 'Patrimonio';
      case AccountingType.income:
        return 'Ingresos';
      case AccountingType.expenses:
        return 'Gastos';
    }
  }

  static AccountingType fromCode(String code) {
    return AccountingType.values.firstWhere(
      (type) => type.code == code,
      orElse: () => AccountingType.assets,
    );
  }
}
