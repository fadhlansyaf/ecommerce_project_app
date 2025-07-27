import 'package:demo_project_app/domain/entity/user_entity.dart';
import 'package:demo_project_app/domain/repository/auth_repository.dart';
import 'package:demo_project_app/domain/usecase/usecase.dart';

class LoginUseCase implements UseCase<UserEntity, LoginParams> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<UserEntity> call(LoginParams params) async {
    if (params.username.length < 8 || params.password.length < 8) {
      throw Exception('Username and password must be at least 8 characters');
    }
    return await repository.login(params.username, params.password);
  }
}

class LoginParams {
  final String username;
  final String password;

  LoginParams({required this.username, required this.password});
}
