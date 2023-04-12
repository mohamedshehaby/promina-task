part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AuthLoginEvent extends AuthEvent {
  final Map<String, dynamic> loginFormMap;

  const AuthLoginEvent({
    required this.loginFormMap,
  });

  @override
  List<Object> get props => [loginFormMap];
}
