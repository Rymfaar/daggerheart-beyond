import 'package:daggerheart_beyond/domain/entities/user_entity.dart';
import 'package:daggerheart_beyond/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

// TODO: Checkout https://pub.dev/packages/value_state/versions/2.0.0
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthSignIn()) {
    on<LogInPressed>((event, emit) async {
      try {
        // TODO: mdp validation
        emit(AuthLoading());
        final UserEntity user = await authRepository.signIn(
          event.email,
          event.password,
        );
        emit(AuthSignedIn(user));
      } catch (e) {
        emit(AuthError(e as Exception));
      }
    });

    on<CreateAccountPressed>((event, emit) async {
      try {
        print("CreateAccountPressed event received");
        emit(AuthLoading());
        print("AuthLoading state emitted");
        final UserEntity user = await authRepository.signUp(
          event.username,
          event.email,
          event.password,
        );
        print("User signed up: $user");
        emit(AuthSignedIn(user));
      } catch (e) {
        emit(AuthError(e as Exception));
      }
    });
  }
}
