import 'package:equatable/equatable.dart';
import 'accounting_type.dart';

class ChartAccount extends Equatable {
  final int id;
  final int? parentId;
  final String accountingTypeId;  // Referencia a AccountingType.id
  final String code;
  final int level;
  final String name;
  final bool active;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  
  const ChartAccount({
    required this.id,
    this.parentId,
    required this.accountingTypeId,
    required this.code,
    required this.level,
    required this.name,
    required this.active,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });
  
  // Getters para el tipo de cuenta
  bool get isAssetAccount => accountingTypeId == AccountingType.assets.id;
  bool get isLiabilityAccount => accountingTypeId == AccountingType.liabilities.id;
  bool get isEquityAccount => accountingTypeId == AccountingType.equity.id;
  bool get isIncomeAccount => accountingTypeId == AccountingType.income.id;
  bool get isExpenseAccount => accountingTypeId == AccountingType.expenses.id;
  
  // Helpers para la jerarquía
  bool get isRootAccount => parentId == null;
  
  // Obtiene el nombre del tipo de cuenta
  String get accountingTypeName => AccountingType.fromId(accountingTypeId).name;
  
  @override
  List<Object?> get props => [
    id, parentId, accountingTypeId, code, level, 
    name, active, createdAt, updatedAt, deletedAt
  ];
  
  // Helper para copiar la entidad con cambios
  ChartAccount copyWith({
    int? id,
    int? parentId,
    String? accountingTypeId,
    String? code,
    int? level,
    String? name,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return ChartAccount(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      accountingTypeId: accountingTypeId ?? this.accountingTypeId,
      code: code ?? this.code,
      level: level ?? this.level,
      name: name ?? this.name,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }
  
  @override
  String toString() => 'ChartAccount(id: $id, code: $code, name: $name)';
}
