part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthLoggedOutState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthLoggedInState extends AuthState {
  final UserEntity userEntity;

  const AuthLoggedInState({
    required this.userEntity,
  });

  @override
  List<Object> get props => [userEntity];
}

class AuthFailureState extends AuthState {
  final Failure failure;

  const AuthFailureState({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}
