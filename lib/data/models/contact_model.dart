import 'package:drift/drift.dart';
import '../../domain/entities/contact.dart';
import '../local/database.dart';

class ContactModel {
  final int id;
  final String name;
  final String? email;
  final String? phone;
  final String? note;
  final bool active;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  ContactModel({
    required this.id,
    required this.name,
    this.email,
    this.phone,
    this.note,
    required this.active,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  ContactModel.create({
    required this.name,
    this.email,
    this.phone,
    this.note,
    bool? active,
  })  : id = 0,
        active = active ?? true,
        createdAt = DateTime.now(),
        updatedAt = null,
        deletedAt = null;

  ContactsCompanion toCompanion() => ContactsCompanion(
    id: id == 0 ? const Value.absent() : Value(id),
    name: Value(name),
    email: Value(email),
    phone: Value(phone),
    note: Value(note),
    active: Value(active),
    createdAt: Value(createdAt),
    updatedAt: Value(updatedAt),
    deletedAt: Value(deletedAt),
  );

  Contact toEntity() => Contact(
    id: id,
    name: name,
    email: email,
    phone: phone,
    note: note,
    active: active,
    createdAt: createdAt,
    updatedAt: updatedAt,
    deletedAt: deletedAt,
  );

  factory ContactModel.fromEntity(Contact entity) => ContactModel(
    id: entity.id,
    name: entity.name,
    email: entity.email,
    phone: entity.phone,
    note: entity.note,
    active: entity.active,
    createdAt: entity.createdAt,
    updatedAt: entity.updatedAt,
    deletedAt: entity.deletedAt,
  );
}
