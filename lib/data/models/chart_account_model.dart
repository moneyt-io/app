import 'package:drift/drift.dart';
import '../../domain/entities/chart_account.dart';
import '../datasources/local/database.dart';

class ChartAccountModel {
  final int id;
  final int? parentId;
  final String accountingTypeId;
  final String code;
  final int level;
  final String name;
  final bool active;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  // Constructor principal
  ChartAccountModel({
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

  // Constructor para nuevas cuentas
  ChartAccountModel.create({
    this.parentId,
    required this.accountingTypeId,
    required this.code,
    required this.level,
    required this.name,
    bool? active,
  })  : id = 0,
        active = active ?? true,
        createdAt = DateTime.now(),
        updatedAt = null,
        deletedAt = null;

  // Convertir a Companion para Drift
  ChartAccountsCompanion toCompanion() {
    return ChartAccountsCompanion(
      id: id == 0 ? const Value.absent() : Value(id),
      parentId: Value(parentId),
      accountingTypeId: Value(accountingTypeId),
      code: Value(code),
      level: Value(level),
      name: Value(name),
      active: Value(active),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: Value(deletedAt),
    );
  }

  // Conversión desde/hacia Domain Entity
  ChartAccount toEntity() => ChartAccount(
    id: id,
    parentId: parentId,
    accountingTypeId: accountingTypeId,
    code: code,
    level: level,
    name: name,
    active: active,
    createdAt: createdAt,
    updatedAt: updatedAt,
    deletedAt: deletedAt,
  );

  factory ChartAccountModel.fromEntity(ChartAccount entity) => ChartAccountModel(
    id: entity.id,
    parentId: entity.parentId,
    accountingTypeId: entity.accountingTypeId,
    code: entity.code,
    level: entity.level,
    name: entity.name,
    active: entity.active,
    createdAt: entity.createdAt,
    updatedAt: entity.updatedAt,
    deletedAt: entity.deletedAt,
  );
}
