class UserEntity {
  final String id;
  final String email;
  final String? displayName;
  final String? photoUrl;

  const UserEntity({
    required this.id,
    required this.email,
    this.displayName,
    this.photoUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
    };
  }

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String?,
      photoUrl: json['photoUrl'] as String?,
    );
  }

  UserEntity copyWith({
    String? id,
    String? email,
    String? displayName,
    String? photoUrl,
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email &&
          displayName == other.displayName &&
          photoUrl == other.photoUrl;

  @override
  int get hashCode =>
      id.hashCode ^ email.hashCode ^ displayName.hashCode ^ photoUrl.hashCode;

  @override
  String toString() {
    return 'UserEntity{id: $id, email: $email, displayName: $displayName, photoUrl: $photoUrl}';
  }
}
