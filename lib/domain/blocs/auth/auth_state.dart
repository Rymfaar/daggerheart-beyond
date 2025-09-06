part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

//* Initial state
class AuthLogIn extends AuthState {}

class AuthSignIn extends AuthState {}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {
  final Exception exception;

  AuthError(this.exception);

  @override
  List<Object?> get props => [exception];
}

class AuthSignedIn extends AuthState {
  final UserEntity user;

  AuthSignedIn(this.user);

  @override
  List<Object?> get props => [user];
}
