import '../../repository/auth_repository.dart';
import '../usecase.dart';

class CheckAuthStatusUseCase implements UseCase<bool, NoParams> {
  final AuthRepository repository;

  CheckAuthStatusUseCase(this.repository);

  @override
  Future<bool> call(NoParams params) async {
    return await repository.isLoggedIn();
  }
}