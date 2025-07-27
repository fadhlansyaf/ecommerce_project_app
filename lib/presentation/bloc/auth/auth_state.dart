import 'package:equatable/equatable.dart';
import '../../../core/data_state.dart';
import '../../../domain/entity/user_entity.dart';

class AuthState extends Equatable {
  final DataState<UserEntity> userState;
  final bool isAuthenticated;

  const AuthState({
    this.userState = const DataState.initial(),
    this.isAuthenticated = false,
  });

  AuthState copyWith({
    DataState<UserEntity>? userState,
    bool? isAuthenticated,
  }) =>
      AuthState(
        userState: userState ?? this.userState,
        isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      );

  @override
  List<Object?> get props => [userState, isAuthenticated];
}