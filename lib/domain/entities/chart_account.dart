class ChartAccountEntity {
  final int? id;
  final int accountingTypeId;
  final int? parentId;
  final String code;
  final String name;
  final int level;
  final bool active;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  ChartAccountEntity({
    this.id,
    required this.accountingTypeId,
    this.parentId,
    required this.code,
    required this.name,
    required this.level,
    this.active = true,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  ChartAccountEntity copyWith({
    int? id,
    int? accountingTypeId,
    int? parentId,
    String? code,
    String? name,
    int? level,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return ChartAccountEntity(
      id: id ?? this.id,
      accountingTypeId: accountingTypeId ?? this.accountingTypeId,
      parentId: parentId ?? this.parentId,
      code: code ?? this.code,
      name: name ?? this.name,
      level: level ?? this.level,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }
}
