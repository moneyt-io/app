enum AccountingType {
  assets('As', 'Activos'),
  liabilities('Li', 'Pasivos'),
  equity('Eq', 'Patrimonio'),
  income('In', 'Ingresos'),
  expenses('Ex', 'Gastos');

  final String id;
  final String name;
  const AccountingType(this.id, this.name);
  
  static AccountingType fromId(String id) {
    return AccountingType.values.firstWhere(
      (type) => type.id == id,
      orElse: () => throw ArgumentError('ID de tipo contable inválido: $id'),
    );
  }
  
  static List<Map<String, String>> getAll() {
    return AccountingType.values.map((type) => {
      'id': type.id,
      'name': type.name,
    }).toList();
  }
}
