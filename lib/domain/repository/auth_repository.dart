import 'package:demo_project_app/domain/entity/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login(String username, String password);
  Future<void> logout();
  Future<bool> isLoggedIn();
}
