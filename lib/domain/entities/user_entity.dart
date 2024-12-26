class UserEntity {
  final String id;
  final String? email;
  final String? displayName;
  final String? photoUrl;
  final bool acceptedMarketing;

  UserEntity({
    required this.id,
    this.email,
    this.displayName,
    this.photoUrl,
    this.acceptedMarketing = false,
  });

  UserEntity copyWith({
    String? id,
    String? email,
    String? displayName,
    String? photoUrl,
    bool? acceptedMarketing,
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      acceptedMarketing: acceptedMarketing ?? this.acceptedMarketing,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'acceptedMarketing': acceptedMarketing,
    };
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      id: map['id'] ?? '',
      email: map['email'],
      displayName: map['displayName'],
      photoUrl: map['photoUrl'],
      acceptedMarketing: map['acceptedMarketing'] ?? false,
    );
  }
}
