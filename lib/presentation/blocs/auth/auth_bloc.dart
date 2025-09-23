import 'package:daggerheart_beyond/domain/entities/user_entity.dart';
import 'package:daggerheart_beyond/domain/use_case/auth_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCase _authUseCase;

  AuthBloc(this._authUseCase) : super(AuthUnauthenticated()) {
    on<LogInPressed>((event, emit) async {
      try {
        emit(AuthLoading());
        final UserEntity user = await _authUseCase.logIn(
          event.email,
          event.password,
        );
        emit(AuthLoggedIn(user));
      } catch (e) {
        emit(AuthError(e as Exception));
      }
    });

    on<CreateAccountPressed>((event, emit) async {
      try {
        emit(AuthLoading());
        final UserEntity user = await _authUseCase.signUp(
          event.username,
          event.email,
          event.password,
        );
        emit(AuthLoggedIn(user));
      } catch (e) {
        emit(AuthError(e as Exception));
      }
    });
  }
}
