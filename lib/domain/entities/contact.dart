import 'package:equatable/equatable.dart';

class Contact extends Equatable {
  final int id;
  final String name;
  final String? email;
  final String? phone;
  final String? note;
  final bool active;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  const Contact({
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

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    phone,
    note,
    active,
    createdAt,
    updatedAt,
    deletedAt,
  ];

  Contact copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? note,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) => Contact(
    id: id ?? this.id,
    name: name ?? this.name,
    email: email ?? this.email,
    phone: phone ?? this.phone,
    note: note ?? this.note,
    active: active ?? this.active,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt ?? this.deletedAt,
  );
}
