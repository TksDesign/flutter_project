class AuthUser {
  final String id;
  final String email;
  final String? username;
  final String? avatarUrl;
  final DateTime? emailVerifiedAt;

  const AuthUser({
    required this.id,
    required this.email,
    this.username,
    this.avatarUrl,
    this.emailVerifiedAt,
  });

  // CopyWith manuel
  AuthUser copyWith({
    String? id,
    String? email,
    String? username,
    String? avatarUrl,
    DateTime? emailVerifiedAt,
  }) {
    return AuthUser(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
    );
  }

  // Equality manuelle
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AuthUser &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            email == other.email &&
            username == other.username &&
            avatarUrl == other.avatarUrl &&
            emailVerifiedAt == other.emailVerifiedAt);
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      email,
      username,
      avatarUrl,
      emailVerifiedAt,
    );
  }

  // toString manuel
  @override
  String toString() {
    return 'AuthUser(id: $id, email: $email, username: $username, avatarUrl: $avatarUrl, emailVerifiedAt: $emailVerifiedAt)';
  }

  // JSON serialization manuelle
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'avatarUrl': avatarUrl,
      'emailVerifiedAt': emailVerifiedAt?.toIso8601String(),
    };
  }

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      id: json['id'] as String,
      email: json['email'] as String,
      username: json['username'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      emailVerifiedAt: json['emailVerifiedAt'] != null
          ? DateTime.parse(json['emailVerifiedAt'] as String)
          : null,
    );
  }

  // Getters utiles
  bool get isEmailVerified => emailVerifiedAt != null;

  String get displayName => username ?? email.split('@').first;
}
