import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required String id,
    required String username,
    required String password,
    required DateTime createdAt,
    DateTime? lastLogin,
  }) : super(
          id: id,
          username: username,
          password: password,
          createdAt: createdAt,
          lastLogin: lastLogin,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastLogin: json['lastLogin'] != null
          ? DateTime.parse(json['lastLogin'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'createdAt': createdAt.toIso8601String(),
      'lastLogin': lastLogin?.toIso8601String(),
    };
  }

  // Helper methods for SharedPreferences
  factory UserModel.fromPrefs(SharedPreferences prefs) {
    return UserModel(
      id: prefs.getString('user_id') ?? '',
      username: prefs.getString('username') ?? '',
      password: prefs.getString('password') ?? '',
      createdAt: DateTime.parse(
          prefs.getString('createdAt') ?? DateTime.now().toIso8601String()),
      lastLogin: prefs.getString('lastLogin') != null
          ? DateTime.parse(prefs.getString('lastLogin')!)
          : null,
    );
  }

  Future<void> saveToPrefs(SharedPreferences prefs) async {
    await prefs.setString('user_id', id);
    await prefs.setString('username', username);
    await prefs.setString('password', password);
    await prefs.setString('createdAt', createdAt.toIso8601String());
    if (lastLogin != null) {
      await prefs.setString('lastLogin', lastLogin!.toIso8601String());
    }
  }
}
