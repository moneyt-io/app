class ChartAccount {
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

  ChartAccount({
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
}
