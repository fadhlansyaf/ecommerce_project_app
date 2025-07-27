import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/data_state.dart';
import '../../../domain/usecase/auth/login_usecase.dart';
import '../../../domain/usecase/auth/logout_usecase.dart';
import '../../../domain/usecase/auth/check_auth_status_usecase.dart';
import '../../../domain/usecase/usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final CheckAuthStatusUseCase checkAuthStatusUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.checkAuthStatusUseCase,
  }) : super(const AuthState()) {
    on<LoginEvent>(_onLogin);
    on<LogoutEvent>(_onLogout);
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(userState: const DataState.loading()));
    try {
      final user = await loginUseCase(LoginParams(
        username: event.username,
        password: event.password,
      ));
      emit(state.copyWith(
        userState: DataState.success(user),
        isAuthenticated: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        userState: DataState.failure(e.toString()),
        isAuthenticated: false,
      ));
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    try {
      await logoutUseCase(const NoParams());
      emit(const AuthState());
    } catch (e) {
      emit(state.copyWith(userState: DataState.failure(e.toString())));
    }
  }

  Future<void> _onCheckAuthStatus(CheckAuthStatusEvent event, Emitter<AuthState> emit) async {
    try {
      final isAuthenticated = await checkAuthStatusUseCase(const NoParams());
      emit(state.copyWith(isAuthenticated: isAuthenticated));
    } catch (e) {
      emit(state.copyWith(isAuthenticated: false));
    }
  }
}