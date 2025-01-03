class Contact {
  final int? id;
  final String name;
  final String? email;
  final String? phone;
  final String? notes;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Contact({
    this.id,
    required this.name,
    this.email,
    this.phone,
    this.notes,
    required this.createdAt,
    this.updatedAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Contact &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          email == other.email &&
          phone == other.phone &&
          notes == other.notes &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode => Object.hash(
        id,
        name,
        email,
        phone,
        notes,
        createdAt,
        updatedAt,
      );

  Contact copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Contact(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
