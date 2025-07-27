import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthLocalDatasource {
  final SharedPreferences prefs;

  AuthLocalDatasource({required this.prefs});

  Future<UserModel> login(String username, String password) async {
    // In a real app, you would hash the password before storing/comparing
    final savedUsername = prefs.getString('username');
    final savedPassword = prefs.getString('password');

    if (savedUsername == username && savedPassword == password) {
      return UserModel(
        id: prefs.getString('user_id') ?? '1',
        username: username,
        password: password,
        createdAt: DateTime.parse(
            prefs.getString('createdAt') ?? DateTime.now().toIso8601String()),
        lastLogin: DateTime.now(),
      );
    } else if (savedUsername == null) {
      // First time login, save the user
      final user = UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        username: username,
        password: password,
        createdAt: DateTime.now(),
        lastLogin: DateTime.now(),
      );

      await prefs.setString('user_id', user.id);
      await prefs.setString('username', username);
      await prefs.setString('password', password);
      await prefs.setString('createdAt', user.createdAt.toIso8601String());

      return user;
    }

    throw Exception('Invalid credentials');
  }

  Future<void> logout() async {
    await prefs.clear();
  }

  Future<bool> isLoggedIn() async {
    return prefs.containsKey('user_id');
  }
}
