import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

import '../../../data/network/failure.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthLoggedOutState()) {
    on<AuthLoginEvent>((event, Emitter<AuthState> emit) async {
      emit(AuthLoadingState());
      (await authRepository.login(event.loginFormMap)).fold((failure) {
        emit(AuthFailureState(failure: failure));
      }, (user) {
        Logger().i(user.toString());
        emit(AuthLoggedInState(userEntity: user));
      });
    });
  }
}
