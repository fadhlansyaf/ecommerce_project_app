import 'package:demo_project_app/data/datasources/auth_local_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entity/user_entity.dart';
import '../../domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDatasource remoteDatasource;
  final SharedPreferences prefs;

  AuthRepositoryImpl(this.remoteDatasource, this.prefs);

  @override
  Future<UserEntity> login(String username, String password) async {
    try {
      final user = await remoteDatasource.login(username, password);
      await prefs.setString('user_id', user.id);
      await prefs.setString('username', user.username);
      return user;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await prefs.clear();
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    return prefs.containsKey('user_id');
  }
}
