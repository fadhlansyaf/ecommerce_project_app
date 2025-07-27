abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}

class NoParams {
  const NoParams();
}

extension NoParamsUseCaseExtension<Type> on UseCase<Type, NoParams> {
  Future<Type> call() => this.call(const NoParams());
}
