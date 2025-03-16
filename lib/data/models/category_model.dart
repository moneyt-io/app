// lib/data/models/category_model.dart
import 'package:drift/drift.dart';
import '../../domain/entities/category.dart' as entity;
import '../datasources/local/database.dart';

class CategoryModel {
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

  CategoryModel({
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

  // Constructor para nuevas categorías
  CategoryModel.create({
    this.parentId,
    required this.documentTypeId,
    required this.chartAccountId,
    required this.name,
    required this.icon,
    bool? active,
  })  : id = 0,
        active = active ?? true,
        createdAt = DateTime.now(),
        updatedAt = null,
        deletedAt = null;

  // Convertir a Companion para Drift
  CategoriesCompanion toCompanion() => CategoriesCompanion(
    id: id == 0 ? const Value.absent() : Value(id),
    parentId: Value(parentId),
    documentTypeId: Value(documentTypeId),
    chartAccountId: Value(chartAccountId),
    name: Value(name),
    icon: Value(icon),
    active: Value(active),
    createdAt: Value(createdAt),
    updatedAt: Value(updatedAt),
    deletedAt: Value(deletedAt),
  );

  // Conversión desde/hacia Domain Entity
  entity.Category toEntity() => entity.Category(
    id: id,
    parentId: parentId,
    documentTypeId: documentTypeId,
    chartAccountId: chartAccountId,
    name: name,
    icon: icon,
    active: active,
    createdAt: createdAt,
    updatedAt: updatedAt,
    deletedAt: deletedAt,
  );

  factory CategoryModel.fromEntity(entity.Category entity) => CategoryModel(
    id: entity.id,
    parentId: entity.parentId,
    documentTypeId: entity.documentTypeId,
    chartAccountId: entity.chartAccountId,
    name: entity.name,
    icon: entity.icon,
    active: entity.active,
    createdAt: entity.createdAt,
    updatedAt: entity.updatedAt,
    deletedAt: entity.deletedAt,
  );
}