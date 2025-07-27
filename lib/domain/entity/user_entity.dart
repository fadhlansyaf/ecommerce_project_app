class UserEntity {
  final String id;
  final String username;
  final String password;
  final DateTime createdAt;
  final DateTime? lastLogin;

  UserEntity({
    required this.id,
    required this.username,
    required this.password,
    required this.createdAt,
    this.lastLogin,
  });
}