import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final int id;
  final int? parentId;
  final String documentTypeId;
  final int chartAccountId;
  final String name;
  final String icon;
  final bool active;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  const Category({
    required this.id,
    this.parentId,
    required this.documentTypeId,
    required this.chartAccountId,
    required this.name,
    required this.icon,
    required this.active,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  // Helper para identificar categorías principales
  bool get isMainCategory => parentId == null;

  @override
  List<Object?> get props => [
    id,
    parentId,
    documentTypeId,
    chartAccountId,
    name,
    icon,
    active,
    createdAt,
    updatedAt,
    deletedAt,
  ];

  @override
  String toString() => 'Category(id: $id, name: $name, documentTypeId: $documentTypeId)';

  // Helper para copiar la entidad con cambios
  Category copyWith({
    int? id,
    int? parentId,
    String? documentTypeId,
    int? chartAccountId,
    String? name,
    String? icon,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return Category(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      documentTypeId: documentTypeId ?? this.documentTypeId,
      chartAccountId: chartAccountId ?? this.chartAccountId,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }
}